Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F011FB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 16:56:09 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: e500mc: Fix: use CONFIG_PPC_E500MC in idle_e500.S
Date: Tue, 11 Oct 2011 11:26:08 +0530
Message-ID: <1318312568-23181-1-git-send-email-bharat.bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, bharatb.yadav@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is wrongly using undefined CONFIG_E500MC.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kernel/idle_e500.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 3e2b95c..4f0ab85 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -26,7 +26,7 @@ _GLOBAL(e500_idle)
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
 	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
 
-#ifdef CONFIG_E500MC
+#ifdef CONFIG_PPC_E500MC
 	wrteei	1
 1:	wait
 
-- 
1.7.0.4
