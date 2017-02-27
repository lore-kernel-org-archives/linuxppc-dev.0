Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWlcw3JR2zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 13:13:51 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id r90so13951520qki.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 18:13:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ec7f0ed8-58b5-cdfb-63a9-d91a7cb8022e@au1.ibm.com>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
 <ec7f0ed8-58b5-cdfb-63a9-d91a7cb8022e@au1.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 27 Feb 2017 13:13:49 +1100
Message-ID: <CAOSf1CHB5tGhJzY_+wgZFcsVsyZg+qn_fr5LuisNe3Z2cR0TuQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2017 at 12:59 PM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> On 24/02/17 17:20, Matt Brown wrote:
>>
>> The HDAT data area is consumed by skiboot and turned into a device-tree.
>> In some cases we would like to look directly at the HDAT, so this patch
>> adds a sysfs node to allow it to be viewed.  This is not possible through
>> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>>
>> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
>
>
> Changes look good, thanks for addressing the comments! Still a couple of
> minor points below, otherwise:
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> Stewart: this might need your ACK?
>
>
>> ---
>>
>> Changes between v2 to v3:
>>         - fixed header comments
>>         - simplified if statement
>>
>> ---
>>  arch/powerpc/include/asm/opal.h            |  1 +
>>  arch/powerpc/platforms/powernv/Makefile    |  1 +
>>  arch/powerpc/platforms/powernv/opal-hdat.c | 65
>> ++++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/opal.c      |  2 +
>>  4 files changed, 69 insertions(+)
>>  create mode 100644 arch/powerpc/platforms/powernv/opal-hdat.c
>>
>> diff --git a/arch/powerpc/include/asm/opal.h
>> b/arch/powerpc/include/asm/opal.h
>> index 5c7db0f..b26944e 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
>>  extern int opal_sensor_init(void);
>>  extern int opal_hmi_handler_init(void);
>>  extern int opal_event_init(void);
>> +extern void opal_hdat_sysfs_init(void);
>>
>>  extern int opal_machine_check(struct pt_regs *regs);
>>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
>> diff --git a/arch/powerpc/platforms/powernv/Makefile
>> b/arch/powerpc/platforms/powernv/Makefile
>> index b5d98cb..9a0c9d6 100644
>> --- a/arch/powerpc/platforms/powernv/Makefile
>> +++ b/arch/powerpc/platforms/powernv/Makefile
>> @@ -3,6 +3,7 @@ obj-y                   += opal-rtc.o opal-nvram.o
>> opal-lpc.o opal-flash.o
>>  obj-y                  += rng.o opal-elog.o opal-dump.o opal-sysparam.o
>> opal-sensor.o
>>  obj-y                  += opal-msglog.o opal-hmi.o opal-power.o
>> opal-irqchip.o
>>  obj-y                  += opal-kmsg.o
>> +obj-y                  += opal-hdat.o
>
>
> Normally we keep putting new object files on the same line until it gets
> long enough that we have to break it. This is very minor though :)
>
>
>>
>>  obj-$(CONFIG_SMP)      += smp.o subcore.o subcore-asm.o
>>  obj-$(CONFIG_PCI)      += pci.o pci-ioda.o npu-dma.o
>> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c
>> b/arch/powerpc/platforms/powernv/opal-hdat.c
>> new file mode 100644
>> index 0000000..3315dd3
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
>> @@ -0,0 +1,65 @@
>> +/*
>> + * PowerNV OPAL HDAT interface
>> + *
>> + * Author: Matt Brown <matthew.brown.dev@gmail.com>
>> + *
>> + * Copyright 2017 IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <asm/io.h>
>> +#include <asm/opal.h>
>> +#include <linux/of.h>
>> +#include <linux/types.h>
>> +
>> +struct hdat_info {
>> +       char *base;
>> +       u64 size;
>> +};
>> +
>> +static struct hdat_info hdat_inf;
>
>
> As Oliver pointed out, we could do with a better name than hdat_inf - it's
> only one character away from the name of the struct type. Hmm, perhaps
> "hdat_location", or maybe Oliver has a better suggestion.

I'm not that bothered by it.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

>
>
> --
> Andrew Donnellan              OzLabs, ADL Canberra
> andrew.donnellan@au1.ibm.com  IBM Australia Limited
>
