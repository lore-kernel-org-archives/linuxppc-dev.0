Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EA721A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:29 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNKx-002aYm-LK
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:27 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/44] memory: emif: Use API function to determine poweroff
 capability
Date: Mon,  6 Oct 2014 22:28:04 -0700
Message-Id: <1412659726-29957-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use have_kernel_poweroff() to determine if the kernel is able
to power off the system.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/memory/emif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 04644e7..acd830a 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1053,10 +1053,10 @@ static irqreturn_t emif_threaded_isr(int irq, void *dev_id)
 		dev_emerg(emif->dev, "SDRAM temperature exceeds operating limit.. Needs shut down!!!\n");
 
 		/* If we have Power OFF ability, use it, else try restarting */
-		if (pm_power_off) {
+		if (have_kernel_poweroff()) {
 			kernel_power_off();
 		} else {
-			WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
+			WARN(1, "FIXME: NO kernel poweroff capability!!! trying restart\n");
 			kernel_restart("SDRAM Over-temp Emergency restart");
 		}
 		return IRQ_HANDLED;
-- 
1.9.1
