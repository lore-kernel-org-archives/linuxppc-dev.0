Message-ID: <370D106E.2FC735F1@talknet.de>
Date: Thu, 08 Apr 1999 20:24:14 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Vger 2.2.5 kernel not working without IDE
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


playing with recent vger 2.2.5 kernels from CVS on samba I found out
that kernels built without IDE support (CONFIG_BLK_DEV_IDE not set)
will no longer boot on prep_hardware.
The reason is asm-ppc/ide.h which redefines the inb and outb macros
to use the ISA-I/O base from ppc_ide_md.io_base. The whole ppc_ide_md
structure is only initialized if IDE support is configured.
For the kernel this means that after including asm-ppc/ide.h all
following inb/outb operations access wrong locations which results in
the kernel not booting at all.

Question is if these undefs and redefs for inb/outb inb_p/outb_p in
ide.h are really required or if they can go away.

I dropped this lines and than tested recompiled IDE and non-IDE kernels
which both woirked fine for me.

Alois


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
