Date: Wed, 7 Jun 2000 23:15:03 -0700
From: Matt Porter <mmporter@home.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?
Message-ID: <20000607231503.B11485@cx258813-a.chnd1.az.home.com>
References: <39243D0C.68406C9D@lucent.com> <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com> <39289187.3AEDEE47@chicago.avenew.com> <slrn8ik4mu.349.mmporter@liberty.chnd1.az.home.com> <392C0B5D.A87105C@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <392C0B5D.A87105C@embeddededge.com>; from dan@netx4.com on Wed, May 24, 2000 at 01:03:25PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 24, 2000 at 01:03:25PM -0400, Dan Malek wrote:
> I will continue to point out that the Linux kernel is not a boot rom.
> You first argue that head.S is too complicated, and then want to make
> it initialize your processor???  I don't get it.  This is not the place
> for processor initialization beyond what is necessary for Linux to
> operate.  There is software in arch/ppc/mbxboot that does a little
> more processor initialization for embedded systems, but that still isn't
> a boot rom.

I think you got the attributions confused...Tom was trying use kernel/head.S
to init the processor.

> Further, writing processor initilization functions is very tedious. I
> certainly don't want to be downloading a half megabyte or more of kernel
> just to test a few processor initialization instructions.  When the
> kernel doesn't boot, where do you start?

I think it's even more difficult for 7xx than on 8xx/82xx stuff since
varying bridges and potentially an ISA bridge (shudder) make it a completely
different game on every system.

> For example, if you write some minimal boot rom to initialize an 8xx
> or 82xx processor, verify that you can read/write memory, you can boot
> a Linux kernel very quickly.  If you have a boot rom, I can have a Linux
> kernel running in a day or two by changing a couple of lines of code
> in arch/ppc/mbxboot/embed_config.c.  Set up an environment for Linux
> to run, and it does so very easily.

No argument.  Obviously, having bootrom/monitor/firmware takes a _vast_
amount of the difficult work out of a port.

> > >I think we need to separate the CPU from the machine....
> >
> > It's being worked on as far as making a framework for non-chrp/pmac/prep
> > 6xx/7xx/74xx ports.  There just hasn't been a real pressing need until
> > lately.
>
> The CPU and system/board are separate.  Some boards imply a particular
> CPU, or vice versa.  You have to specify both for the configuration,
> and depending upon which you ask first, you can reduce the selection
> set for the latter.  Updating the configuration choices is just part
> of adding a new board or processor.

So it seems on the surface, but I was referring to shortcuts made where
ifndef 8XX conditionals are used to conditionally build things like
the drivers/macintosh/ archive when that is not processor specific action.
Similar things happen in the Makefiles to achieve a slimmer kernel.

The point being that the approach taken by the gemini architecture boards
is not a great one since it simply tacks it's objects onto the bloated
chrp/pmac/prep kernel image.  Not pretty and not a suitable approach
when many 6xx/7xx boards need to boot directly from a 512KB flash.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
