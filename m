Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7DC29DDFC6
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 02:29:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Fri, 29 Aug 2008 18:29:48 +0200
References: <Pine.LNX.4.44L0.0808291202270.4447-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808291202270.4447-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808291829.48939.arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 August 2008, Alan Stern wrote:
> > The standard requires that there can only be one protocol handler
> > per physical interface, which is a reasonable limitation.
>=20
> No, you've got it exactly backward. =A0There can be multiple protocol=20
> handlers per physical interface, but there must be only one physical=20
> interface per device.

Maybe I am using wrong terminology, but I still don't see how that
fits together. Let me try to explain what I have understood so far:

The physical device is identified by a struct usb_gadget is defined
statically in the driver that exports the
usb_gadget_{un,}register_driver() functions. Obviously there can only
be one physical interface per physical device, I was not arguing
against that.

The protocol handler is identified by a usb_gadget_driver and defined
in a driver that calls usb_gadget_register_driver().
You say that there can be multiple protocol handlers, which I don't
understand because the protocol handlers all call set_gadget_data,
which overwrites the previous driver_data field in struct usb_gadget,
making it impossible to load more than one simultaneously.
=20
> > However, what the Linux implementation actually enforces is
> > that there can only be one hardware specific driver built or loaded
> > into the kernel, which just looks like an arbitrary restriction
> > that does not actually help.
>=20
> Not at all -- it is an implementation of the constraint that there be=20
> only one physical interface.

How that? Taking drivers/usb/gadget/fsl_usb2_udc.c as an example, it will
create a new fsl_udc structure for each matching platform_device it finds
(though it will leak every one except the last one), so the interface
does not limit the number of physical interfaces at all to this point,
the implementation of the every gadget hardware driver does this.

The real problem is that you cannot build a kernel that has both
fsl_usb2_udc.c and fsl_qe_udc.c built in. Having both drivers loaded
would not violate the one-interface rule, because only one of them
would find hardware to bind to on a given system, just like you can
load both the uhci and ohci drivers without them interfering.

	Arnd <><
