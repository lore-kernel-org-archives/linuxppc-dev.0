Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5CFB8DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 06:09:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: xilinx_hwicap driver problems
Date: Wed, 14 May 2008 13:09:00 -0700
In-reply-to: <3ee6f9e50805141220g2440bd4am6846b416ce20f721@mail.gmail.com>
References: <3ee6f9e50805140903o381346f5kddbce29a3d06ba1f@mail.gmail.com><20080514183731.04FE920053@mail163-sin.bigfish.com>
	<3ee6f9e50805141220g2440bd4am6846b416ce20f721@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Will Kritikos" <will.kritikos@gmail.com>
Message-Id: <20080514200902.DD744F40075@mail7-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



OK, that's progress.  The next thing I'd check is that you are *not*
using the JTAG configuration mode, as this disables the ICAP.  You can
also try turning on the DEBUG flags in the driver itself.  During open()
the driver attempts to read the IDCODE from the hwicap to get it back to
an initial state.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Will
Kritikos
> Sent: Wednesday, May 14, 2008 12:20 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: xilinx_hwicap driver problems
>=20
> Steve,
> Yes, this fixed that problem.  the following is now printed when
> booting the kernel.
>=20
> [    5.866230] icap icap.0: Xilinx icap port driver
> [    5.866401] icap icap.0: ioremap 40200000 to c5000000 with size
10000
>=20
> The icap is at address 0x40200000 on my system, so that seems correct.
>=20
> However, when I copy partial bitstreams to the device, I get strange
> results.  Here is what I am seeing.
>=20
>  # mknod /dev/icap c 259 0
> # cp opb_prr_0_lin_partial.bit /dev/icap
> cp: write error: Bad address
> # cp opb_prr_0_lin_partial.bit /dev/icap
> [   66.566107] icap icap.0: Failed to open file#
> # cp opb_prr_0_lin_partial.bit /dev/icap
> #
>=20
> I know that this file exists in the current directory, and is a
> working partial bitstream.
>=20
> Thanks for the help.
> Will
>=20
>=20
> On Wed, May 14, 2008 at 2:37 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > I bet you're using ARCH ppc...
> >
> > It looks like in arch/ppc/syslib/virtex_devices.c:
> >
> > #define XPAR_HWICAP(num) { \
> >        .name =3D "xilinx_icap", \
> >
> > Should probably be:
> >
> > #define XPAR_HWICAP(num) { \
> >        .name =3D "icap", \
> >
> > now.
> >
> > Can you make this change locally and verify that it solves the
problem?
> >
> > Steve
> >
> >> -----Original Message-----
> >> From:
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> > [mailto:linuxppc-embedded-
> >> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Will
> > Kritikos
> >> Sent: Wednesday, May 14, 2008 9:03 AM
> >> To: linuxppc-embedded@ozlabs.org
> >> Subject: xilinx_hwicap driver problems
> >>
> >> I am having some trouble using the xilinx_hwicap driver in Linux.
> >> I am using version 2.6.24-rc8-xlnx of the Linux kernel from the
Xilinx
> >> GIT repository.
> >> The xilinx_hwicap driver is statically compiled in - not a loadable
> > module.
> >> I am using the opb_hwicap device on a V4FX60 FPGA, Linux running on
> > the PPC405.
> >>
> >> The driver successfully is initialized on boot - I added a printk
to
> >> the init function to verify this.   However, as far as I can tell,
the
> >> probe function is never called.  There is nothing in dmesg from the
> >> icap driver.
> >>
> >> After boot, the following files exist in /sys
> >>
> >> /sys/bus/platform/xilinx_icap.0
> >> /sys/bus/platform/drivers/icap/bind
> >> /sys/bus/platform/drivers/icap/uevent
> >> /sys/bus/platform/drivers/icap/unbind
> >> /sys/devices/platform/xilinx_icap.0
> >>
> >> I can make a device node /dev/icap, major number 259 minor number
0,
> >> and copy partial bitstreams to it, but again nothing happens, and
no
> >> output in dmesg.
> >>
> >> Any help is appreciated.  I am probably overlooking something
simple.
> >>
> >> Thanks,
> >> Will Kritikos
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > This email and any attachments are intended for the sole use of the
named recipient(s) and
> contain(s) confidential information that may be proprietary,
privileged or copyrighted under
> applicable law. If you are not the intended recipient, do not read,
copy, or forward this email
> message or any attachments. Delete this email message and any
attachments immediately.
> >
> >
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be=
 proprietary, privileged or copyrighted under applicable law. If you are=
 not the intended recipient, do not read, copy, or forward this email=
 message or any attachments. Delete this email message and any attachments=
 immediately.
