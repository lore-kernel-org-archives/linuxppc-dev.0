Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rblN12KBdzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 03:15:45 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rblN059kCz9t1K
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2016 03:15:44 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5OH8gkx009352
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 13:15:42 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23s4csb9rc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 13:15:42 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 25 Jun 2016 03:15:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 68A443578053
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2016 03:15:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5OHFauB12976326
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2016 03:15:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5OHFZp4022707
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2016 03:15:36 +1000
Subject: Re: [v2,1/2] refactor code parsing size based on memory range
To: Michael Ellerman <mpe@ellerman.id.au>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3rbRd54y9Vz9t0p@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 24 Jun 2016 22:45:32 +0530
MIME-Version: 1.0
In-Reply-To: <3rbRd54y9Vz9t0p@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <52b513d4-16a2-ca16-975e-a755b7a5ea8d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/24/2016 10:56 AM, Michael Ellerman wrote:
> On Wed, 2016-22-06 at 19:25:26 UTC, Hari Bathini wrote:
>> Currently, crashkernel parameter supports the below syntax to parse size
>> based on memory range:
>>
>> 	crashkernel=<range1>:<size1>[,<range2>:<size2>,...]
>>
>> While such parsing is implemented for crashkernel parameter, it applies to
>> other parameters with similar syntax. So, move this code to a more generic
>> place for code reuse.
>>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Hari, it's not immediately clear that this makes no change to the logic in the
> kexec code. Can you reply with a longer change log explaining why the old & new
> logic is the same for kexec.
>

Hi Michael,

Please consider this changelog for this patch:

--
crashkernel parameter supports different syntaxes to specify the amount
of memory to be reserved for kdump kernel. Below is one of the supported
syntaxes that needs parsing to find the memory size to reserve, based on
memory range:

crashkernel=<range1>:<size1>[,<range2>:<size2>,...]

While such parsing is implemented for crashkernel parameter, it applies to
other parameters, like fadump_reserve_mem, which could use similar syntax.
So, to reuse code, moving the code that checks if the parameter syntax is as
above and also the code that parses memory size to reserve, for this syntax.
While the code is moved to kernel/params.c file, there is no change in logic
for crashkernel parameter parsing as the moved code is invoked with function
calls at appropriate places.
--

Thanks
Hari

>
>
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index 94aa10f..72f55e5 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -436,6 +436,11 @@ extern char *get_options(const char *str, int nints, int *ints);
>>   extern unsigned long long memparse(const char *ptr, char **retptr);
>>   extern bool parse_option_str(const char *str, const char *option);
>>   
>> +extern bool __init is_param_range_based(const char *cmdline);
>> +extern unsigned long long __init parse_mem_range_size(const char *param,
>> +						      char **str,
>> +						      unsigned long long system_ram);
>> +
>>   extern int core_kernel_text(unsigned long addr);
>>   extern int core_kernel_data(unsigned long addr);
>>   extern int __kernel_text_address(unsigned long addr);
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 56b3ed0..d43f5cc 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>>   	char *cur = cmdline, *tmp;
>>   
>>   	/* for each entry of the comma-separated list */
>> -	do {
>> -		unsigned long long start, end = ULLONG_MAX, size;
>> -
>> -		/* get the start of the range */
>> -		start = memparse(cur, &tmp);
>> -		if (cur == tmp) {
>> -			pr_warn("crashkernel: Memory value expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur = tmp;
>> -		if (*cur != '-') {
>> -			pr_warn("crashkernel: '-' expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur++;
>> -
>> -		/* if no ':' is here, than we read the end */
>> -		if (*cur != ':') {
>> -			end = memparse(cur, &tmp);
>> -			if (cur == tmp) {
>> -				pr_warn("crashkernel: Memory value expected\n");
>> -				return -EINVAL;
>> -			}
>> -			cur = tmp;
>> -			if (end <= start) {
>> -				pr_warn("crashkernel: end <= start\n");
>> -				return -EINVAL;
>> -			}
>> -		}
>> -
>> -		if (*cur != ':') {
>> -			pr_warn("crashkernel: ':' expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur++;
>> -
>> -		size = memparse(cur, &tmp);
>> -		if (cur == tmp) {
>> -			pr_warn("Memory value expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur = tmp;
>> -		if (size >= system_ram) {
>> -			pr_warn("crashkernel: invalid size\n");
>> -			return -EINVAL;
>> -		}
>> -
>> -		/* match ? */
>> -		if (system_ram >= start && system_ram < end) {
>> -			*crash_size = size;
>> -			break;
>> -		}
>> -	} while (*cur++ == ',');
>> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
>> +	if (cur == cmdline)
>> +		return -EINVAL;
>>   
>>   	if (*crash_size > 0) {
>>   		while (*cur && *cur != ' ' && *cur != '@')
>> @@ -1272,7 +1222,6 @@ static int __init __parse_crashkernel(char *cmdline,
>>   			     const char *name,
>>   			     const char *suffix)
>>   {
>> -	char	*first_colon, *first_space;
>>   	char	*ck_cmdline;
>>   
>>   	BUG_ON(!crash_size || !crash_base);
>> @@ -1290,12 +1239,10 @@ static int __init __parse_crashkernel(char *cmdline,
>>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>   				suffix);
>>   	/*
>> -	 * if the commandline contains a ':', then that's the extended
>> +	 * if the parameter is range based, then that's the extended
>>   	 * syntax -- if not, it must be the classic syntax
>>   	 */
>> -	first_colon = strchr(ck_cmdline, ':');
>> -	first_space = strchr(ck_cmdline, ' ');
>> -	if (first_colon && (!first_space || first_colon < first_space))
>> +	if (is_param_range_based(ck_cmdline))
>>   		return parse_crashkernel_mem(ck_cmdline, system_ram,
>>   				crash_size, crash_base);
>>   
>> diff --git a/kernel/params.c b/kernel/params.c
>> index a6d6149..84e40ae 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -268,6 +268,102 @@ char *parse_args(const char *doing,
>>   	return err;
>>   }
>>   
>> +/*
>> + * is_param_range_based - check if current parameter is range based
>> + * @cmdline: points to the parameter to check
>> + *
>> + * Returns true when the current paramer is range based, false otherwise
>> + */
>> +bool __init is_param_range_based(const char *cmdline)
>> +{
>> +	char    *first_colon, *first_space;
>> +
>> +	first_colon = strchr(cmdline, ':');
>> +	first_space = strchr(cmdline, ' ');
>> +	if (first_colon && (!first_space || first_colon < first_space))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +/*
>> + * parse_mem_range_size - parse size based on memory range
>> + * @param:  the thing being parsed
>> + * @str: (input)  where parse begins
>> + *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
>> + *       (output) On success - next char after parse completes
>> + *                On failure - unchanged
>> + * @system_ram: system ram size to check memory range against
>> + *
>> + * Returns the memory size on success and 0 on failure
>> + */
>> +unsigned long long __init parse_mem_range_size(const char *param,
>> +					       char **str,
>> +					       unsigned long long system_ram)
>> +{
>> +	char *cur = *str, *tmp;
>> +	unsigned long long mem_size = 0;
>> +
>> +	/* for each entry of the comma-separated list */
>> +	do {
>> +		unsigned long long start, end = ULLONG_MAX, size;
>> +
>> +		/* get the start of the range */
>> +		start = memparse(cur, &tmp);
>> +		if (cur == tmp) {
>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur = tmp;
>> +		if (*cur != '-') {
>> +			printk(KERN_INFO "%s: '-' expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur++;
>> +
>> +		/* if no ':' is here, than we read the end */
>> +		if (*cur != ':') {
>> +			end = memparse(cur, &tmp);
>> +			if (cur == tmp) {
>> +				printk(KERN_INFO "%s: Memory value expected\n",
>> +					param);
>> +				return mem_size;
>> +			}
>> +			cur = tmp;
>> +			if (end <= start) {
>> +				printk(KERN_INFO "%s: end <= start\n", param);
>> +				return mem_size;
>> +			}
>> +		}
>> +
>> +		if (*cur != ':') {
>> +			printk(KERN_INFO "%s: ':' expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur++;
>> +
>> +		size = memparse(cur, &tmp);
>> +		if (cur == tmp) {
>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur = tmp;
>> +		if (size >= system_ram) {
>> +			printk(KERN_INFO "%s: invalid size\n", param);
>> +			return mem_size;
>> +		}
>> +
>> +		/* match ? */
>> +		if (system_ram >= start && system_ram < end) {
>> +			mem_size = size;
>> +			*str = cur;
>> +			break;
>> +		}
>> +	} while (*cur++ == ',');
>> +
>> +	return mem_size;
>> +}
>> +
>>   /* Lazy bastard, eh? */
>>   #define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
>>   	int param_set_##name(const char *val, const struct kernel_param *kp) \
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
