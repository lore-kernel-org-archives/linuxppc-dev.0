Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E65852C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 22:14:22 +1000 (EST)
Subject: Re: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348782713.18375.22@snotra>
Date: Thu, 27 Sep 2012 17:33:26 -0500
Message-Id: <8C412487-0A6A-4C2E-9DE5-05B141201653@kernel.crashing.org>
References: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
 <1348772523-17587-3-git-send-email-Chunhe.Lan@freescale.com>
 <1348762151.18375.6@snotra>
 <CF1EE7AED478CD48A05574C8E2DA142D5E2C18@039-SN1MPN1-006.039d.mgd.msft.net>
 <1348782713.18375.22@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
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


On Sep 27, 2012, at 4:51 PM, Scott Wood wrote:

> On 09/27/2012 04:45:08 PM, Gala Kumar-B11780 wrote:
>> On Sep 27, 2012, at 11:09 AM, Scott Wood wrote:
>>> On 09/27/2012 02:02:03 PM, Chunhe Lan wrote:
>>>> Original process of call:
>>>> 	The mpc85xx_pci_err_probe function completes to been registered
>>>> 	and enabled of EDAC PCI err driver at the latter time stage of
>>>> 	kernel boot in the mpc85xx_edac.c.
>>>> Current process of call:
>>>> 	The mpc85xx_pci_err_probe function completes to been registered
>>>> 	and enabled of EDAC PCI err driver at the first	time stage of
>>>> 	kernel boot in the fsl_pci.c.
>>>> So in this case the following error messages appear in the boot =
log:
>>>>   PCI: Probing PCI hardware
>>>>   pci 0000:00:00.0: ignoring class b20 (doesn't match header type =
01)
>>>>   PCIE error(s) detected
>>>>   PCIE ERR_DR register: 0x00020000
>>>>   PCIE ERR_CAP_STAT register: 0x80000001
>>>>   PCIE ERR_CAP_R0 register: 0x00000800
>>>>   PCIE ERR_CAP_R1 register: 0x00000000
>>>>   PCIE ERR_CAP_R2 register: 0x00000000
>>>>   PCIE ERR_CAP_R3 register: 0x00000000
>>>> Because the EDAC PCI err driver is registered and enabled earlier =
than
>>>> original point of call. But at this point of time, PCI hardware is =
not
>>>> probed and initialized, and it is in unknowable state.
>>>> So, move enable function into mpc85xx_pci_err_en which is called at =
the
>>>> middle time stage of kernel boot and after PCI hardware is probed =
and
>>>> initialized by device_initcall in the fsl_pci.c.
>>>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>>>> ---
>>>> arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
>>>> arch/powerpc/sysdev/fsl_pci.h |    5 ++++
>>>> drivers/edac/mpc85xx_edac.c   |   47 =
++++++++++++++++++++++++++++------------
>>>> 3 files changed, 50 insertions(+), 14 deletions(-)
>>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
>>>> index 3d6f4d8..a591965 100644
>>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>>> @@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
>>>> 	return platform_driver_register(&fsl_pci_driver);
>>>> }
>>>> arch_initcall(fsl_pci_init);
>>>> +
>>>> +static int __init fsl_pci_err_en(void)
>>>> +{
>>>> +	struct device_node *np;
>>>> +
>>>> +	for_each_node_by_type(np, "pci")
>>>> +		if (of_match_node(pci_ids, np))
>>>> +			mpc85xx_pci_err_en(np);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +device_initcall(fsl_pci_err_en);
>>>=20
>>> Why can't you call this from the normal PCIe controller init, =
instead of searching for the node independently?
>> Don't we have this now with mpc85xx_pci_err_probe() ??
>=20
> What do you mean by "this"?

I'm saying don't we replace fsl_pci_err_en() with =
mpc85xx_pci_err_probe()...

I need to look at this more, but not clear why mpc85xx_pci_err_en() can =
just be part of mpc85xx_pci_err_probe()

- k=
