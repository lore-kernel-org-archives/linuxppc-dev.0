Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 842912C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:37:55 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 15:33:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A147D2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:37:50 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OIbeH07274996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:37:40 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OIbnmq006334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:37:50 +1000
Message-ID: <51F01EFB.6070207@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 13:37:47 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] Add all memory via sysfs probe interface at once
References: <51F01E06.6090800@linux.vnet.ibm.com>
In-Reply-To: <51F01E06.6090800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 isimatu.yasuaki@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When doing memory hot add via the 'probe' interface in sysfs we do not
need to loop through and add memory one section at a time. I think this
was originally done for powerpc, but is not needed. This patch removes
the loop and just calls add_memory for all of the memory to be added.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 drivers/base/memory.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

Index: linux/drivers/base/memory.c
===================================================================
--- linux.orig/drivers/base/memory.c
+++ linux/drivers/base/memory.c
@@ -427,8 +427,8 @@ memory_probe_store(struct device *dev, s
 		   const char *buf, size_t count)
 {
 	u64 phys_addr;
-	int nid;
-	int i, ret;
+	int nid, ret;
+	unsigned long block_size;
 	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
 
 	phys_addr = simple_strtoull(buf, NULL, 0);
@@ -436,19 +436,11 @@ memory_probe_store(struct device *dev, s
 	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
 		return -EINVAL;
 
-	for (i = 0; i < sections_per_block; i++) {
-		nid = memory_add_physaddr_to_nid(phys_addr);
-		ret = add_memory(nid, phys_addr,
-				 PAGES_PER_SECTION << PAGE_SHIFT);
-		if (ret)
-			goto out;
+	block_size = get_memory_block_size();
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	ret = add_memory(nid, phys_addr, block_size);
 
-		phys_addr += MIN_MEMORY_BLOCK_SIZE;
-	}
-
-	ret = count;
-out:
-	return ret;
+	return ret ? ret : count;
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
