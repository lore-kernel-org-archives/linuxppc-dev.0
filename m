Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp14.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E43E82C0391
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 00:47:54 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 30 Oct 2013 13:47:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F2F1219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:47 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UDlY0055967836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:34 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UDljmb026591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 07:47:46 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc/nvram: scan partitions only once
Date: Wed, 30 Oct 2013 14:47:06 +0100
Message-Id: <1383140828-7481-2-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1383140828-7481-1-git-send-email-clg@fr.ibm.com>
References: <1383140828-7481-1-git-send-email-clg@fr.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cedric Le Goater <clg@fr.ibm.com>

nvram_scan_partitions() is called twice when initializing the "lnx,oops-log"
partition and the "ibm,rtas-log" partition. This fills the partition list
with duplicate entries. This patch moves the partition scan in the init
routine pseries_nvram_init_log_partitions() which is called only once.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index d276cd3..2498d4d 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -429,9 +429,6 @@ static int __init pseries_nvram_init_os_partition(struct nvram_os_partition
 	loff_t p;
 	int size;
 
-	/* Scan nvram for partitions */
-	nvram_scan_partitions();
-
 	/* Look for ours */
 	p = nvram_find_partition(part->name, NVRAM_SIG_OS, &size);
 
@@ -795,6 +792,9 @@ static int __init pseries_nvram_init_log_partitions(void)
 {
 	int rc;
 
+	/* Scan nvram for partitions */
+	nvram_scan_partitions();
+
 	rc = pseries_nvram_init_os_partition(&rtas_log_partition);
 	nvram_init_oops_partition(rc == 0);
 	return 0;
-- 
1.7.10.4
