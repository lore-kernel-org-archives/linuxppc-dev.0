Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F622B6F86
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:09:36 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7N59Zag024296
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:09:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N58LJ61376274
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:08:21 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N59ZlB018579
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:09:35 +1000
Date: Tue, 23 Aug 2011 15:09:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
	flag
Message-ID: <20110823050931.GT30097@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110819075338.GC21817@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> 
> While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> "features" member of "struct ppc_debug_info" to advertise support for the
> same on Book3E PowerPC processors.

I thought the idea was that the BP_EXACT mode was the default - if the
new interface was supported at all, then BP_EXACT was always
supported.  So, why do you need a new flag?

> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/ptrace.h |    1 +
>  arch/powerpc/kernel/ptrace.c      |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 48223f9..cf014f9 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -380,6 +380,7 @@ struct ppc_debug_info {
>  #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x0000000000000002
>  #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
>  #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
> +#define PPC_DEBUG_FEATURE_DATA_BP_EXACT		0x0000000000000010
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 18d28b6..71db5a6 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1636,6 +1636,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  #ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
>  		dbginfo.features |=
>  				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
> +				   PPC_DEBUG_FEATURE_DATA_BP_EXACT |
>  				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
>  #endif
>  #else /* !CONFIG_PPC_ADV_DEBUG_REGS */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
