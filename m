Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 5EDE067B6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 02:14:56 +1000 (EST)
Subject: Re: MPC5200 fec frame corruption
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "Sylvain Munaut" <tnt@246tNt.com>
In-Reply-To: <4506EDE0.2000706@246tNt.com>
References: <000d01c689f4$281750c0$4129320a@telxsi.com>
	<20060607120252.qjekdh5yzyrs4s0g@webmail.bluenox.com>
	<1158078812.5297.92.camel@usys-sw-server>
	<4506EDE0.2000706@246tNt.com>
Content-Type: multipart/mixed;
	boundary="=-aKVhXfYiXKNdxC8lJlt4"
Date: Wed, 13 Sep 2006 18:14:53 +0200
Message-ID: <1158164094.22548.13.camel@usys-sw-server>
MIME-Version: 1.0
Cc: ma.alvarez@ziv.es, a.arzuaga@usyscom.com, t.arzuaga@usyscom.com,
	linuxppc-embedded@ozlabs.org
Reply-To: a.llano@usyscom.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--=-aKVhXfYiXKNdxC8lJlt4
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for your fast and helpful answer.

I've found a way to solve our issue (or the way to hide it). The
difference between the previous kernel I was using and the current
kernel (from your git repository) is the XLB bus pipelining. Removing
the code that disables the pipelining it works again. (See the attached
patch).

Of course, I don't expect to remove that code from the repository,
because it seems to solve another issue of other configurations (I don't
use ATA), but I would like to know a little more information about it.

The only problem is that I don't see why does it fail when pipelining is
disabled. My only concern is that maybe the pipelining hides the true
issue. Should it work with pipelining disabled? If so, what do you think
about it?

Thank you very much in advance,
Asier Llano

El mar, 12-09-2006 a las 19:26 +0200, Sylvain Munaut escribi=C3=B3:
> Hi Asier,
> > We have been working with the MPC5200 fec and a linux-2.6.10 with =
some
> > patches extracted from Sylvain's bitkeeper repository. We have 3
> > different boards that worked properly with that kernel.
> >
> > We upgraded to the new MPC5200B and it still worked properly with =
the
> > 2.6.10 kernel.
> >
> > We upgraded to the new code of the Sylvain's git repository and the =
FEC
> > transmitted frames are corrupted. This corruption only happens with =
the
> > current git repository and the MPC5200B.
> >
> >                 MPC5200   MPC5200B
> > linux-2.6.10:     OK         OK
> > Sylvain's git:    OK       CORRUPT
> >  =20
> I must admit I don't have bitkeeper anymore installed on my machine so =
I
> don't
> remeber exactly what in there.
>=20
> Could you put somewhere on line the diff between 2.6.10 and you tree,
> eventually minus all the irrelevant/confidential stuff ?
> What would be needed woud be the arch/ppc/syslib/bestcomm ,
> drivers/net/fec_mpc52xx
> and the board setup code.
> > The problem is that the lite5200 and the lite5200b work flawlessly, =
but
> > our architecture is essentialy the same but with different PHYs =
(Marvell
> > 88E6095F and 88E6060). Our architecture works properly with the
> > linux-2.6.10, so we don't think that it is a hardware related =
problem.
> > We have been watching the MII bus by osciloscope and the errors are
> > clearly transmitted by the MPC5200B (no noise or distortion).
> >
> > We have inserted traces in the functions of the FEC driver with the
> > buffer information that is sent to the DMA and the frames are =
correct.
> >
> >
> > [... logs stripped ...]
> > The corrupted bytes are sometimes correct, sometimes overwriten
> > by the byte that is 0x20 bytes before, and sometimes changed
> > by the bytes that is 0x40 bytes before. About 50% of the time
> > the marked bytes are worong.
> >
> > I'd like to know if anything here makes any sense to you, so
> > that I can understand the origin of the problem, or any
> > additional test to perform.
> >  =20
> Any sense not really. But I would check first the options in the board
> setup.
> Things like cache snooping, comm bus prefetching, xlb priority =
settings and
> pipelining, ...
>=20
> Then the microcode of the task themselves and the options wich are =
used when
> loading them.
>=20
> Finally compare the driver code itself.
>=20
>=20
>         Sylvain
>=20
>=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=C2=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=C3=B3n confidencial =
y/o con derecho legal.=20
Est=C3=A1 dirigido =C3=BAnicamente a la/s persona/s o entidad/es =
rese=C3=B1adas como =C3=BAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=C3=ADnelo =
sin revisarlo ni reenviarlo y notif=C3=ADquelo inmediatamente al =
remitente. Gracias por su colaboraci=C3=B3n. =20
=C2=B5SysCom utiliza software antivirus, pero no se hace responsable de =
los virus contenidos en los ficheros anexos.

--=-aKVhXfYiXKNdxC8lJlt4
Content-Disposition: attachment;
	filename="linux-mp5200-pipeline.patch"
Content-Type: text/x-patch;
	charset="utf-8";
	name="linux-mp5200-pipeline.patch"
Content-Transfer-Encoding: 7bit

diff -urP linux-2.6.17.13/arch/ppc/syslib/mpc52xx_setup.c linux-2.6.17.13-mp5200-pipeline/arch/ppc/syslib/mpc52xx_setup.c
--- linux-2.6.17.13/arch/ppc/syslib/mpc52xx_setup.c	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13-mp5200-pipeline/arch/ppc/syslib/mpc52xx_setup.c	2006-09-13 17:54:32.000000000 +0200
@@ -252,11 +252,6 @@
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
 	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
 
-	/* Disable XLB pipelining */
-	/* (cfr errate 292. We could do this only just before ATA PIO
-	    transaction and re-enable it after ...) */
-	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
-
 	/* Unmap reg zone */
 unmap_regs:
 	if (cdm)  iounmap(cdm);

--=-aKVhXfYiXKNdxC8lJlt4--
