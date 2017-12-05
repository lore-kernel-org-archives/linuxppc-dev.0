Return-Path: <>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrstL4vJXzDr6m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 06:55:38 +1100 (AEDT)
From: "Andrew F. Davis" <afd@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v4 2/5] amba: Only descend into amba directory when
 CONFIG_ARM_AMBA is set
Date: Tue, 5 Dec 2017 13:44:53 -0600
Message-ID: <20171205194456.23612-3-afd@ti.com>
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

When CONFIG_ARM_AMBA is not set make will still descend into the amba
directory but nothing will be built. This produces unneeded build
artifacts and messages in addition to slowing the build. Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 82ff1fc5f724..ea2a8bb32818 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_SFI)		+= sfi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
-obj-y				+= amba/
+obj-$(CONFIG_ARM_AMBA)		+= amba/
 
 obj-y				+= clk/
 # Many drivers will want to use DMA so this has to be made available
-- 
2.15.0
