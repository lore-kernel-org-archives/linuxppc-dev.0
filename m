Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 1C4ABDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 02:05:03 +1000 (EST)
Date: Fri, 29 Aug 2008 12:05:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
In-Reply-To: <200808290027.59127.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.0808291202270.4447-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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

On Fri, 29 Aug 2008, Arnd Bergmann wrote:

> > > Does building a kernel image that can run on different hardware without 
> > > rebuilding also violate the "relevant standards"?
> > 
> > No.  That isn't what Arnd was concerned about.  He noted that even if 
> > you did build multiple modules, only one of them could be loaded at any 
> > time.
> 
> Well, actually it was exactly what I was concerned about ;-)
> 
> The way I understand the code, it is layered into the hardware specific
> part and the protocol specific part, which are connected through
> the interfaces I pointed out.

That's right.

> The standard requires that there can only be one protocol handler
> per physical interface, which is a reasonable limitation.

No, you've got it exactly backward.  There can be multiple protocol 
handlers per physical interface, but there must be only one physical 
interface per device.

> However, what the Linux implementation actually enforces is
> that there can only be one hardware specific driver built or loaded
> into the kernel, which just looks like an arbitrary restriction
> that does not actually help.

Not at all -- it is an implementation of the constraint that there be 
only one physical interface.

> If the gadget hardware drivers were registering the device with a
> gadget_bus_type, you could still enforce the "only one protocol"
> rule by binding every protocol to every device in that bus type.

There is no such rule.

Alan Stern
