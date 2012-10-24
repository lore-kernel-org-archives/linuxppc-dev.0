Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2001:4d88:1ffa:82:880:aa0:9009:64ae])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9B00D2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 01:26:39 +1100 (EST)
Date: Wed, 24 Oct 2012 16:01:32 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc/usb: fix build warning
Message-ID: <20121024140132.GB4368@breakpoint.cc>
References: <20121008164731.75483b961a01e824731c552b@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121008164731.75483b961a01e824731c552b@freescale.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> index 9bfde82..968f751 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -222,7 +222,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  
>  	if (pdata->controller_ver < 0) {
>  		dev_warn(hcd->self.controller, "Could not get controller version\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);

Another patch (USB: ehci-fsl: Return valid error in ehci_fsl_setup_phy)
by-passed Greg and went via Linus into tree and is available in v3.7-rc2.

Sebastian
