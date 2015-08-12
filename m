Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 999851A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:21:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 21:21:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E39592CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:21:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7CBL1Tj60227726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:21:09 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7CBKaXq032032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:20:37 +1000
Date: Wed, 12 Aug 2015 21:20:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 05/42] powerpc/powernv: Track IO/M32/M64 segments from
 PE
Message-ID: <20150812112019.GA14309@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-6-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C84FD8.302@ozlabs.ru> <20150811000342.GB10753@gwshan>
 <55C95CAE.1090908@ozlabs.ru> <20150812104502.GB7690@gwshan>
 <55CB2865.4090402@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CB2865.4090402@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 09:05:09PM +1000, Alexey Kardashevskiy wrote:
>On 08/12/2015 08:45 PM, Gavin Shan wrote:
>>On Tue, Aug 11, 2015 at 12:23:42PM +1000, Alexey Kardashevskiy wrote:
>>>On 08/11/2015 10:03 AM, Gavin Shan wrote:
>>>>On Mon, Aug 10, 2015 at 05:16:40PM +1000, Alexey Kardashevskiy wrote:
>>>>>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>>>>>The patch is adding 6 bitmaps, three to PE and three to PHB, to track
>>>>>
>>>>>The patch is also removing 2 arrays (io_segmap and m32_segmap), what is that
>>>>>all about? Also, there was no m64_segmap, now there is, needs an explanation
>>>>>may be.
>>>>>
>>>>
>>>>Originally, the bitmaps (io_segmap and m32_segmap) are allocated dynamically.
>>>>Now, they have fixed sizes - 512 bits.
>>>>
>>>>The subject "powerpc/powernv: Track IO/M32/M64 segments from PE" indicates
>>>>why m64_segmap is added.
>>>
>>>
>>>But before this patch, you somehow managed to keep it working without a map
>>>for M64, by the same time you needed map for IO and M32. It seems you are
>>>making things consistent in this patch but it also feels like you do not have
>>>to do so as M64 did not need a map before and I cannot see why it needs one
>>>now.
>>>
>>
>>The M64 map is used by [PATCH v6 23/42] powerpc/powernv: Release PEs dynamically
>>where the M64 segments consumed by one particular PE will be released.
>
>
>Then add it where it is really started being used. It is really hard to
>review a patch which is actually spread between patches. Do not count that
>reviewers will just trust you.
>

Ok. I'll try. 

>
>>>>>
>>>>>>the consumed by one particular PE, which can be released once the PE
>>>>>>is destroyed during PCI unplugging time. Also, we're using fixed
>>>>>>quantity of bits to trace the used IO, M32 and M64 segments by PEs
>>>>>>in one particular PHB.
>>>>>>
>>>>>
>>>>>Out of curiosity - have you considered having just 3 arrays, in PHB, storing
>>>>>PE numbers, and ditching PE's arrays? Does PE itself need to know what PEs it
>>>>>is using? Not sure about this master/slave PEs though.
>>>>>
>>>>
>>>>I don't follow your suggestion. Can you rephrase and explain it a bit more?
>>>
>>>
>>>Please explains in what situations you need same map in both PHB and PE and
>>>how you are going to use them. For example, pe::m64_segmap and
>>>phb::m64_segmap.
>>>
>>>I believe you need to know what segment is used by what PE and that's it and
>>>having 2 bitmaps is overcomplicated hard to follow. Is there anything else
>>>what I am missing?
>>>
>>
>>The situation is same to all (IO, M32 and M64) segment maps. Taking m64_segmap
>>as an example, it will be used when creating or destroying the PE who consumes
>>M64 segments. phb::m64_segmap is recording the M64 segment usage in PHB's domain.
>>It's used to check same M64 segment won't be used for towice. pe::m64_segmap tracks
>>the M64 segments consumed by the PE.
>
>
>You could have a single map in PHB, key would be a segment number and value
>would be PE number. No need to have a map in PE. At all. No need to
>initialize bitmaps, etc.
>

So it would be arrays for various segmant maps if I understood your suggestion
as below. Please confirm:

#define PNV_IODA_MAX_SEG_NUM	512

	int struct pnv_phb::io_segmap[PNV_IODA_MAX_SEG_NUM];
			    m32_segmap[PNV_IODA_MAX_SEG_NUM];
			    m64_segmap[PNV_IODA_MAX_SEG_NUM];
- Initially, they are initialize to IODA_INVALID_PE;
- When one segment is assigned to one PE, the corresponding entry
  of the array is set to PE number.
- When one segment is relased, the corresponding entry of the array
  is set to IODA_INVALID_PE;
 

>>>>>It would be easier to read patches if this one was right before
>>>>>[PATCH v6 23/42] powerpc/powernv: Release PEs dynamically
>>>>>
>>>>
>>>>I'll try to reoder the patch, but not expect too much...
>>>>
>>>>>
>>>>>
>>>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>>---
>>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 29 +++++++++++++++--------------
>>>>>>  arch/powerpc/platforms/powernv/pci.h      | 18 ++++++++++++++----
>>>>>>  2 files changed, 29 insertions(+), 18 deletions(-)
>>>>>>
>>>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>index e4ac703..78b49a1 100644
>>>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>@@ -388,6 +388,12 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>>>>  			list_add_tail(&pe->list, &master_pe->slaves);
>>>>>>  		}
>>>>>>
>>>>>>+		/* M64 segments consumed by slave PEs are tracked
>>>>>>+		 * by master PE
>>>>>>+		 */
>>>>>>+		set_bit(pe->pe_number, master_pe->m64_segmap);
>>>>>>+		set_bit(pe->pe_number, phb->ioda.m64_segmap);
>>>>>>+
>>>>>>  		/* P7IOC supports M64DT, which helps mapping M64 segment
>>>>>>  		 * to one particular PE#. However, PHB3 has fixed mapping
>>>>>>  		 * between M64 segment and PE#. In order to have same logic
>>>>>>@@ -2871,9 +2877,11 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>>>>>
>>>>>>  			while (index < phb->ioda.total_pe &&
>>>>>>  			       region.start <= region.end) {
>>>>>>-				phb->ioda.io_segmap[index] = pe->pe_number;
>>>>>>+				set_bit(index, pe->io_segmap);
>>>>>>+				set_bit(index, phb->ioda.io_segmap);
>>>>>>  				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>>>>>-					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
>>>>>>+					pe->pe_number, OPAL_IO_WINDOW_TYPE,
>>>>>>+					0, index);
>>>>>
>>>>>Unrelated change.
>>>>>
>>>>
>>>>True, will drop. However, checkpatch.pl will complain wtih:
>>>>exceeding 80 characters.
>>>
>>>It will not as you are not changing these lines, it only complains on changes.
>>>
>>>
>>>
>>>>
>>>>>>  				if (rc != OPAL_SUCCESS) {
>>>>>>  					pr_err("%s: OPAL error %d when mapping IO "
>>>>>>  					       "segment #%d to PE#%d\n",
>>>>>>@@ -2896,9 +2904,11 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>>>>>
>>>>>>  			while (index < phb->ioda.total_pe &&
>>>>>>  			       region.start <= region.end) {
>>>>>>-				phb->ioda.m32_segmap[index] = pe->pe_number;
>>>>>>+				set_bit(index, pe->m32_segmap);
>>>>>>+				set_bit(index, phb->ioda.m32_segmap);
>>>>>>  				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>>>>>-					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
>>>>>>+					pe->pe_number, OPAL_M32_WINDOW_TYPE,
>>>>>>+					0, index);
>>>>>
>>>>>Unrelated change.
>>>>>
>>>>
>>>>same as above.
>>>>
>>>>>>  				if (rc != OPAL_SUCCESS) {
>>>>>>  					pr_err("%s: OPAL error %d when mapping M32 "
>>>>>>  					       "segment#%d to PE#%d",
>>>>>>@@ -3090,7 +3100,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>>>>  {
>>>>>>  	struct pci_controller *hose;
>>>>>>  	struct pnv_phb *phb;
>>>>>>-	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
>>>>>>+	unsigned long size, pemap_off;
>>>>>>  	const __be64 *prop64;
>>>>>>  	const __be32 *prop32;
>>>>>>  	int len;
>>>>>>@@ -3175,19 +3185,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>>>>
>>>>>>  	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>>>>>
>>>>>
>>>>>This comment came with if(IODA1) below, since you are removing the condition
>>>>>below, makes sense to remove the comment as well or move it where people will
>>>>>look for it (arch/powerpc/platforms/powernv/pci.h ?)
>>>>>
>>>>
>>>>Yes, will do.
>>>>
>>>>>
>>>>>>  	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
>>>>>>-	m32map_off = size;
>>>>>>-	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
>>>>>>-	if (phb->type == PNV_PHB_IODA1) {
>>>>>>-		iomap_off = size;
>>>>>>-		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
>>>>>>-	}
>>>>>>  	pemap_off = size;
>>>>>>  	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
>>>>>>  	aux = memblock_virt_alloc(size, 0);
>>>>>
>>>>>
>>>>>After adding static arrays to PE and PHB, do you still need this "aux"?
>>>>>
>>>>
>>>>"aux" is still needed to tell the boundary of pe_alloc_bitmap and pe_array.
>>>>>
>>>>>>  	phb->ioda.pe_alloc = aux;
>>>>>>-	phb->ioda.m32_segmap = aux + m32map_off;
>>>>>>-	if (phb->type == PNV_PHB_IODA1)
>>>>>>-		phb->ioda.io_segmap = aux + iomap_off;
>>>>>>  	phb->ioda.pe_array = aux + pemap_off;
>>>>>>  	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
>>>>>>
>>>>>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>>>>>index 62239b1..08a4e57 100644
>>>>>>--- a/arch/powerpc/platforms/powernv/pci.h
>>>>>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>>>>>@@ -49,6 +49,15 @@ struct pnv_ioda_pe {
>>>>>>  	/* PE number */
>>>>>>  	unsigned int		pe_number;
>>>>>>
>>>>>>+	/* IO/M32/M64 segments consumed by the PE. Each PE can
>>>>>>+	 * have one M64 segment at most, but M64 segments consumed
>>>>>>+	 * by slave PEs will be contributed to the master PE. One
>>>>>>+	 * PE can own multiple IO and M32 segments.
>>>>>
>>>>>
>>>>>A PE can have multiple IO and M32 segments but just one M64 segment? Is this
>>>>>correct for IODA1 or IODA2 or both? Is this a limitation of this
>>>>>implementation or it comes from P7IOC/PHB3 hardware?
>>>>>
>>>>
>>>>It's correct for IO and M32. However, on IODA1 or IODA2, one PE can have
>>>>multiple M64 segments as well.
>>>
>>>
>>>But the comment says "Each PE can have one M64 segment at most". Which
>>>statement is correct?
>>>
>>
>>The comment is correct regarding PHB's 15th M64 BAR: Each PE can have one
>>M64 segment at post. It's from hardware limitation. However, once one PE
>>consumes multiple M64 segments. all those M64 segments will be tracked in
>>"master" PE and it's determined by software implementation.
>>
>>>>>>+	 */
>>>>>>+	unsigned long		io_segmap[8];
>>>>>>+	unsigned long		m32_segmap[8];
>>>>>>+	unsigned long		m64_segmap[8];
>>>>>
>>>>>Magic constant "8", 64bit*8 = 512 PEs - where did this come from?
>>>>>
>>>>>Anyway,
>>>>>
>>>>>#define PNV_IODA_MAX_PE_NUM	512
>>>>>
>>>>>unsigned long io_segmap[PNV_IODA_MAX_PE_NUM/BITS_PER_LONG]
>>>>>
>>>>
>>>>I prefer "8", not macro for 3 reasons:
>>>>- The macro won't be used in the code.
>>>
>>>You will use it 6 times in the header, if you give it a good name, people
>>>won't have to guess if the meaning of all these "8"s is the same and you
>>>won't have to comment every use of it in this header file (now you have).
>>>
>>>Also, using BITS_PER_LONG tells the reader that this is a bitmask for sure.
>>>
>>>
>>>>- The total segment number of specific resource is variable
>>>>   on IODA1 and IODA2. I just choosed the max value with margin.
>>>>- PNV_IODA_MAX_PE_NUM, indicating max PE number, isn't 512 on
>>>>   IODA1 or IODA2.
>>>
>>>Give it a better name.
>>>
>>
>>Ok. It it has to be a macro, then it's as below:
>>
>>#define PNV_IODA_MAX_SEG_NUM	512
>
>
>Thanks mate :)
>
>
>>>
>>>>
>>>>>>+
>>>>>>  	/* "Weight" assigned to the PE for the sake of DMA resource
>>>>>>  	 * allocations
>>>>>>  	 */
>>>>>>@@ -145,15 +154,16 @@ struct pnv_phb {
>>>>>>  			unsigned int		io_segsize;
>>>>>>  			unsigned int		io_pci_base;
>>>>>>
>>>>>>+			/* IO, M32, M64 segment maps */
>>>>>>+			unsigned long		io_segmap[8];
>>>>>>+			unsigned long		m32_segmap[8];
>>>>>>+			unsigned long		m64_segmap[8];
>>>>>>+
>>>>>>  			/* PE allocation */
>>>>>>  			struct mutex		pe_alloc_mutex;
>>>>>>  			unsigned long		*pe_alloc;
>>>>>>  			struct pnv_ioda_pe	*pe_array;
>>>>>>
>>>>>>-			/* M32 & IO segment maps */
>>>>>>-			unsigned int		*m32_segmap;
>>>>>>-			unsigned int		*io_segmap;
>>>>>>-
>>>>>>  			/* IRQ chip */
>>>>>>  			int			irq_chip_init;
>>>>>>  			struct irq_chip		irq_chip;
>>>>>>

Thanks,
Gavin
