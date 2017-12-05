Return-Path: <>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrtK80X43zDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 07:15:22 +1100 (AEDT)
From: "Andrew F. Davis" <afd@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v4 4/5] macintosh: Only descend into directory when
 CONFIG_MACINTOSH_DRIVERS is set
Date: Tue, 5 Dec 2017 13:44:55 -0600
Message-ID: <20171205194456.23612-5-afd@ti.com>
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

When CONFIG_MACINTOSH_DRIVERS is not set make will still descend into the
macintosh directory but nothing will be built. This produces unneeded
build artifacts and messages in addition to slowing the build.
Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index de33bb24c935..cdf4509a2960 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -81,7 +81,7 @@ obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
-obj-y				+= macintosh/
+obj-$(CONFIG_MACINTOSH_DRIVERS)	+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_SCSI)		+= scsi/
 obj-y				+= nvme/
-- 
2.15.0
