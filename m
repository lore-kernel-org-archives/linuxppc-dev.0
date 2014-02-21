Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0FACE2C031B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 01:21:58 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/7] ECHI Platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
Date: Fri, 21 Feb 2014 15:21:32 +0100
Message-ID: <9352625.f2QvCl1mNy@wuerfel>
In-Reply-To: <20140221114803.GB8783@e106331-lin.cambridge.arm.com>
References: <20140221114803.GB8783@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alistair Popple <alistair@popple.id.au>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tony Prisk <linux@prisktech.co.nz>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 February 2014 11:48:03 Mark Rutland wrote:
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
> > +       if (np != NULL) {
> > +               /* claim we really affected by usb23 erratum */
> > +               if (!of_address_to_resource(np, 0, &res))
> > +                       ehci->ohci_hcctrl_reg =
> > +                               devm_ioremap(&pdev->dev,
> > +                                            res.start + OHCI_HCCTRL_OFFSET,
> > +                                            OHCI_HCCTRL_LEN);
> > +               else
> > +                       ehci_dbg(ehci, "%s: no ohci offset in fdt\n", __FILE__);
> > +               if (!ehci->ohci_hcctrl_reg) {
> > +                       ehci_dbg(ehci, "%s: ioremap for ohci hcctrl failed\n",
> > +                               __FILE__);
> > +               } else {
> > +                       ehci->has_amcc_usb23 = 1;
> > +               }
> > +       }
> 
> As this is being dropped into a generic driver, it would be nice to have
> a comment explaining why we need to do this -- not everyone using this
> will know the powerpc history. It certainly seems odd to look for
> another node in the tree that this driver isn't necessarily handling,
> and that should probably be explained.
> 
> As this bit of fixup is only needed for powerpc, it would be nice to not
> have to do it elsewhere. Perhaps these could be factored out into a
> ppc_platform_reset function that could be empty stub for other
> architectures.

How about using the .data field of the of_device_id array to point to
a structure of functions? That way you don't even have to call
of_device_is_compatible() here. Note that using of_find_compatible_node()
is the wrong approach anyway, you want to check the current device
for compatibility, not just any device I assume.

	Arnd
