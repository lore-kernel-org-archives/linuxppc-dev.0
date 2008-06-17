Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1297DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 08:36:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5HMabwK001390
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:36:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5HMabwv239504
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:36:37 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5HMabgN019845
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:36:37 -0400
Received: from zod.rchland.ibm.com ([9.49.216.172])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5HMaaqH019833
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:36:37 -0400
Date: Tue, 17 Jun 2008 18:34:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Clear new TLB cache attribute bits in Data
	Storage vector
Message-ID: <20080617183439.63d2aa3c@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A recent commit added support for the new 440x6 and 464 cores that have the
added WL1, IL1I, IL1D, IL2I, and ILD2 bits for the caching attributes in the
TLBs.  The new bits were cleared in the finish_tlb_load function, however a
similar bit of code was missed in the DataStorage interrupt vector.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/head_44x.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index c2b9dc4..22b5d2c 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -368,7 +368,12 @@ interrupt_base:
 
 	rlwimi	r11,r13,0,26,31		/* Insert static perms */
 
-	rlwinm	r11,r11,0,20,15		/* Clear U0-U3 */
+	/*
+	 * Clear U0-U3 and WL1 IL1I IL1D IL2I IL2D bits which are added
+	 * on newer 440 cores like the 440x6 used on AMCC 460EX/460GT (see
+	 * include/asm-powerpc/pgtable-ppc32.h for details).
+	 */
+	rlwinm	r11,r11,0,20,10
 
 	/* find the TLB index that caused the fault.  It has to be here. */
 	tlbsx	r10, 0, r10
-- 
1.5.4.3
