Message-ID: <38727B8B.2FBD0B8@ctam.com.au>
Date: Wed, 05 Jan 2000 10:00:28 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Linux ABI documents and powerpc supplements.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To linuxppc developers,

Kai Ruottu (who contributes a hell of a lot on the crossgcc mailing list and who
cross-compiles for many targets including i586-cygwin, i586-mingw, powerpc-linux,
powerpc-eabi, sparc-linux, arm-linux, etc) had some questions about Linux ABIs and powerpc
supplements.  I have forwarded the entire email.  Hopefully someone can point him to any
relevant docs and/or answer his questions.  Most of his questions are towards the end of this
email.

Thanks,
Brendan Simon.



Kai Ruottu wrote:

> Brendan J Simon wrote:
> >
> > Kai Ruottu wrote:
> >
> > > 1. Using 'strings' to see the 'hard-wired' name of the dynamic linker in
> > >    the executable:
> > >
> > >         E:\usr\local\samples>strings tst_ppc-linux.x | more
> > >         /lib/ld.so.1    <------- !!!
> > >         __gmon_start__
> > >         libc.so.6
> >
> > The output of "powerpc-linux-strings bjs1-shared" looks OK to me.
> > $ powerpc-linux-strings bjs1-shared
> > _DYNAMIC
> > _GLOBAL_OFFSET_TABLE_
> > __gmon_start__
>
>  When your output from 'strings' didn't show the 'ld.so.1' (didn't it really?)
> I tried removing the '--dynamic-linker xxxxx' from my specs, and got then :
>
>         E:\usr\local\samples>strings tst_ppc-linux.x | more
>         /usr/lib/ld.so.1    <------- !!!!
>         __gmon_start__
>         libc.so.6
>
>  This could be the right place for 'ld.so.1' in a Linux/PPC-system and my
> powerpc-linux executables have been this far just insane... (I should never guess
> these things or trust my memory...)
>
> > I'm not sure how to interpret the output of "powerpc-linux-objdump -p bjs1-shared".
> > The output  is :
> > $ powerpc-linux-objdump -p bjs1-shared
> > <snip>
> > Dynamic Section:
> >   NEEDED      libc.so.6
> >   INIT        0x610   <----- !!!!
> >   FINI        0x634   <----- !!!!
> >   HASH        0x94
> >   STRTAB      0x310
> >   SYMTAB      0x150
> >   PLTGOT      0x40748
> >   JMPREL      0x48c
> >   RELA        0x420
> >   VERNEED     0x400
> >   VERSYM      0x3c8
>
>  The addresses look to be too small, those from my 'ppc-linux-gnu' are all over
> '0x10000000' :
>
>         Dynamic Section:
>           NEEDED      libc.so.6
>           NEEDED      ld.so.1
>           INIT        0x100011f0
>           FINI        0x10001214
>           HASH        0x10000150
>           STRTAB      0x1000027c
>           SYMTAB      0x1000019c
>           PLTGOT      0x10011990
>           JMPREL      0x10000368
>           RELA        0x10000368
>           VERNEED     0x10000348
>           VERSYM      0x1000032a
>
> which is the result of the default linker script (elf32ppclinux.x) :
>
>         SECTIONS
>         {
>           /* Read-only sections, merged into text segment: */
>           . = 0x10000000 + SIZEOF_HEADERS;
>           .interp   : { *(.interp) }
>           .hash           : { *(.hash)          }
>
>  What should the base address be for a Linux/PPC executable?
>
> > I don't see anything strange here.   I did the same for libc.so.6
> > $ powerpc-linux-objdump -p lib/libc.so.6
> > <snip>
> > Version definitions:
> > 1 0x01 0x0865f4e6 libc.so.6
> > 2 0x00 0x0d696910 GLIBC_2.0
> > 3 0x00 0x0d696911 GLIBC_2.1
> >         GLIBC_2.0
> >
> > Version References:
> >   required from ld.so.1:
> >     0x0d696911 0x00 05 GLIBC_2.1
> >     0x0d696910 0x00 04 GLIBC_2.0
> >
> > And again for ld.so.1
> > $ powerpc-linux-objdump -p lib/ld.so.1
> > <snip>
> > Version definitions:
> > 1 0x01 0x0275a261 ld.so.1
> > 2 0x00 0x0d696910 GLIBC_2.0
> > 3 0x00 0x0d696911 GLIBC_2.1
> >         GLIBC_2.0
> >
> > I don't see anything glaringly wrong but I don't exactly know what I would be looking
> > for.  Can you see any problems ?
>
>  Do you have just the same 'libc.so.6', 'ld.so.1' etc. in the cross-tools and in the
> run-time environment?  Your executable seems to be linked using some glibc-2.1.x libs,
> but do you have the same libs in the run-time target board?  Or just some smaller and
> older ones ? (Recently someone somewhere wondered why the glibc-2.1.x libs are so big
> when the older 2.0.6 ones were much smaller...).
>
>  Better to use the older ones at least when linking...
>
>  The generic rule is that one cannot run executables which were linked against newer
> shared libs, using older shared libs at run-time.  No forwards-compatibility expected.
> But all executables linked against older libs should run with newer shared libs. This
> kind of backwards-compatability is always expected... At least between two releases.
>
> > >  Perhaps the new 'readelf' utility in binutils can be used for sanity checks
> > > of the same kind...
> > Never heard of it.  Is it part of binutils-2.9.1 or newer cvs and snapshots ?
>
>  It is included with the new snapshots (perhaps almost a year now) :
>
> E:\usr\local\ppc-linux-gnu\bin>readelf --version
> GNU readelf 991116
> Copyright 1997, 1998, 1999 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
>
>  And the 'elf32ppclinux' support appeared to them some time ago :
>
> E:\usr\local\ppc-linux-gnu\bin>ld -V
> GNU ld version 2.9.5 (with BFD 991116)
>   Supported emulations:
>    elf32ppclinux
>    elf32ppc
>
>  The difference between 'elf32ppc' and 'elf32ppclinux' was discussed some time ago,
> but the only difference seems to be the base address, here is a clip from the default
> linker script for elf32ppc :
>
>         SECTIONS
>         {
>           /* Read-only sections, merged into text segment: */
>           . = 0x01800000 + SIZEOF_HEADERS;
>           .interp   : { *(.interp) }
>           .hash           : { *(.hash)          }
>
>  If the default linker script for 'elf32ppclinux' says in the same lines :
>
>         SECTIONS
>         {
>           /* Read-only sections, merged into text segment: */
>           . = 0x10000000 + SIZEOF_HEADERS;
>           .interp   : { *(.interp) }
>           .hash           : { *(.hash)          }
>
>  So I'll repeat my question: "What should the base address to be for a Linux/PPC
> executable?"
>
>  Or doesn't it really matter if there is a '. = 0', '. = 0x01800000' or a '. = 0x10000000'
> in the line after the comment?
>
>  For all ELF/x86-systems the base address seems to be the same, but for MIPS, SPARC
> etc. it seems to vary between different ELF-systems... The SVR4/PowerPC ABI Supplement
> talks about '0x02000000' as the base address and the '/usr/lib/ld.so.1' is also the
> 'program interpreter' or the 'dynamic linker' there...
>
>   BTW, is there something equivalent for Linux/PPC as there is for the never-seen
> SVR4/PPC, the "System V Application Binary Interface, PowerPC Processor Supplement",
> by Steve Zucker and Kari Karhi?  Sometimes it sounds very funny when there seems to
> be no free docs for the "Free Linux" (only those "For Dummies" things), but quite a
> lot for the commercial SVR4 (e.g. via 'www.sco.com/developer/devspecs').
>
>  A document with the name "Linux Application Binary Interface,  PowerPC Processor
> Supplement" seems to be still missing... For Linux/ARM, Linux/Alpha, Linux/MIPS,
> Linux/M68K too... Isn't there any yet for Linux/x86? (Who said that MS tries to hide
> the Windows ABI...). Some day all the money went to RedHat & Co. should be converted
> into some docs... Meanwhile the SVR4-ABI docs, the ARM-ELF-ABI, DWARF etc. docs seem
> to be the only for Linux. And the GNU sources of course, but who really likes to read
> everything from the sources...
>
>  Ok, if there were some nice PDF etc. docs for Linux/* ABIs, there could be much less
> misunderstandings and much less trouble to find these 'base' things... But surely more
> answers with the advice about 'RTFM'....


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
