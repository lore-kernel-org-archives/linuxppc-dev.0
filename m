Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 0FA2BDE020
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:21:55 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Thu, 10 Apr 2008 12:21:42 +0200
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<1207819649.6958.3.camel@pasglop>
In-Reply-To: <1207819649.6958.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804101221.43154.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-04-02 at 17:12 +0200, Stefan Roese wrote:
>
>    ../..
>
> Overall looks good, just a few things:

Ben, thanks for the review.

> In general, while I have nothing against the idea of reading the HW
> setup left by uboot, I wonder if it wouldn't be best to have this file
> capable of fully configuring it in either mode based on DT properties
> instead.

Sure, this would be optimal. But frankly, I currently have no need for this 
non U-Boot mode, and therefore I didn't implement it. This can be added later 
when really needed don't you think?

> The PCI node in endpoint mode would be called something 
> different, such as "pci-endpoint" and would contain some kind of
> "endpoint-mode" property, maybe ? That way people using other
> bootloaders or even booting of straight flash kernels can still use
> this.

Good. But again, I would really prefer to first include this U-Boot style 
endpoint support and later add this independent device tree endpoint 
configuration when really needed.

> > +
> > +               out_le32(mbase + PCI_BASE_ADDRESS_0,
> > RES_TO_U32_LOW(res->start)); +               out_le32(mbase +
> > PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start)); +       }
> >
> >         /* Enable inbound mapping */
> >         out_le32(mbase + PECFG_PIMEN, 0x1);
> >
> > -       out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
> > -       out_le32(mbase + PCI_BASE_ADDRESS_1,
> > RES_TO_U32_HIGH(res->start)); -
>
> does it work properly to setup the BARs before enabling the inbound
> mapping ?

Yes. At least I have seen no problems so far.

> >          * OMRs are already reset, also disable PIMs
> > @@ -1531,14 +1569,26 @@ static void __init
> > ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port) * and device
> > IDs into it. Those are the same bogus one that the * initial code in
> > arch/ppc add. We might want to change that. */
> > -       out_le16(mbase + 0x200, 0xaaa0 + port->index);
> > -       out_le16(mbase + 0x202, 0xbed0 + port->index);
> > +       if (!port->endpoint) {
> > +               out_le16(mbase + 0x200, 0xaaa0 + port->index);
> > +               out_le16(mbase + 0x202, 0xbed0 + port->index);
>
> We should probably setup the config space IDs based on some device-tree
> properties no ?

Good idea. How about "vendor-id" and "device-id"? And we probably need some 
for endpoint mode too now. "vendor-id-endpoint" and "device-id-endpoint"?

And how should we handle the backward compatibility? Should I set the old 
values as default when those properties are not available?

Thanks.

Best regards,
Stefan
