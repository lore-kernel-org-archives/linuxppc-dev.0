From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Thu, 21 Nov 2002 14:50:50 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: __copy_tofrom_user fails on unaligned read faults
Message-ID: <20021121215050.GD6090@cuzco.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For performance reasons, __copy_tofrom_user copies
data in 16-bytes chunks.  If a read fault occurs in the
middle of one of these chunks, the data which has been
successfully read (up to 15 bytes within the chunk) is
discarded.

Valid data is similarly not copied properly while copying
words and the faulting read address is not word aligned.

Is this a known issue?

While this a rare corner case, I propose that we retry
with byte copies after an unaligned read fault.

I've appended a patch against linuxppc_2_4_devel

-Dale Farnsworth

--- linux/arch/ppc/lib/string.S.orig	2002-11-21 09:26:41.000000000 -0700
+++ linux/arch/ppc/lib/string.S	2002-11-21 11:47:29.000000000 -0700
@@ -512,7 +512,12 @@
 	li	r3,0
 	b	99f
 /* read fault, initial word copy */
-102:	li	r4,0
+102:	andi.	r0,r4,3
+	beq	85f
+/* read fault was not word aligned, retry one byte at a time */
+	li	r3,2
+	b	86f
+85:	li	r4,0
 	b	91f
 /* write fault, initial word copy */
 103:	li	r4,1
@@ -539,15 +544,33 @@
 #endif

 /* read fault in cacheline loop */
-104:	li	r4,0
+104:	addi	r0,r4,4
+	andi.	r0,r0,15
+	beq	87f
+/* read fault was not 16-byte aligned, retry one byte at a time */
+/* number of bytes remaining is r5 + (ctr << r3) */
+86:	mfctr	r0
+	slw	r3,r0,r3
+	add	r3,r3,r5
+	mtctr	r3
+	b	40b
+
+87:	li	r4,0
 	b	92f
+
 /* fault on dcbz (effectively a write fault) */
 /* or write fault in cacheline loop */
 105:	li	r4,1
 92:	li	r3,LG_CACHELINE_BYTES
 	b	99f
 /* read fault in final word loop */
-108:	li	r4,0
+108:	andi.	r0,r4,3
+	beq	88f
+/* read fault was not word aligned, retry one byte at a time */
+	andi.	r5,r5,3
+	li	r3,2
+	b	86b
+88:	li	r4,0
 	b	93f
 /* write fault in final word loop */
 109:	li	r4,1

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
