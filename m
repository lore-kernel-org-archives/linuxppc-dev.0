Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47A231A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:06:17 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 256071400A0
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 17:06:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 11 May 2015 17:06:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 452343578048
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 17:06:12 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B764rT27328678
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 17:06:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B75d3e031467
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 17:05:40 +1000
Date: Mon, 11 May 2015 12:35:12 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] powerpc/mce: fix off by one errors in mce event handling
Message-ID: <20150511070512.GA11213@in.ibm.com>
Reply-To: mahesh@linux.vnet.ibm.com
References: <1431305312-9955-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431305312-9955-1-git-send-email-dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015-05-11 10:48:32 Mon, Daniel Axtens wrote:
> Before 69111bac42f5 ("powerpc: Replace __get_cpu_var uses"), in
> save_mce_event, index got the value of mce_nest_count, and
> mce_nest_count was incremented *after* index was set.
> 
> However, that patch changed the behaviour so that mce_nest count was
> incremented *before* setting index.
> 
> This causes an off-by-one error, as get_mce_event sets index as
> mce_nest_count - 1 before reading mce_event.  Thus get_mce_event reads
> bogus data, causing warnings like
> "Machine Check Exception, Unknown event version 0 !"
> and breaking MCEs handling.
> 
> Restore the old behaviour and unbreak MCE handling by moving the
> increment to after index is set.
> 
> The same broken change occured in machine_check_queue_event (which set
> a queue read by machine_check_process_queued_event).  Fix that too,
> unbreaking printing of MCE information.
> 
> Fixes: 69111bac42f5 ("powerpc: Replace __get_cpu_var uses")
> CC: stable@vger.kernel.org
> CC: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/mce.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index 15c99b6..f774b64 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -73,8 +73,9 @@ void save_mce_event(struct pt_regs *regs, long handled,
>  		    uint64_t nip, uint64_t addr)
>  {
>  	uint64_t srr1;
> -	int index = __this_cpu_inc_return(mce_nest_count);
> +	int index = __this_cpu_read(mce_nest_count);
>  	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
> +	__this_cpu_inc(mce_nest_count);
>  
>  	/*
>  	 * Return if we don't have enough space to log mce event.
> @@ -184,7 +185,8 @@ void machine_check_queue_event(void)
>  	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
>  		return;
>  
> -	index = __this_cpu_inc_return(mce_queue_count);
> +	index = __this_cpu_read(mce_queue_count);
> +	__this_cpu_inc(mce_queue_count);
>  	/* If queue is full, just return for now. */
>  	if (index >= MAX_MC_EVT) {
>  		__this_cpu_dec(mce_queue_count);
> -- 
> 2.1.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Mahesh J Salgaonkar
