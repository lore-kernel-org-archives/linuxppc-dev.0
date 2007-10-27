Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id DCF8FDDE2F
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 19:38:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: akpm@linux-foundation.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] compat_ioctl: fix block device compat ioctl regression
Date: Sat, 27 Oct 2007 11:38:05 +0200
References: <47221F91.60401@overt.org> <200710270051.38748.arnd@arndb.de>
	<47228A9E.80505@overt.org>
In-Reply-To: <47228A9E.80505@overt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710271138.06456.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Philip Langdale <philipl@overt.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Philip Langdale <philipl@overt.org>
The conversion of handlers to compat_blkdev_ioctl accidentally
disabled handling of most ioctl numbers on block devices because
of a typo. Fix the one line to enable it all again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Mea Culpa. This should have been found by my testing, as it's clear
that most of my big patch never worked at all. Sorry for causing
problems for everyone involved here.

I'm attributing the patch to Philip, as he's the one who pointed
out to me what the fix is.

	Arnd <><

--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -581,7 +581,7 @@ static int compat_blkdev_driver_ioctl(struct inode *inode, struct file *file,
 {
 	int ret;
 
-	switch (arg) {
+	switch (cmd) {
 	case HDIO_GET_UNMASKINTR:
 	case HDIO_GET_MULTCOUNT:
 	case HDIO_GET_KEEPSETTINGS:
