Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 523FFB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Oct 2009 02:51:45 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9JFunsA026658
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 11:56:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9JFpfNk198126
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 11:51:41 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9JFpaLD000577
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 09:51:37 -0600
Message-Id: <200910191551.n9JFpZeQ000505@d03av01.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Add kdump support to Collaborative Memory Manager
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 19 Oct 2009 10:51:34 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When running Active Memory Sharing, the Collaborative Memory Manager (CMM)
may mark some pages as "loaned" with the hypervisor. Periodically, the
CMM will query the hypervisor for a loan request, which is a single signed
value. When kexec'ing into a kdump kernel, the CMM driver in the kdump
kernel is not aware of the pages the previous kernel had marked as "loaned",
so the hypervisor and the CMM driver are out of sync. Fix the CMM driver
to handle this scenario by ignoring requests to decrease the number of loaned
pages if we don't think we have any pages loaned. Pages that are marked as
"loaned" which are not in the balloon will automatically get switched to "active"
the next time we touch the page. This also fixes the case where totalram_pages
is smaller than min_mem_mb, which can occur during kdump.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/Kconfig |    2 +-
 arch/powerpc/platforms/pseries/cmm.c   |   29 +++++++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff -puN arch/powerpc/platforms/pseries/cmm.c~powerpc_cmm_fix_kdump arch/powerpc/platforms/pseries/cmm.c
--- linux-2.6/arch/powerpc/platforms/pseries/cmm.c~powerpc_cmm_fix_kdump	2009-09-24 16:35:00.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/cmm.c	2009-09-25 10:24:19.000000000 -0500
@@ -229,8 +229,9 @@ static void cmm_get_mpp(void)
 {
 	int rc;
 	struct hvcall_mpp_data mpp_data;
-	unsigned long active_pages_target;
-	signed long page_loan_request;
+	signed long active_pages_target, page_loan_request, target;
+	signed long total_pages = totalram_pages + loaned_pages;
+	signed long min_mem_pages = (min_mem_mb * 1024 * 1024) / PAGE_SIZE;
 
 	rc = h_get_mpp(&mpp_data);
 
@@ -238,17 +239,25 @@ static void cmm_get_mpp(void)
 		return;
 
 	page_loan_request = div_s64((s64)mpp_data.loan_request, PAGE_SIZE);
-	loaned_pages_target = page_loan_request + loaned_pages;
-	if (loaned_pages_target > oom_freed_pages)
-		loaned_pages_target -= oom_freed_pages;
+	target = page_loan_request + (signed long)loaned_pages;
+
+	if (target < 0 || total_pages < min_mem_pages)
+		target = 0;
+
+	if (target > oom_freed_pages)
+		target -= oom_freed_pages;
 	else
-		loaned_pages_target = 0;
+		target = 0;
+
+	active_pages_target = total_pages - target;
+
+	if (min_mem_pages > active_pages_target)
+		target = total_pages - min_mem_pages;
 
-	active_pages_target = totalram_pages + loaned_pages - loaned_pages_target;
+	if (target < 0)
+		target = 0;
 
-	if ((min_mem_mb * 1024 * 1024) > (active_pages_target * PAGE_SIZE))
-		loaned_pages_target = totalram_pages + loaned_pages -
-			((min_mem_mb * 1024 * 1024) / PAGE_SIZE);
+	loaned_pages_target = target;
 
 	cmm_dbg("delta = %ld, loaned = %lu, target = %lu, oom = %lu, totalram = %lu\n",
 		page_loan_request, loaned_pages, loaned_pages_target,
diff -puN arch/powerpc/platforms/pseries/Kconfig~powerpc_cmm_fix_kdump arch/powerpc/platforms/pseries/Kconfig
--- linux-2.6/arch/powerpc/platforms/pseries/Kconfig~powerpc_cmm_fix_kdump	2009-09-24 16:35:00.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/Kconfig	2009-09-24 16:35:00.000000000 -0500
@@ -59,7 +59,7 @@ config PPC_SMLPAR
 
 config CMM
 	tristate "Collaborative memory management"
-	depends on PPC_SMLPAR && !CRASH_DUMP
+	depends on PPC_SMLPAR
 	default y
 	help
 	  Select this option, if you want to enable the kernel interface
_
