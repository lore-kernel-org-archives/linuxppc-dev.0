Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBwr4RWkzDrDn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:18:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [v2,1/2] refactor code parsing size based on memory range
In-Reply-To: <52b513d4-16a2-ca16-975e-a755b7a5ea8d@linux.vnet.ibm.com>
References: <3rbRd54y9Vz9t0p@ozlabs.org>
 <52b513d4-16a2-ca16-975e-a755b7a5ea8d@linux.vnet.ibm.com>
Date: Tue, 05 Jul 2016 15:18:01 +1000
Message-ID: <87twg4br3q.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 06/24/2016 10:56 AM, Michael Ellerman wrote:
>> On Wed, 2016-22-06 at 19:25:26 UTC, Hari Bathini wrote:
...
> While the code is moved to kernel/params.c file, there is no change in logic
> for crashkernel parameter parsing as the moved code is invoked with function
> calls at appropriate places.

Are you sure that's true?

The old code would return -EINVAL from parse_crashkernel_mem() for any
error, regardless of whether it had already parsed some of the string.

eg:

>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>> index 56b3ed0..d43f5cc 100644
>>> --- a/kernel/kexec_core.c
>>> +++ b/kernel/kexec_core.c
>>> @@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>>>   	char *cur = cmdline, *tmp;
>>>   
>>>   	/* for each entry of the comma-separated list */
>>> -	do {
>>> -		unsigned long long start, end = ULLONG_MAX, size;
>>> -
>>> -		/* get the start of the range */
>>> -		start = memparse(cur, &tmp);
>>> -		if (cur == tmp) {
>>> -			pr_warn("crashkernel: Memory value expected\n");
>>> -			return -EINVAL;
>>> -		}
>>> -		cur = tmp;
>>> -		if (*cur != '-') {
>>> -			pr_warn("crashkernel: '-' expected\n");
>>> -			return -EINVAL;
>>> -		}
>>> -		cur++;
>>> -
>>> -		/* if no ':' is here, than we read the end */
>>> -		if (*cur != ':') {
>>> -			end = memparse(cur, &tmp);
>>> -			if (cur == tmp) {
>>> -				pr_warn("crashkernel: Memory value expected\n");
>>> -				return -EINVAL;
>>> -			}

So eg, if I give it "128M-foo" it will modify cur, and then error out here ^

You've changed that to:

>>> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
>>> +	if (cur == cmdline)
>>> +		return -EINVAL;

Which only returns EINVAL if cur is not modified at all.

And looking below:

>>> diff --git a/kernel/params.c b/kernel/params.c
>>> index a6d6149..84e40ae 100644
>>> --- a/kernel/params.c
>>> +++ b/kernel/params.c
...
>>> +unsigned long long __init parse_mem_range_size(const char *param,
>>> +					       char **str,
>>> +					       unsigned long long system_ram)
>>> +{
>>> +	char *cur = *str, *tmp;
>>> +	unsigned long long mem_size = 0;
>>> +
>>> +	/* for each entry of the comma-separated list */
>>> +	do {
>>> +		unsigned long long start, end = ULLONG_MAX, size;
>>> +
>>> +		/* get the start of the range */
>>> +		start = memparse(cur, &tmp);
>>> +		if (cur == tmp) {
>>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>>> +			return mem_size;
>>> +		}
>>> +		cur = tmp;
>>> +		if (*cur != '-') {
>>> +			printk(KERN_INFO "%s: '-' expected\n", param);
>>> +			return mem_size;
>>> +		}
>>> +		cur++;
>>> +
>>> +		/* if no ':' is here, than we read the end */
>>> +		if (*cur != ':') {
>>> +			end = memparse(cur, &tmp);
>>> +			if (cur == tmp) {
>>> +				printk(KERN_INFO "%s: Memory value expected\n",
>>> +					param);
>>> +				return mem_size;

If we error out here for example, we have modified cur, so the code above
*won't* return EINVAL.

Which looks like a behaviour change to me?

cheers
