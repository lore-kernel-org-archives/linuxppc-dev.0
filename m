Date: Sat, 20 May 2000 22:07:01 -0700
From: Matt Porter <mmporter@home.com>
To: tjroberts@lucent.com, linuxppc-embedded@lists.linuxppc.org
Message-Id: <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com>
Subject: Re: QUERY: Embedded PowerPC Linux?
References: <39243D0C.68406C9D@lucent.com>
Reply-To: mporter@mvista.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[This message has also been posted.]
On Thu, 18 May 2000 13:57:16 -0500, Tom Roberts <tjroberts@lucent.com> wrote:
>	Our LSPS-1 board has 3 PPC604 100MHz CPUs with 16 MBytes of
>	SDRAM each, an ISA interface to the host, and a SCSA-bus
>	telephony interface. Our LSPS-2 board has 3 PPC750 200
>	MHz CPUs with 64 MBytes of SDRAM each, a PCI interface to
>	the host, and an H.110 telephony interface. These boards have
>	no conventional computer peripherals, and can only communicate
>	with the host via memory. We have sample versions of this
>	latter board with PPC755 CPUs and PPC7400 CPUs, and 128 MBytes
>	SDRAM per CPU -- these are our real interest for Linux. it
>	is likely that in the future we will add Ethernet interfaces
>	to our boards.
>
>I downloaded the Yellowdog PPC linux source, and am attempting to
>configure it to boot on our PowerPC board (single CPU, 48 MB SDRAM).
>This board has no I/O whatsoever (except an H.110 telephony interface
>for which I'll have to write a driver). I already have written a driver
>which communicates via memory buffers to/from the host, and have tested
>it using stub code based upon our proprietary on-board OS.
>
>
>The problem is: this Linux distribution thinks that anything which is
>not a PPC8xx is a Macintosh of some sort or another. So I have been
>searching out CONFIG_PMAC (and others) and adding in my own CONFIG_LSPS
>as appropriate. This means removing large numbers of drivers and
>initialization files, and is not very pretty. The hard part is those
>confounded "#ifndef CONFIG_8xx" some of which I need to keep and
>some of which I must replace....
>
>Is there a better distribution to start from than Yellowdog for such
>bare-bones hardware? So far all of the "embedded PowerPC" links I
>have found share the assumption that "embedded" means a PPC8xx;
>my embedded processors are MPC604, MPC750, MPC755, and MPC7400; and
>they are embedded so deeply that they have no conventional I/O at all.

You are talking about a different distribution to start from but that is
really just a collection of apps and tools centered around the Linux
kernel itself.  If I understand correctly, you are concerned about the
fact that the kernel itself doesn't seem very aware of embedded 6xx/7xx/7xxx
systems.  Well, that's true.  The assumption is that 6xx/7xx/7xxx are only
chrp/pmac/prep desktop systems and 8xx/82xx are embedded systems but that
is changing quickly.

I've worked on several embedded 750 ports recently in which I've implemented
some preliminary concepts that should make things _much_ easier when porting
embedded 6xx/7xx systems that don't conform to chrp/pmac/prep specs.

You basically follow MACH_prep and/or MACH_gemini since they are much
simpler than pmac.  Provide kernel/head.S, mm/init.c, and kernel/setup.c
changes where necessary for your MACH type.  I generally prefer setting
up a PReP style memmap unless I'm on a CPCI board and need all that extra
PCI mem space (to map other boards RAM into).

Board specific support should go into kernel/<board>_setup.c, <board>_pci.c,
<board>_pic.c, <board>_time.c, <board>_stubs.c.  <board>_stubs.c is where
I stub out all the chrp/pmac/prep garbage like "prom_init()" to make the
linker happy and have a reasonablly slim kernel for 29F040 boot flashes.
..._pic.c and ..._time.c are new since <board>_setup.c is getting to be
too lengthy for my tastes.  <board>pci.c has something new in that
I'm adding a (rather simplistic) PCI autoconfig routine to the pci_init()
call since a firmware/monitor is not always available or desired.

Everything to this point is non-intrusive into the current arch/ppc
build process which is good.  The only intrusive thing I add is is a
CONFIG_EMBEDDED which arch/ppc/kernel/Makefile keys off of to not link
in all the extra chrp/pmac/prep stuff as well as not linking in the
drivers/macintosh/ library archive.  An embedded port simply sets up
config.in to define CONFIG_EMBEDDED when their board is selected from
the machine type selection.

One sore point is that MACH_<board> is defined as a single bit flag so we
will run out of those with the many MACH types that want to be in the
kernel in the near future.  That should probably get fixed up to something
with more longevity.

The other thing that needs to happen is that the directory structure
will need a reorg to avoid clutter since each port that is merged into
the kernel will add 2-6 files to arch/ppc/kernel/.  I would really
like to see a structure more like arch/ppc/kernel/<system1>,<system2>,etc.
Perhaps the system dependent files belong in arch/ppc/system/<system1>,etc..
Cort has been receptive to something like this in the past, I just like
some input before "showing the code". :)

I've Cc'ed linuxppc-embedded to move the discussion there where it
really belongs.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
