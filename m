Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 71511DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 10:07:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Wed, 9 Jan 2008 17:07:23 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
In-Reply-To: <47854D6D.2010906@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
	<47854D6D.2010906@freescale.com>
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

> From: Scott Wood [mailto:scottwood@freescale.com]=20
> Rune Torgersen wrote:
> >> From: Scott Wood
> >> Don't forget to exclude the SMC parameter RAM from the muram=20
> >> data area=20
> >> in /soc/cpm/muram/data/reg.  If you have an older device=20
> tree binding=20
> >> that has no /soc/cpm/muram node, but instead has two resources in=20
> >> /soc/cpm/reg, you need to move to head-of-tree to get this to work.
> >=20
> > Did that, now we get e checkstop resert. Time to hook up the
> > BDI-2000....
> > Is there a way to have the bootwrapper use the u-boot=20
> serial for a while
> > (like a early srial port) for debugging?
>=20
> If you mean calling into u-boot for a console, no, there's no=20
> code for that.
>=20
> What do your cpm and muram nodes look like?

cpm@119c0 {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	#interrupt-cells =3D <2>;
	compatible =3D "fsl,mpc8280-cpm", "fsl,cpm2";
	reg =3D <119c0 30>;
	ranges;

	muram@0 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges =3D <0 0 10000>;

		data@0 {
			compatible =3D "fsl,cpm-muram-data";
			reg =3D <100 1f00 9800 800>;
		};
	};

	brg@119f0 {
		compatible =3D "fsl,mpc8280-brg",
					 "fsl,cpm2-brg",
					 "fsl,cpm-brg";
		reg =3D <119f0 10 115f0 10>;
	};

	serial@11a80 {
		device_type =3D "serial";
		compatible =3D "fsl,mpc8280-smc-uart",
					 "fsl,cpm2-smc-uart";
		reg =3D <11a80 10 0 40>;            // <base_address
length parameter_ram_address length>
		interrupts =3D <4 8>;                 // Interrupt from
table 4.3 of mpc8280rm, interrupt is level or edge
		interrupt-parent =3D <&PIC>;
		fsl,cpm-brg =3D <7>;
		fsl,cpm-command =3D <1d000000>;       // Page and
Sub-block code of the CPCR
	};
};

and chosen node (not sure if needed)
	chosen {
		linux,stdout-path =3D "/soc/cpm/serial@11a80";
		bootargs =3D "console=3DttyS0,115200";
	};
