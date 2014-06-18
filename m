Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id B1DDD1A032D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 23:05:41 +1000 (EST)
Message-ID: <53A18E9B.7070306@roeck-us.net>
Date: Wed, 18 Jun 2014 06:05:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v2] powerpc/powernv: hwmon driver for power values, fan
 rpm and temperature
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net> <53A1514F.30907@linux.vnet.ibm.com>
In-Reply-To: <53A1514F.30907@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sbhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/18/2014 01:43 AM, Neelesh Gupta wrote:
>
>>> +}
>>> +
>>> +static void __init get_sensor_index_attr(const char *name, u32 *index, char *attr)
>>> +{
>>> +    char *hash_pos = strchr(name, '#');
>>> +    char *dash_pos;
>>> +    u32 copy_len;
>>> +    char buf[8];
>>> +
>>> +    memset(buf, 0, sizeof(buf));
>>> +    *index = 0;
>>> +    *attr = '\0';
>>> +
>>> +    if (hash_pos) {
>>> +        dash_pos = strchr(hash_pos, '-');
>>> +        if (dash_pos) {
>>> +            copy_len = dash_pos - hash_pos - 1;
>>> +            if (copy_len < sizeof(buf)) {
>>> +                strncpy(buf, hash_pos + 1, copy_len);
>>> +                sscanf(buf, "%d", index);
>>
>> What if sscanf fails ? Might be an interesting exercise to try and create
>> multiple sensors with index 0 (or, for that matter, with the same index value).
>> Do you have any protection against bad input data ? Guess not; did you test
>> what happens if you pass bad data to the driver (such as duplicate sensor
>> entries) ?
>
> We can't have duplicate entries in the device tree under the same node ?
> But yes, rest other scenarios must be validated.
>

Was this a serious question ? Sorry, I wonder. It seems quite unlikely for a file
system to accept two files with the same name in the same directory.

Guenter
