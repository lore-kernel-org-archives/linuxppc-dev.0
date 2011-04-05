Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32939B7003
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:22 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3568q5x024671
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:08:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELoa536630
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKU2011094
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/15] powerpc: Call CPU ->restore callback earlier on
	secondary CPUs
Date: Tue,  5 Apr 2011 16:14:07 +1000
Message-Id: <1301984051-18413-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We do it before we loop on the PACA start flag. This way, we get a
chance to set critical SPRs on all CPUs before Linux tries to start
them up, which avoids problems when changing some bits such as LPCR
bits that need to be identical on all threads of a core or similar
things like that. Ideally, some of that should also be done before
the MMU is enabled, but that's a separate issue which would require
moving some of the SMP startup code earlier, let's not get there
for now, it works with that change alone.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/head_64.S |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 53d3bfd..43a3cff 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -236,17 +236,6 @@ generic_secondary_common_init:
 
 	/* From now on, r24 is expected to be logical cpuid */
 	mr	r24,r5
-3:	HMT_LOW
-	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
-					/* start.			 */
-
-#ifndef CONFIG_SMP
-	b	3b			/* Never go on non-SMP		 */
-#else
-	cmpwi	0,r23,0
-	beq	3b			/* Loop until told to go	 */
-
-	sync				/* order paca.run and cur_cpu_spec */
 
 	/* See if we need to call a cpu state restore handler */
 	LOAD_REG_ADDR(r23, cur_cpu_spec)
@@ -258,6 +247,17 @@ generic_secondary_common_init:
 	mtctr	r23
 	bctrl
 
+3:	HMT_LOW
+	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
+					/* start.			 */
+#ifndef CONFIG_SMP
+	b	3b			/* Never go on non-SMP		 */
+#else
+	cmpwi	0,r23,0
+	beq	3b			/* Loop until told to go	 */
+
+	sync				/* order paca.run and cur_cpu_spec */
+
 4:	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
-- 
1.7.1
