Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 94A15DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 03:27:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Best Linux tree for Xilinx support.
Date: Tue, 14 Aug 2007 10:28:20 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
	<20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang:

Thank you very much for the information. What kernel.org version your
tree is based on?

As you noticed, it will be rather reference tree to set some coding
standard, namely where files are located, how drivers are included,
etc... So, I would appreciate if I can get a glimpse of your suggested
tree structure, actual sources are not even required.

Previous support for Xilinx was more oriented toward PPC405 core in
Virtex FPGA and everything was naturally concentrated under
arch/ppc/platform/4xx.

I deem such approach is not very good one. I'm using precisely same IP
cores like GPIO, EMAC, SPI, CAN, etc... in Virtex and Spartan FPGAs
which means (OK, may be cores are different somewhat for different FPGAs
but low level Xilinx code is the same). That means at least 2 different
CPU architectures (PPC and Microblaze).=20

You certainly gave thought to such an issue. What tree structure do you
suggest? There are 3 groups of Xilinx files to place in the Linux tree:

- common .h files (like xbasic_types.h);
- common .c files, used by several cores (like all DMA stuff).
- specific core .h/.c files (say xemac.h and xemac.c).

They all kind of "architecture independent" (at least 2 architectures
can be used - MB and PPC).

Of course, except tree structure there are several other (not completely
independent) questions to answer like:

A How EDK project parameters get into Linux kernel? This is huge issue
which can be divided on several items.

A.1. Do you also suppose that some special type of BSP (.tcl script,
defined by OS parameter of MSS file) shall run or you assume that it
will be regular xaparameters.h file, prepared by standard standalone
BSP? In latter case xparamerts.h needs manual editing since it doesn't
have all parameters required by certain cores.=20

A.2. There is also a question how these definitions get into .c and Make
files. Petalogix has interesting solution when they bump all XILINX
parameters to autoconf.h and .config files thus making them available
for both compiler and make. What's your approach?

A.3. If .config is not prepared automatically, then all configuration
must be done via "make menuconfig" meaning Kconfig files shall be
modified. Do you intend having several FPGA flags like CONFIG_VIRTEX and
CONFIG_SPARTAN? Drivers' inclusion will depend on one of them.

A.4. Is it assumed that Xilinx low level code will stay intact as it is
supplied with EDK package or you are going to prepare special Linux
Xilinx set (mostly because of name convention)?

B How drivers get registered - via platform devices structure in
virtex.c file or something different?

All these questions have been discussed by the community but I somehow
missed a conclusion if any took place. Does anything (kind of memo or
readme) exist on these subjects?

Thanks,

Leonid.

-----Original Message-----
From: Wolfgang Reissnegger [mailto:wolfgang.reissnegger@xilinx.com]=20
Sent: Monday, August 13, 2007 10:08 PM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Best Linux tree for Xilinx support.

Hi Leonid,

I am in the process of publishing a Xilinx Linux git tree which will
contain most of the drivers for Xilinx IP including recent contributions
from Grant Likely, John Williams, Joachim Foerster and others.

This tree will be available on the Xilinx git server soon, however it
will be a non-supported (and likely unstable) tree. Its main purpose is
to provide a common code base for development and a channel to push new
driver code out into the community.

I am still waiting on IT to set up the new server machine. I will post
an announcement once the server is up and running.

Cheers,
   Wolfgang

Leonid wrote:
> Hi:
>=20
> I have several boards with different architectures (Microblaze, PPC),=20
> running Linux/uClinux and using Xilinx IP cores. I use both Virtex and

> Spartan FPGAs.
>=20
> Historically I'm using different kernels for them, starting from=20
> uClinux 2.4, all way through Linux 2.6.16 and 2.6.19. I patched them=20
> here and there to get working.
>=20
> I certainly feel a need to move to some standard kernel tree.
>=20
> I understand that you guys are in some advanced steps of integrating=20
> Xilinx into Linux. What would be my best choice of Linux kernel now?
>=20
> I see the following options:
>=20
> - download some GIT tree your are using (which one?).
> - get latest tree from kernel.org and patch it using your patches=20
> (where I can get them?).
> - ??
>=20
> Please advise,
>=20
> Thanks,
>=20
> Leonid.
>=20
