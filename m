Return-Path: <nm@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjNFY0QvpzDwH8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 14:15:11 +1100 (AEDT)
From: Nishanth Menon <nm@ti.com>
To: Jiri Slaby <jslaby@suse.com>
CC: Timur Tabi <timur@codeaurora.org>, Christopher Covington
 <cov@codeaurora.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] tty: hvc_dcc: Add basic early_con support
Date: Mon, 19 Dec 2016 18:23:36 -0600
Message-ID: <20161220002336.28733-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some cases, earlycon can help catch errors with kernel boot prior to
standard console is available.

Example bootargs: console=hvc0 earlycon=hvcdcc

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on: v4.9 tag
Also applies on: next-20161219
Tested on Simulation environment (which did not have serial console option)

 drivers/tty/hvc/hvc_dcc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 82f240fb98f0..1ec06e550656 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -10,7 +10,9 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/console.h>
 #include <linux/init.h>
+#include <linux/serial_core.h>
 
 #include <asm/dcc.h>
 #include <asm/processor.h>
@@ -94,3 +96,45 @@ static int __init hvc_dcc_init(void)
 	return PTR_ERR_OR_ZERO(p);
 }
 device_initcall(hvc_dcc_init);
+
+static int hvc_dcc_earlyputc(int c)
+{
+	unsigned long count = 0xFFFFFFFF;
+	static bool dead_dcc_earlycon;
+
+	if (dead_dcc_earlycon)
+		return -EBUSY;
+
+	while (count--) {
+		if (!(__dcc_getstatus() & DCC_STATUS_TX))
+			break;
+	}
+	if (!count) {
+		dead_dcc_earlycon = true;
+		return -EBUSY;
+	}
+	__dcc_putchar(c);
+	return 0;
+}
+
+static void hvc_dcc_earlywrite(struct console *con, const char *s,
+			       unsigned int n)
+{
+	int r;
+
+	while (n--) {
+		r = hvc_dcc_earlyputc(*s);
+		if (r)
+			break;
+		s++;
+	}
+}
+
+static int
+__init early_hvc_dcc_setup(struct earlycon_device *device, const char *opt)
+{
+	device->con->write = hvc_dcc_earlywrite;
+	return 0;
+}
+
+EARLYCON_DECLARE(hvcdcc, early_hvc_dcc_setup);
-- 
2.11.0.65.geff96d7
