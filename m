Return-Path: <wd@denx.de>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: cross compilation issue
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Oct 2007 12:36:46 EDT."
	<556445368AFA1C438794ABDA8901891C0750DDF0@USA0300MS03.na.xerox.net>
Date: Tue, 16 Oct 2007 21:07:50 +0200
Sender: wd@denx.de
Message-Id: <20071016190750.224A3242E9@gemini.denx.de>
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

Dear Martin,

in message <556445368AFA1C438794ABDA8901891C0750DDF0@USA0300MS03.na.xerox.net> you wrote:
> 
> #! /bin/bash
> 
> exec make ARCH=powerpc CROSS_COMPILE=/opt/denx/eldk4.1/usr/bin/ppc_74xx- INSTALL_MOD_PATH=${PWD}/root $*

Note that this is *NOT* a suppoted value for CROSS_COMPILE. Please set
your PATH to include the /opt/denx/eldk4.1/usr/bin directory, and set
CROSS_COMPILE=ppc_74xx- 

> I know hardhat linux had a strategy to make . files hiding the names of ARCH/CROSS_COMPILE -- so typing make
> would work once configured...
> 
> IMHO it should be hardcoded in the Makefile after configuration -- it causes a lot of grief if you FORGET
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
	ARCH=ppc
	CROSS_COMPILE=ppc_74xx-
	DEPMOD=/opt/denx/eldk4.1/usr/bin/depmod.pl
	PATH=/opt/denx/eldk4.1/usr/bin:/opt/denx/eldk4.1/bin: ...
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

> One of the things I want to do is look at how the linux make system works now (I recall at times I edit the Makefile
> to hardcode these things).

Never edit the Makefile - this is always a Bad Thing (TM) to do.

Make sure to either set the ARCH and CROSS_COMPILE ariables  in  your
environment  (this  is  IMHO the more convenient way) or pass them on
the make command line.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Wenn Du ein' weise Antwort verlangst, Mußt Du vernünftig fragen.
                                                -- Goethe, Invektiven
