Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F04AEB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 15:38:31 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
Date: Fri,  9 Jul 2010 00:37:59 -0500
Message-Id: <1278653879-27093-1-git-send-email-msm@freescale.com>
In-Reply-To: <20100708-mitltonm-msm-reply@mdm.bga.com>
References: <20100708-mitltonm-msm-reply@mdm.bga.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, Milton Miller <miltonm@bga.com>,
	Matthew McClintock <msm@freescale.com>
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
 arch/powerpc/kernel/machine_kexec.c |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 5fb667a..d254132 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -128,9 +128,9 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	csize = min(csize, PAGE_SIZE);
+	csize = min_t(size_t, csize, PAGE_SIZE);
 
-	if (pfn < max_pfn) {
+	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
 		vaddr = __va(pfn << PAGE_SHIFT);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 	} else {
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index bb3d893..6ff15f0 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -144,24 +144,24 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
 }
 
 /* Values we need to export to the second kernel via the device tree. */
-static unsigned long kernel_end;
-static unsigned long crashk_size;
+static phys_addr_t kernel_end;
+static phys_addr_t crashk_size;
 
 static struct property kernel_end_prop = {
 	.name = "linux,kernel-end",
-	.length = sizeof(unsigned long),
+	.length = sizeof(phys_addr_t),
 	.value = &kernel_end,
 };
 
 static struct property crashk_base_prop = {
 	.name = "linux,crashkernel-base",
-	.length = sizeof(unsigned long),
+	.length = sizeof(phys_addr_t),
 	.value = &crashk_res.start,
 };
 
 static struct property crashk_size_prop = {
 	.name = "linux,crashkernel-size",
-	.length = sizeof(unsigned long),
+	.length = sizeof(phys_addr_t),
 	.value = &crashk_size,
 };
 
-- 
1.6.6.1
