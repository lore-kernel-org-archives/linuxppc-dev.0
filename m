Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 7F631DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 03:53:40 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2517375wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 10:53:28 -0700 (PDT)
Message-ID: <fa686aa40708141053k6e721398t2cf9c1b0655b18b1@mail.gmail.com>
Date: Tue, 14 Aug 2007 11:53:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Best Linux tree for Xilinx support.
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
	<20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
	<406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
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

On 8/14/07, Leonid <Leonid@a-k-a.net> wrote:
> I deem such approach is not very good one. I'm using precisely same IP
> cores like GPIO, EMAC, SPI, CAN, etc... in Virtex and Spartan FPGAs
> which means (OK, may be cores are different somewhat for different FPGAs
> but low level Xilinx code is the same). That means at least 2 different
> CPU architectures (PPC and Microblaze).

The driver code should all be in platform independent locations.  Only
the ppc405 support code lives in arch/ppc.  For ublaze support, you
need to look at the ublaze mailing list.

>
> You certainly gave thought to such an issue. What tree structure do you
> suggest? There are 3 groups of Xilinx files to place in the Linux tree:
>
> - common .h files (like xbasic_types.h);

Common include files go in include/linux.  However, the xilinx
os-independent files are a stopgap measure.  They will probably never
be merged into the mainline Linux source tree.

> - common .c files, used by several cores (like all DMA stuff).

I think we've agreed that drivers/misc is a suitable location.

> - specific core .h/.c files (say xemac.h and xemac.c).

Eth drivers go under drivers/net
serial drivers go under drivers/serial
i2c drivers go under drivers/i2c
etc.

> They all kind of "architecture independent" (at least 2 architectures
> can be used - MB and PPC).

Many of the drivers already are arch independent.  A key feature of
this is that xilinx ip drivers should *not* make use of xparameters.h
directly.  Which drivers are you having trouble with?

> Of course, except tree structure there are several other (not completely
> independent) questions to answer like:
>
> A How EDK project parameters get into Linux kernel? This is huge issue
> which can be divided on several items.

In arch/ppc (depreciated), via platform bus registrations.  The
platform bus is populated via
arch/ppc/platforms/4xx/xparameters/xparameters.h

In arch/powerpc, via a device tree blob.  The device tree blob will be
generated from the EDK project.

in microblaze, I believe it is currently via platform bus
registrations like in arch/ppc, but there is desire to move to using
the arch/powerpc device tree also.

>
> A.1. Do you also suppose that some special type of BSP (.tcl script,
> defined by OS parameter of MSS file) shall run or you assume that it
> will be regular xaparameters.h file, prepared by standard standalone
> BSP? In latter case xparamerts.h needs manual editing since it doesn't
> have all parameters required by certain cores.
>
> A.2. There is also a question how these definitions get into .c and Make
> files. Petalogix has interesting solution when they bump all XILINX
> parameters to autoconf.h and .config files thus making them available
> for both compiler and make. What's your approach?

Just to reinforce my point: xilinx device drivers should *NEVER* use
xparameters.h directly.  The device driver binding code should either
retrieve the device configuration from the platform bus or from the
device tree.

>
> A.3. If .config is not prepared automatically, then all configuration
> must be done via "make menuconfig" meaning Kconfig files shall be
> modified. Do you intend having several FPGA flags like CONFIG_VIRTEX and
> CONFIG_SPARTAN? Drivers' inclusion will depend on one of them.

Yes, some of them even already exist!  :-)

There can also be some defconfigs for supported boards.

>
> A.4. Is it assumed that Xilinx low level code will stay intact as it is
> supplied with EDK package or you are going to prepare special Linux
> Xilinx set (mostly because of name convention)?

No.  The xilinx EDK drivers are not desirable for inclusion in
mainline.  Slowly the drivers are being replaced with Linux specific
drivers.  New uartlite, ns16550, xsysace and framebuffer drivers are
already in mainline.

>
> B How drivers get registered - via platform devices structure in
> virtex.c file or something different?

Read up on 'platform bus' and 'of platform bus'.  platform bus is what
works now.  of platform bus is how it will work when we migrate to
arch/powerpc.

>
> All these questions have been discussed by the community but I somehow
> missed a conclusion if any took place. Does anything (kind of memo or
> readme) exist on these subjects?

Unfortunately, no.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
