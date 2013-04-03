Return-Path: <B41889@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 585972C014F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 15:08:30 +1100 (EST)
Message-ID: <515BAB44.9070001@freescale.com>
Date: Wed, 3 Apr 2013 12:08:36 +0800
From: Chen Yuanquan-B41889 <B41889@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
References: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
 <1364915422.16520.8.camel@pasglop>
In-Reply-To: <1364915422.16520.8.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 11:10 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-04-02 at 19:26 +0800, Yuanquan Chen wrote:
>> So we move the DMA & IRQ initialization code from pcibios_setup_devices() and
>> construct a new function pcibios_enable_device. We call this function in
>> pcibios_enable_device, which will be called by PCI-e rescan code. At the
>> meanwhile, we avoid the the impact on cardbus. I also validate this patch with
>> silicon's PCIe-sata which encounters the IRQ issue.
> My worry is that this delays the setup of the IRQ and DMA to very late in
> the process, possibly after the quirks have been run, which can be
> problematic. We have platform hooks that might try to "fixup" specific
> IRQ issues on some platforms (especially macs) which I worry might fail
> if delayed that way (I may be wrong, I don't have a specific case in mind,
> but I would feel better if we kept setting up these things earlier).
>
> Cheers,
> Ben.
>

Hi Ben,

I have checked all the quirk functions which are declared in kernel 
arch/powerpc
with command :
grep DECLARE_PCI_FIXUP_ `find arch/powerpc/ *.[hc]`

All the quirk function are defined as DECLARE_PCI_FIXUP_EARLY , 
DECLARE_PCI_FIXUP_HEADER
and DECLARE_PCI_FIXUP_FINAL, except quirk_uli5229() in 
arch/powerpc/platforms/fsl_uli1575.c, which is
defined both as DECLARE_PCI_FIXUP_HEADER and DECLARE_PCI_FIXUP_RESUME. 
So the quirk_uli5229()
will also be called with PCI pm module. The quirk functions defined as 
xxx_FINAL, HEADER and EARLY,
will be called in the path:

pci_scan_child_bus()->pci_scan_slot()->pci_scan_single_device()->pci_scan_device()->pci_setup_device()
->pci_device_add()

the pci_scan_slot() is called earlier than pcibios_fixup_bus() even for 
the first scan of PCI-e bus, so the quirk
functions on powerpc platform is called before the DMA & IRQ fixup. So 
in reality, the delay of DMA & IRQ fixup
won't affect anything.

Regards,
Yuanquan

>
>
>
