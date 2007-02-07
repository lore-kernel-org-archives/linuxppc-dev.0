Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35C91DDE21
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:32:42 +1100 (EST)
Subject: Re: mac-address vs. local-mac-address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45CA41F7.6020700@freescale.com>
References: <45CA41F7.6020700@freescale.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 08:32:36 +1100
Message-Id: <1170883956.2620.305.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-07 at 15:17 -0600, Timur Tabi wrote:
> Hi everyone,
> 
> What is the current consensus on using mac-address vs. local-mac-address in the 
> device tree?  The 1275 spec says this:
> 
> "local-mac-address" Standard property name to specify preassigned network address.
> "mac-address" Standard property name to specify network address last used.
> 
> I think we need to agree on some interpretation of these statements, and all the 
> code should be updated to implement that interpretation.

It's fairly clear:

local-mac-address is what is statically set by the firwmare (comes from
EEPROM, whatever).

mac-address is really only meaningful if your firmware is
"dynamic" (real OF, uboot maybe) and was, for some reason, instructed by
the user to use a different mac address for that boot (if that feature
exist).

It's basically the mac-address that was actually used on that interface
to netboot the kernel I'd say.

> Linux doesn't support that.  In some cases, the actual device tree is located on 
> a TFTP server, and it's only copied temporarily into RAM by U-Boot.  There's no 
> way that a Linux driver can update that.

I don't understand what you mean here :-) The linux driver can perfectly
well update the in-memory copy of the device-tree, which would make it
useful in the case of a kexec to a newer kernel.

> On a full-blown OF machine, the firmware does provide APIs for updating the 
> device tree, and so we could support mac-address on these machines.  But U-Boot 
> disappears once the kernel loads, so there is no firmware to call to update the 
> device tree.

I don't understand what the firmware device-tree has to do with that...

If uboot is instructed to use a different mac-address than the
"built-in" one, it can perfectly well create that property before
getting to the kernel.

> Therefore, I propose that on systems where the driver cannot update the device 
> tree, the mac-address property should be absent from the device tree.  U-Boot 
> should not add one, and the Linux device drivers should not reference it.

"cannot update the device tree" is what makes little sense to me.

Ben.
