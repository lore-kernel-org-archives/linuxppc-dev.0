Subject: PATCH: requesting feedback on dead function optimisation
To: linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
Date: Tue, 11 Apr 2000 15:38:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000411053810.E1BA83C969@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[ This got bounced first time for being too big, so I'm trying again ]

Fellow kernel hackers,

For the last couple of weeks I've been looking at how to get gcc/ld to
automatically optimise unused functions and data out of the kernel. In
particular I want to optimise away functions which aren't ever called, even
if other functions in the same object are. I consider this less error prone
than wrapping functions in #ifdef CONFIG_..., and it's particularly good if
you're building a kernel for embedded systems which don't use stuff like /proc
fs, support for which isn't always wrapped in #ifdefs.

This exercise has turned out to be distinctly non-trivial, so I'm soliciting
feedback on the following patch. In its present form, the patch will break
all architectures except PowerPC, but if you're keen you should be able to
work out what to do to make it work for other architectures by following the
architecture-dependent steps from below. Once I've convinced everyone that
this is a good idea :-), I'll send a patch which works on all architectures.
Most importantly, please let me know what you think.

I'm working with a 2.2.x kernel, so that's what the patch is against at
present.  I haven't tried to build anything as modules, and have probably
broken modules; this is experimental, and I'm posting it to solicit feedback.
You may need to apply some bits by hand depending on how recent your 2.2
kernel is, but that should be easy once you get the idea.

Here is the rational behind what I've done in the patch:

1. enable gcc's -ffunction-sections/-fdata-sections options, and ld's
   --gc-sections option in the top Makefile, which together work all the
   magic. You need a recent enough gcc and binutils to have these flags
   actually turn on.

   That causes a whole host of stuff to break, so fix the resulting damage:

2. The section namespace used by -ffunction-sections (.text.*) clashes with
   that used by include/asm/init.h (.text.init), so I renamed the init
   sections to .init.text. Similarly for .init.data. Also for pmac/prep/
   openfirmware sections, for consistency.

3. The user space exception fixup __ex_table search uses a binary chop. This
   relies on references to instructions which may fault on user space accesses
   being in the table in ascending address order. Unfortunately, a bug in all
   previous versions of the linker reverses the order of the orphan .text.*
   sections generated using -ffunction-sections when an intermediate "ld -r"
   is done, causing the binary search to fail.

   There has been some discussion of this on the binutils list, including a
   patch which fixes the problem at:
	http://sourceware.cygnus.com/ml/binutils/2000-04/msg00165.html

   However, it's a big ask to expect _everyone_ who wants to build the kernel
   to upgrade to the latest binutils snapshot, so my solution is to change all
   the intermediate link stages using "ld -r" into archive builds using "ar"
   instead. This is enough to work around the "ld -r" bug. People tell me this
   makes sections disappear, but I don't see that and I'm yet to be convinced
   as to why this isn't The Right Thing to do anyway.

   I've done this by adding an A_TARGET rule to Rules.make, which knows how
   to build an aggregate archive from other archives (and some extra objects
   when necessary). High level L_TARGETs turn into A_TARGETs, and all the
   O_TARGETs turn into L_TARGETs (to avoid "ld -r").

4. Mods to the vmlinux.lds file to keep the world in sync:

   Add an explicit ENTRY(_start) in the .lds file to prevent everything
   getting optimised away(!) because no external references exist.

   Changed the .text and .data entries to .text* and .data*
   I use a single entry instead of adding a .text.* and .data.*, so that the
   linker will keep the ex_table sorted when some functions attempting user
   space access are in .text.* and others are still in .text. This allows you
   to turn -ffunction-sections on and off at will, and mix it with assembler
   code that just does ".text" and also makes user accesses.

   Changed the .text/data.init to .init.text/data, as per init.h

   KEEP the .fixup and __ex_table, otherwise they get optimised away.

5. I've added a check_exception_table function to check_bugs to ensure that
   the table really is in ascending order, since it's not real noticable when
   it's broken until a rogue program passes a bad pointer to the kernel.
   This may be temporary; I'm trying to save space, after all.

6. The __get/put_user_asm macros in include/asm-ppc/uaccess.h were making an
   explicit reference to ".text", rather than using ".previous" like other
   architectures do. This caused me much grief, and should be fixed for
   consistency anyway.

Let the complaints begin!

For the patch, see:
    http://members.xoom.com/greyhams/linux/patches/funcsect.patch

--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
