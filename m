Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54110DE0B6
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 05:52:52 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26Iqmb3032212
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 13:52:48 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26Iqm4v222126
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 11:52:48 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26IqlO5029624
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 11:52:48 -0700
Subject: [PATCH 2/5] [PPC] htab_remove_mapping() error handling
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 10:56:08 -0800
Message-Id: <1204829768.7939.63.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the sub-arch doesn't support hpte_removebolted(), gracefully
return failure rather than success.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |   14 +++++++++-----
 include/asm-powerpc/sparsemem.h |    2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.25-rc3/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-2.6.25-rc3.orig/arch/powerpc/mm/hash_utils_64.c	2008-03-05 10:14:28.000000000 -0800
+++ linux-2.6.25-rc3/arch/powerpc/mm/hash_utils_64.c	2008-03-05 10:18:55.000000000 -0800
@@ -192,7 +192,7 @@ int htab_bolt_mapping(unsigned long vsta
 	return ret < 0 ? ret : 0;
 }
 
-static void htab_remove_mapping(unsigned long vstart, unsigned long vend,
+static int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 		      int psize, int ssize)
 {
 	unsigned long vaddr;
@@ -202,12 +202,15 @@ static void htab_remove_mapping(unsigned
 	step = 1 << shift;
 
 	if (!ppc_md.hpte_removebolted) {
-		printk("Sub-arch doesn't implement hpte_removebolted\n");
-		return;
+		printk(KERN_WARNING "Sub-arch doesn't implement "
+				"hpte_removebolted\n");
+		return -EINVAL;
 	}
 
 	for (vaddr = vstart; vaddr < vend; vaddr += step)
 		ppc_md.hpte_removebolted(vaddr, psize, ssize);
+
+	return 0;
 }
 
 static int __init htab_dt_scan_seg_sizes(unsigned long node,
@@ -449,9 +452,10 @@ void create_section_mapping(unsigned lon
 			mmu_linear_psize, mmu_kernel_ssize));
 }
 
-void remove_section_mapping(unsigned long start, unsigned long end)
+int remove_section_mapping(unsigned long start, unsigned long end)
 {
-	htab_remove_mapping(start, end, mmu_linear_psize, mmu_kernel_ssize);
+	return htab_remove_mapping(start, end, mmu_linear_psize,
+			mmu_kernel_ssize);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
Index: linux-2.6.25-rc3/include/asm-powerpc/sparsemem.h
===================================================================
--- linux-2.6.25-rc3.orig/include/asm-powerpc/sparsemem.h	2008-03-05 10:14:31.000000000 -0800
+++ linux-2.6.25-rc3/include/asm-powerpc/sparsemem.h	2008-03-05 10:19:09.000000000 -0800
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);
-extern void remove_section_mapping(unsigned long start, unsigned long end);
+extern int remove_section_mapping(unsigned long start, unsigned long end);
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
 #else
