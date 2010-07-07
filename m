Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D613CB6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 06:52:02 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o67Kpx01013379 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 7 Jul 2010 13:51:59 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
Date: Wed,  7 Jul 2010 15:51:20 -0500
Message-Id: <1278535881-6463-1-git-send-email-msm@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix sizes of variables so correct values are exported via /proc.
Cast variable in comparison to avoid compiler error.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/crash_dump.c    |    4 ++--
 arch/powerpc/kernel/machine_kexec.c |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 5fb667a..71cadde 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -128,9 +128,9 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	csize = min(csize, PAGE_SIZE);
+	csize = min(csize, (size_t)PAGE_SIZE);
 
-	if (pfn < max_pfn) {
+	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
 		vaddr = __va(pfn << PAGE_SHIFT);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 	} else {
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index bb3d893..ec7f054 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -145,6 +145,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
 
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long kernel_end;
+static unsigned long crashk_start;
 static unsigned long crashk_size;
 
 static struct property kernel_end_prop = {
@@ -156,7 +157,7 @@ static struct property kernel_end_prop = {
 static struct property crashk_base_prop = {
 	.name = "linux,crashkernel-base",
 	.length = sizeof(unsigned long),
-	.value = &crashk_res.start,
+	.value = &crashk_start,
 };
 
 static struct property crashk_size_prop = {
@@ -180,6 +181,7 @@ static void __init export_crashk_values(struct device_node *node)
 		prom_remove_property(node, prop);
 
 	if (crashk_res.start != 0) {
+		crashk_start = crashk_res.start;
 		prom_add_property(node, &crashk_base_prop);
 		crashk_size = crashk_res.end - crashk_res.start + 1;
 		prom_add_property(node, &crashk_size_prop);
-- 
1.6.6.1
