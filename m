Date: Sun, 11 Apr 1999 18:14:08 +0200
To: a sun <asun@saul1.u.washington.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: BootX 1.0.3b2
Message-Id: <19990411181408.020170@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've uploaded BootX 1.0.3b2 to my web page. It contains more "DMA
shutdown" fixes, some source code cleanups, and preliminary support for
NuBus machines so adrian can begin working on them.

There's a kernel patch available at
<http://calvaweb.calvacom.fr/bh40/patch.html> which updates bootx.h along
with minor changes to prom.c. The patch was made against today's vger
tree and could be merged in vger without harm.

I tested the NuBus stuff on an old performa I have here. There kernel is
loaded at 0x200000 (phys) and entered with MMU off. I don't have a nubus
machine with video in DRAM so I can't test if remapping of this works.
The code for it is quick&dirty anyway, I'll clean this up later. Look at
bootx.h for details about infos passed to the kernel on the nubus
(basically, the device tree is gone, the phys mem map is added, along
with the machineID (from gestalt)).

Current kernels will boot until the HW intialisation begins. At this
point, it crashes, and that's normal since it expects a PCI machine. The
early boot text (prom_printf) works, the initial message is correctly
displayed (the above patch adds more infos).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
