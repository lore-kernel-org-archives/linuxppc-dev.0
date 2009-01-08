Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 18F03476AD
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:14:48 +1100 (EST)
Subject: [PATCH 2/4] hvc_console: use kzalloc
From: Milton Miller <miltonm@bga.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Benjiman Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <hvc-console-29-3-2@bga.com>
In-Reply-To: : <hvc-console-29-3@bga.com>
Date: Thu, 08 Jan 2009 06:14:28 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joe Peterson <joe@skyrush.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace kmalloc + memset  with kzalloc.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/drivers/char/hvc_console.c
===================================================================
--- work.git.orig/drivers/char/hvc_console.c	2009-01-08 04:24:10.000000000 -0600
+++ work.git/drivers/char/hvc_console.c	2009-01-08 04:24:35.000000000 -0600
@@ -765,13 +765,11 @@ struct hvc_struct __devinit *hvc_alloc(u
 			return ERR_PTR(err);
 	}
 
-	hp = kmalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
+	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
 			GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
-	memset(hp, 0x00, sizeof(*hp));
-
 	hp->vtermno = vtermno;
 	hp->data = data;
 	hp->ops = ops;
