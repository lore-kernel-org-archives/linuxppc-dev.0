Message-ID: <C08678384BE7D311B4D70004ACA3710511194623@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Marius Groeger'" <mag@sysgo.de>,
	"'cecilia.muaddi@alloptic.com'" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000
Date: Wed, 8 Jan 2003 10:44:05 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think Marius' problem and mine were generalizations
of the same issue -- there can't be *any* mappings in
the kernel with virtual address below 0xc0000000.
(This includes regions mapped 1-1 as a special case.)
I couldn't put the IMMR at 0x38000000; I moved it to
0xf0000000.  Marius found that on-chip RAM was mapped
at 0x70000000; that was bad too.  Also the CPLD on
my board which does LED control is mapped in at
0xf8000000 -- also above the 0xc0000000.  So I am
skeptical when Cecilia says she has "some other IO
mapped to miscellaneous addresses".  What are those
miscellaneous virtual addresses?

The difference, though, is that Marius & I both had
problems entering user mode.  Cecilia's is just a few
lines from the top of head_8xx.S, without yet having
made any subroutine calls to anything more complicated.
There's not much room for anything to have gone wrong
yet, in the Linux kernel code.  So I agree that getting
the vxWorks boot ROM out of the picture (e.g. using
PPCBoot instead) would be an interesting test.


-----Original Message-----
From: Marius Groeger [mailto:mag@sysgo.de]
Sent: Wednesday, January 08, 2003 10:21 AM
To: Wells, Charles
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: BDI-2000

On Wed, 8 Jan 2003, Wells, Charles wrote:

> When I read Cecilia's post, I assumed what the statement "proven hardware
> platform" meant was that the vxworks O/S and user tasks exercised all the
> peripheral hardware; i.e., the SDRAM works, the ROM works, the FLASH
works,
> the console works, etc.  So, that statement made sense to me.  While Linux

vxWorks doesn't use the MMU as much as Linux does. On Linux, the kernel and
all processes run in their own address space. The memory accesses involved
for cache or tlb refills are quite different to what's happening in a
vxWorks setup. Again, I'm probably overly pessimistic here, but we _have_
seen HW problems that just didn't show up when running vxWorks (AFAIR it was
a burst access on some early G4 based system.)

On a related matter, the following might also be interesting, especially
regarding the question of what firmware to use. The vxWorks boot-loader
tends to initialise _a lot_ of things you don't necessarily need. For
instance, on IBM405 based systems it sets up the on-chip RAM at address
0x70000000. Not a good idea when switching to user-mode the first time. Took
me quite some time to find this one... ;-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
