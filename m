Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9221A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 22:30:23 +1000 (AEST)
Received: by yhcb70 with SMTP id b70so12660310yhc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 05:30:21 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: fix the dependency issue for CRASH_DUMP
Date: Thu, 30 Apr 2015 20:29:56 +0800
Message-Id: <1430396997-14656-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
References: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current code, the RELOCATABLE will be forcedly enabled when
enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause build
error when CRASH_DUMP=y && ADVANCED_OPTIONS=n. Even there is no such
issue for ppc64, but select is only for non-visible symbols and for
symbols with no dependencies. As for a symbol like RELOCATABLE, it is
definitely not suitable to select it. So choose to depend on it.

Also enable the RELOCATABLE explicitly for the defconfigs which has
CRASH_DUMP enabled.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                 | 3 +--
 arch/powerpc/configs/ppc64_defconfig | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 190cc48abc0c..d6bbf4f6f869 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -429,8 +429,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
+	depends on 6xx || ((PPC64 || FSL_BOOKE || (44x && !SMP)) && RELOCATABLE)
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index aad501ae3834..01f7b63f2df0 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -46,6 +46,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
+CONFIG_RELOCATABLE=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
-- 
2.1.0
