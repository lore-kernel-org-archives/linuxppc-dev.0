From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15838.54248.574661.759367@argo.ozlabs.ibm.com>
Date: Sat, 23 Nov 2002 12:03:36 +1100
To: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
In-Reply-To: <20021121231855.GF6090@cuzco.az.mvista.com>
References: <20021121215050.GD6090@cuzco.az.mvista.com>
	<3DDD5924.3030506@embeddededge.com>
	<20021121221241.GE6090@cuzco.az.mvista.com>
	<3DDD5DE9.4030404@embeddededge.com>
	<20021121231855.GF6090@cuzco.az.mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth writes:

> copy_from_user is supposed to transfer as much data as is
> valid and then to return the number of bytes not tranferred.
> That's how it works on x86.  On ppc it can be as much as 15
> bytes short.
>
> I initially saw the problem with the mount system call.  Here's
> a partial strace:

I've always disliked the way that the mount system call does that.
However, we just have to deal with it, I guess.

IMO you are right in thinking that we need to try to copy bytes one at
a time after we get a read fault.  I think I would do the extra byte
copy loop inline after the 99: label instead of jumping back the way
you do.  Could you try this patch, please?

Paul.

diff -urN linuxppc_2_4_devel/arch/ppc/lib/string.S pmac/arch/ppc/lib/string.S
--- linuxppc_2_4_devel/arch/ppc/lib/string.S	2002-08-13 21:52:53.000000000 +1000
+++ pmac/arch/ppc/lib/string.S	2002-11-23 12:01:31.000000000 +1100
@@ -567,10 +567,19 @@
  */
 99:	mfctr	r0
 	slw	r3,r0,r3
-	add	r3,r3,r5
+	add.	r3,r3,r5
+	beq	120f			/* shouldn't happen */
 	cmpwi	0,r4,0
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
