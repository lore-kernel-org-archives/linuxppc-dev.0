Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfc7V6qdXzDqvn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:59:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T8xYVN058039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 04:59:45 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt79t38-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 04:59:45 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 18:59:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B9F162BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:59:40 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T8xesX6750510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:59:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T8xdIX024241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:59:40 +1000
Date: Wed, 29 Jun 2016 14:29:36 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
CC: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 arnd@arndb.de, Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <57737AA1.7050201@linaro.org>
In-Reply-To: <57737AA1.7050201@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <57738DF8.3000909@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>
>> +/*
>> + * Used for calculating last_residency in usec. Optimized for case
>> + * where last_residency in nsecs is < INT_MAX/2 by using faster
>> + * approximation. Approximated value has less than 1% error.
>> + */
>> +static inline int convert_nsec_to_usec(u64 nsec)
>> +{
>> +    if (likely(nsec < INT_MAX / 2)) {
> 
> UINT_MAX ?

I don't think I can use UINT_MAX here since usec += usec >> 5 can
overflow. Also using INT_MAX / 2 instead of INT_MAX since potentially
usec += usec >> 5 can be negative and usec >> 10 will retain the sign bit.

> 
>> +        int usec = (int)nsec;
>> +
>> +        usec += usec >> 5;
>> +        usec = usec >> 10;
>> +        return usec;
>> +    } else {
>> +        u64 usec = div_u64(nsec, 1000);
>> +
>> +        if (usec > INT_MAX)
>> +            usec = INT_MAX;
>> +        return (int)usec;
>> +    }
>> +}
> 

Thanks,
Shreyas
