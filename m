Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkFQD2DMczDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 17:10:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkFQC54bXz9ry7
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 17:10:11 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6578dqH081402
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 03:10:09 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mdmneq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Jul 2016 03:10:09 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 5 Jul 2016 17:10:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BD5FA2CE805A
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 17:10:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u657A3lk3342370
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 17:10:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u657A3DL019394
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 17:10:03 +1000
Subject: Re: [v2,1/2] refactor code parsing size based on memory range
To: Michael Ellerman <mpe@ellerman.id.au>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3rbRd54y9Vz9t0p@ozlabs.org>
 <52b513d4-16a2-ca16-975e-a755b7a5ea8d@linux.vnet.ibm.com>
 <87twg4br3q.fsf@@concordia.ellerman.id.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 12:40:00 +0530
MIME-Version: 1.0
In-Reply-To: <87twg4br3q.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <626eae51-9e4a-573e-9ae5-6417315522f1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/05/2016 10:48 AM, Michael Ellerman wrote:
>> On 06/24/2016 10:56 AM, Michael Ellerman wrote:
>>> On Wed, 2016-22-06 at 19:25:26 UTC, Hari Bathini wrote:
> ...
>> While the code is moved to kernel/params.c file, there is no change in logic
>> for crashkernel parameter parsing as the moved code is invoked with function
>> calls at appropriate places.

Hi Michael,

> Are you sure that's true?

Yes. I tested it.

>
> The old code would return -EINVAL from parse_crashkernel_mem() for any
> error, regardless of whether it had already parsed some of the string.
>
> eg:
>
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 56b3ed0..d43f5cc 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>>>>    	char *cur = cmdline, *tmp;
>>>>    
>>>>    	/* for each entry of the comma-separated list */
>>>> -	do {
>>>> -		unsigned long long start, end = ULLONG_MAX, size;
>>>> -
>>>> -		/* get the start of the range */
>>>> -		start = memparse(cur, &tmp);
>>>> -		if (cur == tmp) {
>>>> -			pr_warn("crashkernel: Memory value expected\n");
>>>> -			return -EINVAL;
>>>> -		}
>>>> -		cur = tmp;
>>>> -		if (*cur != '-') {
>>>> -			pr_warn("crashkernel: '-' expected\n");
>>>> -			return -EINVAL;
>>>> -		}
>>>> -		cur++;
>>>> -
>>>> -		/* if no ':' is here, than we read the end */
>>>> -		if (*cur != ':') {
>>>> -			end = memparse(cur, &tmp);
>>>> -			if (cur == tmp) {
>>>> -				pr_warn("crashkernel: Memory value expected\n");
>>>> -				return -EINVAL;
>>>> -			}
> So eg, if I give it "128M-foo" it will modify cur, and then error out here ^

It does modify cur (local variable) but that would have no bearing on 
parsing logic
as we are returning immediately..

> You've changed that to:
>
>>>> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
>>>> +	if (cur == cmdline)
>>>> +		return -EINVAL;
> Which only returns EINVAL if cur is not modified at all.

I think the confusion is with the same local variable cur in 
parse_crashkernel_mem()
& parse_mem_range_size() functions.

We modified cur (local variable) in parse_mem_range_size() but the 
output parameter (char **str)
remains unchanged unless we find a match.

Thanks
Hari

> And looking below:
>
>>>> diff --git a/kernel/params.c b/kernel/params.c
>>>> index a6d6149..84e40ae 100644
>>>> --- a/kernel/params.c
>>>> +++ b/kernel/params.c
> ...
>>>> +unsigned long long __init parse_mem_range_size(const char *param,
>>>> +					       char **str,
>>>> +					       unsigned long long system_ram)
>>>> +{
>>>> +	char *cur = *str, *tmp;
>>>> +	unsigned long long mem_size = 0;
>>>> +
>>>> +	/* for each entry of the comma-separated list */
>>>> +	do {
>>>> +		unsigned long long start, end = ULLONG_MAX, size;
>>>> +
>>>> +		/* get the start of the range */
>>>> +		start = memparse(cur, &tmp);
>>>> +		if (cur == tmp) {
>>>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>>>> +			return mem_size;
>>>> +		}
>>>> +		cur = tmp;
>>>> +		if (*cur != '-') {
>>>> +			printk(KERN_INFO "%s: '-' expected\n", param);
>>>> +			return mem_size;
>>>> +		}
>>>> +		cur++;
>>>> +
>>>> +		/* if no ':' is here, than we read the end */
>>>> +		if (*cur != ':') {
>>>> +			end = memparse(cur, &tmp);
>>>> +			if (cur == tmp) {
>>>> +				printk(KERN_INFO "%s: Memory value expected\n",
>>>> +					param);
>>>> +				return mem_size;
> If we error out here for example, we have modified cur, so the code above
> *won't* return EINVAL.

>
> Which looks like a behaviour change to me?
>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
