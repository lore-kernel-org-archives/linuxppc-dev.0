Message-ID: <36A0B4EA.978DA512@currantbun.com>
Date: Sat, 16 Jan 1999 15:49:01 +0000
From: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
Reply-To: jrestemeier@currantbun.com
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Sorry (Glide for LinuxPPC)
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm sorry, but I can't finish the Glide port for LinuxPPC. It looks like
the card caused major problems in my system, so I had to remove it. It
seems to be mostly heating related, I've got an all-in-one Mac with
monitor integrated into the system, and the card blocks the air
ventilation too much.

Anyway, the port shouldn't be that difficult. This is a collection of
hints I received from several persons, it would be cool if someone with
access to CVS on sourcefourge could fix/implement them:

Build process:
(from jeramy b smith)

> First:
> I noticed 3dfx set x86 CFLAGS in the spec.The spec does this though for
> glibc20 compat libs. I simply commented these lines and their respective
> install lines in the spec.
>
> Second:
> swlib/include/make/3dfx.mak
> This girl contains the default CFLAGS which are 486 specific. They are beside
> the CNODEBUG.
> I waxed em.
>

Endian issues in Glide:
There are GETxx/SETxx macros defined and used for MacOS which do the
byteswapping. The Linux code may have to be fixed to use them, or
redefine them. I think there are some byteswapping macros in the header,
maybe they can be used.

Endian issues in /dev/3dfx:
The driver passes some PCI configuration values through byte/word/long
variables, and assumes little endian. Is there a PCI api accessible from
user-space that can be used instead?

Access to hardware:
Glide offers two ways to access the card, either through /dev/3dfx or by
using inb & Co.
The "inb" approach needs some additional work, which Geert sent to me:

> > - Is this isa_io_base thingy changed in newer kernels, or did I just mix
> > up my configuration ? I don't really like downloading kernels/patches
> > through my slow connections, so I'd like to be sure...
>
> `ISA I/O space' is the same as `PCI I/O space'. Before you can access it on PPC
> using inb() and friends, you have to mmap() it, like
>
>     unsigned long isa_io_base;
>     int io_fd;
>
>     if ((io_fd = open("/dev/mem", O_RDWR)) == -1) {
>         perror("open /dev/mem");
>         exit(1);
>     }
>     isa_io_base = mmap(0, 0x10000, PROT_WRITE|PROT_EXEC|PROT_READ, MAP_SHARED,
>                        io_fd, MB_ISA_IO_BASE);
>     if ((long)isa_io_base == -1) {
>         perror("mmaping io space");
>         exit(1);
>     }
>
> The bad thing is that MB_ISA_IO_BASE depends on the machine type. Look at
> linux/include/asm-ppc/io.h for the different values for different machines.
> On Pmac, isa_io_base seems to be set up in arch/ppc/kernel/pmac_pci.c.
>
> And if the original code contains iopl() calls, you have to protect them inside
> #ifdef __i386__/#endif pairs.
>

P6FENCE
Some hardware registers need to be programmed in a specific order, while
some modern cpus combine memory access or reorder instructions.
Peter wrote:

> This sort of depends on teh hw that you're talking to on the other
> side. If it is v2 or better then it will take care of doing 'hole
> counting' for you so that you don't need explicit fences to make the
> hw happy. If you're doing this for sst1 or sst96 then you will need to
> do fences so taht the command register on gets written after all of
> the command data has been settled.
>

You could simply define P6FENCE as "eieio()", which does the thing for
PPC.
But Geert wrote:

> If you use the *mb() macros instead of eieio(), you don't have to use #ifdefs
> and it'll work automagically on e.g. Alpha as well.
>
and

> wmb() is a barrier for writing.
> rmb() is a barrier for reading.
> mb() is a barrier for both and thus the `safest'.
>
> The main advantage is that these are defined for all architectures, unlike
> eieio().
>

C vs. Asssembler:

> > - Glide compiles, after disabling the assembler triangle setup code.
>
> This was only necessary on the x86 machines because of the crappy fp
> stack stuff. The straightforward code from gxdraw.c should do pretty
> well on a ppc machine. I haven't actually gone to get the code, but
> does the sst1 version do the vectored thing based on the culling mode
> etc? (I did this for v2 and above, but its been a while so I cannot
> remember if I did it for sst1 and sst96).
>

I hope this information helps somebody to port Glide to Linux/PPC.

Jens

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
