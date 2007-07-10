Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:11:42 -0500 (CDT)
Subject: [PATCH 10/15] bootwrapper: add cpio file extraction library.
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-10.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a library to search through a cpio or initramfs to a specified
path contained in a cpio.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Status: tested and working.  

This file is designed to also be usable in a stand alone user space
application.

Index: work.git/arch/powerpc/boot/cpio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/cpio.c	2007-07-10 04:03:40.000000000 -0500
@@ -0,0 +1,306 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+
+#include "cpio.h"
+#include "string.h"
+
+struct cpio_header {
+	char ino[8];
+	char mode[8];
+	char uid[8];
+	char gid[8];
+	char nlink[8];
+	char mtime[8];
+	char filesize[8];
+	char maj[8];
+	char min[8];
+	char rmaj[8];
+	char rmin[8];
+	char namesize[8];
+	char chksum[8];
+} cpio_header_buf;
+
+static int check_magic(char magic[6])
+{
+	return !memcmp(magic,"070701",6) || !memcmp(magic,"070702",6);
+}
+
+static int read_magic(struct gunzip_state *stream)
+{
+	int len;
+	char magic[6];
+
+	len = gunzip_partial(stream, magic, sizeof(magic));
+	if (len == 0)
+		return 0;
+
+	if (len == sizeof(magic) && check_magic(magic))
+		return len;
+
+
+	/* Not the right magic or short read.  We might have stumbled
+	 * onto a compressed archive immediately following an
+	 * uncompressed one, or just some NUL bytes at the end of the
+	 * archive.  Inform the higher layers by the negative length.
+	 */
+	return -len;
+}
+
+static int get_cpio_header(struct gunzip_state *stream)
+{
+	int len;
+
+	len = read_magic(stream);
+	if (len <= 0)
+		return len;
+
+	gunzip_exactly(stream, &cpio_header_buf, sizeof(cpio_header_buf));
+	len += sizeof(cpio_header_buf);
+
+	return len;
+}
+
+static unsigned int cpio_str_to_num(char hexascii[8])
+{
+	unsigned int num = 0;
+	char c;
+	int d;
+
+	for (d=0; d < 8; d++) {
+		c = hexascii[d];
+		num <<= 4;
+		if (c >= '0' && c <= '9') {
+			num += c - '0';
+		} else if (c >= 'A' && c <= 'F') {
+			num += c - 'A' + 10;
+		} else if (c >= 'a' && c <= 'f') {
+			num += c - 'a' + 10;
+		} else {
+			cpio_error("bad cpio archive header: "
+					"invalid a hex digit");
+		}
+	}
+
+	return num;
+}
+
+static char name_buf[MAX_PATH+1];
+static const char cpio_end[] = "TRAILER!!!";
+#define CPIO_END_LEN sizeof(cpio_end)
+
+/* check_next_file
+ * Look for @path in @stream.  Set @consumed to the number of bytes
+ * succesfully read and processed.  return 1 on match, 0 for discarding
+ * an unmatched file, -1 on end of archive (either detected trailer or
+ * EOF on stream), or -(1 + bytes read) for a short read or bad magic
+ * number.  (For the short or bad read, the consumed is not changed).
+ */
+static int check_next_file(char *path, int pathlen,
+		struct gunzip_state *stream, int *consumed)
+{
+	int len, total, match;
+
+	if (pathlen > MAX_PATH) {
+		cpio_error("path too long to search\n");
+	}
+	total = get_cpio_header(stream);
+	if (total <= 0)
+		return total - 1;
+
+	len = cpio_str_to_num(cpio_header_buf.namesize);
+
+	if (len == pathlen || len == CPIO_END_LEN) {
+		gunzip_exactly(stream, name_buf, len);
+		total += len;
+		match = !strcmp(name_buf, path);
+		if (!match && !cpio_str_to_num(cpio_header_buf.filesize))
+			match = -!strcmp(name_buf, cpio_end);
+	} else {
+		gunzip_discard(stream, len);
+		total += len;
+		name_buf[0] = '\0';
+		match = 0;
+	}
+
+	len = total % 4;
+	if (len) {
+		gunzip_discard(stream, 4 - len);
+		total += 4 - len;
+	}
+
+	if (!match) {
+		len = cpio_str_to_num(cpio_header_buf.filesize);
+		gunzip_discard(stream, len);
+		total += len;
+
+		len = total % 4;
+		if (len) {
+			gunzip_discard(stream, 4 - len);
+			total += 4 - len;
+		}
+	}
+
+	*consumed += total;
+	return match;
+}
+
+static char *this_buf;
+static int this_archive;
+
+/* find_in_cpio.
+ * find a pathname @path in a single cpio archive described by @stream.
+ * Return is the same as check_next_file.
+ */
+int find_in_cpio(char *path, struct gunzip_state *stream)
+{
+	int found;
+	int pathlen = strlen(path) + 1;
+
+	this_archive = 0;
+	do {
+		found = check_next_file(path, pathlen, stream, &this_archive);
+	} while (found == 0);
+
+	return found;
+}
+
+/* find_in_initramfs
+ * Search a initramfs buffer for a given path name.  Returns 0 on
+ * not found, or 1 with @state ready to read the file.
+ *
+ * Note: this returns the first match, not the last.   The kernel
+ * decompressor  effectivly uses the last match.  This code also
+ * doesn't worry about the directories in the path existing.
+ */
+int find_in_initramfs(char *path, char *buf, int len,
+		struct gunzip_state *stream)
+{
+	int found, total = 0;
+	int pathlen = strlen(path) + 1;
+	int *ibuf;
+
+	do {
+		/* get to word boundary, but stop if not NUL */
+		for (; total % 4 && total < len - 4; total++)
+			if (buf[total])
+				break;
+
+		if ((total % 4) == 0) {
+			/* fast forward over NUL words.  */
+			for (ibuf = (int *)&buf[total];
+					total < len - sizeof(*ibuf) && !*ibuf;
+					ibuf++)
+			total += sizeof(*ibuf);
+		}
+
+		/* check remainder of a short archive -- it must all be
+		 * zero as both gzip header and cpio header are bigger
+		 * than this.
+		 */
+		if (total >= len - 4) {
+			for (;total < len; total++) {
+				if (buf[len]) {
+					cpio_error("Junk at end of buffer");
+				}
+			}
+			break;
+		}  else if (total % 4) {
+			/*
+			 * If we are unalinged and not at the end of the buffer
+			 * we must be following a compressed archive.  Only
+			 * NUL and gzip headers are allowed.  We skipped NUL.
+			 */
+			if (!(buf[total] == 0x1b && buf[total + 1] == 0x8b))
+				cpio_error("unalinged junk in buffer");
+		}
+
+		this_buf = buf + total;
+		this_archive = 0;
+
+		gunzip_start(stream, this_buf, len - total);
+
+		do {
+			found = check_next_file(path, pathlen, stream,
+					&this_archive);
+		} while (!found);
+
+		if (found > 0)
+			return found;
+
+		if (stream->s.workspace) {
+			int discard;
+
+			if (found < -1) {
+				cpio_error("Junk in compressed archive");
+			}
+
+			/* we either found EOF or TRAILER!!!.  In the later
+			 * case we need to discard to the end of the gzip
+			 * contents.
+			 */
+			do {
+				discard =  gunzip_partial(stream, name_buf,
+					MAX_PATH);
+				this_archive += discard;
+			} while (discard);
+
+			/*
+			 * Peek at how many input bytes were consumed.
+			 * reset our consumed input.
+			 */
+			total += stream->s.total_in + 8;
+
+			/* clean up zlib */
+			discard = gunzip_finish(stream, name_buf, 0);
+		} else {
+			if (this_archive % 4) {
+				cpio_error("Archive not multiple of 4?");
+			}
+			total += this_archive;
+
+			if (!this_archive) {
+				cpio_error("junk between archives");
+			}
+			/* don't check the < -1 of found, it might be an
+			 * archive.  This will be caught by the !this_archive
+			 * check on the next loop.
+			 */
+		}
+	} while (total < len);
+
+	return 0;
+}
+
+void get_cpio_info(void **archive_start, int *consumed)
+{
+	*archive_start = this_buf;
+	*consumed = this_archive;
+}
+
+int get_cpio_file_mode(void)
+{
+	return cpio_str_to_num(cpio_header_buf.mode);
+}
+
+int get_cpio_file_size(void)
+{
+	return cpio_str_to_num(cpio_header_buf.filesize);
+}
Index: work.git/arch/powerpc/boot/cpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/cpio.h	2007-07-10 04:03:40.000000000 -0500
@@ -0,0 +1,12 @@
+#include "gunzip_util.h"
+
+extern int find_in_cpio(char *path, struct gunzip_state *stream);
+extern int find_in_initramfs(char *path, char *buf, int len,
+		struct gunzip_state *state);
+extern void get_cpio_info(void **archive_start, int *consumed);
+extern int get_cpio_file_size(void);
+extern int get_cpio_file_mode(void);
+
+#define MAX_PATH 256
+
+extern void cpio_error(char *msg);
Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 04:02:24.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 04:03:57.000000000 -0500
@@ -36,13 +36,13 @@ $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
-zliblinuxheader := zlib.h zconf.h zutil.h
+zliblinuxheader := zlib.h zconf.h zutil.h stat.h
 
 $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
 	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		flatdevtree_conv.c marshal.c memranges.c kexec.c \
+		flatdevtree_conv.c marshal.c memranges.c kexec.c cpio.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S rtas.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
