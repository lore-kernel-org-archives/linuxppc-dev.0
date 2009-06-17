Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EE332B71E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 15:08:09 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACB27DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:08 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5H56KGE031828
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:06:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5H587B11003760
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5H586tg004763
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Date: Wed, 17 Jun 2009 14:14:20 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090617041420.GK486@yookeroo.seuss>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090818.GE14478@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090610090818.GE14478@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2009 at 02:38:18PM +0530, K.Prasad wrote:
> Modify process handling code to recognise hardware debug registers during copy
> and flush operations. Introduce a new TIF_DEBUG task flag to indicate a
> process's use of debug register. Load the debug register values into a
> new CPU during initialisation.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/process.c |   15 +++++++++++++++
>  arch/powerpc/kernel/smp.c     |    2 ++
>  2 files changed, 17 insertions(+)
> 
> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> @@ -50,6 +50,7 @@
>  #include <asm/syscalls.h>
>  #ifdef CONFIG_PPC64
>  #include <asm/firmware.h>
> +#include <asm/hw_breakpoint.h>
>  #endif
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> @@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
>  			11, SIGSEGV) == NOTIFY_STOP)
>  		return;
>  
> +#ifndef CONFIG_PPC64
>  	if (debugger_dabr_match(regs))
>  		return;
> +#endif

Won't this disable the check for breakpoints set by xmon - but I don't
see anything in this patch series to convert xmon to use the new
breakpoint interface instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
