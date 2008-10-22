Return-Path: <kniht@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0117DDDD4
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:27:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9M1RZcQ022123
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 21:27:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9M1RZpv100100
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:27:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9M1R6w7022386
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:27:06 -0600
Received: from [9.12.243.33] ([9.12.243.33])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m9M1R5Li022367
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:27:06 -0600
Message-ID: <48FE8188.8030706@us.ibm.com>
Date: Tue, 21 Oct 2008 20:27:36 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Don't use a 16G page if beyond mem= limits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If mem= is used on the boot command line to limit memory then the memory block where a 16G page resides may not be available.

Thanks to Michael Ellerman for finding the problem.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

 arch/powerpc/mm/hash_utils_64.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5c64af1..8d5b475 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -382,8 +382,10 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 	printk(KERN_INFO "Huge page(16GB) memory: "
 			"addr = 0x%lX size = 0x%lX pages = %d\n",
 			phys_addr, block_size, expected_pages);
-	lmb_reserve(phys_addr, block_size * expected_pages);
-	add_gpage(phys_addr, block_size, expected_pages);
+	if (phys_addr + (16 * GB) <= lmb_end_of_DRAM()) {
+		lmb_reserve(phys_addr, block_size * expected_pages);
+		add_gpage(phys_addr, block_size, expected_pages);
+	}
 	return 0;
 }
 #endif /* CONFIG_HUGETLB_PAGE */
