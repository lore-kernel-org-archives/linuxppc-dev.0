Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LRsQ75cCzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 02:54:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64GnfAl035866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 12:54:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k118m9uw9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 12:54:00 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 4 Jul 2018 17:53:57 +0100
Subject: Re: [PATCH v2 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To: Guenter Roeck <linux@roeck-us.net>, mpe@ellerman.id.au
References: <1530695793-4584-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530695793-4584-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <e3a013fb-eaf0-8d45-2f23-3be8b3e5640b@roeck-us.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 4 Jul 2018 22:23:51 +0530
MIME-Version: 1.0
In-Reply-To: <e3a013fb-eaf0-8d45-2f23-3be8b3e5640b@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <c7e1272a-c9c8-a120-632f-7693cef3fd22@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guenter,

Thanks for reviewing the patch.
On 07/04/2018 08:16 PM, Guenter Roeck wrote:
>> +        /* Disable if last sensor in the group */
>> +        send_command = true;
>> +        for (i = 0; i < sg->nr_sensor; i++) {
>> +            struct sensor_data *sd = sg->sensors[i];
>> +
>> +            if (sd->enable) {
>> +                send_command = false;
>> +                break;
>> +            }
> 
> This is weird. So there are situations where a request to disable
> a sensor is accepted, but effectively ignored ? Shouldn't that
> return, say, -EBUSY ?

This is because we do not support per-sensor enable/disable. We can only
enable/disable at a sensor-group level.

This patch follows the semantic to disable a sensor group iff all the sensors
belonging to that group have been disabled. Otherwise the sensor alone is marked
to be disabled and returns -ENODATA on reading it.

And a sensor group will be enabled if any of the sensor in that group is enabled.

I will make changes to the remaining code according to your suggestion.

Thanks and Regards,
Shilpa
