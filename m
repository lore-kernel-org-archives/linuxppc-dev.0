Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4B3C2C051D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:56:02 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 8/8] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Date: Thu, 4 Jul 2013 20:54:14 +0800
Message-ID: <1372942454-25191-9-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
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
A new patch in v2.

 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5b2e115..885bf06 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -375,8 +375,7 @@ config KEXEC
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
1.8.1.4
