Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 81D5BB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 07:13:50 +1000 (EST)
Received: from mail48-va3 (localhost.localdomain [127.0.0.1])	by
	mail48-va3-R.bigfish.com (Postfix) with ESMTP id 02DB91658333	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:39 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.238])	by
	mail48-va3.bigfish.com (Postfix) with ESMTP id B8C0E138053	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:38 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6LLDaJt009042	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 14:13:36 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
Date: Wed, 21 Jul 2010 16:14:54 -0500
Message-ID: <1279746894-29529-3-git-send-email-msm@freescale.com>
In-Reply-To: <1279746894-29529-1-git-send-email-msm@freescale.com>
References: <1279746894-29529-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
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
