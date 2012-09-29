Return-Path: <B25806@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E66C2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 12:39:26 +1000 (EST)
Message-ID: <506708BE.1090905@freescale.com>
Date: Sat, 29 Sep 2012 10:42:06 -0400
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
References: <1348853717.5580.5@snotra>
In-Reply-To: <1348853717.5580.5@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2012 01:35 PM, Scott Wood wrote:
> On 09/27/2012 05:33:26 PM, Kumar Gala wrote:
>>
>> On Sep 27, 2012, at 4:51 PM, Scott Wood wrote:
>>
>> > On 09/27/2012 04:45:08 PM, Gala Kumar-B11780 wrote:
>> >> On Sep 27, 2012, at 11:09 AM, Scott Wood wrote:
>> >>> On 09/27/2012 02:02:03 PM, Chunhe Lan wrote:
>> >>>> Original process of call:
>> >>>>     The mpc85xx_pci_err_probe function completes to been registered
>> >>>>     and enabled of EDAC PCI err driver at the latter time stage of
>> >>>>     kernel boot in the mpc85xx_edac.c.
>> >>>> Current process of call:
>> >>>>     The mpc85xx_pci_err_probe function completes to been registered
>> >>>>     and enabled of EDAC PCI err driver at the first    time 
>> stage of
>> >>>>     kernel boot in the fsl_pci.c.
>> >>>> So in this case the following error messages appear in the boot 
>> log:
>> >>>>   PCI: Probing PCI hardware
>> >>>>   pci 0000:00:00.0: ignoring class b20 (doesn't match header 
>> type 01)
>> >>>>   PCIE error(s) detected
>> >>>>   PCIE ERR_DR register: 0x00020000
>> >>>>   PCIE ERR_CAP_STAT register: 0x80000001
>> >>>>   PCIE ERR_CAP_R0 register: 0x00000800
>> >>>>   PCIE ERR_CAP_R1 register: 0x00000000
>> >>>>   PCIE ERR_CAP_R2 register: 0x00000000
>> >>>>   PCIE ERR_CAP_R3 register: 0x00000000
>> >>>> Because the EDAC PCI err driver is registered and enabled 
>> earlier than
>> >>>> original point of call. But at this point of time, PCI hardware 
>> is not
>> >>>> probed and initialized, and it is in unknowable state.
>> >>>> So, move enable function into mpc85xx_pci_err_en which is called 
>> at the
>> >>>> middle time stage of kernel boot and after PCI hardware is 
>> probed and
>> >>>> initialized by device_initcall in the fsl_pci.c.
>> >>>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> >>>> ---
>> >>>> arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
>> >>>> arch/powerpc/sysdev/fsl_pci.h |    5 ++++
>> >>>> drivers/edac/mpc85xx_edac.c   |   47 
>> ++++++++++++++++++++++++++++------------
>> >>>> 3 files changed, 50 insertions(+), 14 deletions(-)
>> >>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c 
>> b/arch/powerpc/sysdev/fsl_pci.c
>> >>>> index 3d6f4d8..a591965 100644
>> >>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> >>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> >>>> @@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
>> >>>>     return platform_driver_register(&fsl_pci_driver);
>> >>>> }
>> >>>> arch_initcall(fsl_pci_init);
>> >>>> +
>> >>>> +static int __init fsl_pci_err_en(void)
>> >>>> +{
>> >>>> +    struct device_node *np;
>> >>>> +
>> >>>> +    for_each_node_by_type(np, "pci")
>> >>>> +        if (of_match_node(pci_ids, np))
>> >>>> +            mpc85xx_pci_err_en(np);
>> >>>> +
>> >>>> +    return 0;
>> >>>> +}
>> >>>> +device_initcall(fsl_pci_err_en);
>> >>>
>> >>> Why can't you call this from the normal PCIe controller init, 
>> instead of searching for the node independently?
>> >> Don't we have this now with mpc85xx_pci_err_probe() ??
>> >
>> > What do you mean by "this"?
>>
>> I'm saying don't we replace fsl_pci_err_en() with 
>> mpc85xx_pci_err_probe()...
>>
>> I need to look at this more, but not clear why mpc85xx_pci_err_en() 
>> can just be part of mpc85xx_pci_err_probe()
>
> OK, I was confused -- I thought the point was to make it happen 
> earlier, not later.  The changelog is not clear at all.
>
> Don't we want to be able to capture errors that happen during PCI 
> driver initialization, though?
     Yes.
     When PCI controller is probing slot which if the any device does 
not have on, happens the invalid address errors.
     Then the edac driver prints the many error massages. This makes 
sense as normal, but this is ugly.
     So, move the enable edac driver to later, and only detect the 
errors of the follow-up pci operations.

    Thanks,
    Chunhe
>
> -Scott
