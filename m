Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ECCA1A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:59:20 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:59:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BD2912BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:59:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1x73I42926220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:59:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1wgXN031622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:58:43 +1100
Date: Tue, 17 Nov 2015 12:58:17 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 22/50] powerpc/powernv: Introduce pnv_ioda_init_pe()
Message-ID: <20151117015817.GC1452@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-23-git-send-email-gwshan@linux.vnet.ibm.com>
 <87wpthbh6u.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wpthbh6u.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2015 at 11:30:49AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> This introduces pnv_ioda_init_pe() to initialize the specified PE
>> instance (phb->ioda.pe_array[x]). It's used by pnv_ioda_alloc_pe()
>> and pnv_ioda_reserve_pe(). No logical changes introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index ef93a01..488e0f8 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -129,6 +129,14 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>>  		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>>  }
>>  
>> +static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
>> +{
>> +	phb->ioda.pe_array[pe_no].phb = phb;
>> +	phb->ioda.pe_array[pe_no].pe_number = pe_no;
>> +
>> +	return &phb->ioda.pe_array[pe_no];
>You have the function returning the newly initalized PE here...
>
>> +}
>> +
>>  static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>  {
>>  	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
>> @@ -141,8 +149,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>  		pr_debug("%s: PE %d was reserved on PHB#%x\n",
>>  			 __func__, pe_no, phb->hose->global_number);
>>  
>> -	phb->ioda.pe_array[pe_no].phb = phb;
>> -	phb->ioda.pe_array[pe_no].pe_number = pe_no;
>> +	pnv_ioda_init_pe(phb, pe_no);
>... but then you ignore the result here and in the other function you've
>modified.
>
>It looks like you're using the result in the next patch though, so I
>wonder if you would be better to merge this patch with the next
>one. However, as I said before I'll defer to Alexey on decisions about
>how to split the patch series if he has a different opinion.
>

I'd like to keep this separate when thinking about the rule I was told before:
one patch does one thing if it can. Also, merging it to next one will make
next one harder to be reiview.

Thanks,
Gavin
