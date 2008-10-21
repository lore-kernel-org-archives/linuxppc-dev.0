Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18685.18597.47016.674292@cargo.ozlabs.ibm.com>
Date: Tue, 21 Oct 2008 14:12:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Revert to real-base = 12MB on 32-bit CHRP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 9b09c6d909dfd8de96b99b9b9c808b94b0a71614 ("powerpc: Change the
default link address for pSeries zImage kernels") changed the
real-base value in the CHRP note added by addnote to the zImage from
12MB to 32MB.  It turns out that this causes unnecessary extra reboots
on old 32-bit CHRP machines.  This therefore adds a -r flag to addnote
to allow us to specify what real-base value it should put in the CHRP
note, and adjusts the wrapper script to pass -r c00000 to addnote when
making a zImage for a CHRP machine.  Also, CHRP machines ignore the
RPA note, so we don't need to arrange for it to be the same as the
kernel's.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This version fixes a bug in the addnote argument parsing where we were
still checking ac == 3 to see if we had an RPA note file.

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index dcc9ab2..a43682e 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -11,7 +11,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  *
- * Usage: addnote zImage [note.elf]
+ * Usage: addnote [-r realbase] zImage [note.elf]
  *
  * If note.elf is supplied, it is the name of an ELF file that contains
  * an RPA note to use instead of the built-in one.  Alternatively, the
@@ -55,7 +55,7 @@ unsigned int rpanote[N_RPA_DESCR] = {
 	1,			/* splpar */
 	-1,			/* min_load */
 	1,			/* new_mem_def */
-	0,			/* ignore_my_client_config */
+	1,			/* ignore_my_client_config */
 };
 
 #define ROUNDUP(len)	(((len) + 3) & ~3)
@@ -153,18 +153,31 @@ unsigned char *read_rpanote(const char *fname, int *nnp)
 int
 main(int ac, char **av)
 {
-	int fd, n, i;
+	int fd, n, i, ai;
 	int ph, ps, np;
 	int nnote, nnote2, ns;
 	unsigned char *rpap;
-
-	if (ac != 2 && ac != 3) {
-		fprintf(stderr, "Usage: %s elf-file [rpanote.elf]\n", av[0]);
+	char *p, *endp;
+
+	ai = 1;
+	if (ac >= ai + 2 && strcmp(av[ai], "-r") == 0) {
+		/* process -r realbase */
+		p = av[ai + 1];
+		descr[1] = strtol(p, &endp, 16);
+		if (endp == p || *endp != 0) {
+			fprintf(stderr, "Can't parse -r argument '%s' as hex\n",
+				p);
+			exit(1);
+		}
+		ai += 2;
+	}
+	if (ac != ai + 1 && ac != ai + 2) {
+		fprintf(stderr, "Usage: %s [-r realbase] elf-file [rpanote.elf]\n", av[0]);
 		exit(1);
 	}
-	fd = open(av[1], O_RDWR);
+	fd = open(av[ai], O_RDWR);
 	if (fd < 0) {
-		perror(av[1]);
+		perror(av[ai]);
 		exit(1);
 	}
 
@@ -184,12 +197,12 @@ main(int ac, char **av)
 	if (buf[E_IDENT+EI_CLASS] != ELFCLASS32
 	    || buf[E_IDENT+EI_DATA] != ELFDATA2MSB) {
 		fprintf(stderr, "%s is not a big-endian 32-bit ELF image\n",
-			av[1]);
+			av[ai]);
 		exit(1);
 	}
 
-	if (ac == 3)
-		rpap = read_rpanote(av[2], &nnote2);
+	if (ac == ai + 2)
+		rpap = read_rpanote(av[ai + 1], &nnote2);
 
 	ph = GET_32BE(buf, E_PHOFF);
 	ps = GET_16BE(buf, E_PHENTSIZE);
@@ -202,7 +215,7 @@ main(int ac, char **av)
 	for (i = 0; i < np; ++i) {
 		if (GET_32BE(buf, ph + PH_TYPE) == PT_NOTE) {
 			fprintf(stderr, "%s already has a note entry\n",
-				av[1]);
+				av[ai]);
 			exit(0);
 		}
 		ph += ps;
@@ -260,18 +273,18 @@ main(int ac, char **av)
 		exit(1);
 	}
 	if (i < n) {
-		fprintf(stderr, "%s: write truncated\n", av[1]);
+		fprintf(stderr, "%s: write truncated\n", av[ai]);
 		exit(1);
 	}
 
 	exit(0);
 
  notelf:
-	fprintf(stderr, "%s does not appear to be an ELF file\n", av[1]);
+	fprintf(stderr, "%s does not appear to be an ELF file\n", av[ai]);
 	exit(1);
 
  nospace:
 	fprintf(stderr, "sorry, I can't find space in %s to put the note\n",
-		av[1]);
+		av[ai]);
 	exit(1);
 }
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ee0dc41..f390735 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -306,11 +306,14 @@ fi
 
 # post-processing needed for some platforms
 case "$platform" in
-pseries|chrp)
+pseries)
     ${CROSS}objcopy -O binary -j .fakeelf "$kernel" "$ofile".rpanote
     $objbin/addnote "$ofile" "$ofile".rpanote
     rm -r "$ofile".rpanote
     ;;
+chrp)
+    $objbin/addnote -r c00000 "$ofile"
+    ;;
 coff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $objbin/hack-coff "$ofile"
