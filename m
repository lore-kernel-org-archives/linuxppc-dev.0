Date: Fri, 05 Mar 1999 14:04:50 -0500
From: harry eaton <haceaton@aplcomm.jhuapl.edu>
Subject: Segfaults in powerpc ld (binutils-2.9.1-19a)
To: egcs@egcs.cygnus.com, linuxppc-dev@lists.linuxppc.org
Message-id: <36E02AD1.8FACA47E@aplcomm.jhuapl.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting seg-faults in ld when I try to compile twin on a powerpc
linux system.  I'm using binutils-2.9.1-19a
and egcs-1.1-1c.

gcc is invoked with these arguments:


-Wall -fwritable-strings -fPIC -shared  -Wl,-Bsymbolic

What specifically is happening is this:
 on line 2856 of bfd/elf32-ppc.c (of binutls of course) the segfault
occurs.

rel->r_info is R_PPC_REL24
info->symbolic is true.
the name of the section:  h->root.u.def.section is ".text"
h->root.u.def.section->output_section is NULL !!!!

The NULL is the problem since it is de-referenced.

I added a test for this NULL, and just used a break
to stop the segfault.  That stops the segfault but
seems to just lose the symbol?  (Later stages of the
make complain about missing symbols during
linking.)  I also added some statements to print
when the this line is encountered and the output_section
is not 0.  I've compiled a few other things with it
configured this way, and the print is never triggered.
It seems like this particular relocation situation is
very seldom encountered, so the bug may have been
lurking for a while.

I have to admit that I don't know enough about the
linker to figure out what's going on.

the twin source consistently causes this problem,
but I have not been able to make  a small example.

Ideas?

harry




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
