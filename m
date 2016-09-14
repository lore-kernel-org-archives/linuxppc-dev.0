Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYzqS0HfwzDsY4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:30:11 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8EBRY9G045771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 07:30:09 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ewq9enmk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 07:30:09 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 17:00:05 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 177D2125805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 17:00:15 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8EBU1JJ40435846
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 17:00:02 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8EBTxFV020078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 17:00:01 +0530
Date: Wed, 14 Sep 2016 21:30:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/pci: Fix m64 checks for SR-IOV and window
 alignment
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160914063717.2673-1-ruscur@russell.cc>
 <1473839468.8689.342.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1473839468.8689.342.camel@kernel.crashing.org>
Message-Id: <20160914113013.GA11215@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2016 at 05:51:08PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2016-09-14 at 16:37 +1000, Russell Currey wrote:
>> Commit 5958d19a143e checks for prefetchable m64 BARs by comparing the
>> addresses instead of using resource flags.=A0=A0This broke SR-IOV as t=
he
>> m64
>> check in pnv_pci_ioda_fixup_iov_resources() fails.
>>=20
>> The condition in pnv_pci_window_alignment() also changed to checking
>> only IORESOURCE_MEM_64 instead of both IORESOURCE_MEM_64 and
>> IORESOURCE_PREFETCH.
>
>CC'ing Gavin who might have some insight in the matter.
>
>Why do we check for prefetch ? On PCIe, any 64-bit BAR can live under a
>prefetchable region afaik... Gavin, any idea ?
>

Ben, what I understood for long time: non-prefetchable BAR cannot live un=
der
a prefetchable region (window), but any BAR can live under non-prefetchab=
le
region (window).

>
>> Revert these cases to the previous behaviour, adding a new helper
>> function
>> to do so.=A0=A0This is named pnv_pci_is_m64_flags() to make it clear t=
his
>> function is only looking at resource flags and should not be relied
>> on for
>> non-SRIOV resources.
>>=20
>> Fixes: 5958d19a143e ("Fix incorrect PE reservation attempt on some
>> 64-bit BARs")
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> ---
>> =A0arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++--
>> =A01 file changed, 9 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
>> b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index c16d790..2f25622 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -124,6 +124,13 @@ static inline bool pnv_pci_is_m64(struct pnv_phb
>> *phb, struct resource *r)
>> =A0		r->start < (phb->ioda.m64_base + phb-
>> >ioda.m64_size));
>> =A0}
>> =A0
>> +static inline bool pnv_pci_is_m64_flags(unsigned long
>> resource_flags)
>> +{
>> +	unsigned long flags =3D (IORESOURCE_MEM_64 |
>> IORESOURCE_PREFETCH);
>> +
>> +	return (resource_flags & flags) =3D=3D flags;
>> +}
>>=20
>I don't agree. See below.
>
>> =A0static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, in=
t
>> pe_no)
>> =A0{
>> =A0	phb->ioda.pe_array[pe_no].phb =3D phb;
>> @@ -2871,7 +2878,7 @@ static void
>> pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> =A0		res =3D &pdev->resource[i + PCI_IOV_RESOURCES];
>> =A0		if (!res->flags || res->parent)
>> =A0			continue;
>> -		if (!pnv_pci_is_m64(phb, res)) {
>> +		if (!pnv_pci_is_m64_flags(res->flags)) {
>> =A0			dev_warn(&pdev->dev, "Don't support SR-IOV
>> with"
>> =A0					" non M64 VF BAR%d: %pR.
>> \n",
>> =A0				=A0i, res);
>
>What is that function actually doing ? Having IORESOURCE_64 and
>PREFETCHABLE is completely orthogonal to being in the M64 region. This
>is the bug my original patch was fixing in fact as it's possible for
>the allocator to put a 64-bit resource in the M32 region.
>

This function is called before the resoureces are resized and assigned.
So using the resource's start/end addresses to judge it's in M64 or M32
windows are not reliable. Currently, all IOV BARs is required to have
(IORESOURCE_64 | PREFETCHABLE) which is covered by bridge's M64 window
and PHB's M64 windows (BARs).

>> @@ -3096,7 +3103,7 @@ static resource_size_t
>> pnv_pci_window_alignment(struct pci_bus *bus,
>> =A0	=A0* alignment for any 64-bit resource, PCIe doesn't care and
>> =A0	=A0* bridges only do 64-bit prefetchable anyway.
>> =A0	=A0*/
>> -	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
>> +	if (phb->ioda.m64_segsize && pnv_pci_is_m64_flags(type))
>> =A0		return phb->ioda.m64_segsize;
>
>I disagree similarly. 64-bit non-prefetchable resources should live in
>the M64 space as well.
>

As I understood, 64-bits non-prefetchable BARs cannot live behind
M64 (64-bits prefetchable) windows.

>> =A0	if (type & IORESOURCE_MEM)
>> =A0		return phb->ioda.m32_segsize;
>
>Something seems to be deeply wrong here and this patch looks to me that
>it's just papering over the problem in way that could bring back the
>bugs I've seen if the generic allocator decides to put things in the
>M32 window.
>
>We need to look at this more closely and understand WTF that code
>intends means to do.
>

Yeah, it seems it partially reverts your changes. The start/end addresses
are usable after resource resizing/assignment is finished. Before that,
we still need to use the flags.

Thanks,
Gavin


>Cheers,
>Ben.
>
