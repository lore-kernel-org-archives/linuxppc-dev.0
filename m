Date: Wed, 15 Nov 2000 09:25:39 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc and kernel build problems (EST8260)
In-Reply-To: <m13w1l8-001SzcC@bucks>
Message-ID: <Pine.GSO.4.21.0011150916280.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 15 Nov 2000, diekema_jon wrote:

> > For glibc, I have read the HowTo and I think I applied the proper glibc
> > patches.  I have also patched my gcc specs file.  Here is where I am
> > dying:
>
> I would go to MontaVista http://www.mvista.com/ and get their CDK.
> They have already done this work and more.
>
Do you know if their 8260 glibc is compiled for soft or hard float?  Also,
did they apply the less than 32 byte cache line patch?  That is removing
optimization for the 8260 instead of fixing things.

These questions and others are why I was hoping someone could help me do
it from scratch myself.

> > make[2]: Entering directory
> > `/home/ford/linux/src/linuxppc_fsm/arch/ppc/mm'
> > powerpc-linux-gcc -D__KERNEL__ -I/home/ford/linux/src/linuxppc_fsm/include
> > -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
> > -Wno-uninitialized -mmultiple -mstring    -c -o init.o init.c
> > init.c: In function `__ioremap':
> > init.c:418: `isa_mem_base' undeclared (first use in this function)
> > init.c:418: (Each undeclared identifier is reported only once
> > init.c:418: for each function it appears in.)
> > init.c: In function `hash_init':
> > init.c:1486: warning: int format, long int arg (arg 2)
> > init.c: At top level:
> > init.c:661: warning: `get_mem_prop' declared `static' but never defined
> > make[2]: *** [init.o] Error 1
>
> You need to change arch/ppc/mm/init.c
>
> dell 1060} diff -c ~/bk/fsmlabs-linux-2.4/arch/ppc/mm/init.c .
> *** /usr/people/diekema/bk/fsmlabs-linux-2.4/arch/ppc/mm/init.c Sat Nov 11 09:06:29 2000
> --- ./init.c    Sat Nov 11 10:28:43 2000
> ***************
> *** 408,413 ****
> --- 408,414 ----
>          */
>         if ( p < 16*1024*1024 )
>                 p += _ISA_MEM_BASE;
> + #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
>         /*
>          * Some drivers give us the physical bus address when they
>          * should give us the physical cpu address.  For those cases
> ***************
> *** 416,421 ****
> --- 417,423 ----
>          */
>         else if ( p < PCI_DRAM_OFFSET )
>                 p += isa_mem_base;
> + #endif
>
>         /*
>          * Don't allow anybody to remap normal RAM that we're using.
>

If this is "the right thing to do", then why is it not in the ppc kernel
tree?  I could obviously have done this myself, but I wanted to bring it
to someone's attention who could architect the real fix.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
