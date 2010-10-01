Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CE20B71AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:28 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id o91724CV025303
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:02:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176Ru12203740
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176RoX019004
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:27 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 12/18] powerpc 44x: Handle TLB miss regardless of endianness
Date: Fri,  1 Oct 2010 17:06:05 +1000
Message-Id: <1285916771-18033-13-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

On the 44x we use 64bit page table entries, but the CPU is only 32bit.
When a PTE is loaded during a TLB miss each half is loaded into
different registers, so we need to reverse the offsets if the CPU is
running in little endian mode.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/head_44x.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 6198733..d4c144f 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -258,8 +258,8 @@ interrupt_base:
 
 	/* Compute pte address */
 	rlwimi  r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK_BIT, 28
-	lwz	r11, 0(r12)		/* Get high word of pte entry */
-	lwz	r12, 4(r12)		/* Get low word of pte entry */
+	lwz	r11, p64h(r12)		/* Get high word of pte entry */
+	lwz	r12, p64l(r12)		/* Get low word of pte entry */
 
 	lis	r10,tlb_44x_index@ha
 
@@ -354,8 +354,8 @@ tlb_44x_patch_hwater_D:
 
 	/* Compute pte address */
 	rlwimi	r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK_BIT, 28
-	lwz	r11, 0(r12)		/* Get high word of pte entry */
-	lwz	r12, 4(r12)		/* Get low word of pte entry */
+	lwz	r11, p64h(r12)		/* Get high word of pte entry */
+	lwz	r12, p64l(r12)		/* Get low word of pte entry */
 
 	lis	r10,tlb_44x_index@ha
 
-- 
1.7.1
