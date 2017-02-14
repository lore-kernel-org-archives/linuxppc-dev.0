Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwzF6DM7zDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:47:37 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8hx78118457
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:47:36 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kr87xhkv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:47:35 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 01:47:34 -0700
Subject: Re: [PATCH] powerpc/xmon: Fix data-breakpoint
To: mpe@ellerman.id.au
References: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 14:17:19 +0530
MIME-Version: 1.0
In-Reply-To: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58A2C417.8000806@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Can you please pull this patch.

Thanks,
Ravi

On Tuesday 22 November 2016 02:55 PM, Ravi Bangoria wrote:
> Xmon data-breakpoint feature is broken.
>
> Whenever there is a watchpoint match occurs, hw_breakpoint_handler will
> be called by do_break via notifier chains mechanism. If watchpoint is
> registered by xmon, hw_breakpoint_handler won't find any associated
> perf_event and returns immediately with NOTIFY_STOP. Similarly, do_break
> also returns without notifying to xmon.
>
> Solve this by returning NOTIFY_DONE when hw_breakpoint_handler does not
> find any perf_event associated with matched watchpoint.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 03d089b..469d86d 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -228,8 +228,10 @@ int hw_breakpoint_handler(struct die_args *args)
>  	rcu_read_lock();
>
>  	bp = __this_cpu_read(bp_per_reg);
> -	if (!bp)
> +	if (!bp) {
> +		rc = NOTIFY_DONE;
>  		goto out;
> +	}
>  	info = counter_arch_bp(bp);
>
>  	/*
