Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1TV25m44zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 21:06:02 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 May 2016 16:35:58 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 171B5E005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 16:38:58 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u46B63wx2818336
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 16:36:03 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u46B5o13009904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 16:35:54 +0530
Date: Fri, 6 May 2016 21:05:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
Subject: Re: [PATCH v9 04/22] powerpc/powernv: Increase PE# capacity
Message-ID: <20160506110541.GA5016@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <2f2282ae-c1dc-1870-4beb-d5e4e8233496@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2f2282ae-c1dc-1870-4beb-d5e4e8233496@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 06, 2016 at 05:17:25PM +1000, Alexey Kardashevskiy wrote:
>On 05/03/2016 11:22 PM, Gavin Shan wrote:
>>Each PHB maintains an array helping to translate 2-bytes Request
>>ID (RID) to PE# with the assumption that PE# takes one byte, meaning
>>that we can't have more than 256 PEs. However, pci_dn->pe_number
>>already had 4-bytes for the PE#.
>
>Can you possibly have more than 256 PEs? Or exactly 256? What patch in this
>series makes use of it?
>
>I probably asked but do not remember the answer :)
>
>Looks like waste of memory - you only used a small fraction of
>pe_rmap[0x10000] and now the waste is quadrupled.
>

The PE capacities on different hardware are different as below. So we're
going to support 16-bits PE number in near future. That means the element
in the array needs "unsigned short" at least and 2 pages (2 * 64KB) will
be reserved for it.

P7IOC: 127        PHB3: 256
PHB4:  65536      NPU1: 4        NPU2: 16

I agree some memory is wasted and the wasted amount depends on the PCI
topology. No memory will be wasted if 256 busses show on one particular
PHB. Less busses one PHB has, more memory will be wasted. As I explained
before, the total used memory is 4 pages (4 * 64KB). Considering the memory
capacity on PPC64 (especially PowerNV), I guess it's fine. Note that the
memory is allocated from memblock together with PHB instance.

The alternative solution (to avoid wasting memory) would be searching for
the PE number according to the input BDFN through the PE list maintained
in each PHB. Obviously, it will induce more logic and more CPU cycles will
be used. So it's a kind of trade-off. If you really want to see this, I
absolutely can do it in next revision. Another option would be to improve
it later and keep the code as what we have. Please input your thought. 

>
>>
>>This extends the PE# capacity for every PHB. After that, the PE number
>>is represented by 4-bytes value. Then we can reuse IODA_INVALID_PE to
>>check the PE# in phb->pe_rmap[] is valid or not.
>
>Looks like using IODA_INVALID_PE is the only reason for this patch.
>

For now, yes. In near future, It needs to be extended to represent 16-bits
PE number for PHB4 as I explained above. 

>
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Reviewed-by: Daniel Axtens <dja@axtens.net>
>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
>> arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
>> 2 files changed, 7 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index cbd4c0b..cf96cb5 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -768,7 +768,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>
>> 	/* Clear the reverse map */
>> 	for (rid = pe->rid; rid < rid_end; rid++)
>>-		phb->ioda.pe_rmap[rid] = 0;
>>+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>
>> 	/* Release from all parents PELT-V */
>> 	while (parent) {
>>@@ -3406,6 +3406,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 	if (prop32)
>> 		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>>
>>+	/* Invalidate RID to PE# mapping */
>>+	for (segno = 0; segno < ARRAY_SIZE(phb->ioda.pe_rmap); segno++)
>>+		phb->ioda.pe_rmap[segno] = IODA_INVALID_PE;
>>+
>> 	/* Parse 64-bit MMIO range */
>> 	pnv_ioda_parse_m64_window(phb);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 904f60b..80f5326 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -156,11 +156,8 @@ struct pnv_phb {
>> 		struct list_head	pe_list;
>> 		struct mutex            pe_list_mutex;
>>
>>-		/* Reverse map of PEs, will have to extend if
>>-		 * we are to support more than 256 PEs, indexed
>>-		 * bus { bus, devfn }
>>-		 */
>>-		unsigned char		pe_rmap[0x10000];
>>+		/* Reverse map of PEs, indexed by {bus, devfn} */
>>+		unsigned int		pe_rmap[0x10000];
>>
>> 		/* TCE cache invalidate registers (physical and
>> 		 * remapped)
>>
>
>
>-- 
>Alexey
>
