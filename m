Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C90A2C00F9
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 16:55:39 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 16:47:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 54814357804A
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 16:55:15 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q6fS8x18874448
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 16:41:29 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q6tDK0027113
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 16:55:14 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Setup BHRB instructions facility in HFSCR for POWER8
Date: Fri, 26 Apr 2013 12:24:55 +0530
Message-Id: <1366959295-1422-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make BHRB instructions available in problem and privileged states.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h        | 1 +
 arch/powerpc/kernel/cpu_setup_power.S | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0bee933..e8afd35 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -271,6 +271,7 @@
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
 #define   HFSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
 #define   HFSCR_TM	(1 << (63-58)) /* Enable Transactional Memory */
+#define   HFSCR_BHRB	(1 << (63-59)) /* Enable Branch History Rolling Buffer */
 #define   HFSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
 #define   HFSCR_VECVSX	(1 << (63-62)) /* Enable VMX/VSX  */
 #define   HFSCR_FP	(1 << (63-63)) /* Enable Floating Point */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index be0c12d..e673429 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -125,7 +125,8 @@ __init_FSCR:
 
 __init_HFSCR:
 	mfspr	r3,SPRN_HFSCR
-	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP
+	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_BHRB|\
+				HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP
 	mtspr	SPRN_HFSCR,r3
 	blr
 
-- 
1.7.11.7
