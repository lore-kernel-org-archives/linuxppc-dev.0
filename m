Date: Sun, 12 Nov 2000 04:52:19 -0500
From: Dan Foster <dsf@gblx.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: build issues and questions
Message-ID: <20001112045219.A29246@gblx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some questions:

What's the difference between penguinppc.org and ppc.samba.org? I see they
both has a rsync repository for linux-pmac-stable and linux-pmac-devel. Just
wondering if it's two sites hosting the exact same source code base, or if
there are subtle differences in the two?

Also, the rsync'd sources from penguinppc.org::linux-pmac-devel as of right
now for the 2.4.0-test10 kernel failed its linking with:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/parport/parport.a  drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o drivers/pci/pci.a drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
	net/network.o \
	/usr/src/linux/lib/lib.a \
	--end-group \
	-o vmlinux
arch/ppc/kernel/kernel.o: In function `get_irq_list':
arch/ppc/kernel/kernel.o(.text+0x1fee): undefined reference to `ipi_count'
arch/ppc/kernel/kernel.o(.text+0x1ff2): undefined reference to `ipi_count'
arch/ppc/kernel/kernel.o: In function `smp_core99_probe':
arch/ppc/kernel/kernel.o(.text+0x9c58): undefined reference to `openpic_request_IPIs'
arch/ppc/kernel/kernel.o(.text+0x9c58): relocation truncated to fit: R_PPC_REL24 openpic_request_IPIs
arch/ppc/kernel/kernel.o: In function `smp_chrp_probe':
arch/ppc/kernel/kernel.o(.text+0x9ee4): undefined reference to `openpic_request_IPIs'
arch/ppc/kernel/kernel.o(.text+0x9ee4): relocation truncated to fit: R_PPC_REL24 openpic_request_IPIs
arch/ppc/kernel/kernel.o(.text+0x9eea): undefined reference to `mot_multi'
arch/ppc/kernel/kernel.o(.text+0x9eee): undefined reference to `mot_multi'
arch/ppc/kernel/kernel.o: In function `smp_prep_probe':
arch/ppc/kernel/kernel.o(.text+0x9f68): undefined reference to `openpic_request_IPIs'
arch/ppc/kernel/kernel.o(.text+0x9f68): relocation truncated to fit: R_PPC_REL24 openpic_request_IPIs
arch/ppc/kernel/kernel.o(.text+0x9f6e): undefined reference to `mot_multi'
arch/ppc/kernel/kernel.o(.text+0x9f72): undefined reference to `mot_multi'
arch/ppc/kernel/kernel.o: In function `smp_prep_kick_cpu':
arch/ppc/kernel/kernel.o(.text+0x9fa2): undefined reference to `MotSave_SmpIar'
arch/ppc/kernel/kernel.o(.text+0x9faa): undefined reference to `MotSave_SmpIar'
arch/ppc/kernel/kernel.o(.text+0x9fba): undefined reference to `MotSave_CpusState'
arch/ppc/kernel/kernel.o(.text+0x9fbe): undefined reference to `MotSave_CpusState'
arch/ppc/kernel/kernel.o: In function `pmac_get_irq':
arch/ppc/kernel/kernel.o(.text+0xac28): undefined reference to `pmac_smp_message_recv'
arch/ppc/kernel/kernel.o(.text+0xac28): relocation truncated to fit: R_PPC_REL24 pmac_smp_message_recv
arch/ppc/kernel/kernel.o: In function `smp_boot_cpus':
arch/ppc/kernel/kernel.o(.text.init+0x1e00): undefined reference to `xmon'
arch/ppc/kernel/kernel.o(.text.init+0x1e00): relocation truncated to fit: R_PPC_REL24 xmon
make: *** [vmlinux] Error 1

For ipi_count, I see it being defined in include/asm-<arch>/smp.h for other
architectures but does not exist in include/asm-ppc/smp.h.

I'm not sure what's up with openpic_request_IPIs. I vaguely recall Ben H.
mentioning he fixed some kind of silly bug with pre-core99 machines. Don't
know if related to this source tree even if it's different from his.

I'm more at a loss as far as the mot* stuff goes. Not sure why
pmac_smp_message_recv is undefined, either - seems bad.

All of the above seems related to SMP support in general. Wish I knew more
about the innards of SMP, but I'll keep poking around.

Can't explain why xmon is showing up; I haven't included xmon in my kernel
config, and explicitly disabled it. I took a quick look by grepping for
mentions of xmon, and I think all use of it is #ifdef CONFIG_XMON, which
seems sane... so not quite sure how this is appearing in the build.

What does relocation truncated to fit: R_PPC_REL24 <routine> mean? Obviously
a linker error in relation to relocation for assembling the actual executable,
but don't understand the part about truncation.

Setup: latest G4 that's only 48 hours old, heh, dual proc G4/500 with 512 MB
RAM, 40 GB IDE HD, running LinuxPPC 2000. If other details needed, just holler.
Pretty much stock from Apple - no other devices/cards/etc. Is there a code
name for this particular type of newer G4? Ie, Sawtooth or something newer?
Just wondering because I imagine it'd be useful to differentiate between the
various G4 models for the linuxppc developers...?

I'm currently booted into the machine using 2.2.18pre17-ben1 and yaboot 0.9
which seems to be working out well so far.

One other question...do I need to also include the MACE driver when also
building in GMAC for Ethernet? Do I need to leave CMD64X IDE chipset  support
enabled for this G4? This G4 is PMU based rather than CUDA, right? Do I
really need to enable Bus Mouse support even though it's an USB mouse?

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
