Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] fix compile of denx rtai ppc with gcc 3.3.2 
Date: Mon, 22 Mar 2004 14:38:35 +1100
Message-ID: <005a01c40fbf$27f738a0$ee00a8c0@CAT>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005B_01C4101B.5B67B0A0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C4101B.5B67B0A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I had a few problems compiling Denx RTAI for ppc with gcc 3.3.2. Attached
patches seem to fix this - at least the examples run on my MPC5200. Changes
still compile ok on 2.95.4.

For linuxppc_devel patched with
patch-denx-linuxppc_2_4_devel-LABEL_2003_12_22_1500-ltt:

Change formatting of __asm__ in ltt_clear_bit to be similar to ltt_set_bit
to fix compile error.

For rtai-24.1.12-denx.tar.bz2:

Fix clobber list to fix compile error on gcc 3.3.2.

Andrew

------=_NextPart_000_005B_01C4101B.5B67B0A0
Content-Type: application/octet-stream;
	name="rtai-24.1.12-denx.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rtai-24.1.12-denx.patch"

diff -ur rtai-24.1.12.orig/include/asm-ppc/rtai_srq.h =
rtai-24.1.12/include/asm-ppc/rtai_srq.h=0A=
--- rtai-24.1.12.orig/include/asm-ppc/rtai_srq.h	Tue Oct 24 11:32:28 2000=0A=
+++ rtai-24.1.12/include/asm-ppc/rtai_srq.h	Thu Mar 18 14:38:35 2004=0A=
@@ -33,8 +33,7 @@=0A=
 		("trap         \n\t"=0A=
 		: "=3D&r" (__sc_3), "=3D&r" (__sc_4)=0A=
 		: "0"   (__sc_3), "1"   (__sc_4),=0A=
-	          "r"   (__sc_0)=0A=
-		: "r0", "r3", "r4" );=0A=
+	          "r"   (__sc_0));=0A=
 	((unsigned long *)&retval)[0] =3D __sc_3;=0A=
 	((unsigned long *)&retval)[1] =3D __sc_4;=0A=
 	return retval;=0A=

------=_NextPart_000_005B_01C4101B.5B67B0A0
Content-Type: application/octet-stream;
	name="LABEL_2003_12_22_1500-ltt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="LABEL_2003_12_22_1500-ltt.patch"

--- drivers/trace/tracer.h.orig	Fri Mar 19 17:41:14 2004=0A=
+++ drivers/trace/tracer.h	Mon Mar 22 10:03:58 2004=0A=
@@ -176,14 +176,14 @@=0A=
 	unsigned long mask =3D 1 << (24 - (nr & 0x18) + (nr & 0x7));=0A=
 	volatile unsigned long *p =3D ((volatile unsigned long *)addr) + (nr =
>> 5);=0A=
 =0A=
-	__asm__ __volatile__("\n\=0A=
-1:	lwarx	%0,0,%3=0A=
-	andc	%1,%0,%2=0A=
-	stwcx.	%1,0,%3=0A=
-	bne	1b"=0A=
-	: "=3D&r" (old), "=3D&r" (t)	/*, "=3Dm" (*p)*/=0A=
-	: "r" (mask), "r" (p)=0A=
-      /*: "cc"*/);=0A=
+	__asm__ __volatile__(=0A=
+		"1:lwarx	%0,0,%3 \n\t"=0A=
+		"andc	%1,%0,%2 \n\t"=0A=
+		"stwcx.	%1,0,%3 \n\t"=0A=
+		"bne	1b \n\t"=0A=
+		: "=3D&r" (old), "=3D&r" (t)	/*, "=3Dm" (*p)*/=0A=
+		: "r" (mask), "r" (p)=0A=
+      		/*: "cc"*/);=0A=
 =0A=
 	return (old & mask) !=3D 0;=0A=
 }=0A=

------=_NextPart_000_005B_01C4101B.5B67B0A0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
