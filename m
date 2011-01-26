Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9BF5B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:22:57 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QG4wNo004896
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 11:05:03 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B8B264DE8162
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 11:14:34 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QGI5wj146078
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 11:18:05 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0QGI310000834
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 09:18:05 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/476: Workaround for PLB6 hang
Date: Wed, 26 Jan 2011 10:17:59 -0600
Message-Id: <1296058679-21352-3-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296058679-21352-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296058679-21352-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 476FP core may hang if an instruction fetch happens during an msync
following a tlbsync.  This workaround makes sure that enough instruction
cache lines are pre-fetched before executing the msync.  (sync and msync
are the same to the compiler.)

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb_nohash_low.S |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index af405ee..7c63c0e 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -189,6 +189,13 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	blr
 
 #ifdef CONFIG_PPC_47x
+
+/*
+ * 47x variant of icbt
+ */
+# define ICBT(CT,RA,RB)	\
+	.long	0x7c00002c | ((CT) << 21) | ((RA) << 16) | ((RB) << 11)
+
 /*
  * _tlbivax_bcast is only on 47x. We don't bother doing a runtime
  * check though, it will blow up soon enough if we mistakenly try
@@ -206,7 +213,35 @@ _GLOBAL(_tlbivax_bcast)
 	isync
 	eieio
 	tlbsync
+BEGIN_FTR_SECTION
+	b	1f
+END_FTR_SECTION_IFSET(CPU_FTR_476_DD2)
+	sync
+	wrtee	r10
+	blr
+/*
+ * DD2 HW could hang if in instruction fetch happens before msync completes.
+ * Touch enough instruction cache lines to ensure cache hits
+ */
+1:	mflr	r9
+	bl	2f
+2:	mflr	r6
+	li	r7,32
+	ICBT(0,r6,r7)		/* touch next cache line */
+	add	r6,r6,r7
+	ICBT(0,r6,r7)		/* touch next cache line */
+	add	r6,r6,r7
+	ICBT(0,r6,r7)		/* touch next cache line */
 	sync
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	mtlr	r9
 	wrtee	r10
 	blr
 #endif /* CONFIG_PPC_47x */
-- 
1.7.3.4
