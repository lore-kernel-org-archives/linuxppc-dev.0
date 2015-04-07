Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0EF51A084E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 00:42:23 +1000 (AEST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Tue, 7 Apr 2015 15:42:19 +0100
Message-ID: <5523ECC4.9010609@fr.ibm.com>
Date: Tue, 07 Apr 2015 16:42:12 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
References: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
 <1427883306-32528-5-git-send-email-clg@fr.ibm.com>
 <551EB692.3010309@roeck-us.net>
In-Reply-To: <551EB692.3010309@roeck-us.net>
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

On 04/03/2015 05:49 PM, Guenter Roeck wrote:
> On 04/01/2015 03:15 AM, Cédric Le Goater wrote:
>> The new OPAL device tree adds a few properties which can be used to add
>> extra information on the sensor label.
>>
>> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
>> ---
>>   drivers/hwmon/ibmpowernv.c |   22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> index be6fe559b52a..3e753c215b40 100644
>> --- a/drivers/hwmon/ibmpowernv.c
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -113,9 +113,31 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
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
>> +        int i;
>> +
>> +        for_each_possible_cpu(i)
>> +            if (paca[i].hw_cpu_id == id)
>> +                break;
>> +
>> +        n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
>> +                  " %d-%d", i, i+7);
> 
> If ibm,pir points to a bad/invalid CPU id you just print an invalid value.
> Is that what you want ? 

Certainly not :) I am being over optimistic on the underlying layer. 

> Also, what relevance does 'i' have for the user ?
> It is the index into the paca array, sure, but what is its relevance
> outside this code, especially in the context of you printing both i and i+7 ?

It gives a hint on the localization of the core in the system, which
can be useful when developing custom heat sinks. The translation 
from physical to linux cpu id is here to be consistent with the user
layer. The physical id is rarely used at that level.  

I will send a v2 for this patch.

Thanks,

C.
 

> 
> Guenter
> 
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
> 
