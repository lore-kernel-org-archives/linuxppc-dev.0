Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szHCm68KfzDt24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 14:16:36 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id r16so1085075pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:16:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 7/7] powerpc/64: allow CONFIG_RELOCATABLE if COMPILE_TEST
Date: Wed, 19 Oct 2016 14:16:00 +1100
Message-Id: <20161019031600.17933-8-npiggin@gmail.com>
In-Reply-To: <20161019031600.17933-1-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is cruft to work around allmodconfig build breakage.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00d9e31..f48d2eb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -458,7 +458,7 @@ config KEXEC
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
+	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
@@ -482,7 +482,7 @@ config RELOCATABLE
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
+	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
-- 
2.9.3
