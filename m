Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s27.blu139.hotmail.com
	(blu139-omc3-s27.blu139.hotmail.com [65.55.175.227])
	by ozlabs.org (Postfix) with ESMTP id F3588DE1D8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 01:09:29 +1100 (EST)
Message-ID: <BLU106-W3191420D0642825B53DD08CA120@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: TQM5200 2.6-denx SM501 voyager enabling problem.
Date: Thu, 6 Mar 2008 15:09:28 +0100
In-Reply-To: <BLU106-W293FED7524135F0A85B76BCA1B0@phx.gbl>
References: <BLU106-W20B00A907B0D9DAD5014E2CA1D0@phx.gbl>
	<loom.20080228T145124-686@post.gmane.org>
	<BLU106-W293FED7524135F0A85B76BCA1B0@phx.gbl>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



I wrote: (:-p)
>=20
>=20
> Martin Krause  wrote:
>=20
>=20
>> Hi Pedro,
>>=20
>> Pedro Luis D. L.  hotmail.com> writes:
>>> Hello,
>>> I'm working right now with a TQM5200 microcontroller on a STX5200 board=
.
>>> I'm having problems to enable SM501 video output using 2.6-denx kernel.=
 The=20
>>=20
>> Have you tried to contact TQ-Components (the manufacturer of the TQM5200=
=20
>> board)? Under the email address support@tqc.de you should get help for
>> hardware and software questions to all of their products.
>>=20
>> Regards,
>> Martin
>=20
> Hi Martin,
>=20
> Well, that sounds like a very reasonable suggestion. I think I should giv=
e it a try. Maybe my bad experience with other providers pushed me to ask i=
n this list before. But you're right!
>=20
> Regards,
> Pedro.
> =20
>=20

I tried to contact TQ but they seem not to be able to solve my problem. The=
y suggested that the problem could be in the different endianness used by M=
PC5200 and SMI501. That problem seems to be corrected in the driver. Anyway=
, this endianness problem may come to light if I had any video output. It i=
s possible to change the endianness of SM501 chip from the u-boot writing a=
 register. I did it and it made no difference at all. The real problem is s=
till that none device is initialized or detected even when the Framebuffer =
driver for SM501 and MFD Driver for SM501 are compiled with the kernel. I c=
hecked that platform driver for both are registered (using some printk outp=
ut) but their probe functions are never invoked.

I thought that my problem could be that I don't have initialized the device=
 within the platform file tqm5200.c. I added the following code (marked wit=
h +) to this file under arch/powerpc/platforms/52xx/tqm5200.c

+static struct resource sm501_resources[] =3D {
+	[0]	=3D {
+		.start	=3D 0xE3E00000,
+		.end	=3D 0xE3DFFFFF,
+		.flags	=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device sm501_device =3D {
+	.name		=3D "sm501",
+	.id		=3D 0,
+	.num_resources	=3D ARRAY_SIZE(sm501_resources),
+	.resource	=3D sm501_resources,
+};

static void __init tqm5200_setup_arch(void)
{
	if (ppc_md.progress)
		ppc_md.progress("tqm5200_setup_arch()", 0);

	/* Some mpc5200 & mpc5200b related configuration */
	mpc5200_setup_xlb_arbiter();

	/* Map wdt for mpc52xx_restart() */
	mpc52xx_map_wdt();

#ifdef CONFIG_PCI
	np =3D of_find_node_by_type(NULL, "pci");
	if (np) {
		mpc52xx_add_bridge(np);
		of_node_put(np);
	}
#endif
+
+	platform_device_register(&sm501_device);
+
}

I got this idea from the configuration files from other platforms, but I st=
ill need to find out how exactly "resources" must be defined. Anybody knows=
 wheather am I pointing in the right direction and this makes any sense?

As far as I understand now (and I may be terribly wrong), once that SM501 M=
FD and Framebuffer drivers are registered,  I need to tell the kernel where=
 to find the device in the local bus. Is it right?

Thanks in advance,

Pedro.

_________________________________________________________________
Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines para=
 estar siempre a la =FAltima
Guapos y guapas, clips musicales y estrenos de cine. =
