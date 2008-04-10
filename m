Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22F04DE009
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 19:29:01 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1207149149-17107-1-git-send-email-sr@denx.de>
References: <1207149149-17107-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 19:27:29 +1000
Message-Id: <1207819649.6958.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-02 at 17:12 +0200, Stefan Roese wrote:

   ../..

Overall looks good, just a few things:

In general, while I have nothing against the idea of reading the HW
setup left by uboot, I wonder if it wouldn't be best to have this file
capable of fully configuring it in either mode based on DT properties
instead. The PCI node in endpoint mode would be called something
different, such as "pci-endpoint" and would contain some kind of
"endpoint-mode" property, maybe ? That way people using other
bootloaders or even booting of straight flash kernels can still use
this.

> +
> +               out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
> +               out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start));
> +       }
>  
>         /* Enable inbound mapping */
>         out_le32(mbase + PECFG_PIMEN, 0x1);
>  
> -       out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
> -       out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start));
> -

does it work properly to setup the BARs before enabling the inbound
mapping ?

>          * OMRs are already reset, also disable PIMs
> @@ -1531,14 +1569,26 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
>          * and device IDs into it. Those are the same bogus one that the
>          * initial code in arch/ppc add. We might want to change that.
>          */
> -       out_le16(mbase + 0x200, 0xaaa0 + port->index);
> -       out_le16(mbase + 0x202, 0xbed0 + port->index);
> +       if (!port->endpoint) {
> +               out_le16(mbase + 0x200, 0xaaa0 + port->index);
> +               out_le16(mbase + 0x202, 0xbed0 + port->index);
>  

We should probably setup the config space IDs based on some device-tree
properties no ?

> -       /* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
> -       out_le32(mbase + 0x208, 0x06040001);
> +               /* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
> +               out_le32(mbase + 0x208, 0x06040001);
> +
> +               printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
> +                      port->index);
> +       } else {
> +               out_le16(mbase + 0x200, 0xeee0 + port->index);
> +               out_le16(mbase + 0x202, 0xfed0 + port->index);
> +
> +               /* Set Class Code to Processor/PPC */
> +               out_le32(mbase + 0x208, 0x0b200001);
> +
> +               printk(KERN_INFO "PCIE%d: successfully set as endpoint\n",
> +                      port->index);
> +       }
>  
> -       printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
> -              port->index);
>         return;
>   fail:
>         if (hose)
> @@ -1586,8 +1636,17 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
>         }
>         port->sdr_base = *pval;
>  
> -       /* XXX Currently, we only support root complex mode */
> -       port->endpoint = 0;
> +       /* Check whether the PCIe port is already configured as root-complex
> +        * or as endpoint. This has been done previously in U-Boot and can
> +        * be configured there dynamically by setting the "pcie_mode"
> +        * environment variable (reboot necessary of course). Here an example:
> +        *
> +        * pcie_mode = 'RP:RP:EP'
> +        *
> +        * Port 0 & 1 are configured as root-complex and port 2 as endpoint.
> +        * This mode will now be used in the Linux driver too.
> +        */
> +       port->endpoint = is_endpoint(port);
>  
>         /* Fetch config space registers address */
>         if (of_address_to_resource(np, 0, &port->cfg_space)) {
> -- 
> 1.5.4.5
> 
