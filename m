Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id E550DDE114
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 06:28:13 +1100 (EST)
Message-ID: <48F8E737.9090904@consentry.com>
Date: Fri, 17 Oct 2008 12:27:51 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Bug in boot code memcmp with zero length
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I noticed, when trying to use, e.g.,
node = find_node_by_prop_value(prev, "booleanprop", "", 0))
to search for all nodes with a certain boolean property, that memcmp()
returns garbage when comparing zero bytes.  It should return zero.

Index: arch/powerpc/boot/string.S
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 string.S
--- arch/powerpc/boot/string.S	11 Oct 2008 02:51:35 -0000	1.1.1.1
+++ arch/powerpc/boot/string.S	17 Oct 2008 19:11:18 -0000
@@ -235,7 +235,7 @@
 	.globl	memcmp
 memcmp:
 	cmpwi	0,r5,0
-	blelr
+	ble	2f
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
@@ -243,6 +243,8 @@
 	lbzu	r0,1(r4)
 	subf.	r3,r0,r3
 	bdnzt	2,1b
+	blr
+2:	li	r3,0
 	blr
