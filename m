Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABFBF67B7E
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:45 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002e4-Pa
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] rewrite mkprep and mkbugboot in sane C
Message-Id: <E1GQvWX-0002e4-Pa@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ppc/boot/utils/mkbugboot.c |  208 ++++++++------------
 arch/ppc/boot/utils/mkprep.c    |  416 +++++++++++++++++----------------------
 2 files changed, 267 insertions(+), 357 deletions(-)

diff --git a/arch/ppc/boot/utils/mkbugboot.c b/arch/ppc/boot/utils/mkbugboot.c
index 29115e0..1640c41 100644
--- a/arch/ppc/boot/utils/mkbugboot.c
+++ b/arch/ppc/boot/utils/mkbugboot.c
@@ -19,36 +19,13 @@ #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <netinet/in.h>
 #ifdef __sun__
 #include <inttypes.h>
 #else
 #include <stdint.h>
 #endif
 
-#ifdef __i386__
-#define cpu_to_be32(x) le32_to_cpu(x)
-#define cpu_to_be16(x) le16_to_cpu(x)
-#else
-#define cpu_to_be32(x) (x)
-#define cpu_to_be16(x) (x)
-#endif
-
-#define cpu_to_le32(x) le32_to_cpu((x))
-unsigned long le32_to_cpu(unsigned long x)
-{
-     	return (((x & 0x000000ffU) << 24) |
-		((x & 0x0000ff00U) <<  8) |
-		((x & 0x00ff0000U) >>  8) |
-		((x & 0xff000000U) >> 24));
-}
-
-#define cpu_to_le16(x) le16_to_cpu((x))
-unsigned short le16_to_cpu(unsigned short x)
-{
-	return (((x & 0x00ff) << 8) |
-		((x & 0xff00) >> 8));
-}
-
 /* size of read buffer */
 #define SIZE 0x1000
 
@@ -62,124 +39,109 @@ typedef struct bug_boot_header {
 
 #define HEADER_SIZE	sizeof(bug_boot_header_t)
 
-uint32_t copy_image(int32_t in_fd, int32_t out_fd)
+void update_checksum(void *buf, size_t size, uint16_t *sum)
 {
-  uint8_t buf[SIZE];
-  int n;
-  uint32_t image_size = 0;
-  uint8_t zero = 0;
-
-  lseek(in_fd, ELF_HEADER_SIZE, SEEK_SET);
-
-  /* Copy an image while recording its size */
-  while ( (n = read(in_fd, buf, SIZE)) > 0 )
-    {
-    image_size = image_size + n;
-    write(out_fd, buf, n);
-    }
-
-  /* BUG romboot requires that our size is divisible by 2 */
-  /* align image to 2 byte boundary */
-  if (image_size % 2)
-    {
-    image_size++;
-    write(out_fd, &zero, 1);
-    }
-
-  return image_size;
+	uint32_t csum = *sum;
+
+	while (size) {
+		csum += *(uint16_t *)buf;
+		if (csum > 0xffff)
+			csum -= 0xffff;
+		buf = (uint16_t *)buf + 1;
+		size -= 2;
+	}
+	*sum = csum;
 }
 
-void write_bugboot_header(int32_t out_fd, uint32_t boot_size)
+uint32_t copy_image(int in_fd, int out_fd, uint16_t *sum)
 {
-  uint8_t header_block[HEADER_SIZE];
-  bug_boot_header_t *bbh = (bug_boot_header_t *)&header_block[0];
-
-  memset(header_block, 0, HEADER_SIZE);
-
-  /* Fill in the PPCBUG ROM boot header */
-  strncpy(bbh->magic_word, "BOOT", 4);		/* PPCBUG magic word */
-  bbh->entry_offset = cpu_to_be32(HEADER_SIZE);	/* Entry address */
-  bbh->routine_length= cpu_to_be32(HEADER_SIZE+boot_size+2);	/* Routine length */
-  strncpy(bbh->routine_name, "LINUXROM", 8);		/* Routine name   */
-
-  /* Output the header and bootloader to the file */
-  write(out_fd, header_block, HEADER_SIZE);
+	uint8_t buf[SIZE];
+	int offset = 0;
+	int n;
+	uint32_t image_size = 0;
+
+	lseek(in_fd, ELF_HEADER_SIZE, SEEK_SET);
+
+	/* Copy an image while recording its size */
+	while ( (n = read(in_fd, buf + offset, SIZE - offset)) > 0 ) {
+		n += offset;
+		offset = n & 1;
+		n -= offset;
+		image_size = image_size + n;
+		/* who's going to deal with short writes? */
+		write(out_fd, buf, n);
+		update_checksum(buf, n, sum);
+		if (offset)
+			buf[0] = buf[n];
+	}
+
+	/* BUG romboot requires that our size is divisible by 2 */
+	/* align image to 2 byte boundary */
+	if (offset) {
+		image_size += 2;
+		buf[1] = '\0';
+		write(out_fd, buf, 2);
+		update_checksum(buf, 2, sum);
+	}
+	return image_size;
 }
 
-uint16_t calc_checksum(int32_t bug_fd)
+void write_bugboot_header(int out_fd, uint32_t boot_size, uint16_t *sum)
 {
-  uint32_t checksum_var = 0;
-  uint8_t buf[2];
-  int n;
-
-  /* Checksum loop */
-  while ( (n = read(bug_fd, buf, 2) ) )
-  {
-    checksum_var = checksum_var + *(uint16_t *)buf;
-
-    /* If we carry out, mask it and add one to the checksum */
-    if (checksum_var >> 16)
-      checksum_var = (checksum_var & 0x0000ffff) + 1;
-  }
-
-  return checksum_var;
+	static bug_boot_header_t bbh = {
+		.magic_word = "BOOT",
+		.routine_name = "LINUXROM"
+	};
+
+	/* Fill in the PPCBUG ROM boot header */
+	bbh.entry_offset = htonl(HEADER_SIZE);	/* Entry address */
+	bbh.routine_length= htonl(HEADER_SIZE+boot_size+2);	/* Routine length */
+
+	/* Output the header and bootloader to the file */
+	write(out_fd, &bbh, sizeof(bug_boot_header_t));
+	update_checksum(&bbh, sizeof(bug_boot_header_t), sum);
 }
 
 int main(int argc, char *argv[])
 {
-  int32_t image_fd, bugboot_fd;
-  int argptr = 1;
-  uint32_t kernel_size = 0;
-  uint16_t checksum = 0;
-  uint8_t bugbootname[256];
-
-  if ( (argc != 3) )
-  {
-    fprintf(stderr, "usage: %s <kernel_image> <bugboot>\n",argv[0]);
-    exit(-1);
-  }
-
-  /* Get file args */
-
-  /* kernel image file */
-    if ((image_fd = open( argv[argptr] , 0)) < 0)
-      exit(-1);
-  argptr++;
+	int image_fd, bugboot_fd;
+	uint32_t kernel_size = 0;
+	uint16_t checksum = 0;
 
-  /* bugboot file */
-  if ( !strcmp( argv[argptr], "-" ) )
-    bugboot_fd = 1;			/* stdout */
-  else
-    if ((bugboot_fd = creat( argv[argptr] , 0755)) < 0)
-      exit(-1);
-    else
-      strcpy(bugbootname, argv[argptr]);
-  argptr++;
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <kernel_image> <bugboot>\n",argv[0]);
+		exit(-1);
+	}
 
-  /* Set file position after ROM header block where zImage will be written */
-  lseek(bugboot_fd, HEADER_SIZE, SEEK_SET);
+	/* Get file args */
 
-  /* Copy kernel image into bugboot image */
-  kernel_size = copy_image(image_fd, bugboot_fd);
-  close(image_fd);
+	/* kernel image file */
+	if ((image_fd = open(argv[1] , 0)) < 0)
+		exit(-1);
 
-  /* Set file position to beginning where header/romboot will be written */
-  lseek(bugboot_fd, 0, SEEK_SET);
+	/* bugboot file */
+	if (!strcmp(argv[2], "-"))
+		bugboot_fd = 1;			/* stdout */
+	else if ((bugboot_fd = creat(argv[2] , 0755)) < 0)
+		exit(-1);
 
-  /* Write out BUG header/romboot */
-  write_bugboot_header(bugboot_fd, kernel_size);
+	/* Set file position after ROM header block where zImage will be written */
+	lseek(bugboot_fd, HEADER_SIZE, SEEK_SET);
 
-  /* Close bugboot file */
-  close(bugboot_fd);
+	/* Copy kernel image into bugboot image */
+	kernel_size = copy_image(image_fd, bugboot_fd, &checksum);
 
-  /* Reopen it as read/write */
-  bugboot_fd = open(bugbootname, O_RDWR);
+	/* Set file position to beginning where header/romboot will be written */
+	lseek(bugboot_fd, 0, SEEK_SET);
 
-  /* Calculate checksum */
-  checksum = calc_checksum(bugboot_fd);
+	/* Write out BUG header/romboot */
+	write_bugboot_header(bugboot_fd, kernel_size, &checksum);
 
-  /* Write out the calculated checksum */
-  write(bugboot_fd, &checksum, 2);
+	/* Write out the calculated checksum */
+	lseek(bugboot_fd, 0, SEEK_END);
+	write(bugboot_fd, &checksum, 2);
 
-  return 0;
+	/* Close bugboot file */
+	close(bugboot_fd);
+	return 0;
 }
diff --git a/arch/ppc/boot/utils/mkprep.c b/arch/ppc/boot/utils/mkprep.c
index f6d5a2f..192bb39 100644
--- a/arch/ppc/boot/utils/mkprep.c
+++ b/arch/ppc/boot/utils/mkprep.c
@@ -15,279 +15,227 @@
  * Modified for Sparc hosted builds by Peter Wahl <PeterWahl@web.de>
  */
 
-#include <fcntl.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
-#include <strings.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#define cpu_to_le32(x) le32_to_cpu((x))
-unsigned long le32_to_cpu(unsigned long x)
-{
-     	return (((x & 0x000000ffU) << 24) |
-		((x & 0x0000ff00U) <<  8) |
-		((x & 0x00ff0000U) >>  8) |
-		((x & 0xff000000U) >> 24));
-}
-
-
-#define cpu_to_le16(x) le16_to_cpu((x))
-unsigned short le16_to_cpu(unsigned short x)
-{
-	return (((x & 0x00ff) << 8) |
-		((x & 0xff00) >> 8));
-}
-
-#define cpu_to_be32(x) (x)
-#define be32_to_cpu(x) (x)
-#define cpu_to_be16(x) (x)
-#define be16_to_cpu(x) (x)
+#include <stdlib.h>
 
 /* size of read buffer */
 #define SIZE 0x1000
 
-
-typedef unsigned long dword_t;
-typedef unsigned short word_t;
-typedef unsigned char byte_t;
-typedef byte_t block_t[512];
-typedef byte_t page_t[4096];
-
-
 /*
  * Partition table entry
  *  - from the PReP spec
  */
 typedef struct partition_entry {
-  byte_t	boot_indicator;
-  byte_t	starting_head;
-  byte_t	starting_sector;
-  byte_t	starting_cylinder;
-
-  byte_t	system_indicator;
-  byte_t	ending_head;
-  byte_t	ending_sector;
-  byte_t	ending_cylinder;
-
-  dword_t	beginning_sector;
-  dword_t	number_of_sectors;
+	unsigned char boot_indicator;
+	unsigned char starting_head;
+	unsigned char starting_sector;
+	unsigned char starting_cylinder;
+
+	unsigned char system_indicator;
+	unsigned char ending_head;
+	unsigned char ending_sector;
+	unsigned char ending_cylinder;
+
+	unsigned char beginning_sector[4];
+	unsigned char number_of_sectors[4];
 } partition_entry_t;
 
 #define BootActive	0x80
 #define SystemPrep	0x41
 
-void copy_image(int , int);
-void write_prep_partition(int , int );
-void write_asm_data( int in, int out );
+void copy_image(FILE *, FILE *);
+void write_prep_partition(FILE *, FILE *);
+void write_asm_data(FILE *, FILE *);
 
 unsigned int elfhdr_size = 65536;
 
 int main(int argc, char *argv[])
 {
-  int in_fd, out_fd;
-  int argptr = 1;
-  unsigned int prep = 0;
-  unsigned int asmoutput = 0;
-
-  if ( (argc < 3) || (argc > 4) )
-  {
-    fprintf(stderr, "usage: %s [-pbp] [-asm] <boot-file> <image>\n",argv[0]);
-    exit(-1);
-  }
-
-  /* needs to handle args more elegantly -- but this is a small/simple program */
-
-  /* check for -pbp */
-  if ( !strcmp( argv[argptr], "-pbp" ) )
-  {
-    prep = 1;
-    argptr++;
-  }
-
-  /* check for -asm */
-  if ( !strcmp( argv[argptr], "-asm" ) )
-  {
-    asmoutput = 1;
-    argptr++;
-  }
-
-  /* input file */
-  if ( !strcmp( argv[argptr], "-" ) )
-    in_fd = 0;			/* stdin */
-  else
-    if ((in_fd = open( argv[argptr] , 0)) < 0)
-      exit(-1);
-  argptr++;
-
-  /* output file */
-  if ( !strcmp( argv[argptr], "-" ) )
-    out_fd = 1;			/* stdout */
-  else
-    if ((out_fd = creat( argv[argptr] , 0755)) < 0)
-      exit(-1);
-  argptr++;
-
-  /* skip elf header in input file */
-  /*if ( !prep )*/
-  lseek(in_fd, elfhdr_size, SEEK_SET);
-
-  /* write prep partition if necessary */
-  if ( prep )
-	  write_prep_partition( in_fd, out_fd );
-
-  /* write input image to bootimage */
-  if ( asmoutput )
-	  write_asm_data( in_fd, out_fd );
-  else
-	  copy_image(in_fd, out_fd);
-
-  return 0;
+	FILE *in, *out;
+	int argptr = 1;
+	int prep = 0;
+	int asmoutput = 0;
+
+	if (argc < 3 || argc > 4) {
+		fprintf(stderr, "usage: %s [-pbp] [-asm] <boot-file> <image>\n",
+			argv[0]);
+		exit(-1);
+	}
+
+/* needs to handle args more elegantly -- but this is a small/simple program */
+
+	/* check for -pbp */
+	if (!strcmp(argv[argptr], "-pbp")) {
+		prep = 1;
+		argptr++;
+	}
+
+	/* check for -asm */
+	if (!strcmp(argv[argptr], "-asm")) {
+		asmoutput = 1;
+		argptr++;
+	}
+
+	/* input file */
+	if (!strcmp(argv[argptr], "-"))
+		in = stdin;
+	else if (!(in = fopen(argv[argptr], "r")))
+		exit(-1);
+	argptr++;
+
+	/* output file */
+	if (!strcmp(argv[argptr], "-"))
+		out = stdout;
+	else if (!(out = fopen(argv[argptr], "w")))
+		exit(-1);
+	argptr++;
+
+	/* skip elf header in input file */
+	/*if ( !prep )*/
+	fseek(in, elfhdr_size, SEEK_SET);
+
+	/* write prep partition if necessary */
+	if (prep)
+		write_prep_partition(in, out);
+
+	/* write input image to bootimage */
+	if (asmoutput)
+		write_asm_data(in, out);
+	else
+		copy_image(in, out);
+
+	return 0;
 }
 
-void write_prep_partition(int in, int out)
+void store_le32(unsigned int v, unsigned char *p)
 {
-  unsigned char block[512];
-  partition_entry_t pe;
-  dword_t *entry  = (dword_t *)&block[0];
-  dword_t *length = (dword_t *)&block[sizeof(long)];
-  struct stat info;
-
-  if (fstat(in, &info) < 0)
-  {
-    fprintf(stderr,"info failed\n");
-    exit(-1);
-  }
-
-  bzero( block, sizeof block );
-
-  /* set entry point and boot image size skipping over elf header */
-#ifdef __i386__
-  *entry = 0x400/*+65536*/;
-  *length = info.st_size-elfhdr_size+0x400;
-#else
-  *entry = cpu_to_le32(0x400/*+65536*/);
-  *length = cpu_to_le32(info.st_size-elfhdr_size+0x400);
-#endif /* __i386__ */
-
-  /* sets magic number for msdos partition (used by linux) */
-  block[510] = 0x55;
-  block[511] = 0xAA;
-
-  /*
-   * Build a "PReP" partition table entry in the boot record
-   *  - "PReP" may only look at the system_indicator
-   */
-  pe.boot_indicator   = BootActive;
-  pe.system_indicator = SystemPrep;
-  /*
-   * The first block of the diskette is used by this "boot record" which
-   * actually contains the partition table. (The first block of the
-   * partition contains the boot image, but I digress...)  We'll set up
-   * one partition on the diskette and it shall contain the rest of the
-   * diskette.
-   */
-  pe.starting_head     = 0;	/* zero-based			     */
-  pe.starting_sector   = 2;	/* one-based			     */
-  pe.starting_cylinder = 0;	/* zero-based			     */
-  pe.ending_head       = 1;	/* assumes two heads		     */
-  pe.ending_sector     = 18;	/* assumes 18 sectors/track	     */
-  pe.ending_cylinder   = 79;	/* assumes 80 cylinders/diskette     */
-
-  /*
-   * The "PReP" software ignores the above fields and just looks at
-   * the next two.
-   *   - size of the diskette is (assumed to be)
-   *     (2 tracks/cylinder)(18 sectors/tracks)(80 cylinders/diskette)
-   *   - unlike the above sector numbers, the beginning sector is zero-based!
-   */
+	p[0] = v;
+	p[1] = v >>= 8;
+	p[2] = v >>= 8;
+	p[3] = v >> 8;
+}
+
+void write_prep_partition(FILE *in, FILE *out)
+{
+	unsigned char block[512];
+	partition_entry_t pe;
+	unsigned char *entry  = block;
+	unsigned char *length = block + 4;
+	long pos = ftell(in), size;
+
+	if (fseek(in, 0, SEEK_END) < 0) {
+		fprintf(stderr,"info failed\n");
+		exit(-1);
+	}
+	size = ftell(in);
+	if (fseek(in, pos, SEEK_SET) < 0) {
+		fprintf(stderr,"info failed\n");
+		exit(-1);
+	}
+
+	memset(block, '\0', sizeof(block));
+
+	/* set entry point and boot image size skipping over elf header */
+	store_le32(0x400/*+65536*/, entry);
+	store_le32(size-elfhdr_size+0x400, length);
+
+	/* sets magic number for msdos partition (used by linux) */
+	block[510] = 0x55;
+	block[511] = 0xAA;
+
+	/*
+	* Build a "PReP" partition table entry in the boot record
+	*  - "PReP" may only look at the system_indicator
+	*/
+	pe.boot_indicator   = BootActive;
+	pe.system_indicator = SystemPrep;
+	/*
+	* The first block of the diskette is used by this "boot record" which
+	* actually contains the partition table. (The first block of the
+	* partition contains the boot image, but I digress...)  We'll set up
+	* one partition on the diskette and it shall contain the rest of the
+	* diskette.
+	*/
+	pe.starting_head     = 0;	/* zero-based			     */
+	pe.starting_sector   = 2;	/* one-based			     */
+	pe.starting_cylinder = 0;	/* zero-based			     */
+	pe.ending_head       = 1;	/* assumes two heads		     */
+	pe.ending_sector     = 18;	/* assumes 18 sectors/track	     */
+	pe.ending_cylinder   = 79;	/* assumes 80 cylinders/diskette     */
+
+	/*
+	* The "PReP" software ignores the above fields and just looks at
+	* the next two.
+	*   - size of the diskette is (assumed to be)
+	*     (2 tracks/cylinder)(18 sectors/tracks)(80 cylinders/diskette)
+	*   - unlike the above sector numbers, the beginning sector is zero-based!
+	*/
 #if 0
-  pe.beginning_sector  = cpu_to_le32(1);
-#else
-  /* This has to be 0 on the PowerStack? */
-#ifdef __i386__
-  pe.beginning_sector  = 0;
+	store_le32(1, pe.beginning_sector);
 #else
-  pe.beginning_sector  = cpu_to_le32(0);
-#endif /* __i386__ */
+	/* This has to be 0 on the PowerStack? */
+	store_le32(0, pe.beginning_sector);
 #endif
 
-#ifdef __i386__
-  pe.number_of_sectors = 2*18*80-1;
-#else
-  pe.number_of_sectors = cpu_to_le32(2*18*80-1);
-#endif /* __i386__ */
+	store_le32(2*18*80-1, pe.number_of_sectors);
 
-  memcpy(&block[0x1BE], &pe, sizeof(pe));
+	memcpy(&block[0x1BE], &pe, sizeof(pe));
 
-  write( out, block, sizeof(block) );
-  write( out, entry, sizeof(*entry) );
-  write( out, length, sizeof(*length) );
-  /* set file position to 2nd sector where image will be written */
-  lseek( out, 0x400, SEEK_SET );
+	fwrite(block, sizeof(block), 1, out);
+	fwrite(entry, 4, 1, out);
+	fwrite(length, 4, 1, out);
+	/* set file position to 2nd sector where image will be written */
+	fseek( out, 0x400, SEEK_SET );
 }
 
 
 
-void
-copy_image(int in, int out)
+void copy_image(FILE *in, FILE *out)
 {
-  char buf[SIZE];
-  int n;
+	char buf[SIZE];
+	int n;
 
-  while ( (n = read(in, buf, SIZE)) > 0 )
-    write(out, buf, n);
+	while ( (n = fread(buf, 1, SIZE, in)) > 0 )
+		fwrite(buf, 1, n, out);
 }
 
 
 void
-write_asm_data( int in, int out )
+write_asm_data(FILE *in, FILE *out)
 {
-  int i, cnt, pos, len;
-  unsigned int cksum, val;
-  unsigned char *lp;
-  unsigned char buf[SIZE];
-  unsigned char str[256];
-
-  write( out, "\t.data\n\t.globl input_data\ninput_data:\n",
-	 strlen( "\t.data\n\t.globl input_data\ninput_data:\n" ) );
-  pos = 0;
-  cksum = 0;
-  while ((len = read(in, buf, sizeof(buf))) > 0)
-  {
-    cnt = 0;
-    lp = (unsigned char *)buf;
-    len = (len + 3) & ~3;  /* Round up to longwords */
-    for (i = 0;  i < len;  i += 4)
-    {
-      if (cnt == 0)
-      {
-	write( out, "\t.long\t", strlen( "\t.long\t" ) );
-      }
-      sprintf( str, "0x%02X%02X%02X%02X", lp[0], lp[1], lp[2], lp[3]);
-      write( out, str, strlen(str) );
-      val = *(unsigned long *)lp;
-      cksum ^= val;
-      lp += 4;
-      if (++cnt == 4)
-      {
-	cnt = 0;
-	sprintf( str, " # %x \n", pos+i-12);
-	write( out, str, strlen(str) );
-      } else
-      {
-	write( out, ",", 1 );
-      }
-    }
-    if (cnt)
-    {
-      write( out, "0\n", 2 );
-    }
-    pos += len;
-  }
-  sprintf(str, "\t.globl input_len\ninput_len:\t.long\t0x%x\n", pos);
-  write( out, str, strlen(str) );
-
-  fprintf(stderr, "cksum = %x\n", cksum);
+	int i, cnt, pos = 0;
+	unsigned int cksum = 0, val;
+	unsigned char *lp;
+	unsigned char buf[SIZE];
+	size_t len;
+
+	fputs("\t.data\n\t.globl input_data\ninput_data:\n", out);
+	while ((len = fread(buf, 1, sizeof(buf), in)) > 0) {
+		cnt = 0;
+		lp = buf;
+		/* Round up to longwords */
+		while (len & 3)
+			buf[len++] = '\0';
+		for (i = 0;  i < len;  i += 4) {
+			if (cnt == 0)
+				fputs("\t.long\t", out);
+			fprintf(out, "0x%02X%02X%02X%02X",
+				lp[0], lp[1], lp[2], lp[3]);
+			val = *(unsigned long *)lp;
+			cksum ^= val;
+			lp += 4;
+			if (++cnt == 4) {
+				cnt = 0;
+				fprintf(out, " # %x \n", pos+i-12);
+			} else {
+				fputs(",", out);
+			}
+		}
+		if (cnt)
+			fputs("0\n", out);
+		pos += len;
+	}
+	fprintf(out, "\t.globl input_len\ninput_len:\t.long\t0x%x\n", pos);
+	fprintf(stderr, "cksum = %x\n", cksum);
 }
-- 
1.4.2.GIT
