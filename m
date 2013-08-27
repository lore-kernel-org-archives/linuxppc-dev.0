Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A38BB2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 16:04:01 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7R63qxb023574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 01:03:54 -0500
Message-ID: <1377583430.3819.108.camel@pasglop>
Subject: [PATCH] powerpc/btext: Fix CONFIG_PPC_EARLY_DEBUG_BOOTX on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Aug 2013 16:03:50 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "rmci" stuff only exists on 64-bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/btext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 0428992..41c011c 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -52,7 +52,7 @@ extern void rmci_off(void);
 
 static inline void rmci_maybe_on(void)
 {
-#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+#if defined(CONFIG_PPC_EARLY_DEBUG_BOOTX) && defined(CONFIG_PPC64)
 	if (!(mfmsr() & MSR_DR))
 		rmci_on();
 #endif
@@ -60,7 +60,7 @@ static inline void rmci_maybe_on(void)
 
 static inline void rmci_maybe_off(void)
 {
-#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+#if defined(CONFIG_PPC_EARLY_DEBUG_BOOTX) && defined(CONFIG_PPC64)
 	if (!(mfmsr() & MSR_DR))
 		rmci_off();
 #endif
