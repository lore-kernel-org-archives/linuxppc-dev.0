Subject: source-level debugging w/ RISCWatch
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Date: 30 Oct 2002 13:06:47 -0600
Message-Id: <1036004807.11072.1289.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-RaclAh4Sk1CquNeZPjnZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Someone just asked me about this and I realized other people might find
it useful.

In your Makefile, CFLAGS_KERNEL   = -g -gdwarf
rw> load image zImage.treeboot <--- loads zImage onto target
rw> load host vmlinux <--- loads debugging info into RISCWatch

That's almost all it takes. Unfortunately RISCWatch will try to open
unqualified filenames, e.g. "rd.c". So you have to add to your srchpath
all the directories you're interested in:
rw> srchpath add /home/hollis/src/linux/arch/ppc/platforms
rw> srchpath add /home/hollis/src/linux/arch/ppc/kernel
rw> srchpath add /home/hollis/src/linux/kernel
......

I did this in my startup.cmd file by starting with a `find -type d` and
trimming from there.

Current (5.0) versions of RISCWatch claim to support dwarf2 which is now
the default debug format in gcc 3.x, but gcc 3.x added some extentions
that RW doesn't understand, so the load fails. I tried dwarf1 with gcc
3.x, but that fails to compile due to gcc bugs. The recommendation was
made to use gcc 2.95 with dwarf2, but that just caused RW to segfault.
I'm using dwarf1 with gcc 2.95 and that's working.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
