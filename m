Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNKT31PKrzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 01:11:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4AErgZ0060580
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 11:11:24 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ac3jwp1hv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 11:11:24 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 11 May 2017 01:11:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4AFBBNW61145160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 01:11:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4AFAfNb025914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 01:10:41 +1000
Subject: Re: [PATCH v4 RFT 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20170502155611.6789-1-msuchanek@suse.de>
 <765ca86f-b6c5-190e-b3a9-91282e199baf@linux.vnet.ibm.com>
 <20170510165827.5a2e1022@kitsune.suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 20:40:22 +0530
MIME-Version: 1.0
In-Reply-To: <20170510165827.5a2e1022@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7c515276-81f0-8595-7deb-93ddbec6bb30@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 10 May 2017 08:28 PM, Michal Suchánek wrote:
> On Wed, 3 May 2017 12:43:33 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> On Tuesday 02 May 2017 09:26 PM, Michal Suchanek wrote:
>>> With fadump (dump capture) kernel booting like a regular kernel, it
>>> almost needs the same amount of memory to boot as the production
>>> kernel, which is unwarranted for a dump capture kernel. But with no
>>> option to disable some of the unnecessary subsystems in fadump
>>> kernel, that much memory is wasted on fadump, depriving the
>>> production kernel of that memory.
>>>
>>> Introduce kernel parameter 'fadump_append=' that would take regular
>>> kernel parameters to be appended when fadump is active.
>>> This 'fadump_append=' parameter can be leveraged to pass parameters
>>> like nr_cpus=1, cgroup_disable=memory and numa=off, to disable
>>> unwarranted resources/subsystems.
>>>
>>> Also, ensure the log "Firmware-assisted dump is active" is printed
>>> early in the boot process to put the subsequent fadump messages in
>>> context.
>>>
>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>> v4:
>>>    - use space separated arguments instead of comma separated
>>>    - do not append parameters when fadummp is disabled
>>> ---
>>>    arch/powerpc/kernel/fadump.c | 27 ++++++++++++++++++++++++---
>>>    1 file changed, 24 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/fadump.c
>>> b/arch/powerpc/kernel/fadump.c index ebf2e9c..e0c728a 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned
>>> long node,
>>>    	 * dump data waiting for us.
>>>    	 */
>>>    	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump",
>>> NULL);
>>> -	if (fdm_active)
>>> +	if (fdm_active) {
>>> +		pr_info("Firmware-assisted dump is active.\n");
>>>    		fw_dump.dump_active = 1;
>>> +	}
>>>
>>>    	/* Get the sizes required to store dump data for the
>>> firmware provided
>>>    	 * dump sections.
>>> @@ -263,8 +265,12 @@ int __init fadump_reserve_mem(void)
>>>    {
>>>    	unsigned long base, size, memory_boundary;
>>>
>>> -	if (!fw_dump.fadump_enabled)
>>> +	if (!fw_dump.fadump_enabled) {
>>> +		if (fw_dump.dump_active)
>>> +			pr_warn("Firmware-assisted dump was active
>>> but kernel"
>>> +				" booted with fadump disabled!\n");
>>>    		return 0;
>>> +	}
>>>
>>>    	if (!fw_dump.fadump_supported) {
>>>    		printk(KERN_INFO "Firmware-assisted dump is not
>>> supported on" @@ -304,7 +310,6 @@ int __init
>>> fadump_reserve_mem(void) memory_boundary = memblock_end_of_DRAM();
>>>
>>>    	if (fw_dump.dump_active) {
>>> -		printk(KERN_INFO "Firmware-assisted dump is
>>> active.\n"); /*
>>>    		 * If last boot has crashed then reserve all the
>>> memory
>>>    		 * above boot_memory_size so that we don't touch
>>> it until @@ -363,6 +368,22 @@ unsigned long __init
>>> arch_reserved_kernel_pages(void) return memblock_reserved_size() /
>>> PAGE_SIZE; }
>>>
>>> +/* Look for fadump_append= cmdline option. */
>>> +static int __init early_fadump_append_param(char *p)
>>> +{
>>> +	if (!p)
>>> +		return 1;
>>> +
>>> +	if (fw_dump.fadump_enabled && fw_dump.dump_active) {
>>> +	pr_info("enforcing additional parameters (%s) passed
>>> through "
>>> +		"'fadump_append=' parameter\n", p);
>>> +		parse_early_options(p);
>> While testing this on a system with yaboot bootloader, it seems that
>> parsing a parameter with syntax like fadump_append="nr_cpus=1
>> numa=off" is not resulting in the intended way..
> Since yaboot arguments are quoted you will probably want something like
>
> append = "quiet splash somearg1 somearg2 fadump_append=\"nr_cpus=1
> numa=off\""

I did try this out. But it wasn't helping either..

> in yaboot.conf
>
> Looking at the yaboot parser it seems to handle quoting of quotes so
> unlike your parser that does not handle quoting of commas it allows
> passing arbitrary arguments to both the normal kernel and the fadump
> kernel.

Will improve on v5 to ensure quotes are taken care of..

Thanks
Hari
