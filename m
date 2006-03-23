Return-Path: <haren@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17B5467A01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 15:30:47 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2N4UhZI005031
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 23:30:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2N4XjOu189218
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 21:33:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2N4UgeZ011597
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 21:30:43 -0700
Message-ID: <44222462.2030103@us.ibm.com>
Date: Wed, 22 Mar 2006 20:30:26 -0800
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] kdump: Fix for machine checkstop on DMA fault
Content-Type: multipart/mixed; boundary="------------060300080802040207080806"
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller <miltonm@bga.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060300080802040207080806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul, If you are OK with this fix, please send it upstream.

Thanks
Haren

- Some machines checkstop on dma protection fault for ongoing DMA left 
in the first kernel. Since, we do not shutdown devices before the kdump 
boot, let them continue DMA to old kernel space.

Signed-off-by: Haren Myneni <haren@us.ibm.com>




--------------060300080802040207080806
Content-Type: text/x-patch;
 name="kdump-dma-fault-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-dma-fault-fix.patch"

--- 2616-git5-k1/arch/powerpc/kernel/iommu.c.orig	2006-04-04 19:08:02.000000000 -0700
+++ 2616-git5-k1/arch/powerpc/kernel/iommu.c	2006-04-04 10:50:45.000000000 -0700
@@ -427,8 +427,10 @@ struct iommu_table *iommu_init_table(str
 	tbl->it_largehint = tbl->it_halfpoint;
 	spin_lock_init(&tbl->it_lock);
 
+#ifndef CONFIG_CRASH_DUMP
 	/* Clear the hardware table in case firmware left allocations in it */
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
+#endif
 
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",

--------------060300080802040207080806--
