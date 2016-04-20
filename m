Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqNwr3dpqzDqBF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:05:48 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 11:05:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A2BB92BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:05:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K15Qxf1573198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:05:34 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K150oJ013866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:05:02 +1000
Date: Wed, 20 Apr 2016 11:04:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 20/45] powerpc/powernv: Allocate PE# in reverse order
Message-ID: <20160420010435.GA20180@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-21-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715A10F.2030704@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715A10F.2030704@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 19, 2016 at 01:07:59PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>PE number for one particular PE can be allocated dynamically or
>>reserved according to the consumed M64 (64-bits prefetchable)
>>segments of the PE. The M64 resources, and hence their segments
>>and PE number are assigned/reserved in ascending order. The PE
>>numbers are allocated dynamically in ascending order as well.
>>It's not a problem as the PE numbers are reserved and then
>>allocated all at once in fine order. However, it will introduce
>>conflicts when PCI hotplug is supported: the PE number to be
>>reserved for newly added PE might have been assigned.
>>
>>To resolve above conflicts, this forces the PE number to be
>>allocated dynamically in reverse order. With this patch applied,
>>the PE numbers are reserved in ascending order, but allocated
>>dynamically in reverse order.
>
>
>The patch is probably is ok, the commit log is not - I do not follow it. Some
>PEs are reserved (for what? why does the absolute PE number matter? put it in
>the commit log), that means that the corresponding bits in pe_alloc[] should
>be set so when you will be allocating PEs for a just plugged device, you
>won't pick them and you will pick free ones, and the order should not matter.
>I would think that "reservation" happens once at the boot time so you set
>"used" bits for the reserved PEs then and after that the dynamic allocator
>will skip them.
>

I will enhance the commit log in next revision, perhaps just pick part of
below words: On PHB3, there are 16 M64 BARs in hardware. The last one is
split ovenly into 256 segments. Each segment can be associated/assigned
to fixed PE# (segment#x <-> PE#x) which is how the hardware was designed.
If one plugged PE has M64 (64-bits prefetchable memory) resources, its
PE# is equal to the segment#. Otherwise, the PE# is allocated dynamically
if the PE doesn't contain M64 resource.

The M64 resources are assigned from low to high end, meaning the reserved
PE# (according to the M64 segments) are grown from low to high end. It's
most likely to get a dynamically allocated PE# which should be reserved
because of M64 segment. It's the conflicts the patch tries to resolve.

The PE# reservation doesn't happen once at boot time because it's
unknow how many PEs and how much M64 resources will be hot added.

>
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index f182ca7..565725b 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -144,16 +144,14 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>
>>  static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>  {
>>-	unsigned long pe;
>>+	unsigned long pe = phb->ioda.total_pe_num - 1;
>>
>>-	do {
>>-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>>-					phb->ioda.total_pe_num, 0);
>>-		if (pe >= phb->ioda.total_pe_num)
>>-			return NULL;
>>-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>>+	for (pe = phb->ioda.total_pe_num - 1; pe >= 0; pe--) {
>>+		if (!test_and_set_bit(pe, phb->ioda.pe_alloc))
>>+			return pnv_ioda_init_pe(phb, pe);
>>+	}
>>
>>-	return pnv_ioda_init_pe(phb, pe);
>>+	return NULL;
>>  }
>>
>>  static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>>
>
>
>-- 
>Alexey
>
