Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B24B5B6FF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3568Z7U004442
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:08:35 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELs22109536
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKPr011084
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/15] powerpc: Initialize LPCR:DPFD on power7 to a sane
	default
Date: Tue,  5 Apr 2011 16:14:05 +1000
Message-Id: <1301984051-18413-10-git-send-email-benh@kernel.crashing.org>
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

This sets the default data stream prefetch size for operating
systems that don't set their own value in DSCR. We use 4 which
is "medium".

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cpu_setup_power7.S |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
index e801ef1..2390f6f 100644
--- a/arch/powerpc/kernel/cpu_setup_power7.S
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -54,6 +54,7 @@ __init_LPCR:
 	 *
 	 *   LPES = 0b01 (HSRR0/1 used for 0x500)
 	 *   PECE = 0b111
+	 *   DPFD = 4
 	 *
 	 * Other bits untouched for now
 	 */
@@ -61,6 +62,12 @@ __init_LPCR:
 	ori	r3,r3,(LPCR_LPES0|LPCR_LPES1)
 	xori	r3,r3, LPCR_LPES0
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
+	li	r5,7
+	sldi	r5,r5,LPCR_DPFD_SH
+	andc	r3,r3,r5
+	li	r5,4
+	sldi	r5,r5,LPCR_DPFD_SH
+	or	r3,r3,r5
 	mtspr	SPRN_LPCR,r3
 	isync
 	blr
-- 
1.7.1
