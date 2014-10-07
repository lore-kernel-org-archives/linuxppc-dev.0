Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48CC31A16F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:30:40 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNM6-002gx4-Bu
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:30:38 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 34/44] ia64: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:36 -0700
Message-Id: <1412659726-29957-35-git-send-email-linux@roeck-us.net>
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
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Fenghua Yu <fenghua.yu@intel.com>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with lower priority of 64 to reflect that the call
is expected to be replaced at some point.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/ia64/sn/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 36182c8..6c83425 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -488,12 +488,12 @@ void __init sn_setup(char **cmdline_p)
 	sn_timer_init();
 
 	/*
-	 * set pm_power_off to a SAL call to allow
+	 * set poweroff handler to a SAL call to allow
 	 * sn machines to power off. The SAL call can be replaced
 	 * by an ACPI interface call when ACPI is fully implemented
 	 * for sn.
 	 */
-	pm_power_off = ia64_sn_power_down;
+	register_poweroff_handler_simple(ia64_sn_power_down, 64);
 	current->thread.flags |= IA64_THREAD_MIGRATION;
 }
 
-- 
1.9.1
