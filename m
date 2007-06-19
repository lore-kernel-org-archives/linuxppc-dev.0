Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 861C1DDF43
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 19:08:21 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 19 Jun 2007 11:08:16 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <136ef2695edbe7c8a535b5b4c7a669bf@kernel.crashing.org>
Message-ID: <20070619090816.55840@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<136ef2695edbe7c8a535b5b4c7a669bf@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Tue, 19 Jun 2007 08:08:42 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
CC: ppcdev list <linuxppc-dev@ozlabs.org>
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> Just name the cpu nodes "cpu@0" etc.  The "generic names"
> recommended practice wants this, and the node names here
> aren't actually used by anything anyway, except they look
> nice to the user.  The PowerPC ISA binding predates the
> generic names r.p. btw.
Good! That simplifies the (yet to be written) amigaone-cuboot.c
bootwrapper code a lot.

> > 3. The dts files define the device_type of a serial port as "serial", 
> > whereas the OF spec says "pnpPNP,501". What's the difference between 
> > the two?
> 
> "device_type" is "serial", "compatible" is "pnpPNP,whatever".
Sorry, I was thinking about compatible = "ns16550" and
compatible = "pnp..", but wrote device_type = "serial".
What's the difference between "ns16550" and "pnpPNP,501"?

> Where in the OF specs did you find this pnpPNP thing btw?
See here:
http://playground.sun.com/1275/bindings/devices/html/serial.html

or

Quote from the document:
>  "compatible" S
> Standard property name, specifies device names with which this
> device is compatible.
> 
> The meaning of this property is as defined in Open Firmware,
> as modified by the Generic Names Recommended Practice [7]. As
> described in those documents, the entries are a list of device
> names with which this device is compatible, starting with the
> name of the device itself and progressing through successively
> less precise and possibly less functional compatible devices.
> 
> For this device, the compatible property shall include "pnpPNP,501."
- End -

> "name" = "device_type" = "interrupt-controller".
> "compatible" is one of those pnpPNP things.

Quote from the "CHRP(TM) ISA Interrupt Controller Device
Binding" document:
> "compatible" S
> Standard property name, specifies device names with which
> this device is compatible.
> ....
> The compatible property shall include "chrp,iic."
- End -

I couldn't find any reference about a "pnp..." value for an i8259
interrupt controller. Is there already a generic function within the
kernel that can setup the interrupt controller based solely on the
information in the device tree?

> Please send the thing inline, not as an attachment.
Okay, will do so next time.

Thanks!

regards,

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
