Return-Path: <>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrstM6TRczDr6m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 06:55:39 +1100 (AEDT)
From: "Andrew F. Davis" <afd@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v4 3/5] NFC: Only descend into nfc directory when CONFIG_NFC
 is set
Date: Tue, 5 Dec 2017 13:44:54 -0600
Message-ID: <20171205194456.23612-4-afd@ti.com>
In-Reply-To: <20171205194456.23612-1-afd@ti.com>
References: <20171205194456.23612-1-afd@ti.com>
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

When CONFIG_NFC is not set make will still descend into the nfc
directory but nothing will be built. This produces unneeded build
artifacts and messages in addition to slowing the build. Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index ea2a8bb32818..de33bb24c935 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -72,7 +72,11 @@ obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
 
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-$(CONFIG_NVM)		+= lightnvm/
-obj-y				+= base/ block/ misc/ mfd/ nfc/
+obj-y				+= base/
+obj-y				+= block/
+obj-y				+= misc/
+obj-y				+= mfd/
+obj-$(CONFIG_NFC)		+= nfc/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
-- 
2.15.0
