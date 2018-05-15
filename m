Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lglW5CrHzF2NB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:02:15 +1000 (AEST)
Date: Tue, 15 May 2018 08:02:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 0/3] Add support to disable sensor groups in P9
Message-ID: <20180515150205.GA29321@roeck-us.net>
References: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2018 at 04:24:32PM +0530, Shilpasri G Bhat wrote:
> This patch series adds support to enable/disable OCC based
> inband-sensor groups at runtime. The environmental sensor groups are
> managed in HWMON and the remaining platform specific sensor groups are
> managed in /sys/firmware/opal.
> 
> The firmware changes required for this patch is posted below:
> https://lists.ozlabs.org/pipermail/skiboot/2018-March/010812.html
> 

Sorry for not getting back earlier. This is a tough one.

Key problem is that you are changing the ABI with those new attributes.
On top of that, the attributes _do_ make some sense (many chips support
enabling/disabling of individual sensors), suggesting that those or
similar attributes may or even should at some point be added to the ABI.

At the same time, returning "0" as measurement values when sensors are
disabled does not seem like a good idea, since "0" is a perfectly valid
measurement, at least for most sensors.

Given that, we need to have a discussion about adding _enable attributes to
the ABI (what is the scope, when should the attributes exist and when not,
do we want/need power_enable or powerX_enable or both, and so on), and what
to return if a sensor is disabled (such as -ENODATA). Once we have an
agreement, we can continue with an implementation.

Guenter

> Shilpasri G Bhat (3):
>   powernv:opal-sensor-groups: Add support to enable sensor groups
>   hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
>   powernv: opal-sensor-groups: Add attributes to disable/enable sensors
> 
>  .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
>  Documentation/hwmon/ibmpowernv                     |  31 ++++-
>  arch/powerpc/include/asm/opal-api.h                |   4 +-
>  arch/powerpc/include/asm/opal.h                    |   2 +
>  .../powerpc/platforms/powernv/opal-sensor-groups.c | 104 ++++++++++++-----
>  arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
>  drivers/hwmon/ibmpowernv.c                         | 127 +++++++++++++++++++--
>  7 files changed, 265 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
> 
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
