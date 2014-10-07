Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C73C1A0A38
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:30:49 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNMD-002hvZ-Vs
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:30:46 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 38/44] x86: lguest: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:40 -0700
Message-Id: <1412659726-29957-39-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/lguest/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index aae9413..083a999 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1441,7 +1441,7 @@ __init void lguest_init(void)
 	 * the Guest routine to power off, and the reboot hook to our restart
 	 * routine.
 	 */
-	pm_power_off = lguest_power_off;
+	register_poweroff_handler_simple(lguest_power_off, 128);
 	machine_ops.restart = lguest_restart;
 
 	/*
-- 
1.9.1
