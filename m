Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88DCE1A0998
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:45 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLD-002baF-IG
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:43 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/44] gpio-poweroff: Drop reference to pm_power_off from
 devicetree bindings
Date: Mon,  6 Oct 2014 22:28:08 -0700
Message-Id: <1412659726-29957-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Mark Rutland <mark.rutland@arm.com>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 Rob Herring <robh+dt@kernel.org>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pm_power_off is an implementation detail. Replace it with a more generic
description of the driver's functionality.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
index d4eab92..c95a1a6 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
@@ -2,12 +2,12 @@ Driver a GPIO line that can be used to turn the power off.
 
 The driver supports both level triggered and edge triggered power off.
 At driver load time, the driver will request the given gpio line and
-install a pm_power_off handler. If the optional properties 'input' is
-not found, the GPIO line will be driven in the inactive
+install a handler to power off the system. If the optional properties
+'input' is not found, the GPIO line will be driven in the inactive
 state. Otherwise its configured as an input.
 
-When the pm_power_off is called, the gpio is configured as an output,
-and drive active, so triggering a level triggered power off
+When the the poweroff handler is called, the gpio is configured as an
+output, and drive active, so triggering a level triggered power off
 condition. This will also cause an inactive->active edge condition, so
 triggering positive edge triggered power off. After a delay of 100ms,
 the GPIO is set to inactive, thus causing an active->inactive edge,
@@ -24,7 +24,7 @@ Required properties:
 
 Optional properties:
 - input : Initially configure the GPIO line as an input. Only reconfigure
-  it to an output when the pm_power_off function is called. If this optional
+  it to an output when the poweroff handler is called. If this optional
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
 
-- 
1.9.1
