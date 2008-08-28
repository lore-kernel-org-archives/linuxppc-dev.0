Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 99BB6DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:28:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Fri, 29 Aug 2008 00:27:58 +0200
References: <Pine.LNX.4.44L0.0808281613540.3844-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808281613540.3844-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808290027.59127.arnd@arndb.de>
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

On Thursday 28 August 2008, Alan Stern wrote:
> On Thu, 28 Aug 2008, Scott Wood wrote:
>=20
> > Alan Stern wrote:
> > > This was done deliberately. =A0The relevant standards state that a USB
> > > device can have no more than one peripheral interface.
> >=20
> > Does building a kernel image that can run on different hardware without=
=20
> > rebuilding also violate the "relevant standards"?
>=20
> No. =A0That isn't what Arnd was concerned about. =A0He noted that even if=
=20
> you did build multiple modules, only one of them could be loaded at any=20
> time.

Well, actually it was exactly what I was concerned about ;-)

The way I understand the code, it is layered into the hardware specific
part and the protocol specific part, which are connected through
the interfaces I pointed out.

The standard requires that there can only be one protocol handler
per physical interface, which is a reasonable limitation.
However, what the Linux implementation actually enforces is
that there can only be one hardware specific driver built or loaded
into the kernel, which just looks like an arbitrary restriction
that does not actually help.

If the gadget hardware drivers were registering the device with a
gadget_bus_type, you could still enforce the "only one protocol"
rule by binding every protocol to every device in that bus type.

	Arnd <><
