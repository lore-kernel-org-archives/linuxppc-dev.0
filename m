Date: Tue, 16 May 2000 13:32:17 -0400
From: Simon Piette <spiette@generation.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Promise Ultra/66
Message-ID: <20000516133216.A760@xim.bellglobal.com>
Reply-To: spiette@generation.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm currently trying to get working a Promise Ultra/66 (BIOS v 1.14) on
a 2.2.12 kernel and/or a 2.2.15 kernel both from kernel.org, as Michael
Lanners used those. I would like to have it to work on a Umax J700/180
(the actual machine) and a StarMax 3200/240

For the former (2.2.12 kernel), I got the ide-2.2.12 patch form Andre
Hedrick (http://www.kernel.org/pub/linux/kernel/people/hedrick)
and applied the patch from Michael Lanners
(http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00146.html)

The patches applied without any hitch (no .rej). My config file got:
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y

And I can't built vmlinux:

make[1]: Entering directory `/mnt/biz/tmp/linux-2.2.12/arch/ppc/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring   -c -o pmac_setup.o pmac_setup.c
In file included from pmac_setup.c:57:
/usr/src/linux/include/asm/ide.h:52: parse error before `*'
/usr/src/linux/include/asm/ide.h:55: warning: function declaration isn't
a prototype
pmac_setup.c:585: parse error before `*'
pmac_setup.c:585: warning: function declaration isn't a prototype
pmac_setup.c:593: redefinition of `ide_init_default_hwifs'
/usr/src/linux/include/asm/ide.h:98: `ide_init_default_hwifs' previously
defined here
make[1]: *** [pmac_setup.o] Error 1
make[1]: Leaving directory `/mnt/biz/tmp/linux-2.2.12/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

I had to apply some patch from ML:
http://lists.linuxppc.org/listarcs/linuxppc-dev/199908/msg00096.html

then manually add:
--- pmac_setup.c.orig   Mon May 15 19:39:53 2000
+++ pmac_setup.c        Tue May 16 12:05:55 2000
@@ -41,6 +41,7 @@
 #include <linux/blk.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
+#include <linux/ide.h>
 #include <linux/pci.h>
 #include <asm/prom.h>
 #include <asm/system.h>

And I got the same result than for 2.2.15...

For the latter (2.2.15), I took the ide.2.2.15.20000509.patch from A. Hedrick,
but I didn't applied Michael Lanners', since it looks as it's already
merged. Same .config, plus make oldconfig.

It build succesfully. I can boot with it (from a scsi drive). At boot,
it shows:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20262: IDE controller on PCI bus 01 dev 00
PDC20262: device not capable of full native PCI mode
PDC20262: device disabled (BIOS)

BTW, I've tried with "idebus=66" as kernel args, but I'm not sure if my
mobo would support that.


For the record, here's the lspci -vvx output:
1:00.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d38 (rev 01)
        Subsystem: Unknown device 105a:4d33
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 1
        Region 0: I/O ports at 1070 [disabled]
        Region 1: I/O ports at 1060 [disabled]
        Region 2: I/O ports at 1050 [disabled]
        Region 3: I/O ports at 1040 [disabled]
        Region 4: I/O ports at 1000 [disabled]
        Region 5: Memory at 80820000 (32-bit, non-prefetchable) [disabled]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 38 4d 04 00 10 02 01 00 80 01 00 20 00 00
10: 71 10 00 00 61 10 00 00 51 10 00 00 41 10 00 00
20: 01 10 00 00 00 00 82 80 00 00 00 00 5a 10 33 4d
30: 00 00 80 80 58 00 00 00 00 00 00 00 0b 01 00 00

Do I have to setup the card BIOS on a PC before getting it to work?

Should I enable PCI_QUIRKS? Put the Promise Card in bus 0 instead?

Do I need addtionnal patches?

Comments, suggestions, kernel args?

Cheers,

Simon Piette

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
