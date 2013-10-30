Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp17.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12C772C0704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 00:49:10 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 30 Oct 2013 13:49:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FEFB219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:49:04 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UDlaDt61997226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:36 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UDlmrP003996
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 07:47:48 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 3/3] powerpc/nvram: fix endian issue when using the partition
 length
Date: Wed, 30 Oct 2013 14:47:08 +0100
Message-Id: <1383140828-7481-4-git-send-email-clg@fr.ibm.com>
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

When reading partitions, the length has to be translated from 
big endian to the endian order of the host. Similarly, when writing 
partitions, the length needs to be in big endian order.

The userspace tool 'nvram' needs a similar fix as it is reading
and writing partitions through /dev/nram :

    http://sourceforge.net/p/powerpc-utils/mailman/message/31571277/

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 8213ee1..fd82c28 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -223,9 +223,13 @@ static int __init nvram_write_header(struct nvram_partition * part)
 {
 	loff_t tmp_index;
 	int rc;
-	
+	struct nvram_header phead;
+
+	memcpy(&phead, &part->header, NVRAM_HEADER_LEN);
+	phead.length = cpu_to_be16(phead.length);
+
 	tmp_index = part->index;
-	rc = ppc_md.nvram_write((char *)&part->header, NVRAM_HEADER_LEN, &tmp_index); 
+	rc = ppc_md.nvram_write((char *)&phead, NVRAM_HEADER_LEN, &tmp_index);
 
 	return rc;
 }
@@ -505,6 +509,8 @@ int __init nvram_scan_partitions(void)
 
 		memcpy(&phead, header, NVRAM_HEADER_LEN);
 
+		phead.length = be16_to_cpu(phead.length);
+
 		err = 0;
 		c_sum = nvram_checksum(&phead);
 		if (c_sum != phead.checksum) {
-- 
1.7.10.4
