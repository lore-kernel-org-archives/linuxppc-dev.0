Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C10FA1A057D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 23:33:15 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 14:33:10 +0100
Message-ID: <55252E0F.8080200@fr.ibm.com>
Date: Wed, 08 Apr 2015 15:33:03 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v3] hwmon: (ibmpowernv) pretty print labels
References: <1428476427-23311-1-git-send-email-clg@fr.ibm.com>
 <55252C9A.4050505@roeck-us.net>
In-Reply-To: <55252C9A.4050505@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2015 03:26 PM, Guenter Roeck wrote:
> On 04/08/2015 12:00 AM, Cédric Le Goater wrote:
>> The new OPAL device tree adds a few properties which can be used to add
>> extra information on the sensor label.
>>
>> In the case of a cpu core sensor, the firmware exposes the physical
>> identifier of the core in the "ibm,pir" property. The driver
>> translates this identifier in a linux cpu number and prints out a
>> range corresponding to the hardware threads of the core (as they
>> share the same sensor).
>>
>> The numbering gives a hint on the localization of the core in the
>> system (which socket, which chip).
>>
>> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
>> ---
>>
>>   Changes since v2:
>>
>>   - fix bogus logical cpu retrieval
>>   - use 'threads_per_core' to print out cpu range
>>
>>   Changes since v1:
>>
>>   - check cpu validity before printing out the attribute label.
>>     if invalid, use a "phy" prefix to distinguish a linux cpu
>>     number from a physical cpu number.
>>
>>   drivers/hwmon/ibmpowernv.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> Index: linux.git/drivers/hwmon/ibmpowernv.c
>> ===================================================================
>> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
>> +++ linux.git/drivers/hwmon/ibmpowernv.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/platform_device.h>
>>   #include <asm/opal.h>
>>   #include <linux/err.h>
>> +#include <asm/cputhreads.h>
>>
>>   #define MAX_ATTR_LEN    32
>>   #define MAX_LABEL_LEN    64
>> @@ -110,12 +111,54 @@ static ssize_t show_label(struct device
>>       return sprintf(buf, "%s\n", sdata->label);
>>   }
>>
>> +static int __init get_logical_cpu(unsigned int hwcpu)
>> +{
>> +    int cpu;
>> +
>> +    for_each_possible_cpu(cpu)
>> +        if (get_hard_smp_processor_id(cpu) == hwcpu)
>> +            return cpu;
>> +
>> +    pr_err("%s: could not find a cpu with physical id 0x%x\n",
>> +           __func__, hwcpu);
> 
> I like moving this into a function, but I really dislike this error
> message. If the devicetree data is wrong/bad, the log and the console
> will be clogged with that message. And the user will not be able
> to do anything about it.

yes. It is not super useful anyway and it is redundant with the "phy" 
prefix below. Do you want me to kill it in a v4 ? 

Thanks,

C. 

> 
> Guenter
> 
>> +    return -ENOENT;
>> +}
>> +
>>   static void __init make_sensor_label(struct device_node *np,
>>               struct sensor_data *sdata, const char *label)
>>   {
>> +    u32 id;
>>       size_t n;
>>
>>       n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
>> +
>> +    /*
>> +     * Core temp pretty print
>> +     */
>> +    if (!of_property_read_u32(np, "ibm,pir", &id)) {
>> +        int cpuid = get_logical_cpu(id);
>> +
>> +        if (cpuid >= 0)
>> +            /*
>> +             * The digital thermal sensors are associated
>> +             * with a core. Let's print out the range of
>> +             * cpu ids corresponding to the hardware
>> +             * threads of the core.
>> +             */
>> +            n += snprintf(sdata->label + n,
>> +                      sizeof(sdata->label) - n, " %d-%d",
>> +                      cpuid, cpuid + threads_per_core - 1);
>> +        else
>> +            n += snprintf(sdata->label + n,
>> +                      sizeof(sdata->label) - n, " phy%d", id);
>> +    }
>> +
>> +    /*
>> +     * Membuffer pretty print
>> +     */
>> +    if (!of_property_read_u32(np, "ibm,chip-id", &id))
>> +        n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
>> +                  " %d", id & 0xffff);
>>   }
>>
>>   static int get_sensor_index_attr(const char *name, u32 *index,
>>
>>
> 
