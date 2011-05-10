Return-Path: <B10812@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E29671007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 17:50:37 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Hollis Blanchard <hollis_blanchard@mentor.com>, Prasanna Khanapur
	<pskhanapur@googlemail.com>
Subject: RE: Regarding P2020 in AMP mode
Date: Tue, 10 May 2011 07:50:26 +0000
Message-ID: <45903308677306428B6EE7E6FF5A5204120187@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTik7tZSJ9-OPDbQEPJDHpZ13wMmo_Q@mail.gmail.com>
	<4DC84D09.5020909@mentor.com>
In-Reply-To: <4DC84D09.5020909@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code looks to be correct in upstream,
Can u mention the AMP boot steps you are using.


5.5.2.4 Test Procedure
1. Power on the board
2. Follow the command below at U-boot prompt=20
=3D> setenv <serverip>
=3D> setenv <ipaddr>
=3D> setenv ethact eTSEC2
=3D> setenv bootargs root=3D/dev/ram rw console=3DttyS0,115200
3. Bring up core1's kernel first:=20
=3D> setenv bootm_low 0x10000000
=3D> setenv bootm_size 0x8000000
=3D> tftp 11000000 uImage.core1
=3D> tftp 12000000 rootfs_min.ext2.gz.uboot
=3D> tftp 10c00000 p1020rdb_camp_core1.dtb
=3D> interrupts off=20
=20
=3D> bootm start 11000000 12000000 10c00000
=3D> bootm loados
=3D> bootm ramdisk
=3D> bootm fdt
=3D> fdt boardsetup
=3D> fdt chosen $initrd_start $initrd_end
=3D> bootm prep
=3D> cpu 1 release $bootm_low - $fdtaddr -

As soon as, when you run the cpu 1 release $bootm_low - $fdtaddr - command,=
 Core-1 starts booting=20
and boot-up log can be observed on the UART#2 console.
4. Bring up core0's kernel(on the same u-boot console -UART#1):
=3D> setenv bootm_low 0x0
=3D> setenv bootm_size 0x10000000
=3D> tftp 1000000 uImage.core0
=3D> tftp 2000000 rootfs_min.ext2.gz.uboot
=3D> tftp c00000 p1020rdb_camp_core0.dtb
=3D> bootm 1000000 2000000 c00000


The main catch  here is to use eTSEC2 as active port at u-boot. I think I r=
emember we also  faced similar issue.
Regards
Poonam

> -----Original Message-----
> From: linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Hollis Blanchard
> Sent: Tuesday, May 10, 2011 1:53 AM
> To: Prasanna Khanapur
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: Regarding P2020 in AMP mode
>=20
> On 05/07/2011 05:20 AM, Prasanna Khanapur wrote:
> > Hi,
> > I'm running P2020 in AMP mode, each core running its linux os.
> > Ethernet 1(@25000) and Ethernet 2(@26000) assigned to Core0 are
> > working fine.
> > I'm facing problems with Ethernet interface(@24000) assigned to Core1,
> > its not working.
> >
> > I'm using dts file which were added by :
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/075594.h
> > tml
> >
> > Looks either there is some mistake in the dts file or my understanding
> > is wrong.
> >
> > MDIO @24000 is defined in core0 dts file though the Ethernet is
> > assigned to Core 1.
> >
> > DTS files :
> > http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p202
> > 0rdb_camp_core0.dts
> > http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p202
> > 0rdb_camp_core1.dts
>=20
> The fixed-link property in core1.dts indicates enet0 should use 1Gb link.
> Is that device connected to a 1Gb network?
>=20
> --
> Hollis Blanchard
> Mentor Graphics, Embedded Systems Division
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
