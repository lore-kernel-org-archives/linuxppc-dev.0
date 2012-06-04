Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E754B6F9D
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2012 19:04:48 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 97FC4258026
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2012 11:04:42 +0200 (CEST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
Date: Mon, 4 Jun 2012 11:04:36 +0200
Message-Id: <1338800676-10386-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emulators such as BDI2000 and CodeWarrior needs to have MSR_DE set
in order to support break points for booke archs.
This adds MSR_DE for kernel space only, protected by CONFIG_BDI_SWITCH

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/include/asm/reg_booke.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 500fe1d..b3e57ed 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -37,7 +37,11 @@
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #else
+#ifdef CONFIG_BDI_SWITCH
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE|MSR_DE)
+#else
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#endif
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
-- 
1.7.3.4
