Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 017B61A2CEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:56:09 +1100 (AEDT)
Date: Wed, 17 Feb 2016 15:56:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
Message-ID: <20160217045606.GA19276@oak.ozlabs.ibm.com>
References: <1455684191.3089.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1455684191.3089.3.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 03:43:11PM +1100, Balbir Singh wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> I ran into this issue while debugging an early boot problem.
> The system hit a BUG_ON() but report bug failed to print the
> line number and file name. The reason being that the system
> was running in real mode and report_bug() searches for
> addresses in the PAGE_OFFSET+ region
> 
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/traps.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index b6becc7..8f28120 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1148,6 +1148,7 @@ void __kprobes program_check_exception(struct pt_regs *regs)
>  		goto bail;
>  	}
>  	if (reason & REASON_TRAP) {
> +		unsigned long bugaddr;
>  		/* Debugger is first in line to stop recursive faults in
>  		 * rcu_lock, notify_die, or atomic_notifier_call_chain */
>  		if (debugger_bpt(regs))
> @@ -1158,8 +1159,13 @@ void __kprobes program_check_exception(struct pt_regs *regs)
>  				== NOTIFY_STOP)
>  			goto bail;
>  
> +		if (!(regs->msr & MSR_IR))
> +			bugaddr = regs->nip + PAGE_OFFSET;
> +		else
> +			bugaddr = regs->nip;

It might be a little better to do this:

		bugaddr = regs->nip;
		if (REGION_ID(bugaddr) == 0 && !(regs->msr & MSR_IR))
			bugaddr += PAGE_OFFSET;

It is possible to execute from addresses with the 0xc000... on top in
real mode, because the CPU ignores the top 4 address bits in real
mode.

Paul.
