Date: Mon, 13 Aug 2001 10:19:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michel Lanners <mlan@cpu.lu>
Cc: bob@kunk.jriver.com, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling EIDE patch on PPC
Message-ID: <20010813101939.A21730@mikef-linux.matchmail.com>
References: <20010810161714.E28914@mikef-linux.matchmail.com> <200108110647.IAA00781@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108110647.IAA00781@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 11, 2001 at 08:47:04AM +0200, Michel Lanners wrote:
> Hi all,
>
> On  10 Aug, this message from Mike Fedyk echoed through cyberspace:
> > OK, I've been able to compile it successfully.  Changes included.
>
> Good.
>
> > I haven't booted the kernel yet.  Can someone take a look at the patch to
> > see if I may have made any bad changes?
>
> Well, if it compiles and works like that, than it should be OK. You only
> changed #include's, after all...
>
> > Maybe the actual files in asm-ppc should be changed instead?
>
> Which ones are you refering to? You only changed .c files; no header
> files. Under asm-ppc, there are only header files.....
>

Someone mentioned that the ppc headers were missing some definitions that
are in i386.  I'm referring to copying those changes instead of changing the
includes... I just wanted to mention it, in case it affects something I
don't know about.

> > If it is good, I'll send it to Hedrick for the
> > next patch release.
>
> Looks good to me. THough I am a bit surprised by you being able to
> remove asm/ide.h from generic IDE driver files...
>

asm/ide.h is included from linux/ide.h, and IIRC gcc doesn't care how far
away the code is included... as long as it gets what it needs.  Probably
just including everything before parsing...

> > Also, there is an include for asm/ide.h in apus_setup.c.  I didn't change it
> > because I don't have any prep machines for testing, and for some reason it is
> > also including from the m86k arch.
>
> APUS is not PREP, its some Amiga stuff. Basically, originally 68k-Amigas
> upgraded with PPC processors; so no wonder they're a hybrid of m68k and
> ppc ;-). I would _guess_ they need the <asm/ide.h> replaced by
> <linux/ide.h> too.
>

Oops, brain fart.  Did any of those APUS have PCI?  If not, then the change
may not be needed.

> > Michel, I'm going to do another compile with your pci-fixup patch.  Do you
> > have any idea if it is needed on 7200, 6500, or oldworld g3 powermacs also?
>
> I never tested it there; but since the problem (for your IDE card) is
> with access to PCI IO ports, _any_ ppc 2.2 kernel would suffer from that
> problem, independant of the precise hardware.
>

Michel, your pci-fixup patch is incompatible with Donald Becker's rtl8139.c
(from his site) driver with the new pci-scan.c module from his web site.  I
thought I'd let you know.

When I insert the module, I get an oops.  On these machines (PPC mac 7200,
6500, & oldworld g3) I have had to use his new drivers to get reliable
ethernet access.  The ones in Linus' kernel haven't been reliable for me.

Is there any chance that your pci patch would fix any problems I've been
having with the eth drivers in the kernel.org kernel?

What behavior could I expect from the system if I used the ide patch without
the PCI-fixup patch on a promise udma66 card?

Mike

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
