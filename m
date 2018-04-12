Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MWmB1TqJzDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 05:52:57 +1000 (AEST)
Received: by mail-wr0-x244.google.com with SMTP id o3so6224551wri.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 12:52:57 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sparse: fix plain integer as NULL pointer warning
Date: Thu, 12 Apr 2018 21:52:35 +0200
Message-Id: <20180412195236.10268-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trivial fix to remove the following sparse warnings:

  arch/powerpc/kernel/module_32.c:112:74: warning: Using plain integer as NULL pointer
  arch/powerpc/kernel/module_32.c:117:74: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:1155:28: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:1230:20: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:1385:36: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:1752:23: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:2084:19: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:2110:32: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:2167:19: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:2183:19: warning: Using plain integer as NULL pointer
  drivers/macintosh/via-pmu.c:277:20: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/setup.c:155:67: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/setup.c:247:27: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/setup.c:249:27: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/setup.c:252:37: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/tlb_hash32.c:127:21: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/tlb_hash32.c:148:21: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/tlb_hash32.c:44:21: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/tlb_hash32.c:57:21: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/tlb_hash32.c:87:21: warning: Using plain integer as NULL pointer
  arch/powerpc/kernel/btext.c:160:31: warning: Using plain integer as NULL pointer
  arch/powerpc/kernel/btext.c:167:22: warning: Using plain integer as NULL pointer
  arch/powerpc/kernel/btext.c:274:21: warning: Using plain integer as NULL pointer
  arch/powerpc/kernel/btext.c:285:31: warning: Using plain integer as NULL pointer
  arch/powerpc/include/asm/hugetlb.h:204:16: warning: Using plain integer as NULL pointer
  arch/powerpc/mm/ppc_mmu_32.c:170:21: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/pci.c:1227:23: warning: Using plain integer as NULL pointer
  arch/powerpc/platforms/powermac/pci.c:65:24: warning: Using plain integer as NULL pointer

Also use `--fix` command line option from `script/checkpatch --strict` to
remove the following:

  CHECK: Comparison to NULL could be written "!dispDeviceBase"
  #72: FILE: arch/powerpc/kernel/btext.c:160:
  +	if (dispDeviceBase == NULL)

  CHECK: Comparison to NULL could be written "!vbase"
  #80: FILE: arch/powerpc/kernel/btext.c:167:
  +	if (vbase == NULL)

  CHECK: Comparison to NULL could be written "!base"
  #89: FILE: arch/powerpc/kernel/btext.c:274:
  +	if (base == NULL)

  CHECK: Comparison to NULL could be written "!dispDeviceBase"
  #98: FILE: arch/powerpc/kernel/btext.c:285:
  +	if (dispDeviceBase == NULL)

  CHECK: Comparison to NULL could be written "strstr"
  #117: FILE: arch/powerpc/kernel/module_32.c:117:
  +		if (strstr(secstrings + sechdrs[i].sh_name, ".debug") != NULL)

  CHECK: Comparison to NULL could be written "!Hash"
  #130: FILE: arch/powerpc/mm/ppc_mmu_32.c:170:
  +	if (Hash == NULL)

  CHECK: Comparison to NULL could be written "Hash"
  #143: FILE: arch/powerpc/mm/tlb_hash32.c:44:
  +	if (Hash != NULL) {

  CHECK: Comparison to NULL could be written "!Hash"
  #152: FILE: arch/powerpc/mm/tlb_hash32.c:57:
  +	if (Hash == NULL) {

  CHECK: Comparison to NULL could be written "!Hash"
  #161: FILE: arch/powerpc/mm/tlb_hash32.c:87:
  +	if (Hash == NULL) {

  CHECK: Comparison to NULL could be written "!Hash"
  #170: FILE: arch/powerpc/mm/tlb_hash32.c:127:
  +	if (Hash == NULL) {

  CHECK: Comparison to NULL could be written "!Hash"
  #179: FILE: arch/powerpc/mm/tlb_hash32.c:148:
  +	if (Hash == NULL) {

  ERROR: space required after that ';' (ctx:VxV)
  #192: FILE: arch/powerpc/platforms/powermac/pci.c:65:
  +	for (; node != NULL;node = node->sibling) {

  CHECK: Comparison to NULL could be written "node"
  #192: FILE: arch/powerpc/platforms/powermac/pci.c:65:
  +	for (; node != NULL;node = node->sibling) {

  CHECK: Comparison to NULL could be written "!region"
  #201: FILE: arch/powerpc/platforms/powermac/pci.c:1227:
  +	if (region == NULL)

  CHECK: Comparison to NULL could be written "of_get_property"
  #214: FILE: arch/powerpc/platforms/powermac/setup.c:155:
  +		if (of_get_property(np, "cache-unified", NULL) != NULL && dc) {

  CHECK: Comparison to NULL could be written "!np"
  #223: FILE: arch/powerpc/platforms/powermac/setup.c:247:
  +		if (np == NULL)

  CHECK: Comparison to NULL could be written "np"
  #226: FILE: arch/powerpc/platforms/powermac/setup.c:249:
  +		if (np != NULL) {

  CHECK: Comparison to NULL could be written "l2cr"
  #230: FILE: arch/powerpc/platforms/powermac/setup.c:252:
  +			if (l2cr != NULL) {

  CHECK: Comparison to NULL could be written "via"
  #243: FILE: drivers/macintosh/via-pmu.c:277:
  +	if (via != NULL)

  CHECK: Comparison to NULL could be written "current_req"
  #252: FILE: drivers/macintosh/via-pmu.c:1155:
  +	if (current_req != NULL) {

  CHECK: Comparison to NULL could be written "!req"
  #261: FILE: drivers/macintosh/via-pmu.c:1230:
  +	if (req == NULL || pmu_state != idle

  CHECK: Comparison to NULL could be written "!req"
  #270: FILE: drivers/macintosh/via-pmu.c:1385:
  +			if (req == NULL) {

  CHECK: Comparison to NULL could be written "via"
  #279: FILE: drivers/macintosh/via-pmu.c:1752:
  +	return via != NULL;

  CHECK: Comparison to NULL could be written "!pp"
  #288: FILE: drivers/macintosh/via-pmu.c:2084:
  +	if (pp == NULL)

  CHECK: Comparison to NULL could be written "!pp"
  #297: FILE: drivers/macintosh/via-pmu.c:2110:
  +	if (count < 1 || pp == NULL)

  CHECK: Comparison to NULL could be written "!pp"
  #306: FILE: drivers/macintosh/via-pmu.c:2167:
  +	if (pp == NULL)

  CHECK: Comparison to NULL could be written "pp"
  #315: FILE: drivers/macintosh/via-pmu.c:2183:
  +	if (pp != NULL) {

Link: https://github.com/linuxppc/linux/issues/37
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/hugetlb.h      |  2 +-
 arch/powerpc/kernel/btext.c             |  8 ++++----
 arch/powerpc/kernel/module_32.c         |  4 ++--
 arch/powerpc/mm/ppc_mmu_32.c            |  2 +-
 arch/powerpc/mm/tlb_hash32.c            | 10 +++++-----
 arch/powerpc/platforms/powermac/pci.c   |  4 ++--
 arch/powerpc/platforms/powermac/setup.c |  8 ++++----
 drivers/macintosh/via-pmu.c             | 18 +++++++++---------
 8 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 9ce465fe551a..bffec13caa7c 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -201,7 +201,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 				    unsigned pdshift)
 {
-	return 0;
+	return NULL;
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 77e1e8b2c2fa..0067a9f8fff1 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -157,14 +157,14 @@ void btext_map(void)
 
 	/* By default, we are no longer mapped */
 	boot_text_mapped = 0;
-	if (dispDeviceBase == 0)
+	if (!dispDeviceBase)
 		return;
 	base = ((unsigned long) dispDeviceBase) & 0xFFFFF000UL;
 	offset = ((unsigned long) dispDeviceBase) - base;
 	size = dispDeviceRowBytes * dispDeviceRect[3] + offset
 		+ dispDeviceRect[0];
 	vbase = __ioremap(base, size, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
-	if (vbase == 0)
+	if (!vbase)
 		return;
 	logicalDisplayBase = vbase + offset;
 	boot_text_mapped = 1;
@@ -271,7 +271,7 @@ static unsigned char * calc_base(int x, int y)
 	unsigned char *base;
 
 	base = logicalDisplayBase;
-	if (base == 0)
+	if (!base)
 		base = dispDeviceBase;
 	base += (x + dispDeviceRect[0]) * (dispDeviceDepth >> 3);
 	base += (y + dispDeviceRect[1]) * dispDeviceRowBytes;
@@ -282,7 +282,7 @@ static unsigned char * calc_base(int x, int y)
 void btext_update_display(unsigned long phys, int width, int height,
 			  int depth, int pitch)
 {
-	if (dispDeviceBase == 0)
+	if (!dispDeviceBase)
 		return;
 
 	/* check it's the same frame buffer (within 256MB) */
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 5a7a78f12562..88d83771f462 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -109,12 +109,12 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 	for (i = 1; i < hdr->e_shnum; i++) {
 		/* If it's called *.init*, and we're not init, we're
                    not interested */
-		if ((strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
+		if ((strstr(secstrings + sechdrs[i].sh_name, ".init") != NULL)
 		    != is_init)
 			continue;
 
 		/* We don't want to look at debug sections. */
-		if (strstr(secstrings + sechdrs[i].sh_name, ".debug") != 0)
+		if (strstr(secstrings + sechdrs[i].sh_name, ".debug"))
 			continue;
 
 		if (sechdrs[i].sh_type == SHT_RELA) {
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 2a049fb8523d..bea6c544e38f 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -167,7 +167,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 {
 	pmd_t *pmd;
 
-	if (Hash == 0)
+	if (!Hash)
 		return;
 	pmd = pmd_offset(pud_offset(pgd_offset(mm, ea), ea), ea);
 	if (!pmd_none(*pmd))
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 702d7689d714..cf8472cf3d59 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -41,7 +41,7 @@ void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
 {
 	unsigned long ptephys;
 
-	if (Hash != 0) {
+	if (Hash) {
 		ptephys = __pa(ptep) & PAGE_MASK;
 		flush_hash_pages(mm->context.id, addr, ptephys, 1);
 	}
@@ -54,7 +54,7 @@ EXPORT_SYMBOL(flush_hash_entry);
  */
 void tlb_flush(struct mmu_gather *tlb)
 {
-	if (Hash == 0) {
+	if (!Hash) {
 		/*
 		 * 603 needs to flush the whole TLB here since
 		 * it doesn't use a hash table.
@@ -84,7 +84,7 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
 	int count;
 	unsigned int ctx = mm->context.id;
 
-	if (Hash == 0) {
+	if (!Hash) {
 		_tlbia();
 		return;
 	}
@@ -124,7 +124,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
 
-	if (Hash == 0) {
+	if (!Hash) {
 		_tlbia();
 		return;
 	}
@@ -145,7 +145,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 	struct mm_struct *mm;
 	pmd_t *pmd;
 
-	if (Hash == 0) {
+	if (!Hash) {
 		_tlbie(vmaddr);
 		return;
 	}
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 89841e6a92b3..8322694c9489 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -62,7 +62,7 @@ struct device_node *k2_skiplist[2];
 
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
 {
-	for (; node != 0;node = node->sibling) {
+	for (; node; node = node->sibling) {
 		const int * bus_range;
 		const unsigned int *class_code;
 		int len;
@@ -1224,7 +1224,7 @@ static void fixup_u4_pcie(struct pci_dev* dev)
 			region = r;
 	}
 	/* Nothing found, bail */
-	if (region == 0)
+	if (!region)
 		return;
 
 	/* Print things out */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index db9186ee85e3..e6bf0eec4623 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -152,7 +152,7 @@ static void pmac_show_cpuinfo(struct seq_file *m)
 			of_get_property(np, "d-cache-size", NULL);
 		seq_printf(m, "L2 cache\t:");
 		has_l2cache = 1;
-		if (of_get_property(np, "cache-unified", NULL) != 0 && dc) {
+		if (of_get_property(np, "cache-unified", NULL) && dc) {
 			seq_printf(m, " %dK unified", *dc / 1024);
 		} else {
 			if (ic)
@@ -244,12 +244,12 @@ static void __init l2cr_init(void)
 	/* Checks "l2cr-value" property in the registry */
 	if (cpu_has_feature(CPU_FTR_L2CR)) {
 		struct device_node *np = of_find_node_by_name(NULL, "cpus");
-		if (np == 0)
+		if (!np)
 			np = of_find_node_by_type(NULL, "cpu");
-		if (np != 0) {
+		if (np) {
 			const unsigned int *l2cr =
 				of_get_property(np, "l2cr-value", NULL);
-			if (l2cr != 0) {
+			if (l2cr) {
 				ppc_override_l2cr = 1;
 				ppc_override_l2cr_value = *l2cr;
 				_set_L2CR(0);
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 433dbeddfcf9..014e97a9ab41 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -274,7 +274,7 @@ int __init find_via_pmu(void)
 	u64 taddr;
 	const u32 *reg;
 
-	if (via != 0)
+	if (via)
 		return 1;
 	vias = of_find_node_by_name(NULL, "via-pmu");
 	if (vias == NULL)
@@ -1152,7 +1152,7 @@ pmu_queue_request(struct adb_request *req)
 	req->complete = 0;
 
 	spin_lock_irqsave(&pmu_lock, flags);
-	if (current_req != 0) {
+	if (current_req) {
 		last_req->next = req;
 		last_req = req;
 	} else {
@@ -1227,7 +1227,7 @@ pmu_start(void)
 	/* assert pmu_state == idle */
 	/* get the packet to send */
 	req = current_req;
-	if (req == 0 || pmu_state != idle
+	if (!req || pmu_state != idle
 	    || (/*req->reply_expected && */req_awaiting_reply))
 		return;
 
@@ -1382,7 +1382,7 @@ pmu_handle_data(unsigned char *data, int len)
 	if ((1 << pirq) & PMU_INT_ADB) {
 		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
 			struct adb_request *req = req_awaiting_reply;
-			if (req == 0) {
+			if (!req) {
 				printk(KERN_ERR "PMU: extra ADB reply\n");
 				return;
 			}
@@ -1749,7 +1749,7 @@ pmu_shutdown(void)
 int
 pmu_present(void)
 {
-	return via != 0;
+	return via;
 }
 
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
@@ -2081,7 +2081,7 @@ pmu_open(struct inode *inode, struct file *file)
 	unsigned long flags;
 
 	pp = kmalloc(sizeof(struct pmu_private), GFP_KERNEL);
-	if (pp == 0)
+	if (!pp)
 		return -ENOMEM;
 	pp->rb_get = pp->rb_put = 0;
 	spin_lock_init(&pp->lock);
@@ -2107,7 +2107,7 @@ pmu_read(struct file *file, char __user *buf,
 	unsigned long flags;
 	int ret = 0;
 
-	if (count < 1 || pp == 0)
+	if (count < 1 || !pp)
 		return -EINVAL;
 	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
@@ -2164,7 +2164,7 @@ pmu_fpoll(struct file *filp, poll_table *wait)
 	__poll_t mask = 0;
 	unsigned long flags;
 	
-	if (pp == 0)
+	if (!pp)
 		return 0;
 	poll_wait(filp, &pp->wait, wait);
 	spin_lock_irqsave(&pp->lock, flags);
@@ -2180,7 +2180,7 @@ pmu_release(struct inode *inode, struct file *file)
 	struct pmu_private *pp = file->private_data;
 	unsigned long flags;
 
-	if (pp != 0) {
+	if (pp) {
 		file->private_data = NULL;
 		spin_lock_irqsave(&all_pvt_lock, flags);
 		list_del(&pp->list);
-- 
2.11.0
