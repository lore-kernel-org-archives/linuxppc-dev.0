Message-ID: <3D6C685B.2040403@embeddededge.com>
Date: Wed, 28 Aug 2002 02:06:19 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260/8xx Embedded Boot patch
References: <NCBBIINEHIPFGJPLBEIFAEEKDLAA.acurtis@onz.com>
Content-Type: multipart/mixed;
 boundary="------------090707060108090001000700"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090707060108090001000700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Allen Curtis wrote:

> I am using a modified EST8260 configuration. However the EST8260 embedded
> stuff was broke.

So, if you have an EST configuration that passes a bd pointer from the
boot rom in r3, the attached patch should be all that is necessary, correct?

I'll just check it in right from my tree if it is what you need.  The
part inside the '#if 0' to hardcode the values still needs to be fixed if
someone actually uses that.  In fact, I'll just fix it and push out the
change since it will work on all boards depending upon what you want.

Thanks.


	-- Dan

--------------090707060108090001000700
Content-Type: text/plain;
 name="estembed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="estembed.patch"

diff -aru devel_old/arch/ppc/boot/simple/embed_config.c linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c
--- devel_old/arch/ppc/boot/simple/embed_config.c	Wed Aug 28 00:59:37 2002
+++ linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c	Wed Aug 28 01:01:04 2002
@@ -465,6 +465,8 @@
 	bd->bi_brgfreq *= 1000000;
 #endif

+	clk_8260(bd);
+
 	cp = (u_char *)def_enet_addr;
 	for (i=0; i<6; i++) {
 		bd->bi_enetaddr[i] = *cp++;
diff -aru devel_old/arch/ppc/boot/simple/head.S linuxppc_2_4_devel/arch/ppc/boot/simple/head.S
--- devel_old/arch/ppc/boot/simple/head.S	Wed Aug 28 00:59:37 2002
+++ linuxppc_2_4_devel/arch/ppc/boot/simple/head.S	Wed Aug 28 01:00:12 2002
@@ -59,7 +59,7 @@
 	isync
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6)
+#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || defined(CONFIG_EST8260)
 	mr	r29,r3	/* On the MBX860, r3 is the board info pointer.
 			 * On the RPXSUPER, r3 points to the
 			 * NVRAM configuration keys.
@@ -103,7 +103,7 @@
 	mr	r3, r29
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6)
+#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || defined(CONFIG_EST8260)
 	mr	r4,r29	/* put the board info pointer where the relocate
 			 * routine will find it
 			 */

--------------090707060108090001000700--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
