Date: Mon, 31 Jan 2000 19:12:00 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch for zsrec.c
Message-ID: <Pine.LNX.4.21.0001311844030.17383-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

File ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/zsrec.c has a bug.
It uses an S9 closing record, but specifies 3 address bytes instead of 2
required by the standard.

RPX/Lite boards report checksum error on such records, which is not good
either, but the real bug is zsrec.c

Since data are represented by S3 records with 4-byte addresses, the safest
way to fix it would be to use S7 records that also use 4-byte addresses.
It is also possible to use 0x200000 as the starting address, so that the
"t" command in the boot prompt works!

The sentence about buggy RPX boards should be removed from
getting_started.rpx

This is my patch

=== cut here ===
--- zsrec.c	Mon Jan 31 10:57:19 2000
+++ zsrec.c	Mon Jan 31 18:41:55 2000
@@ -69,7 +69,7 @@
 		lev1();
 	if (l1total)
 		lev1();
-	printf("S904000000FB\n");
+	printf("S70500200000DA\n");
 }

 lev1()
=== cut here ===

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
