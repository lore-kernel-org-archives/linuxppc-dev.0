From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Mon, 25 Nov 2002 11:30:05 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
Message-ID: <20021125183005.GG6090@cuzco.az.mvista.com>
References: <20021121215050.GD6090@cuzco.az.mvista.com> <3DDD5924.3030506@embeddededge.com> <20021121221241.GE6090@cuzco.az.mvista.com> <3DDD5DE9.4030404@embeddededge.com> <20021121231855.GF6090@cuzco.az.mvista.com> <15838.54248.574661.759367@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15838.54248.574661.759367@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 23, 2002 at 12:03:36PM +1100, Paul Mackerras wrote:
> Could you try this patch, please?

Your patch worked fine after I moved the read/write flag from r4 to r9.
Here's the resultant patch.  I'm happy with it.

-Dale


diff -u linuxppc_2_4_devel/arch/ppc/lib/string.S hxeb100/arch/ppc/lib/string.S
--- linuxppc_2_4_devel/arch/ppc/lib/string.S	2002-11-25 10:38:45.000000000 -0700
+++ hxeb100/arch/ppc/lib/string.S	2002-11-25 09:32:00.000000000 -0700
@@ -504,18 +504,18 @@
 	blr

 /* read fault, initial single-byte copy */
-100:	li	r4,0
+100:	li	r9,0
 	b	90f
 /* write fault, initial single-byte copy */
-101:	li	r4,1
+101:	li	r9,1
 90:	subf	r5,r8,r5
 	li	r3,0
 	b	99f
 /* read fault, initial word copy */
-102:	li	r4,0
+102:	li	r9,0
 	b	91f
 /* write fault, initial word copy */
-103:	li	r4,1
+103:	li	r9,1
 91:	li	r3,2
 	b	99f

@@ -539,38 +539,47 @@
 #endif

 /* read fault in cacheline loop */
-104:	li	r4,0
+104:	li	r9,0
 	b	92f
 /* fault on dcbz (effectively a write fault) */
 /* or write fault in cacheline loop */
-105:	li	r4,1
+105:	li	r9,1
 92:	li	r3,LG_CACHELINE_BYTES
 	b	99f
 /* read fault in final word loop */
-108:	li	r4,0
+108:	li	r9,0
 	b	93f
 /* write fault in final word loop */
-109:	li	r4,1
+109:	li	r9,1
 93:	andi.	r5,r5,3
 	li	r3,2
 	b	99f
 /* read fault in final byte loop */
-110:	li	r4,0
+110:	li	r9,0
 	b	94f
 /* write fault in final byte loop */
-111:	li	r4,1
+111:	li	r9,1
 94:	li	r5,0
 	li	r3,0
 /*
  * At this stage the number of bytes not copied is
- * r5 + (ctr << r3), and r4 is 0 for read or 1 for write.
+ * r5 + (ctr << r3), and r9 is 0 for read or 1 for write.
  */
 99:	mfctr	r0
 	slw	r3,r0,r3
-	add	r3,r3,r5
-	cmpwi	0,r4,0
+	add.	r3,r3,r5
+	beq	120f			/* shouldn't happen */
+	cmpwi	0,r9,0
 	bne	120f
-/* for read fault, clear out the destination: r3 bytes starting at 4(r6) */
+/* for a read fault, first try to continue the copy one byte at a time */
+	mtctr	r3
+130:	lbz	r0,4(r4)
+131:	stb	r0,4(r6)
+	addi	r4,r4,1
+	addi	r6,r6,1
+	bdnz	130b
+/* then clear out the destination: r3 bytes starting at 4(r6) */
+132:	mfctr	r3
 	srwi.	r0,r3,2
 	li	r9,0
 	mtctr	r0
@@ -591,6 +600,8 @@
 	.long	31b,109b
 	.long	40b,110b
 	.long	41b,111b
+	.long	130b,132b
+	.long	131b,120b
 	.long	112b,120b
 	.long	114b,120b
 	.text

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
