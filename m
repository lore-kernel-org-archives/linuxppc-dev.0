Message-ID: <3D537FE2.932524E@irisa.fr>
Date: Fri, 09 Aug 2002 10:40:02 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trouble compiling 2.5.30 on old powermac
References: <3D4FBE55.71B00BF7@irisa.fr> <20020806124542.24275@192.168.4.1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >2) arch/ppc/kernel/process.c fails with:
[snip]
> That's a new one. Paulus ? Incorrect merge ? Missing include ?

This one seems fixed now, the kernel only fails at link time:

#####
make[2]: Leaving directory `/usr/src/linuxppc-2.5/init'
  ld  -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/init.o --start-group arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
security/built-in.o arch/ppc/xmon/x.o lib/lib.a drivers/built-in.o sound/sound.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `do_adb_reset_bus':
drivers/built-in.o(.text+0x4c4a0): undefined reference to `save_flags'
drivers/built-in.o(.text+0x4c4a0): relocation truncated to fit: R_PPC_REL24 save_flags
drivers/built-in.o(.text+0x4c4a4): undefined reference to `cli'
drivers/built-in.o(.text+0x4c4a4): relocation truncated to fit: R_PPC_REL24 cli
drivers/built-in.o(.text+0x4c4c0): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x4c4c0): relocation truncated to fit: R_PPC_REL24 restore_flags
drivers/built-in.o: In function `videodev_exit':
drivers/built-in.o(.text.exit+0xd8): undefined reference to `videodev_proc_destroy'
drivers/built-in.o(.text.exit+0xd8): relocation truncated to fit: R_PPC_REL24 videodev_proc_destroy
[skip a few more related to pm3fb]
#####

videodev_exit might come from the non-essential planb
driver (video input), but the ADB bus is pretty much
mandatory on a 7500 (in particular when no serial
console is available :-)

isn't the save_flags/cli/restore_flags supposed to be
local_irq_save/local_irq_restore(flags) now ? (curious,
as I had a save_flags in pm3fb...)

Thanks in advance for any help,

--
DOLBEAU Romain               | For a hill, men would kill,
ENS Cachan / Ker Lann        |   Why ? They do not know.
Thesard IRISA / CAPS         |      -- Metallica,
dolbeaur@club-internet.fr    |       'For Whom The Bell Tolls'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
