Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6scq4l7lzDvJj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:31:07 +1100 (AEDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3t6scj6VnjzMrH5L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:31:01 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/7] base: soc: Early register bus when needed
Date: Mon, 31 Oct 2016 12:30:49 +0100
Message-Id: <1477913455-5314-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If soc_device_register() is called before soc_bus_register(), it crashes
with a NULL pointer dereference.

soc_bus_register() is already a core_initcall(), but drivers/base/ is
entered later than e.g. drivers/pinctrl/ and drivers/soc/. Hence there
are several subsystems that may need to know SoC revision information,
while it's not so easy to initialize the SoC bus even earlier using an
initcall.

To fix this, let soc_device_register() register the bus early if that
hasn't happened yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 drivers/base/soc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b63f23e6ad61b647..028cef377fd49959 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -113,6 +113,12 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 	struct soc_device *soc_dev;
 	int ret;
 
+	if (!soc_bus_type.p) {
+		ret = bus_register(&soc_bus_type);
+		if (ret)
+			goto out1;
+	}
+
 	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
 	if (!soc_dev) {
 		ret = -ENOMEM;
@@ -156,6 +162,9 @@ void soc_device_unregister(struct soc_device *soc_dev)
 
 static int __init soc_bus_register(void)
 {
+	if (soc_bus_type.p)
+		return 0;
+
 	return bus_register(&soc_bus_type);
 }
 core_initcall(soc_bus_register);
-- 
1.9.1
