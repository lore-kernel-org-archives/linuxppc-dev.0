Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B54C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213CA20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213CA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qt4R32BDzF3Fj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 04:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qsyC08kSzF3Hf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 03:56:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qsy53WMsz9tvr0;
 Wed,  7 Nov 2018 17:56:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CeMppXwPGisB; Wed,  7 Nov 2018 17:56:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qsy52yNRz9tvqG;
 Wed,  7 Nov 2018 17:56:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E3708B815;
 Wed,  7 Nov 2018 17:56:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ekpdvan6Fb7m; Wed,  7 Nov 2018 17:56:31 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 61FA08B814;
 Wed,  7 Nov 2018 17:56:31 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 58DF76995E; Wed,  7 Nov 2018 16:56:31 +0000 (UTC)
Message-Id: <1b27e980fa8dda09955b35be09c99bb1e22fef70.1541568127.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 3/6] powerpc: Add skeleton for Kernel Userspace
 Execution Prevention
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Wed,  7 Nov 2018 16:56:31 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds a skeleton for Kernel Userspace Execution Prevention.

Then subarches implementing it have to define CONFIG_PPC_HAVE_KUEP
and provide setup_kuep() function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/powerpc/include/asm/mmu.h                  |  6 ++++++
 arch/powerpc/mm/fault.c                         |  3 ++-
 arch/powerpc/mm/init-common.c                   | 11 +++++++++++
 arch/powerpc/platforms/Kconfig.cputype          | 12 ++++++++++++
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..1103549363bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2796,7 +2796,7 @@
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[X86]
+	nosmep		[X86,PPC]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 39c51dcba8f4..cf92f2a813a8 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -270,6 +270,12 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 
 void setup_kup(void);
 
+#ifdef CONFIG_PPC_KUEP
+void setup_kuep(bool disabled);
+#else
+static inline void setup_kuep(bool disabled) { }
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 50e5c790d11e..e57bd46cf25b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -230,8 +230,9 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
 				      DSISR_PROTFAULT))) {
 		printk_ratelimited(KERN_CRIT "kernel tried to execute"
-				   " exec-protected page (%lx) -"
+				   " %s page (%lx) -"
 				   "exploit attempt? (uid: %d)\n",
+				   address >= TASK_SIZE ? "exec-protected" : "user",
 				   address, from_kuid(&init_user_ns,
 						      current_uid()));
 	}
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index e469814e8290..89c8bd58509e 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,8 +25,19 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
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
 void setup_kup(void)
 {
+	setup_kuep(disable_kuep);
 }
 
 static void pgd_ctor(void *addr)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..70830cb3c18a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -351,6 +351,18 @@ config PPC_RADIX_MMU_DEFAULT
 
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
2.13.3

