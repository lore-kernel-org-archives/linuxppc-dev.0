Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77111C10F0B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 06:57:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F196F20821
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 06:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F196F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l9016LK6zDqPP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 16:57:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l8sK1w8ZzDqNn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 16:51:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44l8sK0vqCz9s4V; Thu, 18 Apr 2019 16:51:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44l8sK02s2z9s9y; Thu, 18 Apr 2019 16:51:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 04/10] powerpc: Add skeleton for Kernel Userspace Execution
 Prevention
Date: Thu, 18 Apr 2019 16:51:19 +1000
Message-Id: <20190418065125.2687-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418065125.2687-1-mpe@ellerman.id.au>
References: <20190418065125.2687-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

This patch adds a skeleton for Kernel Userspace Execution Prevention.

Then subarches implementing it have to define CONFIG_PPC_HAVE_KUEP
and provide setup_kuep() function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Don't split strings, use pr_crit_ratelimited()]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v6: Unchanged.
v5: Unchanged.
v4: mpe: Don't split strings, use pr_crit_ratelimited()
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/powerpc/include/asm/kup.h                  |  6 ++++++
 arch/powerpc/mm/fault.c                         |  9 ++++-----
 arch/powerpc/mm/init-common.c                   | 11 +++++++++++
 arch/powerpc/platforms/Kconfig.cputype          | 12 ++++++++++++
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..a53df74589e5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2843,7 +2843,7 @@
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[X86]
+	nosmep		[X86,PPC]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 7a88b8b9b54d..a2a959cb4e36 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -6,6 +6,12 @@
 
 void setup_kup(void);
 
+#ifdef CONFIG_PPC_KUEP
+void setup_kuep(bool disabled);
+#else
+static inline void setup_kuep(bool disabled) { }
+#endif /* CONFIG_PPC_KUEP */
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_KUP_H_ */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 887f11bcf330..3384354abc1d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -229,11 +229,10 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	/* NX faults set DSISR_PROTFAULT on the 8xx, DSISR_NOEXEC_OR_G on others */
 	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
 				      DSISR_PROTFAULT))) {
-		printk_ratelimited(KERN_CRIT "kernel tried to execute"
-				   " exec-protected page (%lx) -"
-				   "exploit attempt? (uid: %d)\n",
-				   address, from_kuid(&init_user_ns,
-						      current_uid()));
+		pr_crit_ratelimited("kernel tried to execute %s page (%lx) - exploit attempt? (uid: %d)\n",
+				    address >= TASK_SIZE ? "exec-protected" : "user",
+				    address,
+				    from_kuid(&init_user_ns, current_uid()));
 	}
 	return is_exec || (address >= TASK_SIZE);
 }
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 36d28e872289..83f95a5565d6 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -26,8 +26,19 @@
 #include <asm/pgtable.h>
 #include <asm/kup.h>
 
+static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
+
+static int __init parse_nosmep(char *p)
+{
+	disable_kuep = true;
+	pr_warn("Disabling Kernel Userspace Execution Prevention\n");
+	return 0;
+}
+early_param("nosmep", parse_nosmep);
+
 void __init setup_kup(void)
 {
+	setup_kuep(disable_kuep);
 }
 
 #define CTOR(shift) static void ctor_##shift(void *addr) \
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..7d30bbbaa3c1 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -345,6 +345,18 @@ config PPC_RADIX_MMU_DEFAULT
 
 	  If you're unsure, say Y.
 
+config PPC_HAVE_KUEP
+	bool
+
+config PPC_KUEP
+	bool "Kernel Userspace Execution Prevention"
+	depends on PPC_HAVE_KUEP
+	default y
+	help
+	  Enable support for Kernel Userspace Execution Prevention (KUEP)
+
+	  If you're unsure, say Y.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
-- 
2.20.1

