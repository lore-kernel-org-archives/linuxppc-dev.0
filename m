Date: Wed, 5 Sep 2001 12:06:13 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Dan Malek <dan@mvista.com>, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: patch for mktree.c on cross compiles
Message-ID: <20010905120613.I14548@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not sure how correct this is, but it does get me furthrer
along in doing a cross compile for the 405GP.

I would think everything in arch/ppc/boot/utils should be checked
for endian problems on cross compiles.

This is what is outputed on boot. I don't have a BDM yet so it
is hard to see were things really are wrong.

Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...
loaded at:     00500000 0050A244
relocated to:  00400000 0040A244
board data at: 00407174 004071B4
relocated to:  00200100 00200140
zimage at:     00507067 00584D05
avail ram:     00585000 02000000

Linux/PPC load: root=/dev/nfs rw ip=auto
Uncompressing Linux...done.
Now booting the kernel
----------  progress:  0x200 id mach(): done
----------  progress:  0x111 MMU:enter
----------  progress:  0x300 MMU:hw init
----------  progress:  0x301 MMU:mapin
----------  progress:  0x302 MMU:setio
----------  progress:  0x211 MMU:exit
Linux version 2.4.10-pre4 (amay@infosec-server) (gcc version 2.95.3 20010315 (release/MontaVista)) #4 Wed Sep 5 12:47:36 PDT 2001
----------  progress:  0x3eab setup_arch: enter
----------  progress:  0x3eab setup_arch: bootmem
----------  progress:  0x3eab arch: exit
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw ip=auto

The patch.

--- mktree.c	Wed Sep  5 13:02:11 2001
+++ mktree.c.org	Wed Sep  5 12:43:33 2001
@@ -51,16 +51,16 @@

 	nblks = (st.st_size + IMGBLK) / IMGBLK;

-	bt.bb_magic = htonl(0x0052504F);
+	bt.bb_magic = 0x0052504F;

 	/* We know these from the linker command.
 	 * ...and then move it up into memory a little more so the
 	 * relocation can happen.
 	 */
-	bt.bb_dest = htonl(0x500000);
-        bt.bb_entry_point = htonl(0x500000);
+	bt.bb_dest = 0x500000;
+        bt.bb_entry_point = 0x500000;

-	bt.bb_num_512blocks = htonl(nblks);
+	bt.bb_num_512blocks = nblks;
 	bt.bb_debug_flag = 0;

 	bt.bb_checksum = 0;
@@ -88,17 +88,17 @@
 	/* Assume zImage is an ELF file, and skip the 64K header.
 	*/
 	if (read(in_fd, tmpbuf, IMGBLK) != IMGBLK) {
-		fprintf(stderr, "%s is too small to be an ELF image\n", argv[1]);
+		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
 		exit(4);
 	}

-	if ((*(uint *)tmpbuf) != htonl(0x7f454c46) ) {
-		fprintf(stderr, "%s does not have correct ELF tag\n", argv[1]);
+	if ((*(uint *)tmpbuf) != 0x7f454c46) {
+		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
 		exit(4);
 	}

 	if (lseek(in_fd, (64 * 1024), SEEK_SET) < 0) {
-		fprintf(stderr, "%s failed to seek in ELF image\n", argv[1]);
+		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
 		exit(4);
 	}

@@ -127,7 +127,7 @@

 	/* rewrite the header with the computed checksum.
 	*/
-	bt.bb_checksum = htonl(cksum);
+	bt.bb_checksum = cksum;
 	if (lseek(out_fd, 0, SEEK_SET) < 0) {
 		perror("rewrite seek");
 		exit(1);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
