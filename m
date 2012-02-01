Return-Path: <pkondeti@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine02.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82DC9B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 21:11:46 +1100 (EST)
Message-ID: <4F290FCF.1040406@codeaurora.org>
Date: Wed, 01 Feb 2012 15:41:27 +0530
From: Pavan Kondeti <pkondeti@codeaurora.org>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH] powerpc/usb: fix issue of CPU halt when missing USB PHY
 clock
References: <1328088017-9262-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1328088017-9262-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/1/2012 2:50 PM, Shengzhou Liu wrote:
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index b556a72..834237e 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -239,7 +239,7 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
>  	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
>  }
>  
> -static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> +static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
>  {
>  	struct usb_hcd *hcd = ehci_to_hcd(ehci);
>  	struct fsl_usb2_platform_data *pdata;
> @@ -299,12 +299,19 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
>  #endif
>  		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
>  	}
> +
> +	if (!(in_be32(non_ehci + FSL_SOC_USB_CTRL) & CTRL_PHY_CLK_VALID)) {
> +		printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
> +		return -1;

Please return a proper error code. -ENODEV ?

> +	}
> +	return 0;
>  }
>  


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
