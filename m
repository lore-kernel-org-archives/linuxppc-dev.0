Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8DC42C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 05:11:27 +1000 (EST)
Date: Mon, 1 Oct 2012 14:11:15 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
To: Chunhe Lan <b25806@freescale.com>
References: <1348853717.5580.5@snotra> <506708BE.1090905@freescale.com>
In-Reply-To: <506708BE.1090905@freescale.com> (from b25806@freescale.com on
 Sat Sep 29 09:42:06 2012)
Message-ID: <1349118675.23509.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 09/29/2012 09:42:06 AM, Chunhe Lan wrote:
> On 09/28/2012 01:35 PM, Scott Wood wrote:
>> On 09/27/2012 05:33:26 PM, Kumar Gala wrote:
>>>=20
>>> On Sep 27, 2012, at 4:51 PM, Scott Wood wrote:
>>>=20
>>> > On 09/27/2012 04:45:08 PM, Gala Kumar-B11780 wrote:
>>> >> On Sep 27, 2012, at 11:09 AM, Scott Wood wrote:
>>> >>> On 09/27/2012 02:02:03 PM, Chunhe Lan wrote:
>>> >>>> Original process of call:
>>> >>>>     The mpc85xx_pci_err_probe function completes to been =20
>>> registered
>>> >>>>     and enabled of EDAC PCI err driver at the latter time =20
>>> stage of
>>> >>>>     kernel boot in the mpc85xx_edac.c.
>>> >>>> Current process of call:
>>> >>>>     The mpc85xx_pci_err_probe function completes to been =20
>>> registered
>>> >>>>     and enabled of EDAC PCI err driver at the first    time =20
>>> stage of
>>> >>>>     kernel boot in the fsl_pci.c.
>>> >>>> So in this case the following error messages appear in the =20
>>> boot log:
>>> >>>>   PCI: Probing PCI hardware
>>> >>>>   pci 0000:00:00.0: ignoring class b20 (doesn't match header =20
>>> type 01)
>>> >>>>   PCIE error(s) detected
>>> >>>>   PCIE ERR_DR register: 0x00020000
>>> >>>>   PCIE ERR_CAP_STAT register: 0x80000001
>>> >>>>   PCIE ERR_CAP_R0 register: 0x00000800
>>> >>>>   PCIE ERR_CAP_R1 register: 0x00000000
>>> >>>>   PCIE ERR_CAP_R2 register: 0x00000000
>>> >>>>   PCIE ERR_CAP_R3 register: 0x00000000
>>> >>>> Because the EDAC PCI err driver is registered and enabled =20
>>> earlier than
>>> >>>> original point of call. But at this point of time, PCI =20
>>> hardware is not
>>> >>>> probed and initialized, and it is in unknowable state.
>>> >>>> So, move enable function into mpc85xx_pci_err_en which is =20
>>> called at the
>>> >>>> middle time stage of kernel boot and after PCI hardware is =20
>>> probed and
>>> >>>> initialized by device_initcall in the fsl_pci.c.
>>> >>>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>>> >>>> ---
>>> >>>> arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
>>> >>>> arch/powerpc/sysdev/fsl_pci.h |    5 ++++
>>> >>>> drivers/edac/mpc85xx_edac.c   |   47 =20
>>> ++++++++++++++++++++++++++++------------
>>> >>>> 3 files changed, 50 insertions(+), 14 deletions(-)
>>> >>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c =20
>>> b/arch/powerpc/sysdev/fsl_pci.c
>>> >>>> index 3d6f4d8..a591965 100644
>>> >>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>> >>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>> >>>> @@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
>>> >>>>     return platform_driver_register(&fsl_pci_driver);
>>> >>>> }
>>> >>>> arch_initcall(fsl_pci_init);
>>> >>>> +
>>> >>>> +static int __init fsl_pci_err_en(void)
>>> >>>> +{
>>> >>>> +    struct device_node *np;
>>> >>>> +
>>> >>>> +    for_each_node_by_type(np, "pci")
>>> >>>> +        if (of_match_node(pci_ids, np))
>>> >>>> +            mpc85xx_pci_err_en(np);
>>> >>>> +
>>> >>>> +    return 0;
>>> >>>> +}
>>> >>>> +device_initcall(fsl_pci_err_en);
>>> >>>
>>> >>> Why can't you call this from the normal PCIe controller init, =20
>>> instead of searching for the node independently?
>>> >> Don't we have this now with mpc85xx_pci_err_probe() ??
>>> >
>>> > What do you mean by "this"?
>>>=20
>>> I'm saying don't we replace fsl_pci_err_en() with =20
>>> mpc85xx_pci_err_probe()...
>>>=20
>>> I need to look at this more, but not clear why mpc85xx_pci_err_en() =20
>>> can just be part of mpc85xx_pci_err_probe()
>>=20
>> OK, I was confused -- I thought the point was to make it happen =20
>> earlier, not later.  The changelog is not clear at all.
>>=20
>> Don't we want to be able to capture errors that happen during PCI =20
>> driver initialization, though?
>     Yes.
>     When PCI controller is probing slot which if the any device does =20
> not have on, happens the invalid address errors.
>     Then the edac driver prints the many error massages. This makes =20
> sense as normal, but this is ugly.
>     So, move the enable edac driver to later, and only detect the =20
> errors of the follow-up pci operations.

Is there any way to identify whether the error is the result of such a =20
probe?  If nothing else, you could identify whether a probe is taking =20
place -- better than not having any error detection during driver init.

-Scott=
