Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 6/14] zImage: Cleanup and improve prep_kernel()
In-Reply-To: <20070220020837.GF17818@localhost.localdomain>
Message-Id: <20070220021235.0998DDDDCA@ozlabs.org>
Date: Tue, 20 Feb 2007 13:12:35 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch rewrites prep_kernel() in the zImage wrapper code to be
clearer and more flexible.  Notable changes:

	- Handling of the initrd image from prep_kernel() has moved
into a new prep_initrd() function.
	- The address of the initrd image is now added as device tree
properties, as the kernel expects.
	- We only copy a packaged initrd image to a new location if it
is in danger of being clobbered when the kernel moves to its final
location, instead of always.
	- By default we decompress the kernel directly to address 0,
instead of requiring it to relocate itself.  Platforms (such as OF)
where doing this could clobber still-live firmware data structures can
override the vmlinux_alloc hook to provide an alternate place to
decompress the kernel.
	- We no longer pass lots of information between functions in
global variables.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/main.c |  171 ++++++++++++++++++++++++++++-------------------
 arch/powerpc/boot/of.c   |   12 +++
 arch/powerpc/boot/ops.h  |    1 
 3 files changed, 116 insertions(+), 68 deletions(-)

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-02-19 14:01:15.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-02-19 14:01:38.000000000 +1100
@@ -33,24 +33,21 @@ extern char _dtb_end[];
 static struct gunzip_state gzstate;
 
 struct addr_range {
-	unsigned long addr;
+	void *addr;
 	unsigned long size;
-	unsigned long memsize;
 };
-static struct addr_range vmlinux;
-static struct addr_range vmlinuz;
-static struct addr_range initrd;
-
-static unsigned long elfoffset;
-static int is_64bit;
 
-static char elfheader[256];
+struct elf_info {
+	unsigned long loadsize;
+	unsigned long memsize;
+	unsigned long elfoffset;
+};
 
 typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
 
 #undef DEBUG
 
-static int is_elf64(void *hdr)
+static int parse_elf64(void *hdr, struct elf_info *info)
 {
 	Elf64_Ehdr *elf64 = hdr;
 	Elf64_Phdr *elf64ph;
@@ -74,15 +71,14 @@ static int is_elf64(void *hdr)
 	if (i >= (unsigned int)elf64->e_phnum)
 		return 0;
 
-	elfoffset = (unsigned long)elf64ph->p_offset;
-	vmlinux.size = (unsigned long)elf64ph->p_filesz;
-	vmlinux.memsize = (unsigned long)elf64ph->p_memsz;
+	info->loadsize = (unsigned long)elf64ph->p_filesz;
+	info->memsize = (unsigned long)elf64ph->p_memsz;
+	info->elfoffset = (unsigned long)elf64ph->p_offset;
 
-	is_64bit = 1;
 	return 1;
 }
 
-static int is_elf32(void *hdr)
+static int parse_elf32(void *hdr, struct elf_info *info)
 {
 	Elf32_Ehdr *elf32 = hdr;
 	Elf32_Phdr *elf32ph;
@@ -98,7 +94,6 @@ static int is_elf32(void *hdr)
 	      elf32->e_machine         == EM_PPC))
 		return 0;
 
-	elf32 = (Elf32_Ehdr *)elfheader;
 	elf32ph = (Elf32_Phdr *) ((unsigned long)elf32 + elf32->e_phoff);
 	for (i = 0; i < elf32->e_phnum; i++, elf32ph++)
 		if (elf32ph->p_type == PT_LOAD)
@@ -106,24 +101,26 @@ static int is_elf32(void *hdr)
 	if (i >= elf32->e_phnum)
 		return 0;
 
-	elfoffset = elf32ph->p_offset;
-	vmlinux.size = elf32ph->p_filesz;
-	vmlinux.memsize = elf32ph->p_memsz;
+	info->loadsize = elf32ph->p_filesz;
+	info->memsize = elf32ph->p_memsz;
+	info->elfoffset = elf32ph->p_offset;
 	return 1;
 }
 
-static void prep_kernel(unsigned long a1, unsigned long a2)
+static struct addr_range prep_kernel(void)
 {
+	char elfheader[256];
+	void *vmlinuz_addr = _vmlinux_start;
+	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
+	void *addr = 0;
+	struct elf_info ei;
 	int len;
 
-	vmlinuz.addr = (unsigned long)_vmlinux_start;
-	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
-
 	/* gunzip the ELF header of the kernel */
-	gunzip_start(&gzstate, (void *)vmlinuz.addr, vmlinuz.size);
+	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
 	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
 
-	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
+	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei)) {
 		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 		exit();
 	}
@@ -135,55 +132,92 @@ static void prep_kernel(unsigned long a1
 	 * the kernel bss must be claimed (it will be zero'd by the
 	 * kernel itself)
 	 */
-	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
-	vmlinux.addr = (unsigned long)malloc(vmlinux.memsize);
-	if (vmlinux.addr == 0) {
-		printf("Can't allocate memory for kernel image !\n\r");
-		exit();
+	printf("Allocating 0x%lx bytes for kernel ...\n\r", ei.memsize);
+
+	if (platform_ops.vmlinux_alloc) {
+		addr = platform_ops.vmlinux_alloc(ei.memsize);
+	} else {
+		if ((unsigned long)_start < ei.memsize) {
+			printf("Insufficient memory for kernel at address 0!"
+			       " (_start=%lx)\n\r", _start);
+			exit();
+		}
 	}
 
+	/* Finally, gunzip the kernel */
+	printf("gunzipping (0x%p <- 0x%p:0x%p)...", addr,
+	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
+	/* discard up to the actual load data */
+	gunzip_discard(&gzstate, ei.elfoffset - sizeof(elfheader));
+	len = gunzip_finish(&gzstate, addr, ei.memsize);
+	printf("done 0x%lx bytes\n\r", len);
+
+	flush_cache(addr, ei.loadsize);
+
+	return (struct addr_range){addr, ei.memsize};
+}
+
+static struct addr_range prep_initrd(struct addr_range vmlinux,
+				     unsigned long initrd_addr,
+				     unsigned long initrd_size)
+{
+	void *devp;
+	u32 initrd_start, initrd_end;
+
+	/* If we have an image attached to us, it overrides anything
+	 * supplied by the loader. */
+	if (_initrd_end > _initrd_start) {
+		printf("Attached initrd image at 0x%p-0x%p\n\r",
+		       _initrd_start, _initrd_end);
+		initrd_addr = (unsigned long)_initrd_start;
+		initrd_size = _initrd_end - _initrd_start;
+	} else if (initrd_size > 0) {
+		printf("Using loader supplied ramdisk at 0x%lx-0x%lx\n\r",
+		       initrd_addr, initrd_addr + initrd_size);
+	}
+
+	/* If there's no initrd at all, we're done */
+	if (! initrd_size)
+		return (struct addr_range){0, 0};
+
 	/*
-	 * Now find the initrd
-	 *
-	 * First see if we have an image attached to us.  If so
-	 * allocate memory for it and copy it there.
+	 * If the initrd is too low it will be clobbered when the
+	 * kernel relocates to its final location.  In this case,
+	 * allocate a safer place and move it.
 	 */
-	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
-	initrd.memsize = initrd.size;
-	if (initrd.size > 0) {
+	if (initrd_addr < vmlinux.size) {
+		void *old_addr = (void *)initrd_addr;
+
 		printf("Allocating 0x%lx bytes for initrd ...\n\r",
-		       initrd.size);
-		initrd.addr = (unsigned long)malloc((u32)initrd.size);
-		if (initrd.addr == 0) {
+		       initrd_size);
+		initrd_addr = (unsigned long)malloc(initrd_size);
+		if (! initrd_addr) {
 			printf("Can't allocate memory for initial "
-					"ramdisk !\n\r");
+			       "ramdisk !\n\r");
 			exit();
 		}
-		printf("initial ramdisk moving 0x%lx <- 0x%lx "
-			"(0x%lx bytes)\n\r", initrd.addr,
-			(unsigned long)_initrd_start, initrd.size);
-		memmove((void *)initrd.addr, (void *)_initrd_start,
-			initrd.size);
-		printf("initrd head: 0x%lx\n\r",
-				*((unsigned long *)initrd.addr));
-	} else if (a2 != 0) {
-		/* Otherwise, see if yaboot or another loader gave us an initrd */
-		initrd.addr = a1;
-		initrd.memsize = initrd.size = a2;
-		printf("Using loader supplied initrd at 0x%lx (0x%lx bytes)\n\r",
-		       initrd.addr, initrd.size);
-	}
-
-	/* Eventually gunzip the kernel */
-	printf("gunzipping (0x%lx <- 0x%lx:0x%0lx)...",
-	       vmlinux.addr, vmlinuz.addr, vmlinuz.addr+vmlinuz.size);
-	/* discard up to the actual load data */
-	gunzip_discard(&gzstate, elfoffset - sizeof(elfheader));
-	len = gunzip_finish(&gzstate, (void *)vmlinux.addr,
-			    vmlinux.memsize);
-	printf("done 0x%lx bytes\n\r", len);
+		printf("Relocating initrd 0x%p <- 0x%p (0x%lx bytes)\n\r",
+		       initrd_addr, old_addr, initrd_size);
+		memmove((void *)initrd_addr, old_addr, initrd_size);
+	}
+
+	printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd_addr));
+
+	/* Tell the kernel initrd address via device tree */
+	devp = finddevice("/chosen");
+	if (! devp) {
+		printf("Device tree has no chosen node!\n\r");
+		exit();
+	}
+
+	initrd_start = (u32)initrd_addr;
+	initrd_end = (u32)initrd_addr + initrd_size;
+
+	setprop(devp, "linux,initrd-start", &initrd_start,
+		sizeof(initrd_start));
+	setprop(devp, "linux,initrd-end", &initrd_end, sizeof(initrd_end));
 
-	flush_cache((void *)vmlinux.addr, vmlinux.size);
+	return (struct addr_range){(void *)initrd_addr, initrd_size};
 }
 
 /* A buffer that may be edited by tools operating on a zImage binary so as to
@@ -223,6 +257,7 @@ struct console_ops console_ops;
 
 void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
 {
+	struct addr_range vmlinux, initrd;
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
 	unsigned long ft_addr = 0;
@@ -242,7 +277,8 @@ void start(unsigned long a1, unsigned lo
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, sp);
 
-	prep_kernel(a1, a2);
+	vmlinux = prep_kernel();
+	initrd = prep_initrd(vmlinux, a1, a2);
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
@@ -271,8 +307,7 @@ void start(unsigned long a1, unsigned lo
 	if (ft_addr)
 		kentry(ft_addr, 0, NULL);
 	else
-		/* XXX initrd addr/size should be passed in properties */
-		kentry(initrd.addr, initrd.size, promptr);
+		kentry((unsigned long)initrd.addr, initrd.size, promptr);
 
 	/* console closed so printf below may not work */
 	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-02-19 14:00:51.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-02-19 14:01:38.000000000 +1100
@@ -25,6 +25,7 @@ struct platform_ops {
 	void	(*free)(void *ptr);
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
+	void *	(*vmlinux_alloc)(unsigned long size);
 };
 extern struct platform_ops platform_ops;
 
Index: working-2.6/arch/powerpc/boot/of.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/of.c	2007-02-19 14:00:51.000000000 +1100
+++ working-2.6/arch/powerpc/boot/of.c	2007-02-19 14:01:38.000000000 +1100
@@ -208,6 +208,17 @@ static void of_image_hdr(const void *hdr
 	}
 }
 
+static void *of_vmlinux_alloc(unsigned long size)
+{
+	void *p = malloc(size);
+
+	if (!p) {
+		printf("Can't allocate memory for kernel image!\n\r");
+		exit();
+	}
+	return p;
+}
+
 static void of_exit(void)
 {
 	call_prom("exit", 0, 0);
@@ -261,6 +272,7 @@ int platform_init(void *promptr, char *d
 	platform_ops.image_hdr = of_image_hdr;
 	platform_ops.malloc = of_try_claim;
 	platform_ops.exit = of_exit;
+	platform_ops.vmlinux_alloc = of_vmlinux_alloc;
 
 	dt_ops.finddevice = of_finddevice;
 	dt_ops.getprop = of_getprop;
