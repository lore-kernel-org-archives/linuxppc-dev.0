Date: Tue, 23 Nov 1999 17:15:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Christian Zankel <chris@mvista.com>
cc: Cort Dougan <cort@fsmlabs.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <3839CF18.5D600DE@mvista.com>
Message-ID: <Pine.HPX.4.10.9911231703280.5120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Nov 1999, Christian Zankel wrote:

> 
> Hi,
> 
> It seems to me that on almost every machine linuxppc is running on
> depends on having a bootloader to load the kernel. Would it be possible
> to redesign all bootloaders to load the kernel to position 0, initialize
> the OF path where necessary and jump to the kernel with the MMU switched
> off? Then we could possibly remove all the conditional code (#if ...
> #else .. #endif) in head.S mm/init.c, etc.
> 
> Right now, it is painfull to add a new machine that doesn't follow the
> full PReP,CHRP specification, i.e. has no OF nor Residual Data
> structures, etc.

If you are able find a single machine which correctly follows the specs...

> 
> I started to restructure the arch/ppc tree. However, I would like to

Good luck, I would like to do this too. Note that I haave specific code
for MVME boards which is fairly clean (but nobody seems interested). It
requires residual data for now, if only I could get my hands on a machine
with an OF which at least gets configuratioon space device numbers
right... 

> hear about your thoughts and recommendation. The goals I want to
> achieve, are:
> 
> 1. The bootloader gets a more active part, i.e. does some
> pre-initiaization, esp. to get rid of the 'bl prom_init' and the variaty
> of copying the kernel back and forth.

Mine does a lot of this things for machine with residual data: it has its
own simple memory management and a few other things: 

- the braindead PCI I/O space allocation on PreP is completely redone 
(current kernel PreP code can cause collisions).
- an x86 emulator for ROM BIOSes

> 2. It should be possible to setup the kernel so that the same kernel
> runs on all those machine that it is setup for. Of course, the more
> machines you add the more overhead you get.

I don't care very much for 6xx/7xx machines... Embedded may want the
smallest footprint however. My bootloader is already something like 50kb
of code (ok, including the emulator), and I try to fight bloat...

> 3. Each machine/architecture should get its own directory (pmac, prep,
> chrp, apus, geminit, etc.)

Not exactly, rather a boot directory IMHO so that you find the right image
in the right place.... But then pmacs have several image formats depending
on their age...

> 4. To add a new machine, only a new directory has to be added and only a
> few files have to be changed (mainly: Config.in and Makefile).


> 5. The _machine-ID is seperated into to fields, Vendor and Board.

Maybe... But also all the PCI resource management has to be cleaned up at
least for PreP...

	Gabriel.

P.S: my bootloader is available on vlab1.iram.es:/pub/linux-2.2, I'm
trying to boot 2.3.28 now...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
