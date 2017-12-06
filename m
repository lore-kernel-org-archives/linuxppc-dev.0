Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysWf52g5FzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 08:17:16 +1100 (AEDT)
Subject: [PATCH 1/3] tty/serial/ucc_uart: Delete an error message for a failed
 memory allocation in ucc_uart_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, Timur Tabi <timur@tabi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Message-ID: <f67ae4e0-2f64-3b6d-bd87-3f249a0cca5e@users.sourceforge.net>
Date: Wed, 6 Dec 2017 22:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Dec 2017 21:41:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ucc_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 2b6376e6e5ad..48364f0eba72 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1254,10 +1254,8 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	qe_port = kzalloc(sizeof(struct uart_qe_port), GFP_KERNEL);
-	if (!qe_port) {
-		dev_err(&ofdev->dev, "can't allocate QE port structure\n");
+	if (!qe_port)
 		return -ENOMEM;
-	}
 
 	/* Search for IRQ and mapbase */
 	ret = of_address_to_resource(np, 0, &res);
-- 
2.15.1
