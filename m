Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77D1D1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 23:26:44 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 10:26:41 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D97D3352005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 07:26:30 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13CRGck4743206
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 10:27:17 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13CQakV014596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 10:26:37 -0200
Subject: Re: [PATCH 2/2] powerpc/pseries: Check if EEH is enabled on DDW
 mechanism code
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160202234811.GA17911@gwshan>
Cc: paulus@samba.org, nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56B1F1FC.1080403@linux.vnet.ibm.com>
Date: Wed, 3 Feb 2016 10:26:36 -0200
MIME-Version: 1.0
In-Reply-To: <20160202234811.GA17911@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 09:48 PM, Gavin Shan wrote:
> On Tue, Jan 19, 2016 at 06:18:20PM -0200, Guilherme G. Piccoli wrote:
>> -	/* only attempt to use a new window if 64-bit DMA is requested */
>> -	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>> +	/* We should check if EEH is enabled here, since DDW mechanism has
>> +	 * an intrinsic dependency of EEH config addr information. Also, we
>> +	 * only attempt to use a new window if 64-bit DMA is requested */
>> +	if (eeh_enabled() && !disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>> 		dn = pci_device_to_OF_node(pdev);
>> 		dev_dbg(dev, "node is %s\n", dn->full_name);
>>
>
> There are two types of addresses: (1) PCI config address (2) PE config address.
> (1) is used to indentify one PCI device which is included in the PE. (2) is the
> PCI config address of PE's primary bus in pHyp. Both of them can be used to identify
> the PE. It means the (1) PCI config address, which is retrieved from pci_dn, can be
> passed to hypervisor. Then we don't have to disable DDW when EEH is disabled.
>
> Guilherme, did you hit the crash on pHyp or PowerKVM?

Gavin, thanks very much for the clarification. So, we can interchange 
edev->config_addr with pdn->pci_ext_config_space ?
This would solve the issue with DDW being enabled when EEH is not.

I hit the issue on PowerVM (PHyp). I wasn't able to perform hotplug in 
qemu that time I was testing this - I can re-test on qemu. Can we use 
pci_dn config address in qemu guest too?

Cheers,


Guilherme
