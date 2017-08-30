Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj7QB13k8zDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 00:37:37 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UEYukP068328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:37:35 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cnvaaerpx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:37:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 08:37:34 -0600
Subject: Re: Question: handling early hotplug interrupts
To: Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>
References: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
 <1504043700.2358.37.camel@au1.ibm.com>
 <518374ee-43bd-f873-7742-6c0d42db68d8@linux.vnet.ibm.com>
 <87378937tk.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 09:37:30 -0500
MIME-Version: 1.0
In-Reply-To: <87378937tk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5de488df-5bf0-8e91-8b11-4a36228a5183@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2017 01:09 AM, Michael Ellerman wrote:
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
> 
>> Hi Ben,
>>
>> On 08/29/2017 06:55 PM, Benjamin Herrenschmidt wrote:
>>> On Tue, 2017-08-29 at 17:43 -0300, Daniel Henrique Barboza wrote:
>>>> Hi,
>>>>
>>>> This is a scenario I've been facing when working in early device
>>>> hotplugs in QEMU. When a device is added, a IRQ pulse is fired to warn
>>>> the guest of the event, then the kernel fetches it by calling
>>>> 'check_exception' and handles it. If the hotplug is done too early
>>>> (before SLOF, for example), the pulse is ignored and the hotplug event
>>>> is left unchecked in the events queue.
>>>>
>>>> One solution would be to pulse the hotplug queue interrupt after CAS,
>>>> when we are sure that the hotplug queue is negotiated. However, this
>>>> panics the kernel with sig 11 kernel access of bad area, which suggests
>>>> that the kernel wasn't quite ready to handle it.
>>> That's not right. This is a bug that needs fixing. The interrupt should
>>> be masked anyway but still.
>>>
>>> Tell us more about the crash (backtrace etc...)  this definitely needs
>>> fixing.
>>
>> This is the backtrace using a 4.13.0-rc3 guest:
>>
>> ---------
>> [    0.008913] Unable to handle kernel paging request for data at address 0x00000100
>> [    0.008989] Faulting instruction address: 0xc00000000012c318
>> [    0.009046] Oops: Kernel access of bad area, sig: 11 [#1]
>> [    0.009092] SMP NR_CPUS=1024
>> [    0.009092] NUMA
>> [    0.009128] pSeries
>> [    0.009173] Modules linked in:
>> [    0.009210] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3+ #1
>> [    0.009268] task: c0000000feb02580 task.stack: c0000000fe108000
>> [    0.009325] NIP: c00000000012c318 LR: c00000000012c9c4 CTR: 0000000000000000
>> [    0.009394] REGS: c0000000fffef910 TRAP: 0380   Not tainted (4.13.0-rc3+)
>> [    0.009450] MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
>> [    0.009454]   CR: 28000822  XER: 20000000
>> [    0.009554] CFAR: c00000000012c9c0 SOFTE: 0
>> [    0.009554] GPR00: c00000000012c9c4 c0000000fffefb90 c00000000141f100 0000000000000400
>> [    0.009554] GPR04: 0000000000000000 c0000000fe1851c0 0000000000000000 00000000fee60000
>> [    0.009554] GPR08: 0000000fffffffe1 0000000000000000 0000000000000001 0000000002001001
>> [    0.009554] GPR12: 0000000000000040 c00000000fd80000 c00000000000db58 0000000000000000
>> [    0.009554] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [    0.009554] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
>> [    0.009554] GPR24: 0000000000000002 0000000000000013 c0000000fe14bc00 0000000000000400
>> [    0.009554] GPR28: 0000000000000400 0000000000000000 c0000000fe1851c0 0000000000000001
>> [    0.010121] NIP [c00000000012c318] __queue_work+0x48/0x640
>> [    0.010168] LR [c00000000012c9c4] queue_work_on+0xb4/0xf0
>> [    0.010213] Call Trace:
>> [    0.010239] [c0000000fffefb90] [c00000000000db58] kernel_init+0x8/0x160 (unreliable)
>> [    0.010308] [c0000000fffefc70] [c00000000012c9c4] queue_work_on+0xb4/0xf0
>> [    0.010368] [c0000000fffefcb0] [c0000000000c4608] queue_hotplug_event+0xd8/0x150
>> [    0.010435] [c0000000fffefd00] [c0000000000c30d0] ras_hotplug_interrupt+0x140/0x190
>> [    0.010505] [c0000000fffefd90] [c00000000018c8b0] __handle_irq_event_percpu+0x90/0x310
>> [    0.010573] [c0000000fffefe50] [c00000000018cb6c] handle_irq_event_percpu+0x3c/0x90
>> [    0.010642] [c0000000fffefe90] [c00000000018cc24] handle_irq_event+0x64/0xc0
>> [    0.010710] [c0000000fffefec0] [c0000000001928b0] handle_fasteoi_irq+0xc0/0x230
>> [    0.010779] [c0000000fffefef0] [c00000000018ae14] generic_handle_irq+0x54/0x80
>> [    0.010847] [c0000000fffeff20] [c0000000000189f0] __do_irq+0x90/0x210
>> [    0.010904] [c0000000fffeff90] [c00000000002e730] call_do_irq+0x14/0x24
>> [    0.010961] [c0000000fe10b640] [c000000000018c10] do_IRQ+0xa0/0x130
>> [    0.011021] [c0000000fe10b6a0] [c000000000008c58] hardware_interrupt_common+0x158/0x160
>> [    0.011090] --- interrupt: 501 at __replay_interrupt+0x38/0x3c
>> [    0.011090]     LR = arch_local_irq_restore+0x74/0x90
>> [    0.011179] [c0000000fe10b990] [c0000000fe10b9e0] 0xc0000000fe10b9e0 (unreliable)
>> [    0.011249] [c0000000fe10b9b0] [c000000000b967fc] _raw_spin_unlock_irqrestore+0x4c/0xb0
>> [    0.011316] [c0000000fe10b9e0] [c00000000018ff50] __setup_irq+0x630/0x9e0
>> [    0.011374] [c0000000fe10ba90] [c00000000019054c] request_threaded_irq+0x13c/0x250
>> [    0.011441] [c0000000fe10baf0] [c0000000000c2cd0] request_event_sources_irqs+0x100/0x180
>> [    0.011511] [c0000000fe10bc10] [c000000000eceda8] __machine_initcall_pseries_init_ras_IRQ+0xc4/0x12c
>> [    0.011591] [c0000000fe10bc40] [c00000000000d8c8] do_one_initcall+0x68/0x1e0
>> [    0.011659] [c0000000fe10bd00] [c000000000eb4484] kernel_init_freeable+0x284/0x370
>> [    0.011725] [c0000000fe10bdc0] [c00000000000db7c] kernel_init+0x2c/0x160
>> [    0.011782] [c0000000fe10be30] [c00000000000bc9c] ret_from_kernel_thread+0x5c/0xc0
>> [    0.011848] Instruction dump:
>> [    0.011885] fbc1fff0 f8010010 f821ff21 7c7c1b78 7c9d2378 7cbe2b78 787b0020 60000000
>> [    0.011955] 60000000 892d028a 2fa90000 409e04bc <813d0100> 75290001 408204c0 3d2061c8
>> [    0.012026] ---[ end trace e0b4d36daf3f8b2a ]---
>> [    0.013850]
>> [    2.013962] Kernel panic - not syncing: Fatal exception in interrupt
>> -------------
>>
>> To reproduce it, what I did was to fire a pulse in the hotplug queue 
>> right after CAS by hacking QEMU code.
> 
> That's not right after CAS, that's much later.
> 
> It appears the interrupt has been queued and we've taken it immediately
> on the first unmask of interrupts after registering the
> ras_hotplug_interrupt() IRQ.
> 
> That happens at subsys initcall time.
> 
> ras_hotplug_interrupt() calls queue_hotplug_event() which does:
> 
> 	queue_work(pseries_hp_wq, (struct work_struct *)work);
> 
> Where pseries_hp_wq is initialised in:
> 
>   static int __init pseries_dlpar_init(void)
>   {
>   	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
>   					WQ_UNBOUND, 1);
>   	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
>   }
>   machine_device_initcall(pseries, pseries_dlpar_init);
> 
> 
> The ordering of subsys vs device init call is:
> 
>   #define subsys_initcall(fn)		__define_initcall(fn, 4)
>   #define fs_initcall(fn)			__define_initcall(fn, 5)
>   #define device_initcall(fn)		__define_initcall(fn, 6)
> 
> 
> So this is simply a case of the init calls being out of order.
> 
> We either need to create the pseries_hp_wq earlier, or register the
> event sources IRQs later. I'm not sure which is better.

Perhaps I'm erring on the side of caution, but I think registering
the IRQs later would be better. I think this would give the kernel
more time to come and better handle a hotplug request.

-Nathan 
> 
> cheers
> 
