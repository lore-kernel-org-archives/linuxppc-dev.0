Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0653BDDF0C
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2007 22:33:18 +1000 (EST)
Date: Mon, 2 Apr 2007 14:33:27 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix modalias content in sysfs for macio devices
Message-ID: <20070402123327.GA11394@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Currently the buf pointer is advanced too far during each iteration.
Also terminate the string with a newline.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/macio_sysfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/macintosh/macio_sysfs.c
===================================================================
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -53,12 +53,14 @@ static ssize_t modalias_show (struct dev
 	buf += length;
 	while (cplen > 0) {
 		int l;
-		length += sprintf (buf, "C%s", compat);
-		buf += length;
+		l = sprintf (buf, "C%s", compat);
+		length += l;
+		buf += l;
 		l = strlen (compat) + 1;
 		compat += l;
 		cplen -= l;
 	}
+	length += sprintf(buf, "\n");
 
 	return length;
 }
