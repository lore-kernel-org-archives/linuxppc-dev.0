Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id DE31D2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 06:47:43 +1100 (EST)
Message-ID: <52CEFCE3.1040701@arm.com>
Date: Thu, 09 Jan 2014 19:47:47 +0000
From: Sudeep Holla <Sudeep.Holla@arm.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
 <20140108202707.GE8417@kroah.com> <52CEF624.9020702@arm.com>
 <20140109193121.GA14991@kroah.com>
In-Reply-To: <20140109193121.GA14991@kroah.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Rob Herring <robh@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep.Holla@arm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/14 19:31, Greg Kroah-Hartman wrote:
> On Thu, Jan 09, 2014 at 07:19:00PM +0000, Sudeep Holla wrote:
>> On 08/01/14 20:27, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
>>>> From: Sudeep Holla <sudeep.holla@arm.com>
>>>>
>>>> This patch adds initial support for providing processor cache informat=
ion
>>>> to userspace through sysfs interface. This is based on x86 implementat=
ion
>>>> and hence the interface is intended to be fully compatible.
>>>>
>>>> A per-cpu array of cache information maintained is used mainly for
>>>> sysfs-related book keeping.
>>>>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>  drivers/base/Makefile     |   2 +-
>>>>  drivers/base/cacheinfo.c  | 296 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>>>  include/linux/cacheinfo.h |  43 +++++++
>>>>  3 files changed, 340 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/base/cacheinfo.c
>>>>  create mode 100644 include/linux/cacheinfo.h
>>>>
>>>> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
>>>> index 94e8a80..76f07c8 100644
>>>> --- a/drivers/base/Makefile
>>>> +++ b/drivers/base/Makefile
>>>> @@ -4,7 +4,7 @@ obj-y=09=09=09:=3D core.o bus.o dd.o syscore.o \
>>>>  =09=09=09   driver.o class.o platform.o \
>>>>  =09=09=09   cpu.o firmware.o init.o map.o devres.o \
>>>>  =09=09=09   attribute_container.o transport_class.o \
>>>> -=09=09=09   topology.o
>>>> +=09=09=09   topology.o cacheinfo.o
>>>>  obj-$(CONFIG_DEVTMPFS)=09+=3D devtmpfs.o
>>>>  obj-$(CONFIG_DMA_CMA) +=3D dma-contiguous.o
>>>>  obj-y=09=09=09+=3D power/
>>>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>>>> new file mode 100644
>>>> index 0000000..f436c31
>>>> --- /dev/null
>>>> +++ b/drivers/base/cacheinfo.c
>>>> @@ -0,0 +1,296 @@
>>>> +/*
>>>> + * cacheinfo support - processor cache information via sysfs
>>>> + *
>>>> + * Copyright (C) 2013 ARM Ltd.
>>>> + * All Rights Reserved
>>>> + *
>>>> + * Author: Sudeep Holla <sudeep.holla@arm.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modi=
fy
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>>> + * kind, whether express or implied; without even the implied warrant=
y
>>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/cacheinfo.h>
>>>> +#include <linux/compiler.h>
>>>> +#include <linux/cpu.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/kobject.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/smp.h>
>>>> +#include <linux/sysfs.h>
>>>> +
>>>> +struct cache_attr {
>>>> +=09struct attribute attr;
>>>> +=09 ssize_t(*show) (unsigned int, unsigned short, char *);
>>>> +=09 ssize_t(*store) (unsigned int, unsigned short, const char *, size=
_t);
>>>> +};
>>>> +
>>>> +/* pointer to kobject for cpuX/cache */
>>>> +static DEFINE_PER_CPU(struct kobject *, ci_cache_kobject);
>>>> +#define per_cpu_cache_kobject(cpu)     (per_cpu(ci_cache_kobject, cpu=
))
>>>> +
>>>> +struct index_kobject {
>>>> +=09struct kobject kobj;
>>>> +=09unsigned int cpu;
>>>> +=09unsigned short index;
>>>> +};
>>>> +
>>>> +static cpumask_t cache_dev_map;
>>>> +
>>>> +/* pointer to array of kobjects for cpuX/cache/indexY */
>>>
>>> Please don't use "raw" kobjects for this, use the device attribute
>>> groups, that's what they are there for.  Bonus is that your code should
>>> get a lot simpler when you do that.
>>>
>>
>> Yes I now understand device attribute group simplifies the code, but I t=
hink
>> kobjects are still needed as we need to track both cpu and cache index.
>> By reusing only cpu device kobject, we can track cpu only.
>=20
> I don't understand, you are putting things under the cpu device object,
> why do you care about a "cache" kobject?
>=20
Yes though the cache attributes are under cpu objects, it's hierarchical
something like:
/sys/devices/system/cpu/cpu<n>/cache/index<m>/<attribute_x>
<attribute_x> is unique for each pair of (cpu<n>, index<m>
index is more like cache level, but with 2 indices if they are separate(I$,=
D$)

>> One thought I have is to make cache_info structure common to all archite=
cture
>> (for now its ARM specific) and introduce kobject in that similar to ia64
>> implementation. That even eliminates lot of weak functions defined.
>=20
> Please don't use raw kobjects if at all possible, it's not good for a
> variety of reasons (no userspace events, have to roll your own code,
> etc.)
>=20
Yes I understand, will try to explore other feasible solutions.

Regards,
Sudeep
