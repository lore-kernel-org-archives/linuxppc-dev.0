Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3B852C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 07:52:04 +1000 (EST)
Received: from mail219-ch1 (localhost [127.0.0.1])	by
 mail219-ch1-R.bigfish.com (Postfix) with ESMTP id BFCE41601D6	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 21:51:59 +0000 (UTC)
Received: from CH1EHSMHS039.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail219-ch1.bigfish.com (Postfix) with ESMTP id
 E89871A0019	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 21:51:57
 +0000 (UTC)
Date: Thu, 27 Sep 2012 16:51:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
To: Gala Kumar-B11780 <B11780@freescale.com>
References: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
 <1348772523-17587-3-git-send-email-Chunhe.Lan@freescale.com>
 <1348762151.18375.6@snotra>
 <CF1EE7AED478CD48A05574C8E2DA142D5E2C18@039-SN1MPN1-006.039d.mgd.msft.net>
In-Reply-To: <CF1EE7AED478CD48A05574C8E2DA142D5E2C18@039-SN1MPN1-006.039d.mgd.msft.net>
 (from B11780@freescale.com on Thu Sep 27 16:45:08 2012)
Message-ID: <1348782713.18375.22@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Lan Chunhe-B25806 <B25806@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2012 04:45:08 PM, Gala Kumar-B11780 wrote:
>=20
> On Sep 27, 2012, at 11:09 AM, Scott Wood wrote:
>=20
> > On 09/27/2012 02:02:03 PM, Chunhe Lan wrote:
> >> Original process of call:
> >> 	The mpc85xx_pci_err_probe function completes to been registered
> >> 	and enabled of EDAC PCI err driver at the latter time stage of
> >> 	kernel boot in the mpc85xx_edac.c.
> >> Current process of call:
> >> 	The mpc85xx_pci_err_probe function completes to been registered
> >> 	and enabled of EDAC PCI err driver at the first	time stage of
> >> 	kernel boot in the fsl_pci.c.
> >> So in this case the following error messages appear in the boot =20
> log:
> >>    PCI: Probing PCI hardware
> >>    pci 0000:00:00.0: ignoring class b20 (doesn't match header type =20
> 01)
> >>    PCIE error(s) detected
> >>    PCIE ERR_DR register: 0x00020000
> >>    PCIE ERR_CAP_STAT register: 0x80000001
> >>    PCIE ERR_CAP_R0 register: 0x00000800
> >>    PCIE ERR_CAP_R1 register: 0x00000000
> >>    PCIE ERR_CAP_R2 register: 0x00000000
> >>    PCIE ERR_CAP_R3 register: 0x00000000
> >> Because the EDAC PCI err driver is registered and enabled earlier =20
> than
> >> original point of call. But at this point of time, PCI hardware is =20
> not
> >> probed and initialized, and it is in unknowable state.
> >> So, move enable function into mpc85xx_pci_err_en which is called =20
> at the
> >> middle time stage of kernel boot and after PCI hardware is probed =20
> and
> >> initialized by device_initcall in the fsl_pci.c.
> >> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> >> ---
> >> arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
> >> arch/powerpc/sysdev/fsl_pci.h |    5 ++++
> >> drivers/edac/mpc85xx_edac.c   |   47 =20
> ++++++++++++++++++++++++++++------------
> >> 3 files changed, 50 insertions(+), 14 deletions(-)
> >> diff --git a/arch/powerpc/sysdev/fsl_pci.c =20
> b/arch/powerpc/sysdev/fsl_pci.c
> >> index 3d6f4d8..a591965 100644
> >> --- a/arch/powerpc/sysdev/fsl_pci.c
> >> +++ b/arch/powerpc/sysdev/fsl_pci.c
> >> @@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
> >> 	return platform_driver_register(&fsl_pci_driver);
> >> }
> >> arch_initcall(fsl_pci_init);
> >> +
> >> +static int __init fsl_pci_err_en(void)
> >> +{
> >> +	struct device_node *np;
> >> +
> >> +	for_each_node_by_type(np, "pci")
> >> +		if (of_match_node(pci_ids, np))
> >> +			mpc85xx_pci_err_en(np);
> >> +
> >> +	return 0;
> >> +}
> >> +device_initcall(fsl_pci_err_en);
> >
> > Why can't you call this from the normal PCIe controller init, =20
> instead of searching for the node independently?
>=20
> Don't we have this now with mpc85xx_pci_err_probe() ??

What do you mean by "this"?

-Scott=
