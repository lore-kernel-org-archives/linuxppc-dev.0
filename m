Date: Thu, 25 Oct 2001 17:59:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Lots of changes to PReP booting
Message-ID: <20011025175915.A6439@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  Can people _please_ go and test this (disk and net if
possible) and tell me if their machine still works?  The following
changes have been made:
1) On 'znetboot' and 'znetboot.initrd', no longer give mkprep the -pbp
option.  This allows my PowerStack (PPCBUG) to netboot successfully.
This _hopefully_ won't break anyone else tho.
2) Notify the user where we are just after we init the serial & vga
ports.
3) Notify the user where the residual data is only if we have it.  If we
don't have it tell the user that too.
4) _Always_ relocate the zImage, and if we have an initrd, always
relocate that too.
5) Kill the checks for things being above 16M.  We've now garrenteed
that initrd_start will be valid, and hold_residual and cmd_line are part
of the wrapper and thus must be close to the 8M mark, or wherever we've
relocated the wrapper to after boot.

Comments?  This is vs current linuxppc_2_4, but should apply to older
versions easily (not too old tho, maybe a week or 2 at most) and
probably to _devel too.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/boot/prep/Makefile 1.28 vs edited =====
--- 1.28/arch/ppc/boot/prep/Makefile	Sun Oct 21 20:47:58 2001
+++ edited/arch/ppc/boot/prep/Makefile	Thu Oct 25 17:34:29 2001
@@ -17,10 +17,9 @@

 USE_STANDARD_AS_RULE		:= true

-ifeq ($(CONFIG_SMP),y)
-TFTPIMAGE			= /tftpboot/zImage.prep.smp
-else
 TFTPIMAGE			= /tftpboot/zImage.prep
+ifeq ($(CONFIG_SMP),y)
+TFTPIMAGE			= $(TFTPBOOT).smp
 endif

 ZLINKFLAGS			= -T $(TOPDIR)/arch/$(ARCH)/vmlinux.lds \
@@ -68,14 +67,6 @@
 		$@.tmp $@
 	rm -f $@.tmp

-zImage: zvmlinux $(MKPREP)
-	$(MKPREP) -pbp zvmlinux ../images/$@.prep
-	rm -f zvmlinux
-
-zImage.initrd: zvmlinux.initrd $(MKPREP)
-	$(MKPREP) -pbp zvmlinux.initrd ../images/$@.prep
-	rm -f zvmlinux.initrd
-
 zvmlinux: $(obj-y) $(LIBS) ../images/vmlinux.gz
 #
 # Recompile misc.oagain with more 'correct' bogus offsets
@@ -102,13 +93,25 @@
 		--add-section=image=../images/vmlinux.gz $@.tmp $@
 	rm -f $@.tmp

+zImage: zvmlinux $(MKPREP)
+	$(MKPREP) -pbp zvmlinux ../images/$@.prep
+	rm -f zvmlinux
+
+zImage.initrd: zvmlinux.initrd $(MKPREP)
+	$(MKPREP) -pbp zvmlinux.initrd ../images/$@.prep
+	rm -f zvmlinux.initrd
+
 floppy: zImage
 	dd if=../images/zImage.prep of=/dev/fd0H1440 bs=64b

-znetboot : zImage
+znetboot : zvmlinux $(MKPREP)
+	$(MKPREP) zvmlinux ../images/zImage.prep
 	cp ../images/zImage.prep $(TFTPIMAGE)
+	rm -f zvmlinux

-znetboot.initrd : zImage.initrd
+znetboot.initrd : zvmlinux.initrd
+	$(MKPREP) zvmlinux.initrd ../images/zImage.initrd.prep
 	cp ../images/zImage.initrd.prep $(TFTPIMAGE)
+	rm -f zvmlinux.initrd

 include $(TOPDIR)/Rules.make
===== arch/ppc/boot/prep/misc.c 1.22 vs edited =====
--- 1.22/arch/ppc/boot/prep/misc.c	Mon Oct 15 17:46:21 2001
+++ edited/arch/ppc/boot/prep/misc.c	Thu Oct 25 17:51:38 2001
@@ -172,8 +172,35 @@
 	vga_init((unsigned char *)0xC0000000);
 #endif /* CONFIG_VGA_CONSOLE */

+	/*
+	 * Tell the user where we were loaded at and where we were relocated
+	 * to for debugging this process.
+	 */
+	puts("loaded at:     "); puthex(load_addr);
+	puts(" "); puthex((unsigned long)(load_addr + (4*num_words))); puts("\n");
+	if ( (unsigned long)load_addr != (unsigned long)&start )
+	{
+		puts("relocated to:  "); puthex((unsigned long)&start);
+		puts(" ");
+		puthex((unsigned long)((unsigned long)&start + (4*num_words)));
+		puts("\n");
+	}
+
 	if (residual)
 	{
+		/*
+		 * Tell the user where the residual data is.
+		 */
+		puts("board data at: "); puthex((unsigned long)residual);
+		puts(" ");
+		puthex((unsigned long)((unsigned long)residual +
+					sizeof(RESIDUAL)));
+		puts("\nrelocated to:  ");puthex((unsigned long)hold_residual);
+		puts(" ");
+		puthex((unsigned long)((unsigned long)hold_residual +
+					sizeof(RESIDUAL)));
+		puts("\n");
+
 		/* Is this Motorola PPCBug? */
 		if ((1 & residual->VitalProductData.FirmwareSupports) &&
 		    (1 == residual->VitalProductData.FirmwareSupplier)) {
@@ -223,8 +250,12 @@
 		}
 		memcpy(hold_residual,residual,sizeof(RESIDUAL));
 	} else {
+		/* Tell the user we didn't find anything. */
+		puts("No residual data found.\n");
+
 		/* Assume 32M in the absence of more info... */
 		TotalMemory = 0x02000000;
+
 		/*
 		 * This is a 'best guess' check.  We want to make sure
 		 * we don't try this on a PReP box without OF
@@ -239,23 +270,21 @@
 			/* get handle to memory description */
 			res = of_finddevice("/memory@0",
 					    &dev_handle);
-			// puthex(res);  puts("\n");
 			if (res) break;

 			/* get the info */
-			// puts("get info = ");
 			res = of_getprop(dev_handle,
 					 "reg",
 					 mem_info,
 					 sizeof(mem_info),
 					 &size);
-			// puthex(res);  puts(", info = "); puthex(mem_info[0]);
-			// puts(" ");  puthex(mem_info[1]);   puts("\n");
-			if (res) break;
-
+			if (res)
+				break;
+
 			TotalMemory = mem_info[1];
 			break;
 		}
+
 		hold_residual->TotalMemory = TotalMemory;
 		residual = hold_residual;
 		/* Turn MMU back off */
@@ -273,32 +302,6 @@
 	/* assume the chunk below 8M is free */
 	end_avail = (char *)0x00800000;

-	/* tell the user where we were loaded at and where we
-	 * were relocated to for debugging this process
-	 */
-	puts("loaded at:     "); puthex(load_addr);
-	puts(" "); puthex((unsigned long)(load_addr + (4*num_words))); puts("\n");
-	if ( (unsigned long)load_addr != (unsigned long)&start )
-	{
-		puts("relocated to:  "); puthex((unsigned long)&start);
-		puts(" ");
-		puthex((unsigned long)((unsigned long)&start + (4*num_words)));
-		puts("\n");
-	}
-
-	if ( residual )
-	{
-		puts("board data at: "); puthex((unsigned long)residual);
-		puts(" ");
-		puthex((unsigned long)((unsigned long)residual + sizeof(RESIDUAL)));
-		puts("\n");
-		puts("relocated to:  ");
-		puthex((unsigned long)hold_residual);
-		puts(" ");
-		puthex((unsigned long)((unsigned long)hold_residual + sizeof(RESIDUAL)));
-		puts("\n");
-	}
-
 	/* we have to subtract 0x10000 here to correct for objdump including the
 	   size of the elf header which we strip -- Cort */
 	zimage_start = (char *)(load_addr - 0x10000 + ZIMAGE_OFFSET);
@@ -311,37 +314,31 @@
 	initrd_end = INITRD_SIZE + initrd_start;

 	/*
-	 * Find a place to stick the zimage and initrd and
-	 * relocate them if we have to. -- Cort
+	 * Stick the zImage at the end of ourself (page aligned).  If there's
+	 * an initrd, stick that on the next page following the zImage.
+	 * -- Tom
 	 */
 	avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
 	puts("zimage at:     "); puthex((unsigned long)zimage_start);
 	puts(" "); puthex((unsigned long)(zimage_size+zimage_start)); puts("\n");
-	if ( (unsigned long)zimage_start <= 0x00800000 )
-	{
-		memcpy( (void *)avail_ram, (void *)zimage_start, zimage_size );
-		zimage_start = (char *)avail_ram;
-		puts("relocated to:  "); puthex((unsigned long)zimage_start);
-		puts(" ");
-		puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
-		puts("\n");
+	memcpy( (void *)avail_ram, (void *)zimage_start, zimage_size );
+	zimage_start = (char *)avail_ram;
+	puts("relocated to:  "); puthex((unsigned long)zimage_start);
+	puts(" ");
+	puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
+	puts("\n");

-		/* relocate initrd */
-		if ( initrd_start )
-		{
-			puts("initrd at:     "); puthex(initrd_start);
-			puts(" "); puthex(initrd_end); puts("\n");
-			avail_ram = (char *)PAGE_ALIGN(
-				(unsigned long)zimage_size+(unsigned long)zimage_start);
-			memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
-			initrd_start = (unsigned long)avail_ram;
-			initrd_end = initrd_start + INITRD_SIZE;
-			puts("relocated to:  "); puthex(initrd_start);
-			puts(" "); puthex(initrd_end); puts("\n");
-		}
-	} else if ( initrd_start ) {
+	if ( initrd_start )
+	{
 		puts("initrd at:     "); puthex(initrd_start);
 		puts(" "); puthex(initrd_end); puts("\n");
+		avail_ram = (char *)PAGE_ALIGN(
+			(unsigned long)zimage_size+(unsigned long)zimage_start);
+		memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
+		initrd_start = (unsigned long)avail_ram;
+		initrd_end = initrd_start + INITRD_SIZE;
+		puts("relocated to:  "); puthex(initrd_start);
+		puts(" "); puthex(initrd_end); puts("\n");
 	}

 	avail_ram = (char *)0x00400000;
@@ -384,24 +381,15 @@
 	*cp = 0;
 	puts("\n");

-	/* mappings on early boot can only handle 16M */
-	if ( (int)(cmd_line) > (16<<20))
-		puts("cmd_line located > 16M\n");
-	if ( (int)hold_residual > (16<<20))
-		puts("hold_residual located > 16M\n");
-	if ( initrd_start > (16<<20))
-		puts("initrd_start located > 16M\n");
-
 	puts("Uncompressing Linux...");
-
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");

 	{
 		struct bi_record *rec;
-
+
 		rec = (struct bi_record *)_ALIGN((unsigned long)(zimage_size)+(1<<20)-1,(1<<20));
-
+
 		rec->tag = BI_FIRST;
 		rec->size = sizeof(struct bi_record);
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
@@ -410,31 +398,22 @@
 		memcpy( (void *)rec->data, "prepboot", 9);
 		rec->size = sizeof(struct bi_record) + 8 + 1;
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
-
+
 		rec->tag = BI_MACHTYPE;
 		rec->data[0] = _MACH_prep;
 		rec->data[1] = 0;
 		rec->size = sizeof(struct bi_record) + 2 * sizeof(unsigned long);
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
-
+
 		rec->tag = BI_CMD_LINE;
 		memcpy( (char *)rec->data, cmd_line, strlen(cmd_line)+1);
 		rec->size = sizeof(struct bi_record) + strlen(cmd_line) + 1;
-		rec = (struct bi_record *)((ulong)rec + rec->size);
-
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
 		rec->tag = BI_LAST;
 		rec->size = sizeof(struct bi_record);
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	}
 	puts("Now booting the kernel\n");
 	return (unsigned long)hold_residual;
-}
-
-/*
- * PCI/ISA I/O support
- */
-unsigned long
-local_to_PCI(unsigned long addr)
-{
-	return (addr | 0x80000000);
 }

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
