Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48B061A001D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 03:16:38 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 02:16:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4D5C32CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 03:16:32 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LGGOKS51052732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 03:16:32 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LGFwOS027895
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 03:15:59 +1100
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
Date: Thu, 21 Jan 2016 21:45:31 +0530
Message-Id: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
rtas_rmo_buf from user space is failing. Hence we are not able to make
RTAS syscall.

This patch calls page_is_rtas_user_buf before calling iomem_is_exclusive
in  devmem_is_allowed(). This will allow user space to map rtas_rmo_buf
and we are able to make RTAS syscall.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 22d94c3..d0f0a51 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -560,12 +560,12 @@ subsys_initcall(add_system_ram_resources);
  */
 int devmem_is_allowed(unsigned long pfn)
 {
+	if (page_is_rtas_user_buf(pfn))
+		return 1;
 	if (iomem_is_exclusive(PFN_PHYS(pfn)))
 		return 0;
 	if (!page_is_ram(pfn))
 		return 1;
-	if (page_is_rtas_user_buf(pfn))
-		return 1;
 	return 0;
 }
 #endif /* CONFIG_STRICT_DEVMEM */
-- 
2.1.0
