Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLdcg55HczDsSr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 22:12:35 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 72so5555744pfl.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:12:35 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] powerpc/strict_kernel_rwx: Don't depend on !RELOCATABLE
Date: Mon, 31 Jul 2017 22:11:03 +1000
Message-Id: <20170731121103.6984-4-bsingharora@gmail.com>
In-Reply-To: <20170731121103.6984-1-bsingharora@gmail.com>
References: <20170731121103.6984-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The concerns with extra permissions and overlap have been
address, remove the dependency on !RELOCTABLE

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c..b5b8ba8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -165,7 +165,7 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S_64 && !RELOCATABLE && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S_64 && !HIBERNATION)
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_CONTEXT_TRACKING		if PPC64
-- 
2.9.4
