Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB6682C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:25:17 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 7/7] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Date: Wed, 7 Aug 2013 09:18:35 +0800
Message-ID: <1375838315-27797-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RELOCATABLE is more flexible and without any alignment restriction.
And it is a superset of DYNAMIC_MEMSTART. So use it by default for
a kdump kernel.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v3: no change.

v2: A new patch in v2.

 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 57dc8f9..7553d72 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -376,8 +376,7 @@ config KEXEC
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if PPC64 || 44x
-	select DYNAMIC_MEMSTART if FSL_BOOKE
+	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
-- 
1.8.3.1
