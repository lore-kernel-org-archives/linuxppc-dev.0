Return-Path: <dlclark@chtech.com>
Received: from mail26f.sbc-webhosting.com (mail26f.sbc-webhosting.com
	[216.173.237.180]) by ozlabs.org (Postfix) with SMTP id 8FB41DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 08:06:31 +1100 (EST)
From: "David Clark" <dlclark@chtech.com>
To: <a.llano@usyscom.com>
Subject: RE: 16-bit PCMCIA resource allocation
Date: Mon, 26 Feb 2007 15:07:01 -0600
Message-ID: <007401c759ea$101fd750$0f01a8c0@longhorn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1171875510.27115.29.camel@usyscom-sw-server>
Cc: =?iso-8859-1?Q?'Miguel_=C1ngel_=C1lvarez_Cabanes'?= <ma.alvarez@ziv.es>,
	'Aitor Arzuaga' <a.arzuaga@usyscom.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Asier,

Our problem ended up being a hardware problem.  We made a mistake when
designing the PCB.  It is not likely that your issues are the same as
ours.

I wish you luck.

David Clark
Senior Software Engineer
C&H Technologies, Inc
Web: http:\\www.chtech.com
Phone: 512-733-2621
Fax: 512-733-2629
Email: dlclark@chtech.com
=20

-----Original Message-----
From: Asier Llano Palacios [mailto:a.llano@usyscom.com]=20
Sent: Monday, February 19, 2007 2:58 AM
To: David Clark
Cc: linuxppc-embedded@ozlabs.org; 'Aitor Arzuaga'; 'Miguel =C1ngel =
=C1lvarez
Cabanes'
Subject: RE: 16-bit PCMCIA resource allocation

I have the following lines:

PCI: Bus 1, cardbus bridge: 0000:00:18.0
  IO window: 00001000-000011ff
  IO window: 00001400-000015ff
  PREFETCH window: 80000000-803fffff
  MEM window: a0400000-a07fffff
Yenta: ISA IRQ mask 0x0000, PCI irq 1
Socket status: 30000410
pcmcia: parent PCI bridge I/O window: 0x0 - 0xffffff
pcmcia: parent PCI bridge Memory window: 0x80000000 - 0x9fffffff
pcmcia: parent PCI bridge Memory window: 0xa0000000 - 0xafffffff
...
...
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x80000000-0x9fffffff: excluding 0x80000000-0x9fffffff
cs: memory probe 0xa0000000-0xafffffff: excluding 0xa0000000-0xa07fffff


In fact the assigned resources are (the important one is the
pcmcia_socket0):

# cat /proc/iomem
80000000-9fffffff : PCI prefetchable memory
  80000000-803fffff : PCI CardBus #01
a0000000-afffffff : PCI memory
  a0000000-a0000fff : 0000:00:18.0
    a0000000-a0000fff : yenta_socket
  a0040000-a007ffff : 0000:00:1a.0
  a0400000-a07fffff : PCI CardBus #01
  a0800000-a0800fff : pcmcia_socket0
f0000900-f000097f : mpc52xx-mscan.0
f0000980-f00009ff : mpc52xx-mscan.1
f0000f00-f0000f1f : mpc52xx-spi
f0001000-f00010ff : ppc-soc-ohci
f0001200-f00012ff : mpc52xx-sdma
  f0001200-f00012ff : mpc52xx-sdma
f0001300-f000130f : mpc52xx-bdlc
f0002000-f000209f : mpc52xx-psc.0
  f0002000-f000209f : mpc52xx_psc_uart
f0002200-f000229f : mpc52xx-psc.1
f0002400-f000249f : mpc52xx-psc.2
  f0002400-f000249f : mpc52xx_psc_uart
f0002600-f000269f : mpc52xx-psc.3
  f0002600-f000269f : mpc52xx_psc_uart
f0002800-f000289f : mpc52xx-psc.4
f0002c00-f0002c9f : mpc52xx-psc.5
f0003000-f00033ff : mpc52xx-fec
  f0003000-f00033ff : mpc52xx-fec
f0003a00-f0003aff : mpc52xx-ata
f0003d00-f0003d1f : fsl-i2c.0
f0003d40-f0003d5f : fsl-i2c.1
f0008000-f000bfff : mpc52xx-sdma
  f0008000-f000bfff : mpc52xx-sdma
ff800000-ffffffff : physmap-flash.0
  ff800000-ffffffff : physmap-flash.0
# cat /proc/ioports
00000000-00ffffff : PCI I/O
  00000000-0000003f : pcmcia_socket0
  00001000-000011ff : PCI CardBus #01
  00001400-000015ff : PCI CardBus #01


That are not equal to the resources that were used by linux kernel
2.6.10:

~ # cat /proc/iomem
80000000-9fffffff : PCI prefetchable memory
  80000000-803fffff : PCI CardBus #01
a0000000-afffffff : PCI memory
  a0000000-a0000fff : 0000:00:18.0
    a0000000-a0000fff : yenta_socket
  a0040000-a007ffff : 0000:00:1a.0
  a0100000-a0100fff : pcmcia_socket0
  a0400000-a07fffff : PCI CardBus #01
f0002000-f000209f : mpc52xx_psc_uart
f0002400-f000249f : mpc52xx_psc_uart
f0002600-f000269f : mpc52xx_psc_uart
f0003000-f00033fb : mpc52xx_fec
f0003d00-f0003d1f : i2c-mpc
f0003d40-f0003d5f : i2c-mpc
~ # cat /proc/ioports
00000000-00ffffff : PCI I/O
  00000100-0000013f : pcmcia_socket0
  00001000-000010ff : PCI CardBus #01
  00001400-000014ff : PCI CardBus #01

Maybe a better understanding of the resource allocation mechanism is
needed in order to know if the differences are important, or if it
should work also with this resource allocation table.

Thank you,
Asier Llano



El vie, 16-02-2007 a las 10:32 -0600, David Clark escribi=F3:
> Asier,
>=20
> Do you get the following message or similar during boot (dmesg
output)?
>=20
> "cs: memory probe 0x80000000-0xfcffffff:"
> "  excluding 0x80000000-0xfcffffff"
>=20
> Note: in my dmesg output these where not on consecutive lines.
>=20
> David Clark
> Senior Software Engineer
> C&H Technologies, Inc
> Web: http:\\www.chtech.com
> Phone: 512-733-2621
> Fax: 512-733-2629
> Email: dlclark@chtech.com
> =20
>=20
>=20
>=20
=20
----------------------------------------- PLEASE NOTE
-------------------------------------------
This message, along with any attachments, may be confidential or legally
privileged.=20
It is intended only for the named person(s), who is/are the only
authorized recipients.
If this message has reached you in error, kindly destroy it without
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como
=FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente.
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los
virus contenidos en los ficheros anexos.
