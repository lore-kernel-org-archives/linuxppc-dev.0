From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 3 Apr 2003 13:08:52 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: [TRIVIAL PATCH] linuxppc_2_4_devel: boot/common/misc-simple.c
Message-ID: <20030403200852.GA3137@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Declare decompress_kernel to avoid compiler warnings about type mismatches.

Thanks,
-Dale

===== arch/ppc/boot/common/misc-simple.c 1.13 vs edited =====
--- 1.13/arch/ppc/boot/common/misc-simple.c	Thu Mar 27 02:24:15 2003
+++ edited/arch/ppc/boot/common/misc-simple.c	Thu Apr  3 12:57:39 2003
@@ -78,6 +78,8 @@
 extern void serial_close(unsigned long com_port);
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void serial_fixups(void);
+struct bi_record *decompress_kernel(unsigned long load_addr, int num_words,
+		unsigned long cksum, void *bp);

 /* Allow decompress_kernel to be hooked into.  This is the default. */
 void * __attribute__ ((weak))
@@ -88,7 +90,8 @@
 }

 struct bi_record *
-decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
+decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
+		void *bp)
 {
 #ifdef INTERACTIVE_CONSOLE
 	int timer = 0;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
