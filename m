Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0396100807
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 13:31:22 +1100 (EST)
Message-ID: <1329273064.3772.18.camel@pasglop>
Subject: RE: [PATCH] powerpc/usb: fix issue of CPU halt when missing USB PHY
 clock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Date: Wed, 15 Feb 2012 13:31:04 +1100
In-Reply-To: <3F453DDFF675A64A89321A1F352810216EDA8B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1328088017-9262-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4F290FCF.1040406@codeaurora.org>
 <3F453DDFF675A64A89321A1F352810216EDA8B@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Pavan Kondeti <pkondeti@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > +	if (!(in_be32(non_ehci + FSL_SOC_USB_CTRL) & CTRL_PHY_CLK_VALID))
> > {
> > > +		printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
> > > +		return -1;
> > 
> > Please return a proper error code. -ENODEV ?
> 
> [Shengzhou] Ok, updated in v2, thanks.
> >

Note that I just got a p5020ds from FSL, and with it's default
configuration, when I build & boot current upstream with FSL USB
support (64-bit kernel) it hangs when initializing USB.

With or without this patch.

It complains about invalid dr-mode (there's two USB nodes in the .dts
coming from uboot, an "mph" and "dr", the former has no dr-mode property
in the device-tree.

Is the current kernel incompatible with old device-tree's ? (that would
be a shame...)

Cheers,
Ben.
