Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B71BA1400B0
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2014 16:33:32 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 30 Mar 2014 15:33:31 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 203A42BB0045
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2014 16:33:27 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2U5Cs6H4194726
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2014 16:12:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2U5XQ2A009913
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2014 16:33:26 +1100
Subject: [PATCH] powerpc/book3s: Fix mc_recoverable_range buffer overrun issue.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 30 Mar 2014 11:03:23 +0530
Message-ID: <20140330053310.2748.89461.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Currently we wrongly allocate mc_recoverable_range buffer (to hold
recoverable ranges) based on size of the property "mcheck-recoverable-ranges".
This results in allocating less memory to hold available recoverable range
entries from /proc/device-tree/ibm,opal/mcheck-recoverable-ranges.

This patch fixes this issue by allocating mc_recoverable_range buffer based
on number of entries of recoverable ranges instead of device property size.
Without this change we end up allocating less memory and run into memory
corruption issue.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d5f11d6..f4c011f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -102,13 +102,13 @@ int __init early_init_dt_scan_opal(unsigned long node,
 int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 				   const char *uname, int depth, void *data)
 {
-	unsigned long i, size;
+	unsigned long i, psize, size;
 	const __be32 *prop;
 
 	if (depth != 1 || strcmp(uname, "ibm,opal") != 0)
 		return 0;
 
-	prop = of_get_flat_dt_prop(node, "mcheck-recoverable-ranges", &size);
+	prop = of_get_flat_dt_prop(node, "mcheck-recoverable-ranges", &psize);
 
 	if (!prop)
 		return 1;
@@ -116,6 +116,23 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 	pr_debug("Found machine check recoverable ranges.\n");
 
 	/*
+	 * Calculate number of available entries.
+	 *
+	 * Each recoverable address range entry is (start address, len,
+	 * recovery address), 2 cells each for start and recovery address,
+	 * 1 cell for len, totalling 5 cells per entry.
+	 */
+	mc_recoverable_range_len = psize / (sizeof(*prop) * 5);
+
+	/* Sanity check */
+	if (!mc_recoverable_range_len)
+		return 1;
+
+	/* Size required to hold all the entries. */
+	size = mc_recoverable_range_len *
+			sizeof(struct mcheck_recoverable_range);
+
+	/*
 	 * Allocate a buffer to hold the MC recoverable ranges. We would be
 	 * accessing them in real mode, hence it needs to be within
 	 * RMO region.
@@ -124,11 +141,7 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 							ppc64_rma_size));
 	memset(mc_recoverable_range, 0, size);
 
-	/*
-	 * Each recoverable address entry is an (start address,len,
-	 * recover address) pair, * 2 cells each, totalling 4 cells per entry.
-	 */
-	for (i = 0; i < size / (sizeof(*prop) * 5); i++) {
+	for (i = 0; i < mc_recoverable_range_len; i++) {
 		mc_recoverable_range[i].start_addr =
 					of_read_number(prop + (i * 5) + 0, 2);
 		mc_recoverable_range[i].end_addr =
@@ -142,7 +155,6 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 				mc_recoverable_range[i].end_addr,
 				mc_recoverable_range[i].recover_addr);
 	}
-	mc_recoverable_range_len = i;
 	return 1;
 }
 
