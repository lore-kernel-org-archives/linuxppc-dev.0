Date: Thu, 5 Dec 2002 10:48:56 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Chris Zimman <chris@cryptoapps.com>
Cc: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: looking for documentation on porting Linux to PowerPC platforms
Message-ID: <20021205104856.A3899@crystal.2d3d.co.za>
References: <20021204103839.A28568@crystal.2d3d.co.za> <20021204192129.GA8996@mail.cryptoapps.com>
Mime-Version: 1.0
In-Reply-To: <20021204192129.GA8996@mail.cryptoapps.com>; from chris@cryptoapps.com on Wed, Dec 04, 2002 at 11:21:29 -0800
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Chris!

> > a) how to boot linux (can I just branch to the the address where I loaded t
> > he
> > image into ram or do I need to setup registers / data structures beforehand?)
>
> Yes, you need to setup a number of things.  Take a look at PPCBoot (now called
> U-Boot).  Porting PPCBoot is pretty straight forward.  Once you have
> PPCBoot support done for the board, you're pretty far along.

I've got a VxWorks boot loader on the thing, so I'm not worrying about a
boot loader right now. I just need to know what I need to setup before
branching to the processor. Looking at the source for the 8xx processors, it
seems I need:

------------< snip <------< snip <------< snip <------------
r3: ptr to board info data
r4: initrd_start or if no initrd then 0
r5: initrd_end - unused if r4 is 0
r6: start of command line string
r7: end of command line string
------------< snip <------< snip <------< snip <------------

Is that all? Also, what is the "board info data" ?

> > b) where/what do I change if I want to add a "sub" architecture?
>
> arch/ppc/platforms is what you want.  You need a LinuxPPC tree with
> what they call "platforms" support.  You can get one from the BK
> repositories.

I downloaded ppc-patch-2.4.18.bz2 from
ftp://ftp.kernel.org/pub/linux/kernel/ports/ppc - is that sufficient or is
there better support in the BK repository?

> > I've got a ICP-PPC PowerPC backplane type system here which I want to get
> > Linux on. It has the MPC8240 CPU on it which from what I read is pretty much
> > the same as the 8260, 8245, etc. (they're all based on the 603e core right?)
> >
> > Now, if I select "8xx" in menuconfig, I get another selection of machine
> > types (RPX-Lite, RPX-Classic, etc.). Obviously I need to own my own machine
> > type here, but how do I do that. Also, how does these machine types differ?
> > Just different peripherals? Do they have anything in common (e.g. uart).
>
> For the most part, anything based on the 8240 is going to be roughly
> similar.  You'll have to know how the chip selects are configured, and
> possibly the SDRAM controller setup, but that's usually handled by PPCBoot.
> Sometimes the kernel does additional setup in arch/ppc/platforms for
> specific targets (eg. PCI bridge config, etc.) you'll see what I mean.

Well, the boot loader have everything configured already. I'm not worried
about peripherals for now, just booting the kernel.

--

Regards
 Abraham

The first thing I do in the morning is brush my teeth and sharpen my tongue.
		-- Dorothy Parker

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
