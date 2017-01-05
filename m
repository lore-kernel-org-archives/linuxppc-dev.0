Return-Path: <>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvgjt37hkzDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 08:26:58 +1100 (AEDT)
From: "Andrew F. Davis" <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>,
 Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio
 <lauro.venancio@openbossa.org>, Aloisio Almeida Jr
 <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo
 Molnar <mingo@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-media@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2 4/6] macintosh: Only descend into directory when
 CONFIG_MACINTOSH_DRIVERS is set
Date: Thu, 5 Jan 2017 15:01:56 -0600
Message-ID: <20170105210158.14204-5-afd@ti.com>
In-Reply-To: <20170105210158.14204-1-afd@ti.com>
References: <20170105210158.14204-1-afd@ti.com>
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

When CONFIG_MACINTOSH_DRIVERS is not set make will still descend into the
macintosh directory but nothing will be built. This produces unneeded
build artifacts and messages in addition to slowing the build.
Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index f47f23cf817a..0823730bc50b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -75,7 +75,7 @@ obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DEV_DAX)		+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
-obj-y				+= macintosh/
+obj-$(CONFIG_MACINTOSH_DRIVERS)	+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_SCSI)		+= scsi/
 obj-y				+= nvme/
-- 
2.11.0
