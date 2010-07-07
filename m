Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D61BEB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 06:52:02 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o67Kq0Vq013418 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 7 Jul 2010 13:52:00 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/booke: Enable building of a crash dump kernel
Date: Wed,  7 Jul 2010 15:51:21 -0500
Message-Id: <1278535881-6463-2-git-send-email-msm@freescale.com>
In-Reply-To: <1278535881-6463-1-git-send-email-msm@freescale.com>
References: <1278535881-6463-1-git-send-email-msm@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable building crash dump kernel as well as expose the flat
device tree for kexec to update to boot the crash kernel
---
 arch/powerpc/Kconfig       |    2 +-
 arch/powerpc/kernel/prom.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 042f2f0..0b60c57 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -368,7 +368,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx
+	depends on PPC64 || 6xx || FSL_BOOKE
 	select RELOCATABLE if PPC64
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05131d6..fd9359a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -892,7 +892,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 }
 EXPORT_SYMBOL(of_get_cpu_node);
 
-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
+#if defined(CONFIG_DEBUG_FS) && (defined(DEBUG) || defined(CONFIG_KEXEC))
 static struct debugfs_blob_wrapper flat_dt_blob;
 
 static int __init export_flat_device_tree(void)
-- 
1.6.6.1
