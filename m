Return-Path: <srs0=xksd=4c=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCfDw2Pg9zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 22:16:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCfDw1zNjz8t6s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 22:16:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCfDv4xDyz9s3w
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 22:15:59 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3QC8vng039484
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 08:15:55 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2eburb1h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 08:15:50 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 22:15:16 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3QCF9FW47317066
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 22:15:12 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3QC32Q2017975
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 22:03:02 +1000
Subject: Re: [PATCH v3 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
To: Michael Ellerman <mpe@ellerman.id.au>
References: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
 <87o9vj1mso.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 17:32:44 +0530
MIME-Version: 1.0
In-Reply-To: <87o9vj1mso.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d4e1ab57-7512-8697-79c8-456fda5d5e97@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 26 April 2017 04:02 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 8ff0dd4..87edc7b 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -338,6 +343,36 @@ unsigned long __init arch_reserved_kernel_pages(void)
>>   	return memblock_reserved_size() / PAGE_SIZE;
>>   }
>>   
>> +static void __init parse_fadump_append_params(const char *p)
>> +{
>> +	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
>> +	char *token;
>> +
>> +	strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
>> +	token = strchr(fadump_cmdline, ',');
>> +	while (token) {
>> +		*token = ' ';
>> +		token = strchr(token, ',');
>> +	}
>> +
>> +	pr_info("enforcing additional parameters (%s) passed through "
>> +		"'fadump_append=' parameter\n", fadump_cmdline);
>> +	parse_early_options(fadump_cmdline);
> Using parse_early_options() means it only works for parameters defined
> with early_param() or __setup() doesn't it?

Yeah. Actually, is it better to change commandline from "$params 
fadump_append=nr_cpus=1,numa=off"
to "$params nr_cpus=1 numa=off" early in the boot process? That way, 
parameters like udev.children-max=2 &
systemd.unit=kdump.service may also be specified in fadump_append= 
parameter?

Thanks
Hari
