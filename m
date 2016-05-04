Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r051b1SJTzDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:40:03 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 May 2016 14:40:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0EC262CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:39:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444dnaG11534662
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:39:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444dOc7025415
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:39:25 +1000
Date: Wed, 4 May 2016 14:38:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru
Subject: Re: [PATCH v9 07/26] powerpc/powernv: Fix initial IO and M32 segmap
Message-ID: <20160504043829.GA11660@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <2708321.yBECSdbB51@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2708321.yBECSdbB51@new-mexico>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 04, 2016 at 01:31:04PM +1000, Alistair Popple wrote:
>On Tue, 3 May 2016 15:41:26 Gavin Shan wrote:
>> There are two arrays for IO and M32 segment maps on every PHB.
>> The index of the arrays are segment number and the value stored
>> in the corresponding element is PE number, indicating the segment
>> is assigned to the PE. Initially, all elements in those two arrays
>> are zeroes, meaning all segments are assigned to PE#0. It's wrong.
>> 
>> This fixes the initial values in the elements of those two arrays
>> to IODA_INVALID_PE, meaning all segments aren't assigned to any
>> PE.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c 
>b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 4aa6cdf..59b20e5 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -3240,6 +3240,7 @@ static void __init pnv_pci_init_ioda_phb(struct 
>device_node *np,
>>  	const __be64 *prop64;
>>  	const __be32 *prop32;
>>  	int len;
>> +	unsigned int segno;
>>  	u64 phb_id;
>>  	void *aux;
>>  	long rc;
>> @@ -3334,8 +3335,13 @@ static void __init pnv_pci_init_ioda_phb(struct 
>device_node *np,
>>  	aux = memblock_virt_alloc(size, 0);
>>  	phb->ioda.pe_alloc = aux;
>>  	phb->ioda.m32_segmap = aux + m32map_off;
>> -	if (phb->type == PNV_PHB_IODA1)
>> +	for (segno = 0; segno < phb->ioda.total_pe_num; segno++)
>
>These arrays are indexed by segment number but the upper bound is the total 
>number of PEs. Does IODA1 & IODA2 hardware always have the same number of PE#s 
>and segments? Is there any chance there could be more or less PE#s 
>(total_pe_num) than segments?
>

Alistair, thanks for review the code in time. The total number of M32 segments
and PEs are always equal on IODA1/IODA2.

Thanks,
Gavin

>- Alistair
>
>> +		phb->ioda.m32_segmap[segno] = IODA_INVALID_PE;
>> +	if (phb->type == PNV_PHB_IODA1) {
>>  		phb->ioda.io_segmap = aux + iomap_off;
>> +		for (segno = 0; segno < phb->ioda.total_pe_num; segno++)
>> +			phb->ioda.io_segmap[segno] = IODA_INVALID_PE;
>> +	}
>>  	phb->ioda.pe_array = aux + pemap_off;
>>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>  
>> 
>
