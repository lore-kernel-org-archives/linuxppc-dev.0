Return-Path: <andid@gmx.net>
Received: from mncltd.com (p15112080.pureserver.info [217.160.169.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A21C967A8B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 15:34:42 +1100 (EST)
Message-ID: <4206EFDC.3090904@gmx.net>
Date: Mon, 07 Feb 2005 05:34:36 +0100
From: Andre' Draszik <andid@gmx.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [PATCH][PPC32] mktree fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This one fixes mktree. The image size stored in the header is pretty off without
this patch. (yes, it can make a difference of upto almost 64k)

Signed-off-by: Andre' Draszik <andid@gmx.net>

diff -urN linuxppc-2.5.orig/arch/ppc/boot/utils/mktree.c linuxppc-2.5/arch/ppc/boot/utils/mktree.c
--- linuxppc-2.5.orig/arch/ppc/boot/utils/mktree.c	2005-02-03 20:20:39.000000000 +0100
+++ linuxppc-2.5/arch/ppc/boot/utils/mktree.c	2005-02-06 03:13:27.000000000 +0100
@@ -113,7 +113,8 @@
  		exit(4);
  	}

-	nblks -= (64 * 1024) / IMGBLK;
+	nblks -= (64 * 1024 - sizeof (bt)) / IMGBLK;
+	bt.bb_num_512blocks = htonl(nblks + 1);

  	/* And away we go......
  	*/
@@ -122,7 +123,7 @@
  		exit(5);
  	}

-	while (nblks-- > 0) {
+	while (--nblks > 0) {
  		if (read(in_fd, tmpbuf, IMGBLK) < 0) {
  			perror("zImage read");
  			exit(5);
