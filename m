Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 848361A0734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 10:26:54 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Nov 2015 09:26:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 06FA93578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 10:26:49 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tACNQe0I65142916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 10:26:49 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tACNQFRX032553
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 10:26:16 +1100
Date: Fri, 13 Nov 2015 10:25:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 38/50] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
Message-ID: <20151112232550.GA14719@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-39-git-send-email-gwshan@linux.vnet.ibm.com>
 <87lha2zuwg.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lha2zuwg.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2015 at 09:59:27AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> When pnv_pci_reset_secondary_bus() is called to issue reset on
>> the indicated secondary bus, the bus can't be root bus. So we
>> needn't consider root bus in the function.
>
>It took me a while to convince myself that this is correct. For the
>record, this is why it's correct:
>
>pnv_pci_reset_secondary_bus fills the reset_secondary_bus callback in
>the pci_controller_ops structure, and isn't used elsewhere.
>
>In arch/powerpc/kernel/pci.c, that callback is called (if it exists) in 
>pcibios_reset_secondary_bus(). It's not called anywhere else.
>
>The PPC pcibios_reset_secondary_bus overrides the weak version in
>drivers/pci/pci.c. It's called from the same file by
>pci_reset_bridge_secondary_device() (and nowhere else).
>
>pci_reset_bridge_secondary_device() is nicely documented:
>
>/**
> * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
> * @dev: Bridge device
> *
> * Use the bridge control register to assert reset on the secondary bus.
> * Devices on the secondary bus are left in power-on state.
> */
>
>Therefore, by the definiton of pci_reset_bridge_secondary_bus,
>pnv_pci_reset_secondary_bus() can only be called with a bridge
>device. As such, a bridge reset only is appropriate. If this breaks
>anything, the caller is broken.
>
>It might be worth including a condensed version of this in the commit
>message.
>

Right. I'll add more description to the changelog in next revision.

>Reviewed-by: Daniel Axtens <dja@axtens.net>
>

Thanks,
Gavin

>Regards,
>Daniel Axtens
>
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> index a7d84a4..c69b6a1 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -880,16 +880,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  
>>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>  {
>> -	struct pci_controller *hose;
>> -
>> -	if (pci_is_root_bus(dev->bus)) {
>> -		hose = pci_bus_to_host(dev->bus);
>> -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
>> -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
>> -	} else {
>> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>> -	}
>> +	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>> +	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>  }
>>  
>>  /**
>> -- 
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
