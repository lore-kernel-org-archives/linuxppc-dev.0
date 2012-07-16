Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19D472C0146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 09:20:24 +1000 (EST)
Message-ID: <5004A1B0.6070004@freescale.com>
Date: Mon, 16 Jul 2012 18:20:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: workaround for chips with MSI hareware
 errata to support MSI-X
References: <1342409730-28340-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1342409730-28340-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, soniccat.liu@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2012 10:35 PM, Jia Hongtao wrote:
> From: Liu Shuo <soniccat.liu@gmail.com>
> 
> The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of mpc8544),
> It causes that neither MSI nor MSI-X can work fine. There is a workaround
> to allow MSI-X to function properly.

s/There is/This is/

There is also a workaround for regular MSI to function properly, though
this patch does not implement it.

> +/* MPIC chip with 2.0 version has erratum PIC1 */
> +static int mpic_has_errata(struct platform_device *dev)
> +{
> +	struct device_node *mpic_node;
> +
> +	mpic_node = of_irq_find_parent(dev->dev.of_node);
> +	if (mpic_node) {
> +		u32 *reg_base, brr1 = 0;
> +		/* Get the PIC reg base */
> +		reg_base = of_iomap(mpic_node, 0);
> +		of_node_put(mpic_node);
> +		if (!reg_base) {
> +			dev_err(&dev->dev, "ioremap problem failed.\n");
> +			return -EIO;
> +		}
> +
> +		/* Get the mpic chip version from block revision register 1 */
> +		brr1 = in_be32(reg_base + MPIC_FSL_BRR1);
> +		iounmap(reg_base);
> +		if ((brr1 & MPIC_FSL_BRR1_VER) == 0x0200)
> +			return 1;

There's already been a patch posted that includes BRR1 checking:
http://patchwork.ozlabs.org/patch/169713/

Please coordinate with that.  Have the MPIC code read the version once,
and expose it to the MSI driver, rather than digging directly into the
non-MSI MPIC registers from here.

> diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
> index 8225f86..354d546 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -25,6 +25,9 @@
>  #define FSL_PIC_IP_IPIC   0x00000002
>  #define FSL_PIC_IP_VMPIC  0x00000003
>  
> +#define MSI_HW_ERRATA_MASK   0x000000F0
> +#define MSI_HW_ERRATA_ENDIAN 0x00000010

Why do we need a mask for this?

-Scott
