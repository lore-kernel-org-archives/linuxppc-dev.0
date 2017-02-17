Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPp2F0Lr3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 20:41:40 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H9dFwu070473
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:41:38 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nwc7b59e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:41:38 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 17 Feb 2017 19:31:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EC8212BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 20:31:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1H9VIqx20971620
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 20:31:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1H9Urlk005421
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 20:30:54 +1100
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <87shnek9hd.fsf@concordia.ellerman.id.au>
 <72cfff06-bd93-a727-0b93-31dfa3a7ac65@linux.vnet.ibm.com>
 <8466dffc-d75c-d83a-2a4f-d567721db7d5@linux.vnet.ibm.com>
 <87h93tjqrn.fsf@concordia.ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 17:30:23 +0800
MIME-Version: 1.0
In-Reply-To: <87h93tjqrn.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <cecc8a28-4e2f-8e03-0b1a-8a9ac60c0c71@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



ÔÚ 2017/2/17 14:05, Michael Ellerman Ð´µÀ:
> Pan Xinhui <xinhui@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 9c0e17c..f6e5c3d 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -76,6 +76,7 @@ static int xmon_gate;
>>   #endif /* CONFIG_SMP */
>>
>>   static unsigned long in_xmon __read_mostly = 0;
>> +static int xmon_off = !IS_ENABLED(CONFIG_XMON_DEFAULT);
>
> I think the logic would probably clearer if we invert this to become
> xmon_on.
>
yep, make sense.

>> @@ -3266,16 +3269,16 @@ static int __init setup_xmon_sysrq(void)
>>   __initcall(setup_xmon_sysrq);
>>   #endif /* CONFIG_MAGIC_SYSRQ */
>>
>> -static int __initdata xmon_early, xmon_off;
>> +static int __initdata xmon_early;
>>
>>   static int __init early_parse_xmon(char *p)
>>   {
>>   	if (!p || strncmp(p, "early", 5) == 0) {
>>   		/* just "xmon" is equivalent to "xmon=early" */
>> -		xmon_init(1);
>>   		xmon_early = 1;
>> +		xmon_off = 0;
>>   	} else if (strncmp(p, "on", 2) == 0)
>> -		xmon_init(1);
>> +		xmon_off = 0;
>
> You've just changed the timing of when xmon gets enabled for the above
> two cases, from here which is called very early, to xmon_setup() which
> is called much later in boot.
>
> That effectively disables xmon for most of the boot, which we do not
> want to do.
>
Although it is not often that kernel got stucked during boot. Yes, the behavior changed anyway. Will fix that in v3.

> cheers
>
