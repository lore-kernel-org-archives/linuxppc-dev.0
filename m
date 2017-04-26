Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCfsm5VCLzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 22:44:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
In-Reply-To: <d4e1ab57-7512-8697-79c8-456fda5d5e97@linux.vnet.ibm.com>
References: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
 <87o9vj1mso.fsf@concordia.ellerman.id.au>
 <d4e1ab57-7512-8697-79c8-456fda5d5e97@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 22:44:25 +1000
Message-ID: <87fugv1gpi.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> On Wednesday 26 April 2017 04:02 PM, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>
>>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>>> index 8ff0dd4..87edc7b 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -338,6 +343,36 @@ unsigned long __init arch_reserved_kernel_pages(void)
>>>   	return memblock_reserved_size() / PAGE_SIZE;
>>>   }
>>>   
>>> +static void __init parse_fadump_append_params(const char *p)
>>> +{
>>> +	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
>>> +	char *token;
>>> +
>>> +	strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
>>> +	token = strchr(fadump_cmdline, ',');
>>> +	while (token) {
>>> +		*token = ' ';
>>> +		token = strchr(token, ',');
>>> +	}
>>> +
>>> +	pr_info("enforcing additional parameters (%s) passed through "
>>> +		"'fadump_append=' parameter\n", fadump_cmdline);
>>> +	parse_early_options(fadump_cmdline);
>> Using parse_early_options() means it only works for parameters defined
>> with early_param() or __setup() doesn't it?
>
> Yeah. Actually, is it better to change commandline from "$params 
> fadump_append=nr_cpus=1,numa=off"
> to "$params nr_cpus=1 numa=off" early in the boot process?

It's not better, it's more confusing for a user, because the command
line looks different to what they specified.

But it might be the only option because I don't know if there's an easy
way to trigger parsing for the non-early options.

cheers
