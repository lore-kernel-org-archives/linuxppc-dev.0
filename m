Message-ID: <38976797.F621D0A9@ctam.com.au>
Date: Wed, 02 Feb 2000 10:09:11 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <200002010035.BAA26304@denx.local.net> <3896CEA3.EBA97957@ctam.com.au> <38968BC0.6FD6E801@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brendan John Simon wrote:
>
> > Sorry about my ignornace but why can't I use the address range
> > 0x80000000-0xBFFFFFFF for my peripherals ?
> > Is 0xC0000000-0xFFFFFFFF ok ?  What address range would be recommended ?
>
> I posted this before.....I hope this matches previous messages :-).
>
> If you map (i.e. ioremap()) physical memory prior to the
> kernel VM initialization, the mapping is 1:1 virtual to physical.
> This happens in mm/init.c for things like the IMMR and some
> other board control registers.  In this case, mapping below
> something like 0xd0000000 causes problems with VM collision in
> kernel or user process space.
>
> After the kernel VM is initialized, you can ioremap() any
> physical space, as the mapping isn't 1:1.

The memory controller is setup in my boot loader.  It knows nothing about VMA, only
PMA.
I currently have CS0 mapped to 0xFF800000 for flash, CS1/2 mapped to 0x00000000 and
CS4 to 0x80000000 for DRAM.
Both Dan and Wolfgang have suggested that all peripherals should be at 0xD0000000
and above.  I am happy with this but am not sure what the DRAM address should be.
Should I map CS1 and CS2 to 0x00000000 or 0xC0000000 ?

I have not changed any code in the linux source tree with regards to memory
mapping.  ie. not use of ioremap as I do not use any of the peripherals yet.  I've
got a very vague idea of what ioremap() does and will read more on it.  I sounds
like I will probably need it to access my peripherals from within linux.  Is this
correct ?


> At this stage, nothing beats a simple rom monitor that can display
> memory after a processor reset.

I'll look into adding this support to my bootloader.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
