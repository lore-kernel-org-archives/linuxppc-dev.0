Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6661A0AAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 18:50:58 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 1 Jul 2015 14:20:55 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A81CF3940064
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 14:20:53 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t618op9q58130594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2015 14:20:51 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t618omjV014906
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2015 14:20:50 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, j.anaszewski81@gmail.com,
 cooloney@gmail.com, rpurdie@rpsys.net, arnd@arndb.de,
 mpe@ellerman.id.au, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v5 0/3] LED driver for PowerNV platform
Date: Wed,  1 Jul 2015 14:20:35 +0530
Message-Id: <1435740638-16259-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
for 'ibm,opal/leds' node in device tree to enable LED driver. And we use
OPAL API's to get/set LEDs.

Note that on PowerNV platform firmware can activate fault LED, if it can isolate
the problem. Also one can modify the LEDs using service processor interface. None
of these involes kernel. Hence we retain LED state in unload path.

Sample LED device tree output:
------------------------------
leds {
	compatible = "ibm,opal-v3-led";
	led-mode = "lightpath";

	U78C9.001.RST0027-P1-C1 {
		led-types = "identify", "fault";
	};
	...
	...
    }

Sample sysfs output:
--------------------
.
├── U78CB.001.WZS008R-A1:fault
│   ├── brightness
│   ├── device -> ../../../opal_leds
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
├── U78CB.001.WZS008R-A1:identify
│   ├── brightness
│   ├── device -> ../../../opal_leds
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

Note that this version of patchset is based on upstream Linus tree
as Jacek mention its better to go via LED subsystem (commit 05a8256c).

@Jacek,
  Let me know if you want me to rebase this patchset on top of LED tree.

Previous patchset:
  v4: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/128028.html
  v3: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html
  v2: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126301.html
  v1: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/125705.html

Changes in v5:
  - Rebased on top of Linus tree
  - Renamed led as leds and updated documentation
  - As Ben and Arnd suggested, removed phandle from documenation
  - As Ben suggested removed led-loc device tree property
  - As Jacek suggested, added back compatible property to documentation

Changes in v4:
  - Updated macros to reflect platform.
  - s/u64/__be64/g for big endian data we get from firmware
  - Addressed review comments from Jacek. Major once are:
    Removed list in powernv_led_data structure
    s/kzalloc/devm_kzalloc/
    Removed compatible property from documentation
    s/powernv_led_set_queue/powernv_brightness_set/
  - Removed LED specific brightness_set/get function. Instead this version
    uses single function to queue all LED set/get requests. Later we use
    LED name to detect LED type and value.
  - Removed hardcoded LED type used in previous version. Instead we use
    led-types property to form LED classdev.

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

Anshuman Khandual (1):
  powerpc/powernv: Add OPAL interfaces for accessing and modifying
    system LED states

Vasant Hegde (2):
  powerpc/powernv: Create LED platform device
  leds/powernv: Add driver for PowerNV platform

 .../devicetree/bindings/leds/leds-powernv.txt      |  27 ++
 arch/powerpc/include/asm/opal-api.h                |  29 +-
 arch/powerpc/include/asm/opal.h                    |   4 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   2 +
 arch/powerpc/platforms/powernv/opal.c              |  12 +-
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-powernv.c                        | 463 +++++++++++++++++++++
 8 files changed, 547 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

-- 
Vasant
2.1.0
