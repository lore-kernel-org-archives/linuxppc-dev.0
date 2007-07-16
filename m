Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C001DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:35:15 +1000 (EST)
Subject: Re: Legacy ISA registers/interrupts in PCI device tree node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <469B336A.5060303@genesi-usa.com>
References: <20070716075317.15260@gmx.net> <469B336A.5060303@genesi-usa.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 07:35:05 +1000
Message-Id: <1184621705.25235.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 09:59 +0100, Matt Sealey wrote:
> You could do a LOT worse than check the Pegasos.

Yes, mimmicing the pegasos will probably work

> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
> 
> Gerhard Pircher wrote:
> > Hi,
> > 
> > I wonder, if there is a recommended way to specify ISA register
> addresses
> > and interrupts for a PCI device (unlike for a PCI2ISA bridge)?
> > The device in question is the integrated IDE controller of the
> VIA686B
> > southbridge, which works in compatible/legacy mode and thus uses
> interrupts
> > 14 and 15 of the i8259 PIC. Should the fdt contain this information
> or
> > should I hardcode the values in the platform setup code?

You may need a fixup like pegasos does because that chip seems to use
14/15 even when in native mode, which is somewhat out of spec.

Cheers,
Ben.
