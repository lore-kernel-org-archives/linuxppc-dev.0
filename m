Return-Path: <B36685@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFB94B71A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 14:32:13 +1100 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: RE: [PATCH] powerpc/usb: fix issue of CPU halt when missing USB PHY
 clock
Date: Thu, 2 Feb 2012 03:31:32 +0000
Message-ID: <3F453DDFF675A64A89321A1F352810216EDA8B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1328088017-9262-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4F290FCF.1040406@codeaurora.org>
In-Reply-To: <4F290FCF.1040406@codeaurora.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Pavan Kondeti [mailto:pkondeti@codeaurora.org]
> Sent: Wednesday, February 01, 2012 6:11 PM
> To: Liu Shengzhou-B36685
> Cc: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/usb: fix issue of CPU halt when missing
> USB PHY clock
>=20
> On 2/1/2012 2:50 PM, Shengzhou Liu wrote:
> > diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-
> fsl.c
> > index b556a72..834237e 100644
> > --- a/drivers/usb/host/ehci-fsl.c
> > +++ b/drivers/usb/host/ehci-fsl.c
> > @@ -239,7 +239,7 @@ static void ehci_fsl_setup_phy(struct ehci_hcd
> *ehci,
> >  	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
> >  }
> >
> > -static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> > +static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> >  {
> >  	struct usb_hcd *hcd =3D ehci_to_hcd(ehci);
> >  	struct fsl_usb2_platform_data *pdata; @@ -299,12 +299,19 @@
> static
> > void ehci_fsl_usb_setup(struct ehci_hcd *ehci)  #endif
> >  		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
> >  	}
> > +
> > +	if (!(in_be32(non_ehci + FSL_SOC_USB_CTRL) & CTRL_PHY_CLK_VALID))
> {
> > +		printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
> > +		return -1;
>=20
> Please return a proper error code. -ENODEV ?

[Shengzhou] Ok, updated in v2, thanks.
>=20
> > +	}
> > +	return 0;
> >  }
> >
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
