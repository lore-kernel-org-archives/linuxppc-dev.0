Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLyP763CfzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 02:48:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH] powerpc/mm: Add a CONFIG option to choose if radix is used by
 default
Date: Tue, 24 Oct 2017 17:48:49 +0200
Message-Id: <1508860129-28365-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if the hardware supports the radix MMU we will use
it, *unless* "disable_radix" is passed on the kernel command line.

However some users would like the reverse semantics. ie. The kernel
uses the hash MMU by default, unless radix is explicitly requested on
the command line.

So add a CONFIG option to choose whether we use radix by default or
not, and expand the disable_radix command line option to allow
"disable_radix=no" which *enables* radix.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/init_64.c              | 13 +++++++++++--
 arch/powerpc/platforms/Kconfig.cputype | 13 +++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 12b3025fadac..a07722531b32 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -368,10 +368,19 @@ EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 #ifdef CONFIG_PPC_BOOK3S_64
-static bool disable_radix;
+static bool disable_radix = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
+
 static int __init parse_disable_radix(char *p)
 {
-	disable_radix = true;
+	bool val;
+
+	if (strlen(p) == 0)
+		val = true;
+	else if (kstrtobool(p, &val))
+		return -EINVAL;
+
+	disable_radix = val;
+
 	return 0;
 }
 early_param("disable_radix", parse_disable_radix);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f8928ee85f6b..596bd9091478 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -304,6 +304,19 @@ config PPC_RADIX_MMU
 	  is only implemented by IBM Power9 CPUs, if you don't have one of them
 	  you can probably disable this.
 
+config PPC_RADIX_MMU_DEFAULT
+	bool "Default to using the Radix MMU when possible"
+	depends on PPC_RADIX_MMU
+	default y
+	help
+	  When the hardware supports the Radix MMU, default to using it unless
+	  "disable_radix[=yes]" is specified on the kernel command line.
+
+	  If this option is disabled, the Hash MMU will be used by default,
+	  unless "disable_radix=no" is specified on the kernel command line.
+
+	  If you're unsure, say Y.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
-- 
2.7.4
