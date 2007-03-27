Return-Path: <moilanen@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05CA1DDF2C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 06:14:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2RKDsUX013511
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:13:54 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2RKDlwl077286
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:13:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2RKDlHa003287
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:13:47 -0400
Subject: Re: [PATCH] DMA 4GB boundary protection
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070322175324.GA21120@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net> <1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 15:10:41 -0500
Message-Id: <1175026241.1398.23.camel@goblue>
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

On Thu, 2007-03-22 at 12:53 -0500, Olof Johansson wrote:
> On Wed, Mar 21, 2007 at 04:05:48PM -0500, Jake Moilanen wrote:
> 
> > @@ -480,6 +495,21 @@ struct iommu_table *iommu_init_table(str
> >  	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
> >  #endif
> >  
> > +	/*
> > +	 * DMA cannot cross 4 GB boundary.  Mark first entry of each 4
> > +	 * GB chunk as reserved.
> > +	 */
> > +	if (protect4gb) {
> > +		start_addr = tbl->it_offset << IOMMU_PAGE_SHIFT;
> > +		/* go up to next 4GB boundary */
> > +		start_addr = (start_addr + 0x00000000ffffffffl) >> 32;
> > +		end_addr = (tbl->it_offset + tbl->it_size) << IOMMU_PAGE_SHIFT;
> > +		for (index = start_addr; index < end_addr; index += (1l << 32)) {
> > +			/* Reserve 4GB entry */
> > +			__set_bit((index >> IOMMU_PAGE_SHIFT) - tbl->it_offset,
> > tbl->it_map);
> > +		}
> > +	}
> > +
> 
> 
> This is done a bit more complicated than it has to be. The >> 32 is a
> red flag as well.
> 
> I would also like it to be the last page in the range, not the first
> (since otherwise you'll reserve even if the window is less than 4GB.
> 
> Something like (untested):
> 
> 	entries_per_4g = 0x100000000 >> IOMMU_PAGE_SHIFT;
> 
> 	/* Mark the last bit before a 4GB boundary as used */
> 	start_index = tbl->it_offset | (entries_per_4g - 1);
> 	end_index = tbl->it_offset + tbl->it_size;
> 
> 	for (index = start_index; index < end_index; index += entries_per_4g)
> 		__set_bit(index, tbl->it_map);

I just had to realign the start_index in case it didn't start at a 4GB
boundary.  Other than that, it worked like a champ.  I also changed to
for loop to exit if it's the last entry.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---
 arch/powerpc/kernel/iommu.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletion(-)

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
@@ -429,6 +442,9 @@ void iommu_unmap_sg(struct iommu_table *
 struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 {
 	unsigned long sz;
+	unsigned long start_index, end_index;
+	unsigned long entries_per_4g;
+	unsigned long index;
 	static int welcomed = 0;
 	struct page *page;
 
@@ -450,7 +466,7 @@ struct iommu_table *iommu_init_table(str
 
 #ifdef CONFIG_CRASH_DUMP
 	if (ppc_md.tce_get) {
-		unsigned long index, tceval;
+		unsigned long tceval;
 		unsigned long tcecount = 0;
 
 		/*
@@ -480,6 +496,23 @@ struct iommu_table *iommu_init_table(str
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
 #endif
 
+	/*
+	 * DMA cannot cross 4 GB boundary.  Mark last entry of each 4
+	 * GB chunk as reserved.
+	 */
+	if (protect4gb) {
+		entries_per_4g = 0x100000000l >> IOMMU_PAGE_SHIFT;
+
+		/* Mark the last bit before a 4GB boundary as used */
+		start_index = (tbl->it_offset << IOMMU_PAGE_SHIFT) >> 32;
+		start_index |= (entries_per_4g - 1);
+
+		end_index = tbl->it_offset + tbl->it_size;
+
+		for (index = start_index; index < end_index - 1; index +=
entries_per_4g)
+			__set_bit(index, tbl->it_map);
+	}
+
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
 		       novmerge ? "disabled" : "enabled");
