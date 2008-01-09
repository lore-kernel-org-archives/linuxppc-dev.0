Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F1365DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 09:22:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Wed, 9 Jan 2008 16:22:39 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
In-Reply-To: <4785246D.6090206@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Scott Wood=20
> Sent: Wednesday, January 09, 2008 1:46 PM
> > We're trying to get a SMC serial port on a8280 to work.
> > I cannot find any ecxamples on the binding, so we've tried=20
> to make one.
> >=20
> > is this anywhere close to workable?
> >=20
> > serial@11a80 {
> > 	device_type =3D "serial";
> > 	compatible =3D "fsl,mpc8280-smc-uart",
> > 				 "fsl,cpm2-smc-uart";
> > 	reg =3D <11a80 10 87fc 2>;
>=20
> The current binding has the actual parameter ram block as the=20
> second reg=20
> property, not the two-byte pointer.  If your firmware doesn't=20
> initialize=20
> the pointer, you'll have to do it in platform code.
>=20
> > 	interrupts =3D <4 8>;
> > 	interrupt-parent =3D <&PIC>;
> > 	fsl,cpm-brg =3D <7>;
> > 	fsl,cpm-command =3D <01000000>;
> > };
>=20
> cpm-command should be <1d000000> for SMC1.
>=20
> Otherwise, it looks OK.

Ok we're now using
serial@11a80 {
	device_type =3D "serial";
	compatible =3D "fsl,mpc8280-smc-uart",
				 "fsl,cpm2-smc-uart";
	reg =3D <11a80 10 0 40>;            // <base_address length
parameter_ram_address length>
	interrupts =3D <4 8>;                 // Interrupt from table 4.3
of mpc8280rm, interrupt is level or edge
	interrupt-parent =3D <&PIC>;
	fsl,cpm-brg =3D <7>;
	fsl,cpm-command =3D <1d000000>;       // Page and Sub-block code
of the CPCR
};

Right now we're trying to just get a kernel to give us some serial
output, so we can continue the porting job.
We're unsig a cuImage (using the pq2fads code right now).

Now our problem is that the serial port is spitting out 0x0a's as fast
as it can.
Seems to be repeadtin the linefeed at the end of "Uncompressing Kernel
Image ... OK"
