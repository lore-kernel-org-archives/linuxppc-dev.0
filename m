Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id 377042BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:34:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jan 2005 09:34:21 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB912F225@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Saso Kavcic" <saso@activetools.si>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Some issues with kernel 2.6 for MPC8260 target
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I ported it to the Embedded Planet ep8260 board with FCC3, ep8248 board
with FCC1 and FCC2 and ep8280 with FCC2 and FCC3.  I had to make very
little, if anything, to get it to work.  I did not try 2.6.9.  I am
currently using 2.6.10-rc3 which I believe after the last merge is now
2.6.10.  I did practically nothing to get all of these to work.=20

> -----Original Message-----
> From: Saso Kavcic [mailto:saso@activetools.si]=20
> Sent: Wednesday, January 12, 2005 9:27 AM
> To: Steven Blakeslee
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Some issues with kernel 2.6 for MPC8260 target
>=20
> Hi Steven,
>=20
> Have you noticed any improvements in 2.6.10. over 2.6.9? We=20
> were porting
> 2.6.9 to a custom mpc8275vr
> board and we were able to get everything working except=20
> ethernet (fcc enet). We did manage to get a few packets over=20
> it but it was all very slow, unstable and unpredictable and=20
> it seemed that fcc enet driver doesn't work well in 2.6. Were=20
> you able to use fcc under 2.6.9?
>=20
> Best Regards, Saso
>=20
> Steven Blakeslee wrote:
>=20
> >I would suggest going to the latest 2.6.10 kernel.  I have=20
> it running=20
> >with several ethernets running on all the 82xx processors.
> >
> > =20
> >
> >>-----Original Message-----
> >>From: linuxppc-embedded-bounces@ozlabs.org
> >>[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Vijay=20
> >>Padiyar
> >>Sent: Wednesday, January 12, 2005 5:37 AM
> >>To: LinuxPPC Support
> >>Subject: Some issues with kernel 2.6 for MPC8260 target
> >>
> >>Hi all
> >>
> >>I wish to discuss some strange issues that I faced with=20
> respect to the=20
> >>Linux
> >>2.6.8 kernel (downloaded from kernel.org). Firstly, I wish to know=20
> >>whether this has been known to work on an MPC8260 PowerPC target.
> >>
> >>Secondly, when I tried to compile the Linux kernel with my=20
> toolchain=20
> >>(built with Dan Kegel's crosstool for the PowerPC 603e=20
> core, which is=20
> >>what my processor has), I got some errors which I found to rather=20
> >>queer after investigation. Firstly, let me state the errors that I=20
> >>got:
> >>
> >>------------------------------------------------------
> >>
> >>  LD      init/built-in.o
> >>  LD      .tmp_vmlinux1
> >>arch/ppc/8260_io/built-in.o(.text+0x103c): In function
> >>`mii_queue_relink':
> >>arch/ppc/8260_io/fcc_enet.c:1254: undefined reference to=20
> >>`schedule_task'
> >>arch/ppc/8260_io/built-in.o(.text+0x1074): In function
> >>`mii_queue_config':
> >>arch/ppc/8260_io/fcc_enet.c:1263: undefined reference to=20
> >>`schedule_task'
> >>
> >>------------------------------------------------------
> >>
> >>On further investigation, I find that 'schedule_task()' is=20
> simply not=20
> >>defined anywhere in the 2.6.8 kernel sources. This is quite wierd!=20
> >>However, it is defined in a file 'context.c'
> >>(linux-src/kernel) in the 2.4.27 kernel sources, which we=20
> were using=20
> >>earlier. How is it that a function is being called but its=20
> definition=20
> >>has been removed from the sources?
> >>
> >>Another such example is with the structure 'tq_struct'. It=20
> is referred=20
> >>to in the file 'fcc_enet.c'
> >>(linux-src/arch/ppc/8260_io) but it's not defined anywhere!=20
> >>Again, after checking in the 2.4.27 sources, I find that=20
> it's defined=20
> >>in the file 'tqueue.h' (linux-src/include/linux)!
> >>
> >>A third thing is that the 2.4.27 kernel source file 'uart.c'
> >>(linux-src/arch/ppc/cpm2_io) is not present in the corresponding=20
> >>folder in the 2.6.8 source (linux-src/arch/ppc/8260_io).=20
> There is one=20
> >>'uart.c' in the folder '8xx_io', but it doesn't get compiled during=20
> >>the kernel build process. Will my UART work correctly with=20
> this build?
> >>
> >>Can someone please tell me if there's some explanation for=20
> this that=20
> >>I'm unaware of? Which would be the proper forum to report=20
> this? Again=20
> >>I would like to ask: Has the 2.6.8 kernel been tested=20
> successfully on=20
> >>the MPC8260 PowerPC platform?
> >>
> >>Lastly, where can I get the latest stable Linux kernel=20
> source for the=20
> >>PowerPC platform?
> >>
> >>Regards
> >>
> >>Vijay Padiyar
> >>_______________________________________________
> >>Linuxppc-embedded mailing list
> >>Linuxppc-embedded@ozlabs.org
> >>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >>   =20
> >>
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > =20
> >
>=20
>=20
