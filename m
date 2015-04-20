Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0508B1A0BF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 17:59:33 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 13:29:31 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 502181258053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:31:24 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3K7xNfH33423400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:29:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3K7aPYw025725
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:06:26 +0530
Subject: [PATCH v3 0/3] LED interface for PowerNV platform
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Mon, 20 Apr 2015 13:29:22 +0530
Message-ID: <20150420075558.12371.6697.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series implements LED driver for PowerNV platform.

PowerNV platform has below type of LEDs:
  - System attention
      Indicates there is a problem with the system that needs attention.
  - Identify
      Helps the user locate/identify a particular FRU or resource in the
      system.
  - Fault
      Indicates there is a problem with the FRU or resource at the
      location with which the indicator is associated.

On PowerNV (Non Virtualized) platform OPAL firmware provides LED information
to host via device tree (location code and LED type). During init we check
for 'ibm,opal/led' node in device tree to enable LED driver. And we use
OPAL API's to get/set LEDs.

Note that on PowerNV platform firmware can activate fault LED, if it can isolate
the problem. Also one can modify the LEDs using service processor interface. None
of these involes kernel. Hence we retain LED state in unload path.

Sample LED device tree output:
------------------------------
led {
	compatible = "ibm,opal-v3-led";
	phandle = <0x1000006b>;
	linux,phandle = <0x1000006b>;
	led-mode = "lightpath";

	U78C9.001.RST0027-P1-C1 {
		led-types = "identify", "fault";
		led-loc = "descendent";
		phandle = <0x1000006f>;
		linux,phandle = <0x1000006f>;
	};
	...
	...
    }

Sample sysfs output:
--------------------
.
├── U78CB.001.WZS008R-A1:FAULT
│   ├── brightness
│   ├── device -> ../../../opal_led
│   ├── max_brightness
│   ├── power
│   │   ├── async
│   │   ├── autosuspend_delay_ms
│   │   ├── control
│   │   ├── runtime_active_kids
│   │   ├── runtime_active_time
│   │   ├── runtime_enabled
│   │   ├── runtime_status
│   │   ├── runtime_suspended_time
│   │   └── runtime_usage
│   ├── subsystem -> ../../../../../class/leds
│   ├── trigger
│   └── uevent
├── U78CB.001.WZS008R-A1:IDENT
│   ├── brightness
│   ├── device -> ../../../opal_led
│   ├── max_brightness
│   ├── power
│   │   ├── async
│   │   ├── autosuspend_delay_ms
│   │   ├── control
│   │   ├── runtime_active_kids
│   │   ├── runtime_active_time
│   │   ├── runtime_enabled
│   │   ├── runtime_status
│   │   ├── runtime_suspended_time
│   │   └── runtime_usage
│   ├── subsystem -> ../../../../../class/leds
│   ├── trigger
│   └── uevent
....
....
....


patch 1/2: PowerNV architecture specific code. This adds necessary
           OPAL APIs.
patch 2/2: Create LED platform device and export OPAL symbols
patch 3/3: Actual LED driver implemenation for PowerNV platform.

This patchset is based on top of mpe's next branch:
  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next

Previous patchset:
  v2: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126301.html
  v1: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/125705.html

Changes in v3:
  - Addressed review comments from Jacek. Major once are:
    Replaced spin lock and mutex and removed redundant structures
    Replaced pr_* with dev_*
    Moved OPAL platform sepcific part to separate patch
    Moved repteated code to common function
    Added device tree documentation for LEDs

Changes in v2:
  - Rebased patches on top of mpe's next branch
    https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
  - Added System Attention Indicator support
  - Removed redundant code in leds-powernv.c file


---

Anshuman Khandual (1):
      powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states

Vasant Hegde (2):
      powerpc/powernv: Create LED platform device
      leds/powernv: Add driver for PowerNV platform


 .../devicetree/bindings/leds/leds-powernv.txt      |   34 +
 arch/powerpc/include/asm/opal-api.h                |   29 +
 arch/powerpc/include/asm/opal.h                    |    5 
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    2 
 arch/powerpc/platforms/powernv/opal.c              |   12 -
 drivers/leds/Kconfig                               |   11 
 drivers/leds/Makefile                              |    1 
 drivers/leds/leds-powernv.c                        |  455 ++++++++++++++++++++
 8 files changed, 547 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

--
Vasant
