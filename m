Message-ID: <3B39C8AA.5000605@humboldt.co.uk>
Date: Wed, 27 Jun 2001 12:51:06 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rearrangements in linuxppc_2_4_devel
References: <15161.33091.788459.48900@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
[...]

> The next thing I would like to do, which I haven't done yet, is to
> avoid the need to have a separate _MACH_xxx define for each platform.
> I would see _machine as distinguishing between different types of
> machine that count as a single platform, rather than distinguishing
> between platforms.  (We distinguish between platforms by their config
> options.)  Thus I don't see any need for anything more than
> _MACH_prep, _MACH_Pmac and _MACH_chrp.


I've not bothered to create new _MACH_xxx defines for my boards. The
only boards in the tree that will require any code changes to eliminate
are Gemini and APUS.


> With those changes, I think that adding a new platform should only
> require adding stuff to arch/ppc/config.in, arch/ppc/kernel/Makefile,
> and adding a new xxx_setup.c file.
>
> Comments?


I just ported one of my boards to this - the code is now a lot more
readable.

APUS is probably broken, because it believes that it can call
parse_bootinfo with a pointer to the boot records. From apus_setup.c:

void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
		   unsigned long r6, unsigned long r7)
{
	extern int parse_bootinfo(const struct bi_record *);
	extern char _end[];

	/* Parse bootinfo. The bootinfo is located right after
            the kernel bss */
	parse_bootinfo((const struct bi_record *)&_end);

Why do people keep sticking function declarations into each C file,
rather than in headers where they belong? I keep finding consistency
problems like this.

Paul: would you take patches that moved some of this stuff into header
files, and if so, which header file would you like all the miscellaneous
setup functions to move into?


--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
