Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A1AAB2C06BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:08:07 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pci: fix PCI-e check link issue
Date: Tue, 21 May 2013 14:07:52 +0200
Message-ID: <1405132.q7TVHIgXSr@pcimr>
In-Reply-To: <1368776129-21249-1-git-send-email-Yuanquan.Chen@freescale.com>
References: <1368776129-21249-1-git-send-email-Yuanquan.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 17 May 2013 15:35:29 Yuanquan Chen wrote:
> For Freescale powerpc platform, the PCI-e bus number uses the reassign mode
> by default. It means the second PCI-e controller's hose->first_busno is the
> first controller's last bus number adding 1. For some hotpluged device(or
> controlled by FPGA), the device is linked to PCI-e slot at linux runtime.
> It needs rescan for the system to add it and driver it to work. It successes
> to rescan the device linked to the first PCI-e controller's slot, but fails
> to rescan the device linked to the second PCI-e controller's slot. The
> cause is that the bus->number is reset to 0, which isn't equal to the
> hose->first_busno for the second controller checking PCI-e link. So it
> doesn't really check the PCI-e link status, the link status is always
> no_link. The device won't be really rescaned. Reset the bus->number to
> hose->first_busno in the function fsl_pcie_check_link(), it will do the
> real checking PCI-e link status for the second controller, the device will
> be rescaned.
> 
> Signed-off-by: Yuanquan Chen <Yuanquan.Chen@freescale.com>

Tested-by: Rojhalat Ibrahim <imr@rtschenk.de>


> ---
>  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 028ac1f..534597a 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -64,7 +64,7 @@ static int fsl_pcie_check_link(struct pci_controller
> *hose) if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
>  		if (hose->ops->read == fsl_indirect_read_config) {
>  			struct pci_bus bus;
> -			bus.number = 0;
> +			bus.number = hose->first_busno;
>  			bus.sysdata = hose;
>  			bus.ops = hose->ops;
>  			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
