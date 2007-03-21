Return-Path: <moilanen@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77002DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:10:14 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2LLA9Z4019217
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 17:10:09 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2LL8r4b249878
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 17:08:53 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2LL8q1g004569
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 17:08:53 -0400
Subject: Re: [PATCH] DMA 4GB boundary protection
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070303232915.GB8028@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 16:05:48 -0500
Message-Id: <1174511149.5225.135.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > I propose fixing it in the IOMMU allocation instead of making each
> > driver protect against it as it is more efficient, and won't require
> > changing every driver which has not considered this issue.
> 
> The drawback of this patch is that it adds code to every single allocation.
> Instead, you should just mark the last entry before the 4GB boundary
> as allocated when you setup the bitmaps for the table. That way, no
> allocation will ever be able to cross over.

Agreed.  While it's not an issue at 4KB, when we go to say 64k, or 16MB
TCE sizes, this extra space will be wasted.  But, I believe we'll need a
little code for this anyways.

> Even nicer would be to only do it when a boot option is specified, so
> we actually have a chance to expose and find the driver bugs instead of
> papering them over.

Done.

> Also, remember to use IOMMU_PAGE_SHIFT instead of PAGE_SHIFT, they might
> be different.

Yup...

Here's a patch addressing Olof's concerns.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---
 arch/powerpc/kernel/iommu.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/kernel/iommu.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/iommu.c
+++ powerpc/arch/powerpc/kernel/iommu.c
@@ -47,6 +47,8 @@ static int novmerge = 0;
 static int novmerge = 1;
 #endif
 
+static int protect4gb = 1;
+
 static inline unsigned long iommu_num_pages(unsigned long vaddr,
 					    unsigned long slen)
 {
@@ -58,6 +60,16 @@ static inline unsigned long iommu_num_pa
 	return npages;
 }
 
+static int __init setup_protect4gb(char *str)
+{
+	if (strcmp(str, "on") == 0)
+		protect4gb = 1;
+	else if (strcmp(str, "off") == 0)
+		protect4gb = 0;
+
+	return 1;
+}
+
 static int __init setup_iommu(char *str)
 {
 	if (!strcmp(str, "novmerge"))
@@ -67,6 +79,7 @@ static int __init setup_iommu(char *str)
 	return 1;
 }
 
+__setup("protect4gb=", setup_protect4gb);
 __setup("iommu=", setup_iommu);
 
 static unsigned long iommu_range_alloc(struct iommu_table *tbl,
@@ -429,6 +442,8 @@ void iommu_unmap_sg(struct iommu_table *
 struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 {
 	unsigned long sz;
+	unsigned long start_addr, end_addr;
+	unsigned long index;
 	static int welcomed = 0;
 	struct page *page;
 
@@ -450,7 +465,7 @@ struct iommu_table *iommu_init_table(str
 
 #ifdef CONFIG_CRASH_DUMP
 	if (ppc_md.tce_get) {
-		unsigned long index, tceval;
+		unsigned long tceval;
 		unsigned long tcecount = 0;
 
 		/*
@@ -480,6 +495,21 @@ struct iommu_table *iommu_init_table(str
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
 #endif
 
+	/*
+	 * DMA cannot cross 4 GB boundary.  Mark first entry of each 4
+	 * GB chunk as reserved.
+	 */
+	if (protect4gb) {
+		start_addr = tbl->it_offset << IOMMU_PAGE_SHIFT;
+		/* go up to next 4GB boundary */
+		start_addr = (start_addr + 0x00000000ffffffffl) >> 32;
+		end_addr = (tbl->it_offset + tbl->it_size) << IOMMU_PAGE_SHIFT;
+		for (index = start_addr; index < end_addr; index += (1l << 32)) {
+			/* Reserve 4GB entry */
+			__set_bit((index >> IOMMU_PAGE_SHIFT) - tbl->it_offset,
tbl->it_map);
+		}
+	}
+
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
 		       novmerge ? "disabled" : "enabled");
