Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3F40DDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 20:50:41 +1000 (EST)
Received: from dolphin.spb.rtsoft.ru (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 90C328815
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 15:19:33 +0500 (SAMST)
Subject: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
From: Vladislav Buzov <vbuzov@ru.mvista.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 14:19:33 +0400
Message-Id: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

I'm currently working on a Linux 2.6.x port for a MCP7448 based board.
And I'm observing that some memory areas become corrupted on early
kernel startup. Namely some parts of kernel page table, that leads to
sudden kernel crashes. After some investigations I've managed to narrow
the problem down to a _set_L2CR() function that seems to not work for
this processor and the memory become corrupted after the cache is
flushed and re-enabled.

Note that I'm working with arch/ppc code. I've looked through
arch/powerpc sources and found some fixes for MPC7450 processors family
in l2cr_6xx.S. Then I've backported them to arch/ppc but it didn't help.

I read the MPC7450 reference manual and it describes a method to flush
the cache using L2 hardware flushing feature. The cache flushing
procedure consist of several steps and some of them are dictated by
MPC7448 errata (www.freescale.com/files/32bit/doc/errata/MPC7448CE.pdf,
Erratum no.3).

When I implemented that method in _set_L2CR() (patch included below)
following the MPC7450 reference manual, things worked fine. With these
changes the kernel works stable. The same result I get when I force a
boot loader to not enable the L2 cache before starting the kernel.

So, I have couple questions:

First, I'm looking for a help and advice why the current _set_L2CR()
implementation may not work for MPC7450 (namely 7448 with 1Mb L2 cache
installed). Is it a bug in _set_L2CR()  or a hardware problem. I've
mentioned above about MPC7450 hardware bug in L2 hardware flushing
mechanism. May it be applicable to common cache flushing procedure based
on sequence of lwz/dcbf instructions?

I'd like to note that I've had a hard time to find a root cause of the
problem in the current _set_L2CR() implementation. I changed a size of
memory used to fill and then flush the cache, tried to apply the
workaround for the MPC7448 hardware bug above and nothing helped except
the patch below.

Second, Is this patch acceptable?

Any feedback will be appreciated.

Thanks in advance,
Vlad.

---

 arch/powerpc/kernel/l2cr_6xx.S |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/l2cr_6xx.S b/arch/powerpc/kernel/l2cr_6xx.S
index 858f28a..e6d96a6 100644
--- a/arch/powerpc/kernel/l2cr_6xx.S
+++ b/arch/powerpc/kernel/l2cr_6xx.S
@@ -156,6 +156,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	  ****/
 
 BEGIN_FTR_SECTION
+	/* MPC7450 provides a L2 hardware flushing mechanism
+	 * implemented through L2CR[L2HWF] bit. Refer to MPC7450
+	 * reference manual p. 3-53 for details.
+	 */
+
+	/* Set L2CR[L2IO], L2CR[L2DO] to lock the cache */
+	mfspr	r4, SPRN_L2CR
+	oris	r4, r4, 0x0011
+	sync
+	mtspr	SPRN_L2CR, r4
+	sync
+	isync
+	
 	/* Disable L2 prefetch on some 745x and try to ensure
 	 * L2 prefetch engines are idle. As explained by errata
 	 * text, we can't be sure they are, we just hope very hard
@@ -173,6 +186,31 @@ BEGIN_FTR_SECTION
 	dcbf	0,r4
 	dcbf	0,r4
 	dcbf	0,r4
+
+	/* Flush and invalidate L2:
+	 * Set L2HWF and wait till it is cleared.
+	 */
+	mfspr	r4, SPRN_L2CR
+	ori	r4, r4, 0x0800
+	sync
+	mtspr	SPRN_L2CR, r4
+	sync
+	isync
+	
+1:	mfspr	r4, SPRN_L2CR
+	rlwinm.	r0,r4,0,20,20
+	bne	1b
+
+	/* Clear L2IO, L2DO to unlock the cache */
+	mfspr	r4, SPRN_L2CR
+	rlwinm  r4, r4, 0, 12, 10
+	rlwinm	r4, r4, 0, 16, 14
+	sync
+	mtspr	SPRN_L2CR, r4
+	sync
+	isync
+
+	b	2f
 END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 
 	/* TODO: use HW flush assist when available */
