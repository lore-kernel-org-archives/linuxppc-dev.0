Date: Wed, 12 May 1999 13:52:39 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: mac-on-linux (g3/r5 problems)
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990512134259.539075676A-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK... I'm trying to build mac-on-linux on my original (beige) G3. Got a
romdump from an 8500 and ready to roll...

I downloaded the macos source, built it up. This being a pre-R5 machine, I
had to work some, but nothing ugly (I added #include <errno.h> to a lot of
files...). Done with that, looks good, says that the kernel has no macos
support (no surprise there).

updated my vger cvs (well cvs.on.openprojects.net actually) to
linux-cvs-2.3.0-19990511. I then patched in the kernel stuff, and
proceeded to go through (with a known-good .config, and enabling both
macos items).

Everything compiled, but the link failed, because
arch/ppc/macos/macos_ksyms.c and kernel/ksyms.c both tried to define
__ksymtab_find_vma and .kstrtab_find_vma. At this point I munged it
(commented out EXPORT_SYMBOL(find_vma) in arch/ppc/macos/macos_ksyms.c)
and it built (I was curious how much farther I'd get). How am I supposed
to get past this / what did I do wrong that caused it?

The kenel boots, seems to work, but any attempt to insert macos_mod fails
because clear_tlb_table is not defined - this symbol is in my vmlinux
file, but does not appear in /proc/ksyms. Is this the 603 bug (since the
750 is like a 603 in many ways, and I know the problem is related to
memory mapping...)?

Any ideas on where to start? I don't know much about asm (like
anything...), but am willing to guinea-pig to work this out.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
