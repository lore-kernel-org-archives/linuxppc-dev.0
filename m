Date: Tue, 11 Dec 2001 19:22:04 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: HIGHMEM + serial console + SMP + 2GB freeze on pmac
Message-ID: <20011211192204.W21339@altus.drgw.net>
References: <20011206180754.A23942@altus.drgw.net> <p05101000b836f0e87832@[10.0.0.42]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p05101000b836f0e87832@[10.0.0.42]>; from tas@mindspring.com on Fri, Dec 07, 2001 at 02:25:14PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 07, 2001 at 02:25:14PM -0800, Timothy A. Seufert wrote:
> At 6:07 PM -0600 12/6/01, Troy Benjegerdes wrote:
>
> >This machine is an ealier Sawtooth G4 (7400) with 4 memory slots and 2GB
> >of ram (I know, Macos does not support this).
>
> [...]
>
> >I'm going to try several other combinations of things, including taking
> >one memory stick out since this could actually be that the hardware
> >doesn't like that much memory.
>
> MacOS X supports 2GB on Uni-N machines with four sockets, so the
> hardware supports it.  I think the 1.5GB thing was just a consequence
> of Classic MacOS having a fairly inflexible address space layout.

Yeah, it's not the RAM that's the problem. I've been running various
highmem configs with 2GB for a couple days now.

The following change to arch/ppc/mm/init.c *seems* to fix the hang problem
for me. (And for Olaf Herring on some power3 machines)

===== init.c 1.62 vs edited =====
52c52
< #define MAX_LOW_MEM   (0xF0000000UL - KERNELBASE)
---
> #define MAX_LOW_MEM   (0xE0000000UL - KERNELBASE)

Benh said on IRC he thinks we might have a problem running out of
ioremap/vmmalloc space. I'm inclined to agree with him, although for now
I'd rather just change MAX_LOW_MEM for now until someone figures out a way
to detect vmalloc/ioremap collionsions with lowmem RAM mappings.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
