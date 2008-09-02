Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 63159DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 20:51:45 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5121e port status
Date: Tue, 2 Sep 2008 12:50:52 +0200
References: <6e36f2f00808271507w5b58d646w66c73c5af5931e50@mail.gmail.com>
In-Reply-To: <6e36f2f00808271507w5b58d646w66c73c5af5931e50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809021250.52802.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008 00:07:11 Andr=E9s Calder=F3n wrote:
> Is the mpc5121e kernel port mature enough to be used in commercial
> appliance?

That depends. For any use of the linux kernel in a "commercial appliance", =
the=20
manufacturer of the appliance has the sole responsibility of testing for=20
stability and fitness.

That said, the status of MPC5121e support in the linux kernel is as follows:

Latest mainline (git) kernel: Only basic CPU support, almost no drivers for=
=20
anything.

LTIB distribution from Freescale (downloadable on Freescale web-page of the=
=20
MPC5121e), latest version: kernel 2.6.24.5 with a lot of drivers for (among=
=20
other things): DIU, NAND-flash, PSC-I2C, PSC-Uarts, CAN, DMA, Ethernet, USB=
=20
(ehci host works well), etc....
Notably missing from this version is support for MBX, SATA and SDHC.
One thing that you shouldn't count on quite yet is the MBX (3D-acceleration=
),=20
because it will not have open-source drivers in any forseeable time AFAIK=20
(probably never)... only some promise of a commercial driver and OpenGL-ES=
=20
library which probably will be more of a hassle than useful to anyone.

We have a custom board running the LTIB version of the kernel, and the=20
existing drivers work surprisingly well, but are IMHO not useable for=20
production right out of the box. The NAND-flash driver for instance is brok=
en=20
for most uses, and the DIU driver has some cache-related issues (glitches i=
n=20
the image). Those problems are more or less easily fixed however. Ethernet=
=20
and USB (host) seem pretty stable however (I am running on NFS-root all the=
=20
time).

There are effords underway to get the drivers ported and fixed for mainline=
=20
linux, but the process is quite slow at the moment. That has us for instanc=
e=20
locked in the ancient 2.6.24.5 version of the kernel.

Best regards,

=2D-=20
David Jander
