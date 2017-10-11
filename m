Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBhGV02BXzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 15:44:33 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B4iS2B075234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:44:31 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2s7926j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:44:31 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 05:44:16 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9B4iCUH23724066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:44:13 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9B4iCfX007916
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 15:44:12 +1100
Subject: Re: [PATCH] powerpc/perf: Fix IMC initialization crash
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 hemant@linux.vnet.ibm.com, ppaidipe@linux.vnet.ibm.com
References: <1507654315-1620-1-git-send-email-anju@linux.vnet.ibm.com>
 <87fuaqz5ki.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 10:14:08 +0530
MIME-Version: 1.0
In-Reply-To: <87fuaqz5ki.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <15763134-6b59-ca46-9e74-19f213f6d83f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 11 October 2017 09:41 AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> Call trace observed with latest firmware, and upstream kernel.
>>
>> [   14.499938] NIP [c0000000000f318c] init_imc_pmu+0x8c/0xcf0
>> [   14.499973] LR [c0000000000f33f8] init_imc_pmu+0x2f8/0xcf0
>> [   14.500007] Call Trace:
>> [   14.500027] [c000003fed18f710] [c0000000000f33c8] init_imc_pmu+0x2c8/0xcf0 (unreliable)
>> [   14.500080] [c000003fed18f800] [c0000000000b5ec0] opal_imc_counters_probe+0x300/0x400
>> [   14.500132] [c000003fed18f900] [c000000000807ef4] platform_drv_probe+0x64/0x110
>> [   14.500185] [c000003fed18f980] [c000000000804b58] driver_probe_device+0x3d8/0x580
>> [   14.500236] [c000003fed18fa10] [c000000000804e4c] __driver_attach+0x14c/0x1a0
>> [   14.500302] [c000003fed18fa90] [c00000000080156c] bus_for_each_dev+0x8c/0xf0
>> [   14.500353] [c000003fed18fae0] [c000000000803fa4] driver_attach+0x34/0x50
>> [   14.500397] [c000003fed18fb00] [c000000000803688] bus_add_driver+0x298/0x350
>> [   14.500449] [c000003fed18fb90] [c00000000080605c] driver_register+0x9c/0x180
>> [   14.500500] [c000003fed18fc00] [c000000000807dec] __platform_driver_register+0x5c/0x70
>> [   14.500552] [c000003fed18fc20] [c00000000101cee0] opal_imc_driver_init+0x2c/0x40
>> [   14.500603] [c000003fed18fc40] [c00000000000d084] do_one_initcall+0x64/0x1d0
>> [   14.500654] [c000003fed18fd00] [c00000000100434c] kernel_init_freeable+0x280/0x374
>> [   14.500705] [c000003fed18fdc0] [c00000000000d314] kernel_init+0x24/0x160
>> [   14.500750] [c000003fed18fe30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
>> [   14.500799] Instruction dump:
>> [   14.500827] 4082024c 2f890002 419e054c 2e890003 41960094 2e890001 3ba0ffea 419602d8
>> [   14.500884] 419e0290 2f890003 419e02a8 e93e0118 <e8690018> 2fa30000 419e0010 4827ba41
>> [   14.500945] ---[ end trace 27b734ad26f1add4 ]---
>> [   15.908719]
>> [   16.908869] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>> [   16.908869]
>> [   18.125813] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007]
>>
>> While registering nest imc at init, cpu-hotplug callback `nest_pmu_cpumask_init()`
>> makes an opal call to stop the engine. And if the OPAL call fails,
>> imc_common_cpuhp_mem_free() is invoked to cleanup memory and cpuhotplug setup.
>>
>> But when cleaning up the attribute group, we were dereferencing the attribute
>> element array without checking whether the backing element is not NULL. This
>> causes the kernel panic.
>>
>> Factor out the memory freeing part from imc_common_cpuhp_mem_free() to handle
>> the failing case gracefully.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/imc-pmu.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
> It's the week before rc5, so I'd really like just the absolute minimal
> fix. There's sufficient code movement here that I can't even immediately
> see where the bug fix is.
mpe,

We have just re-factored the code to handle the memory freeing and fixed 
a leak.
This is minimal fix. And there are no risks in taking this in.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Maddy

>
> cheers
>
