Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mgsM4lZBzF1QL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 16:10:47 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H604Ea011084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:10:44 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j14308eg1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:10:44 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 17 May 2018 07:10:42 +0100
Subject: Re: [PATCH 0/3] Add support to disable sensor groups in P9
To: Guenter Roeck <linux@roeck-us.net>
References: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180515150205.GA29321@roeck-us.net>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stewart@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 17 May 2018 11:40:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180515150205.GA29321@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <2ceb6b30-60b7-d985-ee0d-6c5784eda273@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/15/2018 08:32 PM, Guenter Roeck wrote:
> On Thu, Mar 22, 2018 at 04:24:32PM +0530, Shilpasri G Bhat wrote:
>> This patch series adds support to enable/disable OCC based
>> inband-sensor groups at runtime. The environmental sensor groups are
>> managed in HWMON and the remaining platform specific sensor groups are
>> managed in /sys/firmware/opal.
>>
>> The firmware changes required for this patch is posted below:
>> https://lists.ozlabs.org/pipermail/skiboot/2018-March/010812.html
>>
> 
> Sorry for not getting back earlier. This is a tough one.
> 

Thanks for the reply. I have tried to answer your questions according to my
understanding below:

> Key problem is that you are changing the ABI with those new attributes.
> On top of that, the attributes _do_ make some sense (many chips support
> enabling/disabling of individual sensors), suggesting that those or
> similar attributes may or even should at some point be added to the ABI.
> 
> At the same time, returning "0" as measurement values when sensors are
> disabled does not seem like a good idea, since "0" is a perfectly valid
> measurement, at least for most sensors.

I agree.

> 
> Given that, we need to have a discussion about adding _enable attributes to
> the ABI 

> what is the scope,
IIUC the scope should be RW and the attribute is defined for each supported
sensor group

> when should the attributes exist and when not,
We control this currently via device-tree

> do we want/need power_enable or powerX_enable or both, and so on), and 
We need power_enable right now

> what to return if a sensor is disabled (such as -ENODATA).
-ENODATA sounds good.

Thanks and Regards,
Shilpa

 Once we have an
> agreement, we can continue with an implementation.
> 
> Guenter
> 
>> Shilpasri G Bhat (3):
>>   powernv:opal-sensor-groups: Add support to enable sensor groups
>>   hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
>>   powernv: opal-sensor-groups: Add attributes to disable/enable sensors
>>
>>  .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
>>  Documentation/hwmon/ibmpowernv                     |  31 ++++-
>>  arch/powerpc/include/asm/opal-api.h                |   4 +-
>>  arch/powerpc/include/asm/opal.h                    |   2 +
>>  .../powerpc/platforms/powernv/opal-sensor-groups.c | 104 ++++++++++++-----
>>  arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
>>  drivers/hwmon/ibmpowernv.c                         | 127 +++++++++++++++++++--
>>  7 files changed, 265 insertions(+), 38 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
>>
>> -- 
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
