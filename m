Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4857D1A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:34:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 16:34:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C33FE3578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:34:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B6Y6Sb48627828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:34:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B6Xf38009885
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:33:42 +1000
Message-ID: <55792BB3.3000102@linux.vnet.ibm.com>
Date: Thu, 11 Jun 2015 12:03:23 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au
CC: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v4 0/3] LED interface for PowerNV platform
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
In-Reply-To: <20150428100535.26912.29607.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2015 03:39 PM, Vasant Hegde wrote:
> The following series implements LED driver for PowerNV platform.

Ben, Michael,

Can you please review/ACK this patchset?

-Vasant

> 
> PowerNV platform has below type of LEDs:
>   - System attention
>       Indicates there is a problem with the system that needs attention.
>   - Identify
>       Helps the user locate/identify a particular FRU or resource in the
>       system.
>   - Fault
>       Indicates there is a problem with the FRU or resource at the
>       location with which the indicator is associated.
> 
> On PowerNV (Non Virtualized) platform OPAL firmware provides LED information
> to host via device tree (location code and LED type). During init we check
> for 'ibm,opal/led' node in device tree to enable LED driver. And we use
> OPAL API's to get/set LEDs.
> 
> Note that on PowerNV platform firmware can activate fault LED, if it can isolate
> the problem. Also one can modify the LEDs using service processor interface. None
> of these involes kernel. Hence we retain LED state in unload path.
> 
> Sample LED device tree output:
> ------------------------------
> led {
> 	compatible = "ibm,opal-v3-led";
> 	phandle = <0x1000006b>;
> 	linux,phandle = <0x1000006b>;
> 	led-mode = "lightpath";
> 
> 	U78C9.001.RST0027-P1-C1 {
> 		led-types = "identify", "fault";
> 		led-loc = "descendent";
> 		phandle = <0x1000006f>;
> 		linux,phandle = <0x1000006f>;
> 	};
> 	...
> 	...
>     }
> 
> Sample sysfs output:
> --------------------
> .
> ├── U78CB.001.WZS008R-A1:fault
> │   ├── brightness
> │   ├── device -> ../../../opal_led
> │   ├── max_brightness
> │   ├── power
> │   │   ├── async
> │   │   ├── autosuspend_delay_ms
> │   │   ├── control
> │   │   ├── runtime_active_kids
> │   │   ├── runtime_active_time
> │   │   ├── runtime_enabled
> │   │   ├── runtime_status
> │   │   ├── runtime_suspended_time
> │   │   └── runtime_usage
> │   ├── subsystem -> ../../../../../class/leds
> │   ├── trigger
> │   └── uevent
> ├── U78CB.001.WZS008R-A1:identify
> │   ├── brightness
> │   ├── device -> ../../../opal_led
> │   ├── max_brightness
> │   ├── power
> │   │   ├── async
> │   │   ├── autosuspend_delay_ms
> │   │   ├── control
> │   │   ├── runtime_active_kids
> │   │   ├── runtime_active_time
> │   │   ├── runtime_enabled
> │   │   ├── runtime_status
> │   │   ├── runtime_suspended_time
> │   │   └── runtime_usage
> │   ├── subsystem -> ../../../../../class/leds
> │   ├── trigger
> │   └── uevent
> ....
> ....
> ....
> 
> patch 1/2: PowerNV architecture specific code. This adds necessary
>            OPAL APIs.
> patch 2/2: Create LED platform device and export OPAL symbols
> patch 3/3: Actual LED driver implemenation for PowerNV platform.
> 
> This patchset is based on top of mpe's next branch:
>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
> 
> Previous patchset:
>   v3: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html
>   v2: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126301.html
>   v1: https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/125705.html
> 
> Changes in v4:
>   - Updated macros to reflect platform.
>   - s/u64/__be64/g for big endian data we get from firmware
>   - Addressed review comments from Jacek. Major once are:
>     Removed list in powernv_led_data structure
>     s/kzalloc/devm_kzalloc/
>     Removed compatible property from documentation
>     s/powernv_led_set_queue/powernv_brightness_set/
>   - Removed LED specific brightness_set/get function. Instead this version
>     uses single function to queue all LED set/get requests. Later we use
>     LED name to detect LED type and value.
>   - Removed hardcoded LED type used in previous version. Instead we use
>     led-types property to form LED classdev.
> 
> Changes in v3:
>   - Addressed review comments from Jacek. Major once are:
>     Replaced spin lock and mutex and removed redundant structures
>     Replaced pr_* with dev_*
>     Moved OPAL platform sepcific part to separate patch
>     Moved repteated code to common function
>     Added device tree documentation for LEDs
> 
> Changes in v2:
>   - Rebased patches on top of mpe's next branch
>     https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
>   - Added System Attention Indicator support
>   - Removed redundant code in leds-powernv.c file
> 
> 
> ---
> 
> Anshuman Khandual (1):
>       powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states
> 
> Vasant Hegde (2):
>       powerpc/powernv: Create LED platform device
>       leds/powernv: Add driver for PowerNV platform
> 
> 
>  .../devicetree/bindings/leds/leds-powernv.txt      |   29 +
>  arch/powerpc/include/asm/opal-api.h                |   29 +
>  arch/powerpc/include/asm/opal.h                    |    5 
>  arch/powerpc/platforms/powernv/opal-wrappers.S     |    2 
>  arch/powerpc/platforms/powernv/opal.c              |   12 -
>  drivers/leds/Kconfig                               |   11 
>  drivers/leds/Makefile                              |    1 
>  drivers/leds/leds-powernv.c                        |  472 ++++++++++++++++++++
>  8 files changed, 559 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
>  create mode 100644 drivers/leds/leds-powernv.c
> 
> --
> Vasant
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
