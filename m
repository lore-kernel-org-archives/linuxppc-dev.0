Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B7C81A0220
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 16:31:22 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 15:31:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0DAFA2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 16:31:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u145V1nw42926296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 16:31:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u145UlAN023790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 16:30:47 +1100
Date: Thu, 4 Feb 2016 16:30:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, paulus@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Check if EEH is enabled on DDW
 mechanism code
Message-ID: <20160204053023.GB16304@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160202234811.GA17911@gwshan>
 <56B1F1FC.1080403@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B1F1FC.1080403@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 03, 2016 at 10:26:36AM -0200, Guilherme G. Piccoli wrote:
>On 02/02/2016 09:48 PM, Gavin Shan wrote:
>>On Tue, Jan 19, 2016 at 06:18:20PM -0200, Guilherme G. Piccoli wrote:
>>>-	/* only attempt to use a new window if 64-bit DMA is requested */
>>>-	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>>>+	/* We should check if EEH is enabled here, since DDW mechanism has
>>>+	 * an intrinsic dependency of EEH config addr information. Also, we
>>>+	 * only attempt to use a new window if 64-bit DMA is requested */
>>>+	if (eeh_enabled() && !disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>>>		dn = pci_device_to_OF_node(pdev);
>>>		dev_dbg(dev, "node is %s\n", dn->full_name);
>>>
>>
>>There are two types of addresses: (1) PCI config address (2) PE config address.
>>(1) is used to indentify one PCI device which is included in the PE. (2) is the
>>PCI config address of PE's primary bus in pHyp. Both of them can be used to identify
>>the PE. It means the (1) PCI config address, which is retrieved from pci_dn, can be
>>passed to hypervisor. Then we don't have to disable DDW when EEH is disabled.
>>
>>Guilherme, did you hit the crash on pHyp or PowerKVM?
>
>Gavin, thanks very much for the clarification. So, we can interchange
>edev->config_addr with pdn->pci_ext_config_space ?
>This would solve the issue with DDW being enabled when EEH is not.
>
>I hit the issue on PowerVM (PHyp). I wasn't able to perform hotplug in qemu
>that time I was testing this - I can re-test on qemu. Can we use pci_dn
>config address in qemu guest too?
>

On PowerKVM, QEMU can't recognize (1). pHyp is expected to support both
of them. Please have a try with (1) when eeh_enabled() returns false.
The address (1) can be retrieved from pci_dn as below:

	(pdn->busno << 8) | (pdn->devfn)

Thanks,
Gavin
