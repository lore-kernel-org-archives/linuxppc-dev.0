Date: Mon, 31 Mar 2003 11:10:51 +0200
From: Toni Van Remortel <t.vanremortel@ha.be>
To: linuxppc-embedded@lists.linuxppc.org
Subject: EP405 linker error.
Message-Id: <20030331111051.74af0790.t.vanremortel@ha.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Here is what I did before:
 cd /opt
 bk clone bk://ppc.bkbits.net/linuxppc_2_4_devel linuxppc_2_4_devel
 cd linuxppc_2_4_devel
 bk -r get -q
 bk edit Makefile
 vi Makefile
 	|-> ARCH := ppc
 	|-> CROSS_COMPILE = ppc_4xx-
 	|-> AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS) -Wa,-m405
 	`-> kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 		`-> this one is to avoid the "stdarg.h: not found" stuff in 'make dep'. This will include the ELDK headers.
 make ep405_config
 	`-> I have the EP405 board, o wonder ;-)
 make menuconfig
 	|-> Activate Unix98 PTY and /dev/pts support
 	|-> Deactivate PCI support (gave me errors)
 	`-> Deactivate I2C support (same story)
 make dep
 make zImage

And this last step gives me the following error:
 ppc_4xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head_4xx.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/macintosh/macintosh.o drivers/media/media.o arch/ppc/4xx_io/4xx_io.o \
	net/network.o \
	/opt/linuxppc_2_4_devel/lib/lib.a \
	--end-group \
	-o vmlinux
 arch/ppc/platforms/platform.o: In function `bios_fixup':
 arch/ppc/platforms/platform.o(.text.init+0x23c): undefined reference to `early_write_config_dword'
 arch/ppc/platforms/platform.o(.text.init+0x23c): relocation truncated to fit: R_PPC_REL24 early_write_config_dword
 arch/ppc/platforms/platform.o(.text.init+0x254): undefined reference to `early_read_config_dword'
 arch/ppc/platforms/platform.o(.text.init+0x254): relocation truncated to fit: R_PPC_REL24 early_read_config_dword
 make: *** [vmlinux] Error 1

So it's a link problem at the final linkage to vmlinux. Does anybody have an idea how I can solve this one? I haven't found anything on Google.

Thanks in advance.
--
Toni Van Remortel - Scientific Researcher
D-science lab (Hogeschool Antwerpen)
Phone: +32 (0) 3 205 61 72
Fax  : +32 (0) 3 205 61 95

Current project:
LinEmb: RealTime and Embedded Linux
(http://linemb.d-sciencelab.com)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
