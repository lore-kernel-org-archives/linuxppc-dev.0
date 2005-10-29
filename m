Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lB2u030075@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:40 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 26/43] ppc64 boot: remove need for imagesize.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Compute the vmlinux size at runtime.

Use Z_FULL_FLUSH instead of Z_FINISH, to extract only the ELF header
and ELF program header.

 ->p_memsz is the required memory range for the executable, including bss
 ->p_filesz is the size of .text, .data and other runtime sections

These values must be used for the claim call.
All additional memory needed by the kernel is claimed in prom_init, remove
the extra Mb.

Pass the full memsize as target area to gunzip, otherwise not everything
will be uncompressed.

flush_cache has to flush all runtime sections, do not reduce the memrange
by the ->p_offset value because its just that: an offset.

Remove the Makefile code to produce an imagesize.c, its not needed anymore.
Remove all FORCE flags, to not rebuild the zImage if vmlinux was not changed.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/Makefile |   32 ++++++------------
 arch/ppc64/boot/main.c   |   80 ++++++++++++++++++++++-------------------------
 2 files changed, 50 insertions(+), 62 deletions(-)

diff -puN arch/ppc64/boot/main.c~ppc64-boot-remove-need-for-imagesizec arch/ppc64/boot/main.c
--- devel/arch/ppc64/boot/main.c~ppc64-boot-remove-need-for-imagesizec	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/main.c	2005-10-28 17:45:22.000000000 -0700
@@ -32,8 +32,6 @@ extern char _vmlinux_start[];
 extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
-extern unsigned long vmlinux_filesize;
-extern unsigned long vmlinux_memsize;
 
 struct addr_range {
 	unsigned long addr;
@@ -45,6 +43,7 @@ static struct addr_range vmlinuz = {0, 0
 static struct addr_range initrd  = {0, 0, 0};
 
 static char scratch[46912];	/* scratch space for gunzip, from zlib_inflate_workspacesize() */
+static char elfheader[256];
 
 
 typedef void (*kernel_entry_t)( unsigned long,
@@ -78,6 +77,7 @@ static unsigned long try_claim(unsigned 
 void start(unsigned long a1, unsigned long a2, void *promptr)
 {
 	unsigned long i;
+	int len;
 	kernel_entry_t kernel_entry;
 	Elf64_Ehdr *elf64;
 	Elf64_Phdr *elf64ph;
@@ -113,25 +113,45 @@ void start(unsigned long a1, unsigned lo
 		claim_base = PROG_START;
 #endif
 
-	/*
-	 * Now we try to claim some memory for the kernel itself
-	 * our "vmlinux_memsize" is the memory footprint in RAM, _HOWEVER_, what
-	 * our Makefile stuffs in is an image containing all sort of junk including
-	 * an ELF header. We need to do some calculations here to find the right
-	 * size... In practice we add 1Mb, that is enough, but we should really
-	 * consider fixing the Makefile to put a _raw_ kernel in there !
-	 */
-	vmlinux_memsize += ONE_MB;
-	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux_memsize);
-	vmlinux.addr = try_claim(vmlinux_memsize);
+	vmlinuz.addr = (unsigned long)_vmlinux_start;
+	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
+
+	/* gunzip the ELF header of the kernel */
+	if (*(unsigned short *)vmlinuz.addr == 0x1f8b) {
+		len = vmlinuz.size;
+		gunzip(elfheader, sizeof(elfheader),
+				(unsigned char *)vmlinuz.addr, &len);
+	} else
+		memcpy(elfheader, (const void *)vmlinuz.addr, sizeof(elfheader));
+
+	elf64 = (Elf64_Ehdr *)elfheader;
+	if ( elf64->e_ident[EI_MAG0]  != ELFMAG0	||
+	     elf64->e_ident[EI_MAG1]  != ELFMAG1	||
+	     elf64->e_ident[EI_MAG2]  != ELFMAG2	||
+	     elf64->e_ident[EI_MAG3]  != ELFMAG3	||
+	     elf64->e_ident[EI_CLASS] != ELFCLASS64	||
+	     elf64->e_ident[EI_DATA]  != ELFDATA2MSB	||
+	     elf64->e_type            != ET_EXEC	||
+	     elf64->e_machine         != EM_PPC64 )
+	{
+		printf("Error: not a valid PPC64 ELF file!\n\r");
+		exit();
+	}
+
+	elf64ph = (Elf64_Phdr *)((unsigned long)elf64 +
+				(unsigned long)elf64->e_phoff);
+	for(i=0; i < (unsigned int)elf64->e_phnum ;i++,elf64ph++) {
+		if (elf64ph->p_type == PT_LOAD && elf64ph->p_offset != 0)
+			break;
+	}
+	vmlinux.size = (unsigned long)elf64ph->p_filesz;
+	vmlinux.memsize = (unsigned long)elf64ph->p_memsz;
+	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
+	vmlinux.addr = try_claim(vmlinux.memsize);
 	if (vmlinux.addr == 0) {
 		printf("Can't allocate memory for kernel image !\n\r");
 		exit();
 	}
-	vmlinuz.addr = (unsigned long)_vmlinux_start;
-	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
-	vmlinux.size = PAGE_ALIGN(vmlinux_filesize);
-	vmlinux.memsize = vmlinux_memsize;
 
 	/*
 	 * Now we try to claim memory for the initrd (and copy it there)
@@ -155,11 +175,10 @@ void start(unsigned long a1, unsigned lo
 
 	/* Eventually gunzip the kernel */
 	if (*(unsigned short *)vmlinuz.addr == 0x1f8b) {
-		int len;
 		printf("gunzipping (0x%lx <- 0x%lx:0x%0lx)...",
 		       vmlinux.addr, vmlinuz.addr, vmlinuz.addr+vmlinuz.size);
 		len = vmlinuz.size;
-		gunzip((void *)vmlinux.addr, vmlinux.size,
+		gunzip((void *)vmlinux.addr, vmlinux.memsize,
 			(unsigned char *)vmlinuz.addr, &len);
 		printf("done 0x%lx bytes\n\r", len);
 	} else {
@@ -167,32 +186,11 @@ void start(unsigned long a1, unsigned lo
 	}
 
 	/* Skip over the ELF header */
-	elf64 = (Elf64_Ehdr *)vmlinux.addr;
-	if ( elf64->e_ident[EI_MAG0]  != ELFMAG0	||
-	     elf64->e_ident[EI_MAG1]  != ELFMAG1	||
-	     elf64->e_ident[EI_MAG2]  != ELFMAG2	||
-	     elf64->e_ident[EI_MAG3]  != ELFMAG3	||
-	     elf64->e_ident[EI_CLASS] != ELFCLASS64	||
-	     elf64->e_ident[EI_DATA]  != ELFDATA2MSB	||
-	     elf64->e_type            != ET_EXEC	||
-	     elf64->e_machine         != EM_PPC64 )
-	{
-		printf("Error: not a valid PPC64 ELF file!\n\r");
-		exit();
-	}
-
-	elf64ph = (Elf64_Phdr *)((unsigned long)elf64 +
-				(unsigned long)elf64->e_phoff);
-	for(i=0; i < (unsigned int)elf64->e_phnum ;i++,elf64ph++) {
-		if (elf64ph->p_type == PT_LOAD && elf64ph->p_offset != 0)
-			break;
-	}
 #ifdef DEBUG
 	printf("... skipping 0x%lx bytes of ELF header\n\r",
 			(unsigned long)elf64ph->p_offset);
 #endif
 	vmlinux.addr += (unsigned long)elf64ph->p_offset;
-	vmlinux.size -= (unsigned long)elf64ph->p_offset;
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 
@@ -263,7 +261,7 @@ static void gunzip(void *dst, int dstlen
 	s.avail_in = *lenp - i;
 	s.next_out = dst;
 	s.avail_out = dstlen;
-	r = zlib_inflate(&s, Z_FINISH);
+	r = zlib_inflate(&s, Z_FULL_FLUSH);
 	if (r != Z_OK && r != Z_STREAM_END) {
 		printf("inflate returned %d msg: %s\n\r", r, s.msg);
 		exit();
diff -puN arch/ppc64/boot/Makefile~ppc64-boot-remove-need-for-imagesizec arch/ppc64/boot/Makefile
--- devel/arch/ppc64/boot/Makefile~ppc64-boot-remove-need-for-imagesizec	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/Makefile	2005-10-28 17:45:22.000000000 -0700
@@ -34,7 +34,7 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c main.c imagesize.c div64.S
+src-boot := crt0.S string.S prom.c main.c div64.S
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
@@ -87,7 +87,7 @@ src-sec = $(foreach section, $(1), $(pat
 gz-sec  = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.gz, $(section)))
 
 hostprogs-y		:= addnote addRamDisk
-targets 		+= zImage.vmode zImage.initrd.vmode zImage zImage.initrd imagesize.c \
+targets 		+= zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
 			   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
 			   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
 			   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
@@ -100,9 +100,9 @@ quiet_cmd_ramdisk = RAMDISK $@
 quiet_cmd_stripvm = STRIP   $@
       cmd_stripvm = $(STRIP) -s $< -o $@
 
-vmlinux.strip: vmlinux FORCE
+vmlinux.strip: vmlinux
 	$(call if_changed,stripvm)
-$(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk $(obj)/ramdisk.image.gz FORCE
+$(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk $(obj)/ramdisk.image.gz
 	$(call if_changed,ramdisk)
 
 quiet_cmd_addsection = ADDSEC  $@
@@ -110,48 +110,38 @@ quiet_cmd_addsection = ADDSEC  $@
 		--add-section=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(patsubst %.o,%.gz, $@) \
 		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(OBJCOPYFLAGS)
 
-quiet_cmd_imagesize = GENSIZE $@
-      cmd_imagesize = ls -l vmlinux.strip | \
-		awk '{printf "/* generated -- do not edit! */\n" "unsigned long vmlinux_filesize = %d;\n", $$5}' \
-		> $(obj)/imagesize.c && \
-		$(CROSS_COMPILE)nm -n vmlinux | tail -n 1 | \
-		awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' >> $(obj)/imagesize.c
-
 quiet_cmd_addnote = ADDNOTE $@
       cmd_addnote = $(obj)/addnote $@
 
-$(call gz-sec, $(required)): $(obj)/kernel-%.gz: % FORCE
+$(call gz-sec, $(required)): $(obj)/kernel-%.gz: %
 	$(call if_changed,gzip)
 
 $(obj)/kernel-initrd.gz: $(obj)/ramdisk.image.gz
 	cp -f $(obj)/ramdisk.image.gz $@
 
-$(call src-sec, $(required) $(initrd)): $(obj)/kernel-%.c: $(obj)/kernel-%.gz FORCE
+$(call src-sec, $(required) $(initrd)): $(obj)/kernel-%.c: $(obj)/kernel-%.gz
 	@touch $@
 
-$(call obj-sec, $(required) $(initrd)): $(obj)/kernel-%.o: $(obj)/kernel-%.c FORCE
+$(call obj-sec, $(required) $(initrd)): $(obj)/kernel-%.o: $(obj)/kernel-%.c
 	$(call if_changed_dep,bootcc)
 	$(call cmd,addsection)
 
 $(obj)/zImage.vmode: obj-boot += $(call obj-sec, $(required))
-$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) FORCE
+$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot)
 	$(call cmd,bootld,$(obj-boot))
 
 $(obj)/zImage.initrd.vmode: obj-boot += $(call obj-sec, $(required) $(initrd))
-$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) FORCE
+$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot)
 	$(call cmd,bootld,$(obj-boot))
 
-$(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote FORCE
+$(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
-$(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/addnote FORCE
+$(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
-$(obj)/imagesize.c: vmlinux.strip
-	$(call cmd,imagesize)
-
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
_
