Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F7F5140134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:35 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5EEA12BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dcJV47710328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80WHF004388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 25/25] powerpc/prom: Stop scanning dev-tree for fdump early
Date: Thu, 24 Apr 2014 18:00:31 +1000
Message-Id: <1398326431-24305-26-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function early_init_dt_scan_fw_dump() is called to scan the device
tree for fdump properties under node "rtas". Any one of them is
invalid, we can stop scanning the device tree early by returning
"1". It would save a bit time during boot.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2230fd0..0266774 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -69,7 +69,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	 */
 	token = of_get_flat_dt_prop(node, "ibm,configure-kernel-dump", NULL);
 	if (!token)
-		return 0;
+		return 1;
 
 	fw_dump.fadump_supported = 1;
 	fw_dump.ibm_configure_kernel_dump = *token;
@@ -92,7 +92,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 					&size);
 
 	if (!sections)
-		return 0;
+		return 1;
 
 	num_sections = size / (3 * sizeof(u32));
 
@@ -110,6 +110,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 			break;
 		}
 	}
+
 	return 1;
 }
 
-- 
1.8.3.2
