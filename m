Message-ID: <C08678384BE7D311B4D70004ACA371050B7632C9@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'David Marqvar (DAM)'" <DAM@tt.dk>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel 2.4.4
Date: Mon, 11 Feb 2002 11:09:57 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello David,

I also recently started an embedded 8xx system.  I am not
a newbie at using Linux on my desktop machine, but until
two months ago I was very much at newbie at implementing
an embedded Linux system.  At this point, everything makes
sense; Linux is up and running on my board & now it's just
a matter of doing plain old application programming.
I hope you don't mind if I share a few paragraphs.

I found the following:

* If I go to my local bookstore, I can find an entire *shelf*
  full of books on Linux system administration, application
  programming, shell scripting, etc. etc. etc. -- but
  very little about *embedded* Linux.  On that subject,
  I found only one book -- and it was thin, and not very
  helpful.  (It seemed that the author was basically
  describing how to make a boot floppy for a PC.
  However, embedded systems typically don't *have*
  floppy drives; there is an entirely different set of
  techniques to load the OS from flash, TFTP, etc. vs.
  using a floppy.  Also the author discussed x86 embedded
  systems -- a crucial omission since cross-compiling for
  a different processor type is one of the key issues in
  embedded systems.)

  So, there don't seem to *be* any good books on embedded
  Linux out (yet) -- however, on-line it's a different
  story.  At penguinppc.org you will find a host of
  great documents.  In particular I recommend
  http://penguinppc.org/embedded/howto/PowerPC-Embedded-HOWTO.html
  which told me most of what I needed to know.  This includes,
  among other things, links to information about PPCBoot that
  W. Denk et al. referred to.

* Also, this mailing list is great!  I recommend that you continue
  to read it.  Much of it is specialized, e.g. discussions of
  particular devices, but there are all sorts of useful, unexpected
  things you'll find.  In particular, I found the answer to my
  One Big Problem (after several weeks of frustration -- see below)
  right here on this mailing list.  There are very expert people as
  well as very new people, all sharing this list so there is plenty
  to learn.  It's what Open Source is all about.

* You should know that porting Linux to an 8xx board is usually
  pretty easy -- people like Cort Dougan, Dan Malek, etc. (I'm
  failing to mention many more names) have already done the
  hard work of porting Linux to this processor family.  In fact,
  getting the *boot loader* customized to your board may be the
  least easy part.  This was my experience -- and in fact the
  boot-loader stuff (I customized mbxboot, rather than using
  PPCBoot, so I have no personal advice about the latter) was
  really pretty easy.  It's just that the other things were
  even *easier*.

  The other side of this point is that problems with Linux on
  a simple 8xx board are much more likely to be board-setup
  problems than kernel bugs.

* For me, this first Linux project has been easy (boot loader,
  apps, device drivers) *EXCEPT* for one problem which stumped
  me for a month.  The kernel was "hanging" (no longer printing
  stuff to the console) somewhere in spawning init, and print
  statements revealed it didn't always hang in the same place.
  I had some advice from some people on this mailing list, and
  thought I'd found various hardware problems, but I resolved
  those issues but they didn't fix my init hang.  Later, I
  found out on this mailing list that the whole problem was
  that my IMMR space (virtual = physical address) was not set
  to over 0xc0000000.  It had been 0x38000000; I moved it to
  0xf0000000 and voila, got a shell.

  It turns out that I'm not the first to run into this, so I'm
  taking this opportunity to inform anyone else who's seeing a
  similar problem.

* For me, that stumper was the *only* hard problem.  In particular,
  I've taken some application code that I 5-6 years ago on Solaris,
  cross-compiled it -- without change -- for powerpc-linux and it
  runs fine.  This is good news -- if you're familiar with
  Unix, application programming should be straightforward.

* Device drivers are different -- this is where Unixes differ.
  However, device drivers *are* a subject on which you can find
  good books at the bookstore.  I can personally recommend
  _Linux Kernel Internals_ by Beck et al., chapter 7.  Although
  it's a bit out of date & not everything is spelled right in
  their sapmle code (caveat emptor).

* For myself, getting a cross-compiler built from bare source
  code was a bit clumsy; I followed the instructions I found
  at penguinppc.org, & interpolated between 2-3 different
  documents & got it to work.  I did it from bare source
  mainly out of stubbornness, to show that I could do it.
  However, I *highly* recommend getting pre-built cross tools if
  you can -- it's quicker and easier.  One might check out Lineo
  or HardHat for "stable" tools, as Denk calls them.

* As for your problem cross-compiling your application, we can
  discuss it more off-line if you like.  However, I've found that
  to cross-compile my apps, I use the same makefiles as on my
  desktop host, except I add the line

	CC=powerpc-linux-gcc

  or whatever the name of your cross-compiler is.  Then,

	$(CC) ... (the usual stuff)

  in all my make rules.

* To get pre-compiled PowerPC binaries for many tools, you
  might check out, for example, Debian's
  dists/potato/main/binary-powerpc, where you can grab
  .deb files.  Use "ar t xyz.deb" to open them.

* Debian's dists/potato/main/source is a place to get source
  for things, if you want that.  This is where I got the source
  for sash 3.4 & it works just fine -- it's my regular shell
  for day-to-day use on my board.

* There are other places besides Debian, of course; penguinppc.org,
  & its how-to document in particular, have many pointers to
  things you can use.


-----Original Message-----
From: David Marqvar (DAM) [mailto:DAM@tt.dk]
Sent: Monday, February 11, 2002 3:57 AM
To: Embedded Linux PPC List (E-mail)
Cc: Laurits Lassen Petersen (LLP)
Subject: Kernel 2.4.4



I've downloaded the Linux kernel 2.4.4-2002-01-19 from ftp.denx.de.
I want to compile it for a custom MPC823-based board.

I'm a newbie with Linux. Maybe someone have a comment at my problems and
fixes.... :)

I'm using:
gcc-3.0.3, cross-compiling for "powerpc-elf".
binutils-2.11.2
newlib-1.10.0

make menuconfig
make dep
make clean
make zImage

During the compilation (last step) I've encountered the following problems:

1) error compiling coda.h (missing keywords)
Fix: adding the switch -D__linux__ to the makefile.

2) error compiling ... (don't remember)
Fix: changed sched.c:540 declaring time struct, to ..volatile..

3) error compiling embedded_config.c:
Fix: changed include sys/types to linux/types.h

4) I had to stop enabling "Magic SysRq Key" in Kernel hacking in menuconfig.
Error: m8xx_setup.c:851: structure has no member named  'kbd_sysrq_xlate'.

Please give me any comments about my fixes? Anyone had the same problems?

Where do I find the zImage file - it is compressed, right? I've located the
vmlinux, but as far as I know this is the uncompressed kernel-image.


I want to compile SASH for powerpc too. Does anyone know a place with
powerpc-ready source for this? I've tried to compile it from the latest
source, but I'm missing some kind of way to make i compile for powerpc - the
Makefile keeps compiling for i386 (working fine by the way).

My next step is to find a simple bootloader..

Best regards,
David Marqvar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
