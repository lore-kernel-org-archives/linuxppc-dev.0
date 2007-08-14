Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5277FDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 06:42:39 +1000 (EST)
Date: Tue, 14 Aug 2007 13:43:58 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Best Linux tree for Xilinx support.
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
	<20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
	<406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20070814204218.6986C64807A@mail1-fra.bigfish.com>
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

Hi Leonid,

see my answers below.

> Thank you very much for the information. What kernel.org version your
> tree is based on?

Right now the development tree is based on mainline (Linus' tree)
v2.6.22. I also keep a release candidate (rc) branch around that I sync
up frequently with the leading edge mainline in order to catch merge
conflicts early. However, I'm not currently test-compiling the rc branch.

> As you noticed, it will be rather reference tree to set some coding
> standard, namely where files are located, how drivers are included,
> etc... So, I would appreciate if I can get a glimpse of your suggested
> tree structure, actual sources are not even required.

The structure follows pretty much what is out there so far. For example,
the temac/emac/lltemac drivers go into drivers/net/xilinx_xxx.

All the PPC405 stuff is still in arch/ppc. I know it needs to be ported
over to arch/powerpc, which is one of the future goals.

MicroBlaze support is in arch/microblaze and include/asm-microblaze.

> Previous support for Xilinx was more oriented toward PPC405 core in
> Virtex FPGA and everything was naturally concentrated under
> arch/ppc/platform/4xx.

This is, for now, still the case. See above.

> I deem such approach is not very good one. I'm using precisely same IP
> cores like GPIO, EMAC, SPI, CAN, etc... in Virtex and Spartan FPGAs
> which means (OK, may be cores are different somewhat for different FPGAs
> but low level Xilinx code is the same). That means at least 2 different
> CPU architectures (PPC and Microblaze). 

Yes.

> You certainly gave thought to such an issue. What tree structure do you
> suggest? There are 3 groups of Xilinx files to place in the Linux tree:
> 
> - common .h files (like xbasic_types.h);
> - common .c files, used by several cores (like all DMA stuff).
> - specific core .h/.c files (say xemac.h and xemac.c).
> 
> They all kind of "architecture independent" (at least 2 architectures
> can be used - MB and PPC).

Yes, the drivers are (or at least should be) arch independent. So far we
have been able compiling various drivers under PPC405 and MB without any
code changes. Further testing is needed, but generally it looks OK.

> Of course, except tree structure there are several other (not completely
> independent) questions to answer like:
> 
> A How EDK project parameters get into Linux kernel? This is huge issue
> which can be divided on several items.
> 
> A.1. Do you also suppose that some special type of BSP (.tcl script,
> defined by OS parameter of MSS file) shall run or you assume that it
> will be regular xaparameters.h file, prepared by standard standalone
> BSP? In latter case xparamerts.h needs manual editing since it doesn't
> have all parameters required by certain cores. 

The kernel will contain pre-generated xparameters_xxx.h files for the
reference systems. For custom projects you still need to copy over the
EDK-generated xparameters.h file.

For the xparameters.h file we are planning to move away from the bus
specific #defines and move towards more generic ones.

> A.2. There is also a question how these definitions get into .c and Make
> files. Petalogix has interesting solution when they bump all XILINX
> parameters to autoconf.h and .config files thus making them available
> for both compiler and make. What's your approach?

I have thought about adopting the Petalogix scheme at some point.
However, i got into trouble as I was changing too many things at a time.
I think the Petalogix way works well and could be one of the future
solutions for that.
Currently the approach is to copy over the EDK-generated xparamater.h file.

> A.3. If .config is not prepared automatically, then all configuration
> must be done via "make menuconfig" meaning Kconfig files shall be
> modified. Do you intend having several FPGA flags like CONFIG_VIRTEX and
> CONFIG_SPARTAN? Drivers' inclusion will depend on one of them.

The plan is to generate a .config file through the EDK.

> A.4. Is it assumed that Xilinx low level code will stay intact as it is
> supplied with EDK package or you are going to prepare special Linux
> Xilinx set (mostly because of name convention)?

For new drivers, meaning the ones that we are putting into the kernel
right now, the drivers will not follow the Linux coding convention. As
time progresses there will be one or the other driver being converted
for upstream, though.

> B How drivers get registered - via platform devices structure in
> virtex.c file or something different?

Drivers will be registered vie platform devices for botthe MB and PPC405
systems.

> All these questions have been discussed by the community but I somehow
> missed a conclusion if any took place. Does anything (kind of memo or
> readme) exist on these subjects?

Nope...

> Thanks,
> 
> Leonid.

Cheers,
   Wolfgang
