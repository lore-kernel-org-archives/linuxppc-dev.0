Return-Path: <haokexin@gmail.com>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDN96tC3zDrcC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:07:21 +1000 (AEST)
Received: by mail-yb0-x241.google.com with SMTP id b96so1091977ybi.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:07:21 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/5] powerpc: introduce arch_enable_default_of_probe()
Date: Tue, 23 Aug 2016 10:06:56 +0800
Message-Id: <1471918019-19472-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can use this function to enable the default of probe for one
board.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/setup.h  | 1 +
 arch/powerpc/kernel/of_platform.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 654d64c9f3ac..213719882fe4 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -24,6 +24,7 @@ extern void reloc_got2(unsigned long);
 void check_for_initrd(void);
 void initmem_init(void);
 void setup_panic(void);
+extern void arch_enable_default_of_probe(void);
 #define ARCH_PANIC_TIMEOUT 180
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index ace7fe132b6f..77402a14e928 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -123,7 +123,14 @@ device_initcall(of_pci_phb_init);
 
 #endif /* CONFIG_PPC_OF_PLATFORM_PCI */
 
+static bool default_of_probe_enabled;
+
 bool __init arch_want_default_of_probe(void)
 {
-	return false;
+	return default_of_probe_enabled;
+}
+
+void __init arch_enable_default_of_probe(void)
+{
+	default_of_probe_enabled = true;
 }
-- 
2.5.5
