Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CFC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:15:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EC3223CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EC3223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wgL50808zF3cW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wgHL55cRzF3cB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:13:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42wgHL1v5gz9s47;
 Thu, 15 Nov 2018 23:13:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Reduce a number of hooks in
 pnv_phb
In-Reply-To: <20181115032418.GB19578@tungsten.ozlabs.ibm.com>
References: <20181016023409.42238-1-aik@ozlabs.ru>
 <20181115032418.GB19578@tungsten.ozlabs.ibm.com>
Date: Thu, 15 Nov 2018 23:13:01 +1100
Message-ID: <875zwyv8s2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Stewart Smith <stewart@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sam Bobroff <sbobroff@linux.ibm.com> writes:

> On Tue, Oct 16, 2018 at 01:34:09PM +1100, Alexey Kardashevskiy wrote:
>> fixup_phb() is never used, this removes it.
>> 
>> pick_m64_pe() and reserve_m64_pe() are always defined for all powernv
>> PHBs: they are initialized by pnv_ioda_parse_m64_window() which is
>> called unconditionally from pnv_pci_init_ioda_phb() which initializes
>> all known PHB types on powernv so we can open code them.
>> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/platforms/powernv/pci.h      | 4 ----
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++------
>>  2 files changed, 3 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 8b37b28..2131373 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -115,11 +115,7 @@ struct pnv_phb {
>>  			 unsigned int hwirq, unsigned int virq,
>>  			 unsigned int is_64, struct msi_msg *msg);
>>  	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
>> -	void (*fixup_phb)(struct pci_controller *hose);
>>  	int (*init_m64)(struct pnv_phb *phb);
>> -	void (*reserve_m64_pe)(struct pci_bus *bus,
>> -			       unsigned long *pe_bitmap, bool all);
>> -	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
>>  	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>>  	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>>  	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 78b61f0..15a4556 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -518,8 +518,6 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  		phb->init_m64 = pnv_ioda1_init_m64;
>>  	else
>>  		phb->init_m64 = pnv_ioda2_init_m64;
>> -	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
>> -	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>>  }
>>  
>>  static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>> @@ -1161,8 +1159,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>  		pe = &phb->ioda.pe_array[phb->ioda.root_pe_idx];
>>  
>>  	/* Check if PE is determined by M64 */
>> -	if (!pe && phb->pick_m64_pe)
>> -		pe = phb->pick_m64_pe(bus, all);
>> +	if (!pe)
>> +		pe = pnv_ioda_pick_m64_pe(bus, all);
>
> What about the cases where pnv_ioda_parse_m64_window() returns before
> setting pick_m64_pe or reserve_m64_pe?
>
> For example, if !firmware_has_feature(FW_FEATURE_OPAL).  In that case,
> it looks like this change would cause pnv_ioda_pick_m64_pe() to be
> called, and it would try to perform an OPAL call without OPAL support.
>
> (Is it even possible to have powernv without OPAL?)

It is, though I'm not sure how well tested it is these days. We should
probably either start testing it regularly, or drop it entirely.

But if we are running without OPAL then we don't probe PCI at all, see
pnv_pci_init().

So the check in pnv_ioda_parse_m64_window() can be removed AFAICS.

cheers
