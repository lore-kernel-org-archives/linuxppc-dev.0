Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 5C9A1DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 06:46:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Best Linux tree for Xilinx support.
Date: Tue, 14 Aug 2007 13:47:30 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C02053C2C@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20070814204218.6986C64807A@mail1-fra.bigfish.com>
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
	<20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
	<406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
	<20070814204218.6986C64807A@mail1-fra.bigfish.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
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

Thank you both for detailed answers, it was very helpful indeed.

Reagrds,

Leonid.

-----Original Message-----
From: Wolfgang Reissnegger [mailto:wolfgang.reissnegger@xilinx.com]=20
Sent: Tuesday, August 14, 2007 1:44 PM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Best Linux tree for Xilinx support.

Hi Leonid,

see my answers below.

> Thank you very much for the information. What kernel.org version your=20
> tree is based on?

Right now the development tree is based on mainline (Linus' tree)
v2.6.22. I also keep a release candidate (rc) branch around that I sync
up frequently with the leading edge mainline in order to catch merge
conflicts early. However, I'm not currently test-compiling the rc
branch.

> As you noticed, it will be rather reference tree to set some coding=20
> standard, namely where files are located, how drivers are included,=20
> etc... So, I would appreciate if I can get a glimpse of your suggested

> tree structure, actual sources are not even required.

The structure follows pretty much what is out there so far. For example,
the temac/emac/lltemac drivers go into drivers/net/xilinx_xxx.

All the PPC405 stuff is still in arch/ppc. I know it needs to be ported
over to arch/powerpc, which is one of the future goals.

MicroBlaze support is in arch/microblaze and include/asm-microblaze.

> Previous support for Xilinx was more oriented toward PPC405 core in=20
> Virtex FPGA and everything was naturally concentrated under=20
> arch/ppc/platform/4xx.

This is, for now, still the case. See above.

> I deem such approach is not very good one. I'm using precisely same IP

> cores like GPIO, EMAC, SPI, CAN, etc... in Virtex and Spartan FPGAs=20
> which means (OK, may be cores are different somewhat for different=20
> FPGAs but low level Xilinx code is the same). That means at least 2=20
> different CPU architectures (PPC and Microblaze).

Yes.

> You certainly gave thought to such an issue. What tree structure do=20
> you suggest? There are 3 groups of Xilinx files to place in the Linux
tree:
>=20
> - common .h files (like xbasic_types.h);
> - common .c files, used by several cores (like all DMA stuff).
> - specific core .h/.c files (say xemac.h and xemac.c).
>=20
> They all kind of "architecture independent" (at least 2 architectures=20
> can be used - MB and PPC).

Yes, the drivers are (or at least should be) arch independent. So far we
have been able compiling various drivers under PPC405 and MB without any
code changes. Further testing is needed, but generally it looks OK.

> Of course, except tree structure there are several other (not=20
> completely
> independent) questions to answer like:
>=20
> A How EDK project parameters get into Linux kernel? This is huge issue

> which can be divided on several items.
>=20
> A.1. Do you also suppose that some special type of BSP (.tcl script,=20
> defined by OS parameter of MSS file) shall run or you assume that it=20
> will be regular xaparameters.h file, prepared by standard standalone=20
> BSP? In latter case xparamerts.h needs manual editing since it doesn't

> have all parameters required by certain cores.

The kernel will contain pre-generated xparameters_xxx.h files for the
reference systems. For custom projects you still need to copy over the
EDK-generated xparameters.h file.

For the xparameters.h file we are planning to move away from the bus
specific #defines and move towards more generic ones.

> A.2. There is also a question how these definitions get into .c and=20
> Make files. Petalogix has interesting solution when they bump all=20
> XILINX parameters to autoconf.h and .config files thus making them=20
> available for both compiler and make. What's your approach?

I have thought about adopting the Petalogix scheme at some point.
However, i got into trouble as I was changing too many things at a time.
I think the Petalogix way works well and could be one of the future
solutions for that.
Currently the approach is to copy over the EDK-generated xparamater.h
file.

> A.3. If .config is not prepared automatically, then all configuration=20
> must be done via "make menuconfig" meaning Kconfig files shall be=20
> modified. Do you intend having several FPGA flags like CONFIG_VIRTEX=20
> and CONFIG_SPARTAN? Drivers' inclusion will depend on one of them.

The plan is to generate a .config file through the EDK.

> A.4. Is it assumed that Xilinx low level code will stay intact as it=20
> is supplied with EDK package or you are going to prepare special Linux

> Xilinx set (mostly because of name convention)?

For new drivers, meaning the ones that we are putting into the kernel
right now, the drivers will not follow the Linux coding convention. As
time progresses there will be one or the other driver being converted
for upstream, though.

> B How drivers get registered - via platform devices structure in=20
> virtex.c file or something different?

Drivers will be registered vie platform devices for botthe MB and PPC405
systems.

> All these questions have been discussed by the community but I somehow

> missed a conclusion if any took place. Does anything (kind of memo or
> readme) exist on these subjects?

Nope...

> Thanks,
>=20
> Leonid.

Cheers,
   Wolfgang
