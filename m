Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id EB72967A6B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 05:17:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 31 Mar 2005 21:17:00 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D25@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dan,

Please be aware I am no expert in that field, so bear with me :)

Dan Malek wrote:
>> When CPU has no (classic) FPU, and math emulation is disabled,
>> fp instructions are not allowed in kernel mode.
>
>FP Instructions are never allowed in kernel mode regardless of the CPU.
>However, with math emulation disabled and no FPU, we still emulate
>FP load/store operations because they are usually hard coded in
>some of the context save/restore functions of the C library.

What I don't understand, is how the FP load/store operations
in misc.S can "work" on a system with no FPU and *no* math-emu?

>> This bug has been found with crashme (crash01) of LTP, on a e500=20
>> system.
>
>What is the bug?  This patch disables a big feature we have been
>using for many years.  Please take another look at this.

Many years? Allow me to doubt it's really used :). I took a better=20
look, at math-emu/math.c. And then I understood why my previous
patch should not have disabled cvt_fd et al in misc.S.

The fact is, with CONFIG_MATH_EMULATION disabled, make does not enter
the math-emu/ subdir, math.c does not get compiled (so no lfs/etc.
emulation), and  by the way, nobody even call do_mathemu in
traps.c because it's always surrounded with #ifdef
CONFIG_MATH_EMULATION.
Though, it does work for 8xx thanks to Soft_emulate_8xx, but doesn't
for other FPU-less cores when CONFIG_MATH_EMULATION is disabled.

So here is another patch, which hopefully is a better fix,
yet find a solution to my problem. Please comment on it,
as I'm not sure whether ProgramCheckException is right.
Rem: it looks weird to use FP load/store operations when
you do know that you don't have a FPU and CONFIG_MATH_EMULATION
is disabled. Should we do like 8xx, and call directly
the emulation layer? Could we re-use Soft_emulate_8xx() (made generic
without the *_8xx_pte) for the 4xx and e500 ?


Signed-off-by: Stephane Fillod <fillods@gmail.com>=20

--- linux/arch/ppc/Makefile	26 Mar 2005 03:28:39 -0000	1.1.1.2
+++ linux/arch/ppc/Makefile	31 Mar 2005 18:59:25 -0000
@@ -55,10 +55,10 @@
 head-$(CONFIG_POWER4)		+=3D arch/ppc/kernel/idle_power4.o
=20
 core-y				+=3D arch/ppc/kernel/ arch/ppc/platforms/
\
-				   arch/ppc/mm/ arch/ppc/lib/
arch/ppc/syslib/
+				   arch/ppc/mm/ arch/ppc/lib/
arch/ppc/syslib/ \
+				   arch/ppc/math-emu/
 core-$(CONFIG_4xx)		+=3D arch/ppc/platforms/4xx/
 core-$(CONFIG_85xx)		+=3D arch/ppc/platforms/85xx/
-core-$(CONFIG_MATH_EMULATION)	+=3D arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+=3D arch/ppc/xmon/
 core-$(CONFIG_APUS)		+=3D arch/ppc/amiga/
 drivers-$(CONFIG_8xx)		+=3D arch/ppc/8xx_io/
--- linux/arch/ppc/kernel/traps.c	30 Mar 2005 16:25:07 -0000
1.3
+++ linux/arch/ppc/kernel/traps.c	31 Mar 2005 18:59:25 -0000
@@ -540,7 +540,6 @@
 	    return;
 #endif /* CONFIG_ADEOS_CORE */
=20
-#ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
 	 * that means ESR is sometimes set incorrectly - either to
@@ -552,7 +551,6 @@
 		emulate_single_step(regs);
 		return;
 	}
-#endif /* CONFIG_MATH_EMULATION */
=20
 	if (reason & REASON_FP) {
 		/* IEEE FP exception */
--- linux/arch/ppc/kernel/process.c	26 Mar 2005 03:28:20 -0000
1.1.1.2
+++ linux/arch/ppc/kernel/process.c	31 Mar 2005 18:59:25 -0000
@@ -342,7 +342,7 @@
 	printk("\n");
 #ifdef CONFIG_KALLSYMS
 	/*
-	 * Lookup NIP late so we have the best change of getting the
+	 * Lookup NIP late so we have the best chance of getting the
 	 * above info out without failing
 	 */
 	printk("NIP [%08lx] ", regs->nip);



Thanks for the reply
--=20
Stephane
