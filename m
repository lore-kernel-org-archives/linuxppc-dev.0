Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKrmL6JYpzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 03:30:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sKrmL1KkQz9sCg
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2016 03:30:25 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7PHTgAd118289
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2016 13:30:16 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 250wuqqp2x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2016 13:30:16 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 03:30:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A22352CE8046
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2016 03:30:11 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7PHUB5J24313988
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2016 03:30:11 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7PHUBL8015256
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2016 03:30:11 +1000
Subject: Re: [PATCH v3 2/2] powerpc/fadump: parse fadump reserve memory size
 based on memory range
To: Dave Young <dyoung@redhat.com>
References: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
 <147082352471.4631.16292252236310652183.stgit@hbathini.in.ibm.com>
 <20160825070152.GA15879@dhcp-128-65.nay.redhat.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, vgoyal@redhat.com
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 25 Aug 2016 23:00:06 +0530
MIME-Version: 1.0
In-Reply-To: <20160825070152.GA15879@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <05642bf1-6e46-bab0-f871-9391996ff264@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 25 August 2016 12:31 PM, Dave Young wrote:
> On 08/10/16 at 03:35pm, Hari Bathini wrote:
>> When fadump is enabled, by default 5% of system RAM is reserved for
>> fadump kernel. While that works for most cases, it is not good enough
>> for every case.
>>
>> Currently, to override the default value, fadump supports specifying
>> memory to reserve with fadump_reserve_mem=size, where only a fixed size
>> can be specified. This patch adds support to specify memory size to
>> reserve for different memory ranges as below:
>>
>> 	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]
> Hi, Hari

Hi Dave,

> I do not understand why you need introduce the new cmdline param, what's
> the difference between the "fadump reserved" memory and the memory

I am not introducing a new parameter but adding a new syntax for
an existing parameter.

> reserved by "crashkernel="? Can fadump just use crashkernel= to reserve
> memory?

Not all syntaxes supported by crashkernel apply for fadump_reserve_mem.
Nonetheless, it is worth considering reuse of crashkernel parameter instead
of fadump_reserve_mem. Let me see what I can do about this..

Thanks
Hari

> Thanks
> Dave
>
>> Supporting range based input for "fadump_reserve_mem" parameter helps
>> using the same commandline parameter for different system memory sizes.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>
>> Changes from v2:
>> 1. Updated changelog
>>
>>
>>   arch/powerpc/kernel/fadump.c |   63 ++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 54 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index b3a6633..7c01b5b 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -193,6 +193,55 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>>   	return addr;
>>   }
>>   
>> +/*
>> + * This function parses command line for fadump_reserve_mem=
>> + *
>> + * Supports the below two syntaxes:
>> + *    1. fadump_reserve_mem=size
>> + *    2. fadump_reserve_mem=ramsize-range:size[,...]
>> + *
>> + * Sets fw_dump.reserve_bootvar with the memory size
>> + * provided, 0 otherwise
>> + *
>> + * The function returns -EINVAL on failure, 0 otherwise.
>> + */
>> +static int __init parse_fadump_reserve_mem(void)
>> +{
>> +	char *name = "fadump_reserve_mem=";
>> +	char *fadump_cmdline = NULL, *cur;
>> +
>> +	fw_dump.reserve_bootvar = 0;
>> +
>> +	/* find fadump_reserve_mem and use the last one if there are many */
>> +	cur = strstr(boot_command_line, name);
>> +	while (cur) {
>> +		fadump_cmdline = cur;
>> +		cur = strstr(cur+1, name);
>> +	}
>> +
>> +	/* when no fadump_reserve_mem= cmdline option is provided */
>> +	if (!fadump_cmdline)
>> +		return 0;
>> +
>> +	fadump_cmdline += strlen(name);
>> +
>> +	/* for fadump_reserve_mem=size cmdline syntax */
>> +	if (!is_colon_in_param(fadump_cmdline)) {
>> +		fw_dump.reserve_bootvar = memparse(fadump_cmdline, NULL);
>> +		return 0;
>> +	}
>> +
>> +	/* for fadump_reserve_mem=ramsize-range:size[,...] cmdline syntax */
>> +	cur = fadump_cmdline;
>> +	fw_dump.reserve_bootvar = parse_mem_range_size("fadump_reserve_mem",
>> +					&cur, memblock_phys_mem_size());
>> +	if (cur == fadump_cmdline) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
>>    *
>> @@ -212,12 +261,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>>   {
>>   	unsigned long size;
>>   
>> +	/* sets fw_dump.reserve_bootvar */
>> +	parse_fadump_reserve_mem();
>> +
>>   	/*
>>   	 * Check if the size is specified through fadump_reserve_mem= cmdline
>>   	 * option. If yes, then use that.
>>   	 */
>>   	if (fw_dump.reserve_bootvar)
>>   		return fw_dump.reserve_bootvar;
>> +	else
>> +		printk(KERN_INFO "fadump: calculating default boot size\n");
>>   
>>   	/* divide by 20 to get 5% of value */
>>   	size = memblock_end_of_DRAM() / 20;
>> @@ -348,15 +402,6 @@ static int __init early_fadump_param(char *p)
>>   }
>>   early_param("fadump", early_fadump_param);
>>   
>> -/* Look for fadump_reserve_mem= cmdline option */
>> -static int __init early_fadump_reserve_mem(char *p)
>> -{
>> -	if (p)
>> -		fw_dump.reserve_bootvar = memparse(p, &p);
>> -	return 0;
>> -}
>> -early_param("fadump_reserve_mem", early_fadump_reserve_mem);
>> -
>>   static void register_fw_dump(struct fadump_mem_struct *fdm)
>>   {
>>   	int rc;
>>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
