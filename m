Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbjkj68GYzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 02:01:49 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5OFxEQM047529
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 12:01:46 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ryh7uafv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 12:01:46 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 25 Jun 2016 02:01:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9BBEA2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 02:01:39 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5OG1dYN44040312
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 02:01:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5OG1d8P004789
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 02:01:39 +1000
Date: Fri, 24 Jun 2016 21:31:35 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
CC: David Laight <David.Laight@aculab.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "anton@samba.org" <anton@samba.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
 <14940457.SEYBmqcunj@wuerfel>
In-Reply-To: <14940457.SEYBmqcunj@wuerfel>
Content-Type: text/plain; charset=windows-1252
Message-Id: <576D595F.9090001@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/24/2016 03:41 PM, Arnd Bergmann wrote:
> On Friday, June 24, 2016 9:00:48 AM CEST David Laight wrote:
>> The intent of the >> 10 was probably to avoid an expensive 64bit divide.
>> So maybe something like:
>>         diff = time_end - time_start;
>>         if (diff >= INT_MAX/2)
>>                 diff_32 = INT_MAX/2/1000;
>>         else
>>                 diff_32 = diff;
>>                 diff_32 += diff_32 >> 6;
>>                 diff_32 >>= 10;
>>         }
>>
>> Adding an extra 1/32 makes the division by be something slightly below 1000.
> 
> Why not change the definition of the time to nanoseconds and update
> the users accordingly?
> 
> I see that cpuidle_enter_state() writes to the last_residency value,
> and it is read in three places: ladder_select_state(), menu_update()
> and show_state_time() (for sysfs).
> 

Updating show_state_time() to convert ns to us gets bit messy since
show_state_##_name which is used for disable, usage and time simply
returns state_usage->_name. And state_usage->time updation happens in
cpuidle_enter_state() itself.

> If those functions are called less often than cpuidle_enter_state(),
> we could just move the division there. Since the divisor is constant,
> do_div() can convert it into a multiply and shift, or we could use
> your the code you suggest above, or use a 32-bit division most of
> the time:
> 
> 	if (diff <= UINT_MAX)
> 		diff_32 = (u32)diff / NSECS_PER_USEC;
> 	else
> 		diff_32 = div_u64(diff, NSECS_PER_USEC;
> 
> which gcc itself will turn into a multiplication or series of
> shifts on CPUs on which that is faster.
>
I'm not sure which division method of the three suggested here to use.
Does anyone have a strong preference?

--Shreyas
