From: "Ole Andreas Torvmark" <ole.torvmark@radionor.no>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling linux-2.4.devel on a sandpoint
Date: Tue, 13 Nov 2001 16:28:53 +0100
Message-ID: <MHEAIGEFFBAFIOMKCIGCEEKACAAA.ole.torvmark@radionor.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

I have tried to compile the 2.4.devel kernel on my sandpoint running the
2.4.2 hardhat 2.0 kernel from Monta Vista with gcc 2.95.3 and ran into some
problems during linking
and I'm wondering what is my problem here ?



ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o
init/main.o init/version.o \
        --start-group \
	        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o \
		         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/pci/driver.o
drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o \
			         net/network.o \
				         /usr/src/linux-2.4.devel/lib/lib.a \
					         --end-group \
						         -o vmlinux
 arch/ppc/platforms/platform.o: In function `lookup_partitions':
 arch/ppc/platforms/platform.o(.text.init+0x12): undefined reference to
`pmac_newworld'
 arch/ppc/platforms/platform.o(.text.init+0x16): undefined reference to
`pmac_newworld'
 arch/ppc/platforms/platform.o: In function `pmac_nvram_init':
 arch/ppc/platforms/platform.o(.text.init+0x128): undefined reference to
`find_devices'
 arch/ppc/platforms/platform.o(.text.init+0x128): relocation truncated to
fit: R_PPC_REL24 find_devices
 arch/ppc/platforms/platform.o(.text.init+0x15c): undefined reference to
`device_is_compatible'
 arch/ppc/platforms/platform.o(.text.init+0x15c): relocation truncated to
fit: R_PPC_REL24 device_is_compatible
 arch/ppc/platforms/platform.o(.text.init+0x28a): undefined reference to
`sys_ctrler'
 arch/ppc/platforms/platform.o(.text.init+0x28e): undefined reference to
`sys_ctrler'
 fs/fs.o: In function `cpuinfo_open':
 fs/fs.o(.text+0x2453a): undefined reference to `cpuinfo_op'
 fs/fs.o(.text+0x2453e): undefined reference to `cpuinfo_op'
 make: *** [vmlinux] Error 1
 root@192.168.0.151:/usr/src/linux-2.4.devel#

Regards

Ole Andreas Torvmark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
