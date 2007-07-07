Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5364EDE105
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:47:38 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Sat, 7 Jul 2007 20:39:48 +0200
References: <1179245829.8132.100.camel@rhino>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<468FDB8F.4050007@ru.mvista.com>
In-Reply-To: <468FDB8F.4050007@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707072039.49148.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Sergei Shtylyov wrote:
> =A0 =A0Yet it's kinda accepted years ago, see:
>=20
> http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt
>=20
> =A0 =A0 Ugh, it's hard to find these documents... All "name", "device_typ=
e", and=20
> "compatible" must all be "8042".
>=20

Right. I've just checked an OF based machine that has 8042 keyboard
controller (the OLPC laptop), to see what's in there.

Here, we have=20

8042@i60 {
	device_type =3D "8042";
	reg =3D <1 60 1 1 64 1>;
	interrupts <1 3 c 3>;
	/* no interrupt-parent, this gets inherited from ISA node */
	model =3D "INT,80c42";
	compatible =3D "ps2-keyboard-controller" "INTC,80c42";
	name =3D "8042"
	#size-cells <0>;
	#address-cells <1>;

	mouse@aux {
		reg =3D <1>;
		compatible =3D "pnpPNP,f03";
		device_type =3D "mouse";
		name =3D "mouse";
	}

	keyboard@ {
		reg =3D <0>;
		language =3D "EN";
		keyboard-type =3D "us";
		device-type =3D "keyboard";
		compatible =3D "pnpPNP,303";
		name =3D "keyboard";
	}
}

My interpretation of the document you cited is that the #size-cells and
#address-cells as well as the child nodes are actually required by the
standard, but it seems that Linux doesn't care.

The model and compatible properties in the 8042 node are not standard
compliant in my machine, so I'm not sure what to best put in there.
It is very clear on name and device-type though.

	Arnd <><
