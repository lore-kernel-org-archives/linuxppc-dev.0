Date: Sat, 5 Oct 2002 19:03:48 -0400 (EDT)
Message-Id: <200210052303.g95N3mD312030@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.5.xx
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anybody with 2.5.xx running? I need the very latest code
to run on my Mac Cube.

Linus's BitKeeper tree stops compiling when it hits the
ppc signal code, with some complaint about a lock. With
that fixed, the build stops in the Mac IDE code with a
complaint about something missing from a struct.

So I gave up on that and got the linuxppc-2.5 BitKeeper
tree instead. Compiling fails for several things, all of
which I reluctantly disable: ieee1394, Mac serial ports,
the OpenFirmware framebuffer... and I even fixed an
include for FASTCALL in include/linux/workqueue.h before
getting stopped with a link error that appears to be
video-related. Any fix? I need the aty128fb driver.

        ld  -Ttext 0xc0000000 -Bstatic -T arch/ppc/vmlinux.lds.s arch/ppc/kernel/head.o  init/built-in.o --start-group  arch/ppc/kernel/built-in.o  arch/ppc/platforms/built-in.o  arch/ppc/mm/built-in.o  arch/ppc/lib/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.data+0x2df68): undefined reference to `cfb_fillrect'
drivers/built-in.o(.data+0x2df6c): undefined reference to `cfb_copyarea'
drivers/built-in.o(.data+0x2df70): undefined reference to `cfb_imageblit'
make: *** [vmlinux] Error 1


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
