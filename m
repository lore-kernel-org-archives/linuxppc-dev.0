Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A36F72C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:58 +1100 (EST)
Received: by mail-pd0-f171.google.com with SMTP id z10so6021678pdj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:54 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 10/10] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Date: Tue, 24 Dec 2013 15:12:12 +0800
Message-Id: <1387869132-12650-11-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
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
v4: No change.

v3: No change.

v2: A new patch in v2.

 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f5b464c41117..569784af841c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -399,8 +399,7 @@ config KEXEC
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
