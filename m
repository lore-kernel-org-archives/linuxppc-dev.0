Return-Path: <pbadari@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91B8BDDE99
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:41:41 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGf8Ev010948
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:41:08 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGfOMc033882
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:29 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGfL9E005089
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:21 -0700
Received: from dyn9047017100.beaverton.ibm.com
	(dyn9047017100.beaverton.ibm.com [9.47.17.100])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1SGfKQK005042
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:41:21 -0700
Subject: [PATCH 1/3] ppc64-specific remove htab bolted mapping support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 08:44:35 -0800
Message-Id: <1204217076.28696.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For memory remove, we need to clean up htab mappings for the
section of the memory we are removing.

This patch implements support for removing htab bolted mappings
for ppc64 lpar. Other sub-archs, may need to implement similar
functionality for the hotplug memory remove to work. 

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/mm/hash_utils_64.c       |   26 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/lpar.c |   15 +++++++++++++++
 include/asm-powerpc/machdep.h         |    2 ++
 include/asm-powerpc/sparsemem.h       |    1 +
 5 files changed, 44 insertions(+), 4 deletions(-)

Index: linux-2.6.25-rc2/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-2.6.25-rc2.orig/arch/powerpc/mm/hash_utils_64.c	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/arch/powerpc/mm/hash_utils_64.c	2008-02-27 12:59:53.000000000 -0800
@@ -191,6 +191,26 @@ int htab_bolt_mapping(unsigned long vsta
 	return ret < 0 ? ret : 0;
 }
 
+static int htab_remove_mapping(unsigned long vstart, unsigned long vend,
+		      int psize, int ssize)
+{
+	unsigned long vaddr;
+	unsigned int step, shift;
+
+	shift = mmu_psize_defs[psize].shift;
+	step = 1 << shift;
+
+	if (!ppc_md.hpte_removebolted) {
+		printk("Sub-arch doesn't implement hpte_removebolted\n");
+		return -EINVAL;
+	}
+
+	for (vaddr = vstart; vaddr < vend; vaddr += step)
+		ppc_md.hpte_removebolted(vaddr, psize, ssize);
+
+	return 0;
+}
+
 static int __init htab_dt_scan_seg_sizes(unsigned long node,
 					 const char *uname, int depth,
 					 void *data)
@@ -429,6 +449,12 @@ void create_section_mapping(unsigned lon
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX,
 			mmu_linear_psize, mmu_kernel_ssize));
 }
+
+int remove_section_mapping(unsigned long start, unsigned long end)
+{
+	return htab_remove_mapping(start, end, mmu_linear_psize,
+				mmu_kernel_ssize);
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 static inline void make_bl(unsigned int *insn_addr, void *func)
Index: linux-2.6.25-rc2/include/asm-powerpc/sparsemem.h
===================================================================
--- linux-2.6.25-rc2.orig/include/asm-powerpc/sparsemem.h	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/include/asm-powerpc/sparsemem.h	2008-02-27 12:59:53.000000000 -0800
@@ -15,6 +15,7 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);
+extern int remove_section_mapping(unsigned long start, unsigned long end);
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
 #else
Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6.25-rc2.orig/arch/powerpc/platforms/pseries/lpar.c	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/lpar.c	2008-02-27 12:59:53.000000000 -0800
@@ -520,6 +520,20 @@ static void pSeries_lpar_hpte_invalidate
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+static void pSeries_lpar_hpte_removebolted(unsigned long ea,
+					   int psize, int ssize)
+{
+	unsigned long slot, vsid, va;
+
+	vsid = get_kernel_vsid(ea, ssize);
+	va = hpt_va(ea, vsid, ssize);
+
+	slot = pSeries_lpar_hpte_find(va, psize, ssize);
+	BUG_ON(slot == -1);
+
+	pSeries_lpar_hpte_invalidate(slot, va, psize, ssize, 0);
+}
+
 /* Flag bits for H_BULK_REMOVE */
 #define HBR_REQUEST	0x4000000000000000UL
 #define HBR_RESPONSE	0x8000000000000000UL
@@ -597,6 +611,7 @@ void __init hpte_init_lpar(void)
 	ppc_md.hpte_updateboltedpp = pSeries_lpar_hpte_updateboltedpp;
 	ppc_md.hpte_insert	= pSeries_lpar_hpte_insert;
 	ppc_md.hpte_remove	= pSeries_lpar_hpte_remove;
+	ppc_md.hpte_removebolted = pSeries_lpar_hpte_removebolted;
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
 	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
 }
Index: linux-2.6.25-rc2/include/asm-powerpc/machdep.h
===================================================================
--- linux-2.6.25-rc2.orig/include/asm-powerpc/machdep.h	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/include/asm-powerpc/machdep.h	2008-02-27 12:59:53.000000000 -0800
@@ -68,6 +68,8 @@ struct machdep_calls {
 				       unsigned long vflags,
 				       int psize, int ssize);
 	long		(*hpte_remove)(unsigned long hpte_group);
+	void            (*hpte_removebolted)(unsigned long ea,
+					       int psize, int ssize);
 	void		(*flush_hash_range)(unsigned long number, int local);
 
 	/* special for kexec, to be called in real mode, linar mapping is
