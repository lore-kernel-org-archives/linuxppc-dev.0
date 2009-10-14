Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78F1CB7B77
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:13:30 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n9E6Au0F031133
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:10:56 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9E6DSQI1343652
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:13:28 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9E6DRrj020872
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:13:28 +1100
Message-ID: <4AD56C05.9030602@in.ibm.com>
Date: Wed, 14 Oct 2009 11:43:25 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: rostedt@goodmis.org
Subject: Re: [PATCH] Ftrace : fix function_graph tracer OOPS
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop>
	<1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
	<4ACC57C4.5010002@in.ibm.com> <1254906621.2409.1.camel@pasglop>
	<4ACDFC83.4080205@in.ibm.com>
	<1255489284.7113.3121.camel@gandalf.stny.rr.com>
In-Reply-To: <1255489284.7113.3121.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Thu, 2009-10-08 at 20:21 +0530, Sachin Sant wrote:
>   
>> Switch to LOAD_REG_ADDR().
>>
>> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
>> ---
>> diff -Naurp old/arch/powerpc/kernel/entry_64.S
>> new/arch/powerpc/kernel/entry_64.S
>> --- old/arch/powerpc/kernel/entry_64.S  2009-10-08 18:37:44.000000000
>> +0530
>> +++ new/arch/powerpc/kernel/entry_64.S  2009-10-08 18:34:33.000000000
>> +0530
>> @@ -1038,8 +1038,8 @@ _GLOBAL(mod_return_to_handler)
>>          * We are in a module using the module's TOC.
>>          * Switch to our TOC to run inside the core kernel.
>>          */
>> -       LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
>> -       ld      r2, 8(r4)
>> +       ld      r2, PACATOC(r13)
>> +       LOAD_REG_ADDR(r4,ftrace_return_to_handler)
>>     
>
> Actually, the loading of this register is not needed. The original used
> the loading to get the r2.
>
> I actually wrote a fix for this a month ago. I never sent it out because
> I was distracted by other issues.
>
> I'll send out the two patches I had now.
>
> Could yo test them?
>   
Tested both the patches. Works fine.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
