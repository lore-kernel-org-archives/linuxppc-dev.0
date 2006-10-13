Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FB3A67B7C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 01:03:50 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DF3k13014445
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 11:03:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DF3kcX454012
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 09:03:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DF3k1m023535
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 09:03:46 -0600
Subject: [PATCH] powerpc: Add mktree utility to arch/powerpc/boot
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Fri, 13 Oct 2006 10:07:01 -0500
Message-Id: <1160752023.3351.3.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the mktree program that is needed to post process zImage
wrappers for various PowerPC 4xx boards

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/Makefile |    4 -
 arch/powerpc/boot/mktree.c |  152 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -94,13 +94,13 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
 $(obj)/wrapper.a: $(obj-wlib)
 	$(call cmd,bootar)
 
-hostprogs-y	:= addnote addRamDisk hack-coff
+hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
 extra-y		:= $(obj)/crt0.o $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff)
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
 
 #############
 # Bits for building various flavours of zImage
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/mktree.c
@@ -0,0 +1,152 @@
+/*
+ * Makes a tree bootable image for IBM Evaluation boards.
+ * Basically, just take a zImage, skip the ELF header, and stuff
+ * a 32 byte header on the front.
+ *
+ * We use htonl, which is a network macro, to make sure we're doing
+ * The Right Thing on an LE machine.  It's non-obvious, but it should
+ * work on anything BSD'ish.
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
+
+/* This gets tacked on the front of the image.  There are also a few
+ * bytes allocated after the _start label used by the boot rom (see
+ * head.S for details).
+ */
+typedef struct boot_block {
+	uint32_t bb_magic;		/* 0x0052504F */
+	uint32_t bb_dest;		/* Target address of the image */
+	uint32_t bb_num_512blocks;	/* Size, rounded-up, in 512 byte blks */
+	uint32_t bb_debug_flag;	/* Run debugger or image after load */
+	uint32_t bb_entry_point;	/* The image address to start */
+	uint32_t bb_checksum;	/* 32 bit checksum including header */
+	uint32_t reserved[2];
+} boot_block_t;
+
+#define IMGBLK	512
+char	tmpbuf[IMGBLK];
+
+int main(int argc, char *argv[])
+{
+	int	in_fd, out_fd;
+	int	nblks, i;
+	uint	cksum, *cp;
+	struct	stat	st;
+	boot_block_t	bt;
+
+	if (argc < 3) {
+		fprintf(stderr, "usage: %s <zImage-file> <boot-image> [entry-point]\n",argv[0]);
+		exit(1);
+	}
+
+	if (stat(argv[1], &st) < 0) {
+		perror("stat");
+		exit(2);
+	}
+
+	nblks = (st.st_size + IMGBLK) / IMGBLK;
+
+	bt.bb_magic = htonl(0x0052504F);
+
+	/* If we have the optional entry point parameter, use it */
+	if (argc == 4)
+		bt.bb_dest = bt.bb_entry_point = htonl(strtoul(argv[3], NULL, 0));
+	else
+		bt.bb_dest = bt.bb_entry_point = htonl(0x500000);
+
+	/* We know these from the linker command.
+	 * ...and then move it up into memory a little more so the
+	 * relocation can happen.
+	 */
+	bt.bb_num_512blocks = htonl(nblks);
+	bt.bb_debug_flag = 0;
+
+	bt.bb_checksum = 0;
+
+	/* To be neat and tidy :-).
+	*/
+	bt.reserved[0] = 0;
+	bt.reserved[1] = 0;
+
+	if ((in_fd = open(argv[1], O_RDONLY)) < 0) {
+		perror("zImage open");
+		exit(3);
+	}
+
+	if ((out_fd = open(argv[2], (O_RDWR | O_CREAT | O_TRUNC), 0666)) < 0) {
+		perror("bootfile open");
+		exit(3);
+	}
+
+	cksum = 0;
+	cp = (void *)&bt;
+	for (i=0; i<sizeof(bt)/sizeof(uint); i++)
+		cksum += *cp++;
+
+	/* Assume zImage is an ELF file, and skip the 64K header.
+	*/
+	if (read(in_fd, tmpbuf, IMGBLK) != IMGBLK) {
+		fprintf(stderr, "%s is too small to be an ELF image\n",
+				argv[1]);
+		exit(4);
+	}
+
+	if ((*(uint *)tmpbuf) != htonl(0x7f454c46)) {
+		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
+		exit(4);
+	}
+
+	if (lseek(in_fd, (64 * 1024), SEEK_SET) < 0) {
+		fprintf(stderr, "%s failed to seek in ELF image\n", argv[1]);
+		exit(4);
+	}
+
+	nblks -= (64 * 1024) / IMGBLK;
+
+	/* And away we go......
+	*/
+	if (write(out_fd, &bt, sizeof(bt)) != sizeof(bt)) {
+		perror("boot-image write");
+		exit(5);
+	}
+
+	while (nblks-- > 0) {
+		if (read(in_fd, tmpbuf, IMGBLK) < 0) {
+			perror("zImage read");
+			exit(5);
+		}
+		cp = (uint *)tmpbuf;
+		for (i=0; i<sizeof(tmpbuf)/sizeof(uint); i++)
+			cksum += *cp++;
+		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
+			perror("boot-image write");
+			exit(5);
+		}
+	}
+
+	/* rewrite the header with the computed checksum.
+	*/
+	bt.bb_checksum = htonl(cksum);
+	if (lseek(out_fd, 0, SEEK_SET) < 0) {
+		perror("rewrite seek");
+		exit(1);
+	}
+	if (write(out_fd, &bt, sizeof(bt)) != sizeof(bt)) {
+		perror("boot-image rewrite");
+		exit(1);
+	}
+
+	exit(0);
+}
