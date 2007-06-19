Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7C59EDDF15
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 18:40:17 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Jun 2007 10:40:15 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070619054232.GB32039@localhost.localdomain>
Message-ID: <20070619084015.202120@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: David Gibson <david@gibson.dropbear.id.au>
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
Datum: Tue, 19 Jun 2007 15:42:32 +1000
Von: David Gibson <david@gibson.dropbear.id.au>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> > 3. The dts files define the device_type of a serial port as
> > "serial", whereas the OF spec says "pnpPNP,501". What's the
> > difference between the two?
> 
> Err... device_type == "pnpPNP,501", or compatible == "pnpPNP,501"?
Sorry, I meant compatible = "ns16550" and compatible = "pnpPNP,501".

> This node has no children, so #address-cells and #size-cells values
> are meaningless.
Ah, I thought these properties are always necessary, if a ranges or reg
property is defined.

> >   	interrupt-controller {
> > 		device_type = "interrupt-controller";
> > 		compatible = "chrp,iic";
> 
> Is there a device binding defined somewhere for "chrp,iic"?
Dunno. :-) It's based on these document here:
http://playground.sun.com/1275/bindings/devices/html/isa-pic-1_1d.html
http://playground.sun.com/1275/bindings/pci/pci2_1.pdf

> This should cause a dtc error.  Either you want &/interrupt-controller
> or give the interrupt-controller node a label and refer to that.  It's
> either '&/some/full/path' or '&label'.
That makes sense.

> > 	timer@40 {
> > 		device_type = "timer";
> 
> For flat device trees we're generally avoiding setting the device_type
> property unless there is a clearly defined "class binding" which
> applies.  There are a number of cases here where I'm not sure if
> that's true.
What about platforms that provide a real OF device tree? Do they define
device nodes for timers?

> > 		clock-frequency = <0>;			// Not necessary?
> 
> Probably necessary, but may need to be filled in from the bootwrapper.
This should be a constant anyway, so I can define it here.

> > 	fdc@3f0 {
> > 		device_type = "fdc";
> > 		compatible = "pnpPNP,700";
> > 		reg = <3f0 8>;
> > 		interrupts = <6 3>;
> > 		interrupt-parent = <&interrupt-controller>;
> > /*		dma = < >;*/
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> >
> > 		disk {
> > 			device_type = "block";
> > 			reg = <0>;
> > 		};
> >
> Don't think you need this subnode.
It's mentioned here (if I interpreted it correctly):
http://playground.sun.com/1275/bindings/devices/html/fdc.html
Not sure, if the Linux kernel needs it.

Thanks!

regards,

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
