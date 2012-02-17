Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D6A05B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:43:04 +1100 (EST)
Message-ID: <1329450178.2892.50.camel@pasglop>
Subject: RE: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pan Jiafei-B37022 <B37022@freescale.com>
Date: Fri, 17 Feb 2012 14:42:58 +1100
In-Reply-To: <4F9F958A64F25C4DA463F3D6931E533140828E@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1329433132.2892.30.camel@pasglop> <1329436955.2892.32.camel@pasglop>
 <3F453DDFF675A64A89321A1F3528102170A6FF@039-SN1MPN1-004.039d.mgd.msft.net>
 <4F9F958A64F25C4DA463F3D6931E533140828E@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 03:20 +0000, Pan Jiafei-B37022 wrote:
> FYI, I once fixed this issue when backport P5020 BSP for WR Linux, The
> following is the patch which I have submitted to linuxbj-internal.

Should I just apply this to upstream ?

Cheers,
Ben.

> From: linuxbj-internal-bounces@linux.freescale.net [mailto:linuxbj-internal-bounces@linux.freescale.net] On Behalf Of Pan Jiafei-B37022
> Sent: Friday, December 16, 2011 12:49 PM
> To: linuxbj-internal@linux.freescale.net
> Cc: Pan Jiafei-B37022
> Subject: [Linuxbj-internal] [PATCH] USB: ehci-fsl: Turn on cache snooping on MPC8xxx
> 
> If a MPC8xxx was being used, 'have_sysif_regs' should be set and
> it should setup cache snooping for all the 4GB space on both PPC32
> and PPC64.
> 
> Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>
> ---
> drivers/usb/host/ehci-fsl.c |   23 ++++++++++-------------
> 1 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 90534cc..ee14fa7 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -260,21 +260,18 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
>     if (pdata->have_sysif_regs) {
>           temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
>           out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
> -          out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
> -    }
> 
> -#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> -    /*
> -    * Turn on cache snooping hardware, since some PowerPC platforms
> -    * wholly rely on hardware to deal with cache coherent
> -    */
> +          /*
> +          * Turn on cache snooping hardware, since some PowerPC platforms
> +          * wholly rely on hardware to deal with cache coherent
> +          */
> 
> -    /* Setup Snooping for all the 4GB space */
> -    /* SNOOP1 starts from 0x0, size 2G */
> -    out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
> -    /* SNOOP2 starts from 0x80000000, size 2G */
> -    out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
> -#endif
> +          /* Setup Snooping for all the 4GB space */
> +          /* SNOOP1 starts from 0x0, size 2G */
> +          out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
> +          /* SNOOP2 starts from 0x80000000, size 2G */
> +          out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
> +    }
> 
>      if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
>                (pdata->operating_mode == FSL_USB2_DR_OTG))
