Date: Mon, 8 Mar 1999 23:12:18 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: No-IDE kernel compile link errors
Message-ID: <Pine.LNX.3.96L.990308225823.26298C-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been having this problem recently with 2.2.2 source from kernel.org and
now the NMT vger snapshot:

So I 'make menuconfig'. And since I have a PowerCenter (with no IDE anything),
I turn off all IDE support, in General and Block Devices.

I get the following link error:
arch/ppc/kernel/kernel.o: In function `find_ide_boot':
arch/ppc/kernel/kernel.o(.text.init+0x1ca6): undefined reference to
`pmac_ide_count'
arch/ppc/kernel/kernel.o(.text.init+0x1caa): undefined reference to
`pmac_ide_count'
arch/ppc/kernel/kernel.o(.text.init+0x1cc2): undefined reference to
`pmac_ide_node'
arch/ppc/kernel/kernel.o(.text.init+0x1cc6): undefined reference to
`pmac_ide_node'
arch/ppc/kernel/kernel.o(.text.init+0x1cce): undefined reference to
`pmac_ide_count'
arch/ppc/kernel/kernel.o(.text.init+0x1d06): undefined reference to
`pmac_ide_count'

Awesome. Of course it can't find those symbols - I haven't compiled (and don't
want) any IDE stuff.



When I rerun 'make menuconfig', I find that the IDE stuff has been re-enabled
on me. My other changes were saved, though. Examining the .config file, I find
that CONFIG_BLK_DEV_IDE_PMAC and CONFIG_PARIDE_PARPORT are both set to y.

On a related note, I've always wondered who maintains the Makefiles for the
kernel. Is it communal, and if so, are patches to the Makefiles submitted just
like source patches?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
