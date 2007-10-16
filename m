Return-Path: <Martin.Leisner@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cross compilation issue
Date: Tue, 16 Oct 2007 15:34:52 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C064600D5@USA0300MS03.na.xerox.net>
References: <20071016190750.224A3242E9@gemini.denx.de>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org,
	linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

I disagree vehemently with "modifying" you session to suit the platform.
This becomes a problem when cross-platforms > 1.  When I "set the PATH =
and
environment variables" I have the same problem -- I go to a different=20
platform, type make and get bad results.  =20

Why is modifying the makefile a "bad thing?"  hardhat did it, and =
afterwards
the cross-compile/arch becomes painless and transparent.  Building ways =
to=20
construct software with fewer chances of human error is IMHO a "good =
thing".

I tend to lock down my source tree, and have a link tree for each =
platform.
So I'm not changing my build parameters, hard coding these things in the =
makefile
becomes a "set and forget" operation.

I agree with "problems" running from command lines...I often link in=20
special tools into ~/bin so I can find them (instead of modifying my =
path).
But I can go weeks without having to run a tool from the command line, =
make's I run daily.


Having to "source" a script is another thing you can "forget" to do.
I often "forget" to run my 'make-line' script, and when I quickly hit =
<cntl>-C I don't
have problems (but sometimes I do).

marty

PS:
To cross developers,  its VERY handy to build a copy of binutils which =
support multiple=20
architectures -- so the
only thing which is really platform dependent is gas...so my host =
nm/objcopy/objdump/ld
supports all the platforms I'm working on...

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tue 10/16/2007 3:07 PM
To: Leisner, Martin
Cc: ravi.rao@rflelect.com; avenkatesh@hcl.in; =
linuxppc-embedded-bounces+ravi.rao=3Drflelect.com@ozlabs.org; =
linuxppc-embedded@ozlabs.org
Subject: Re: cross compilation issue
=20
Dear Martin,

in message =
<556445368AFA1C438794ABDA8901891C0750DDF0@USA0300MS03.na.xerox.net> you =
wrote:
>=20
> #! /bin/bash
>=20
> exec make ARCH=3Dpowerpc =
CROSS_COMPILE=3D/opt/denx/eldk4.1/usr/bin/ppc_74xx- =
INSTALL_MOD_PATH=3D${PWD}/root $*

Note that this is *NOT* a suppoted value for CROSS_COMPILE. Please set
your PATH to include the /opt/denx/eldk4.1/usr/bin directory, and set
CROSS_COMPILE=3Dppc_74xx-=20

> I know hardhat linux had a strategy to make . files hiding the names =
of ARCH/CROSS_COMPILE -- so typing make
> would work once configured...
>=20
> IMHO it should be hardcoded in the Makefile after configuration -- it =
causes a lot of grief if you FORGET
> to specify one of these and just type "make".

I disagree. Such an approach will hit you as soon as you run a command
not from "make", but from the command line.

Instead, please set and export thse variables in your shell
environment, where each tool can pick it up.

If you have to switch environments frequently you can use some  shell
functions  to  do  so. For example, ELDK 4.1 which you use comes with
the  "eldk_init"  script   ("/opt/denx/eldk4.1/eldk_init"   in   your
installation) which can be "sourced" from the shell like this:

	$ source /opt/denx/eldk4.1/eldk_init 74xx
	ARCH=3Dppc
	CROSS_COMPILE=3Dppc_74xx-
	DEPMOD=3D/opt/denx/eldk4.1/usr/bin/depmod.pl
	PATH=3D/opt/denx/eldk4.1/usr/bin:/opt/denx/eldk4.1/bin: ...
	$

ELDK 4.2 will use a much cleverer script "eldk-switch" which allows
to select versions and board like this:

	-> eldk-switch -r4.1 sequoia
	[ sequoia is using PPC440EPx ]
	Setup for ppc_4xxFP (using ELDK 4.1)
	-> eldk-switch -r4.2 TQM8540
	[ TQM8540 is using MPC8540 ]
	Setup for ppc_85xx (using ELDK 4.2)
	-> eldk-switch -r4.0 MPC860
	Setup for ppc_8xx (using ELDK 4.0)
	-> eldk-switch MPC7448
	Setup for ppc_74xx (using ELDK 4.2)

> One of the things I want to do is look at how the linux make system =
works now (I recall at times I edit the Makefile
> to hardcode these things).

Never edit the Makefile - this is always a Bad Thing (TM) to do.

Make sure to either set the ARCH and CROSS_COMPILE ariables  in  your
environment  (this  is  IMHO the more convenient way) or pass them on
the make command line.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Wenn Du ein' weise Antwort verlangst, Mu=DFt Du vern=FCnftig fragen.
                                                -- Goethe, Invektiven
