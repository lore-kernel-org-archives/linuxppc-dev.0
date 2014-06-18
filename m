Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20A0F1A0123
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 18:44:32 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 18 Jun 2014 14:14:27 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 005E6E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 14:15:31 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5I8jNFG61669392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 14:15:24 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5I8iK1e021871
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 14:14:20 +0530
Message-ID: <53A1514F.30907@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2014 14:13:59 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
 jdelvare@suse.de, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v2] powerpc/powernv: hwmon driver for power values, fan
 rpm and temperature
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net>
In-Reply-To: <53858F02.2020808@roeck-us.net>
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


>> +}
>> +
>> +static void __init get_sensor_index_attr(const char *name, u32 
>> *index, char *attr)
>> +{
>> +    char *hash_pos = strchr(name, '#');
>> +    char *dash_pos;
>> +    u32 copy_len;
>> +    char buf[8];
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    *index = 0;
>> +    *attr = '\0';
>> +
>> +    if (hash_pos) {
>> +        dash_pos = strchr(hash_pos, '-');
>> +        if (dash_pos) {
>> +            copy_len = dash_pos - hash_pos - 1;
>> +            if (copy_len < sizeof(buf)) {
>> +                strncpy(buf, hash_pos + 1, copy_len);
>> +                sscanf(buf, "%d", index);
>
> What if sscanf fails ? Might be an interesting exercise to try and create
> multiple sensors with index 0 (or, for that matter, with the same 
> index value).
> Do you have any protection against bad input data ? Guess not; did you 
> test
> what happens if you pass bad data to the driver (such as duplicate sensor
> entries) ?

We can't have duplicate entries in the device tree under the same node ?
But yes, rest other scenarios must be validated.

- Neelesh

>
>> +            }
>> +
>> +            strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
>> +        }
>> +    }
>> +}
>> +
>> +
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
