Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA81EDDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 00:21:04 +1100 (EST)
Date: Thu, 4 Jan 2007 14:20:53 +0100
From: Olaf Hering <olh@suse.de>
To: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix logic error in AIX detection
Message-ID: <20070104132053.GA24903@suse.de>
References: <20061206211630.GB27857@krispykreme>
	<20061206222213.GA17446@localhost.localdomain>
	<20070104084049.GA19959@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070104084049.GA19959@suse.de>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Correct the AIX magic check to let 'echo > /dev/sdb' actually work.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/msdos.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.20-rc3/fs/partitions/msdos.c
===================================================================
--- linux-2.6.20-rc3.orig/fs/partitions/msdos.c
+++ linux-2.6.20-rc3/fs/partitions/msdos.c
@@ -68,10 +68,10 @@ static int aix_magic_present(unsigned ch
 	unsigned char *d;
 	int slot, ret = 0;
 
-	if (p[0] != AIX_LABEL_MAGIC1 &&
-		p[1] != AIX_LABEL_MAGIC2 &&
-		p[2] != AIX_LABEL_MAGIC3 &&
-		p[3] != AIX_LABEL_MAGIC4)
+	if (!(p[0] == AIX_LABEL_MAGIC1 &&
+		p[1] == AIX_LABEL_MAGIC2 &&
+		p[2] == AIX_LABEL_MAGIC3 &&
+		p[3] == AIX_LABEL_MAGIC4))
 		return 0;
 	/* Assume the partition table is valid if Linux partitions exists */
 	for (slot = 1; slot <= 4; slot++, pt++) {
