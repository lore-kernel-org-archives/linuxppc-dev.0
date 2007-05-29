Return-Path: <BillF@optiscan.com>
Received: from mail.optiscan.com (mailgw.optiscan.com [203.26.112.6])
	by ozlabs.org (Postfix) with ESMTP id 6D9ACDDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 17:13:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8560 Gianfar driver hangs after soft reboot
Date: Tue, 29 May 2007 17:13:13 +1000
Message-ID: <34E73CC1202BF246B7DE3463BEBC068998EE91@postie.optiscan.com>
In-Reply-To: <4656D9BE.3000809@anagramm.de>
References: <34E73CC1202BF246B7DE3463BEBC068998EE82@postie.optiscan.com>
	<4656D9BE.3000809@anagramm.de>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 25 May 2007 Clemens Koller wrote:
> Hi, Bill!
>=20
> Bill Farrow schrieb:
> > The Gianfar driver is hanging during boot-up after a soft
> reboot.  It works fine when the board is power cycled.
> >=20
> > Any hints on where to look further on this issue?
>=20
> I have had some rare issues with PHY initialization on the
> PM854 with the u-boot-1.2.0 not being able to download something via=20
> TFTP. There is an entry somewhere in the U-Boot wiki (I think) that=20
> the TQM8540 board can have some issues...
> well the boards are quite similar.
> Pushing the reset button (Never needed to power that off) solves the=20
> issue.

We have found a work around for this problem: If the network interfaces
are disabled before doing a soft reboot then everything works properly.
We are using the ramdisk from the ELDK 4.1 and are no rc scripts for
busybox to call to shutdown the network interfaces before rebooting.  We
will just add our own script to do this when rebooting.

> > 3. After rebooting, the system starts up Linux and it hangs after:
> >=20
> >   eth0: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:00
> >   eth0: Running with NAPI enabled
> >   eth0: 256/256 RX/TX BD ring size
>=20
> The Kernels I 've tried (2.6.13 up to 2.6.21-rc5 and some latest gits)

> never stopped there...
> I would just try another kernel. Checkout the code in the latest git.

Agreed. I did look at some future kernel versions to see what changes
had been made to the gianfar source code, but your right, we should try
some out on the actual hardware.

> > Also tried soft rebooting without the network cable and the kernel=20
> > boots without hanging, but the network does not work when
> the re-connected.
> > The PHY seems to be working because when we plug the cable
> back in it
> > detects the link and writes this console message:
> >=20
> >   [ 1557.465085] PHY: 0:01 - Link is Up - 100/Full
> >=20
> > Note that there are two Ethernet controllers on the board (eth0 and=20
> > eth1).  Only eth1 is connected to the network.
>=20
> What PHY's do you have on these ports?
> (MV88E1111 over here)

Same ones as you: Marvell 88E1111 Gigabit NetPhy

> > Background info:
> > Kernel version 2.6.20.4 PPC
> > Uboot version 1.2.0
> > Busybox version 1.5.0
> > ELDK: 4.1
> > JTAG: BDI-2000
> > Board : Microsys PM856 - with MPC8560 processor.
>=20
> Looks good. I am using the PM854.
>=20
> Well, some other thing: I had some instabilities on my prototyping=20
> hardware in the beginnging, but I guess due to EMI and the sloppy=20
> setup.
> After I got all the stuff nailed down onto some aluminum-plate, the=20
> boards is working _very_ stable (24/7).

We are using the Microsys carrier board with the PM856 module and has
been quite stable.

Bill
