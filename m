Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B34081A0C46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 19:21:44 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 869B914076E
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 19:21:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 18:21:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E92332BB003F
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 19:21:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9L8LWD925428170
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 19:21:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9L8L8Wt008487
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 19:21:08 +1100
Date: Wed, 21 Oct 2015 16:20:44 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: retrieve m64_bar_idx from device node
Message-ID: <20151021082044.GB8207@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445411854-6951-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445413971.3870.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445413971.3870.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 06:52:51PM +1100, Michael Ellerman wrote:
>On Wed, 2015-10-21 at 15:17 +0800, Wei Yang wrote:
>
>> Count of M64 BAR would differ with the evolution of hardware.
>> 
>> This patch retieves this count from device node instead of a hard coded
>> value.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 5c65d8f..4635d25 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -368,6 +368,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  	struct resource *res;
>>  	const u32 *r;
>>  	u64 pci_addr;
>> +	const __be32 *prop32;
>>  
>>  	/* FIXME: Support M64 for P7IOC */
>>  	if (phb->type != PNV_PHB_IODA2) {
>> @@ -402,7 +403,11 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  			res->start, res->end, pci_addr);
>>  
>>  	/* Use last M64 BAR to cover M64 window */
>> -	phb->ioda.m64_bar_idx = 15;
>> +	prop32 = of_get_property(dn, "ibm,opal-m64-count", NULL);
>> +	if (prop32)
>> +		phb->ioda.m64_bar_idx = be32_to_cpup(prop32) - 1;
>> +	else
>> +		phb->ioda.m64_bar_idx = 15;
>
>Please use of_property_read_u32() instead of using of_get_property() directly.
>
>Also the "-1" is a bit unclear, I think it would be clearer if you did
>something like:
>
>	if (of_property_read_u32(dn, "ibm,opal-m64-count", &count))
>		count = 16;
>
>	/* Use last M64 BAR to cover M64 window */
>	phb->ioda.m64_bar_idx = count - 1;
>

Ok, thanks for the suggestion :-)

>
>cheers

-- 
Richard Yang
Help you, Help me
