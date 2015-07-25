Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62EB31A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 15:22:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Sat, 25 Jul 2015 15:22:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 19F2E357804C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 15:22:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6P5M4IY459236
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 15:22:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6P5Lenh017441
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 15:21:40 +1000
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 j.anaszewski@samsung.com
Cc: rpurdie@rpsys.net, cooloney@gmail.com, khandual@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, stewart@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v8 0/3] LED driver for PowerNV platform
Date: Sat, 25 Jul 2015 10:51:07 +0530
Message-Id: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
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

Note:
 - This patchset depends on Jacek's patchset
   https://lkml.org/lkml/2015/7/17/151 (Remove work queues from LED class drivers)
 - This version of patchset is based on top of v4.2-rc2.

Previous patchset:
  v7: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-July/131533.html
  v6: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-July/131328.html
  v5: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-July/130602.html
  v4: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/128028.html
  v3: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html
  v2: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126301.html
  v1: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/125705.html

Changes in v8:
  - Added powernv_led_common structure for common variables
  - Removed unused variable 'value'
  - Fixed locking issue

Changes in v7:
  - Club powernv_led_data & powernv_leds_priv into single structure
  - Removed num_leds & powernv_leds_count()
  - Replaced per LED mutex with global mutex
  - Removed driver specific workqueue. Instead this version uses new
    global workqueue.

Changes in v6:
  - Added loc_code and type to powernv_led_data structure instead of parsing
    them from led classdev name.
  - Fixed documentation issues.
  - Fixed mutex_destry issue
  - Replaced led_classdev_register with devm_led_classdev_register

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

 .../devicetree/bindings/leds/leds-powernv.txt      |  26 ++
 arch/powerpc/include/asm/opal-api.h                |  25 +-
 arch/powerpc/include/asm/opal.h                    |   4 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   2 +
 arch/powerpc/platforms/powernv/opal.c              |  12 +-
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-powernv.c                        | 350 +++++++++++++++++++++
 8 files changed, 429 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

-- 
2.1.0
