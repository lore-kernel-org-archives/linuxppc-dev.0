Return-Path: <libo.chen@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9203B2C0345
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:40:38 +1000 (EST)
Message-ID: <51A568EC.2070103@huawei.com>
Date: Wed, 29 May 2013 10:33:16 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: <timur@tabi.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] driver: tty: add missing unregister in err case
Content-Type: text/plain; charset="ISO-8859-1"
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Li Zefan <lizefan@huawei.com>,
 linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


when platform_driver_register broken, we should unregister ucc_uart_driver

Signed-off-by: Libo chen <libo.chen@huawei.com>
---
 drivers/tty/serial/ucc_uart.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 7355303..f86f447 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1518,9 +1518,11 @@ static int __init ucc_uart_init(void)
 	}

 	ret = platform_driver_register(&ucc_uart_of_driver);
-	if (ret)
+	if (ret) {
 		printk(KERN_ERR
 		       "ucc-uart: could not register platform driver\n");
+		uart_unregister_driver(&ucc_uart_driver);
+	}

 	return ret;
 }
-- 
1.7.1
