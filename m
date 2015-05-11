Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C3071A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 20:16:37 +1000 (AEST)
In-Reply-To: <1431305312-9955-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/mce: fix off by one errors in mce event handling
Message-Id: <20150511101637.3ADB614016A@ozlabs.org>
Date: Mon, 11 May 2015 20:16:37 +1000 (AEST)
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stable folks please ignore this patch.

Comments below.

On Mon, 2015-11-05 at 00:48:32 UTC, Daniel Axtens wrote:
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
> Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
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

As we discussed offline, this looks racy against another machine check coming
in. ie. if another machine check comes in after mce_nest_count is loaded but
before it's incremented and stored, we might lose an increment.

But the original code also looks racy, just maybe with a smaller window.

Fixing it properly might be a bit involved though, so for a fix for stable we
might want to just do:

 -	int index = __this_cpu_inc_return(mce_nest_count);
 +	int index = __this_cpu_inc_return(mce_nest_count) - 1;

Which will hopefully generate a ld/addi/std that is at least minimal in its
exposure to the race.

Thoughts?

cheers
