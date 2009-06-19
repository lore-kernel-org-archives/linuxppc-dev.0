Return-Path: <sonny@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 14EEAB72BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 11:14:42 +1000 (EST)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91850DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 11:14:41 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5J1DBcR026499
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 19:13:11 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J1EbJu252376
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 19:14:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J1Ea1U000305
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 19:14:36 -0600
Date: Thu, 18 Jun 2009 20:14:36 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] BSR: add 4096 byte BSR size
Message-ID: <20090619011436.GG31192@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sonnyrao@us.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a 4096 byte BSR size which will be used on new machines.  Also, remove
the warning when we run into an unknown size, as this can spam the kernel
log excessively.

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>

Index: linux-2.6.27/drivers/char/bsr.c
===================================================================
--- linux-2.6.27.orig/drivers/char/bsr.c	2009-06-18 17:50:41.000000000 -0500
+++ linux-2.6.27/drivers/char/bsr.c	2009-06-18 17:50:58.000000000 -0500
@@ -76,12 +76,13 @@
 static int bsr_major;
 
 enum {
-	BSR_8   = 0,
-	BSR_16  = 1,
-	BSR_64  = 2,
-	BSR_128 = 3,
-	BSR_UNKNOWN = 4,
-	BSR_MAX = 5,
+	BSR_8    = 0,
+	BSR_16   = 1,
+	BSR_64   = 2,
+	BSR_128  = 3,
+	BSR_4096 = 4,
+	BSR_UNKNOWN = 5,
+	BSR_MAX  = 6,
 };
 
 static unsigned bsr_types[BSR_MAX];
@@ -231,9 +232,11 @@
 		case 128:
 			cur->bsr_type = BSR_128;
 			break;
+		case 4096:
+			cur->bsr_type = BSR_4096;
+			break;
 		default:
 			cur->bsr_type = BSR_UNKNOWN;
-			printk(KERN_INFO "unknown BSR size %d\n",cur->bsr_bytes);
 		}
 
 		cur->bsr_num = bsr_types[cur->bsr_type];
