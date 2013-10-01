Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A37C62C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 18:09:47 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 13:39:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 78708394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 13:39:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r918C39F46596258
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 13:42:03 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9189e7x016930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 13:39:40 +0530
Message-ID: <524A8343.5030609@linux.vnet.ibm.com>
Date: Tue, 01 Oct 2013 13:39:39 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/kernel/sysfs: disable writing to purr in
 non-powernv
References: <1380281634-9921-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20131001063129.GF17966@concordia>
In-Reply-To: <20131001063129.GF17966@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 01 October 2013 12:01 PM, Michael Ellerman wrote:
> Hi Maddy,
> 
> On Fri, Sep 27, 2013 at 05:03:54PM +0530, Madhavan Srinivasan wrote:
>> powerpc/kernel/sysfs.c exports purr with write permission.
> 
> PURR
> 
>> This is only valid for kernel in hypervisor mode.
>> But writing to the file in PowerVM lpar causes crash.
> 
> In the kernel history/source we refer to it as "phyp". However in this

Will follow the convention.

> case it's not an issue with phyp, it's simply that you are not in
> hypervisor mode, ie. the same crash would occur under KVM.
> 
> So you should just say "writing to the file in guest mode .."
> 

Sure. Will make the changes.

>> # echo 0 > purr
>> cpu 0x0: Vector: 700 (Program Check) at [c000000000d072b0]
>>     pc: c00000000001770c: .write_purr+0x1c/0x40
>>     lr: c000000000017708: .write_purr+0x18/0x40
>>     sp: c000000000d07530
>>    msr: 8000000000049032
>>   current = 0xc000000000c53de0
>>   paca    = 0xc00000000ec70000	 softe: 0	 irq_happened: 0x01
>>     pid   = 0, comm = swapper/0
>> enter ? for help
>> [c000000000d075b0] c0000000000fba64
>> .generic_smp_call_function_single_interrupt+0x104/0x190
>> [c000000000d07650] c000000000037748 .smp_ipi_demux+0xa8/0xf0
>> [c000000000d076e0] c000000000035314 .doorbell_exception+0x74/0xb0
>> [c000000000d07760] c000000000002950 doorbell_super_common+0x150/0x180
>> --- Exception: a01 (Doorbell) at c000000000060904
>> .plpar_hcall_norets+0x84/0xd4
>> [link register   ] c00000000006dbd4 .check_and_cede_processor+0x24/0x40
>> [c000000000d07a50] c000000001002558 (unreliable)
>> [c000000000d07ac0] c00000000006dd0c .shared_cede_loop+0x2c/0x70
>> [c000000000d07b40] c0000000006ae954 .cpuidle_enter_state+0x64/0x150
>> [c000000000d07c00] c0000000006aeb30 .cpuidle_idle_call+0xf0/0x300
>> [c000000000d07cb0] c000000000062fa0 .pseries_lpar_idle+0x10/0x50
>> [c000000000d07d20] c000000000016d14 .arch_cpu_idle+0x64/0x150
>> [c000000000d07da0] c0000000000e0060 .cpu_startup_entry+0x1a0/0x2c0
>> [c000000000d07e80] c00000000000bca4 .rest_init+0x94/0xb0
>> [c000000000d07ef0] c000000000b54530 .start_kernel+0x478/0x494
>> [c000000000d07f90] c000000000009be0 .start_here_common+0x20/0x40
>> 0:mon>
>>
>> Changes:
>>
>> 1)Changed the test for to hypervisor mode instead of platform
> 
> I think Ben's wrong about that.
> 
> Almost all existing code uses FW_FEATURE_LPAR to differentiate
> hypervisor vs guest mode, so I think we should do the same here.
> 
> So it would be:
> 
>> +	if (cpu_has_feature(CPU_FTR_PURR)) {
>> +		if (!firmware_has_feature(FW_FEATURE_LPAR))
>> +			add_write_permission_dev_attr((void *)&dev_attr_purr);
>>  		device_create_file(s, &dev_attr_purr);
>> +	}
>

Will modify the check.

> 
>> +static void add_write_permission_dev_attr(void *ptr)
>> +{
>> +	struct device_attribute *attr = (struct device_attribute *)ptr;
>> +
>> +	attr->attr.mode |= (unsigned short) 0200;
>> +}
> 
> Why does it take a void *, which then requires a cast at the call site?
>

just prefered to send the address as void.

> And do you need the cast to short? If so shouldn't you use umode_t
> directly?

No, not really.
Will make the changes and will resend the patch.

> 
> cheers
> 
Thanks for feedback.
Maddy
