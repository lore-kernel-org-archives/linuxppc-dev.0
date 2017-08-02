Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMqq3547GzDrnZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 20:55:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72ArpFI077179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 06:55:41 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c39p0u0ug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 06:55:40 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 07:55:38 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72AtZS839387282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 07:55:35 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72AtbD4012528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 07:55:38 -0300
Subject: Re: [RFC PATCH] powerpc: Disabling MEMORY_HOTPLUG_DEFAULT_ONLINE
 option for PPC64 arch
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170731181759.13839-1-danielhb@linux.vnet.ibm.com>
 <87y3r3sj57.fsf@concordia.ellerman.id.au>
 <9f4cbb26-f8f4-7f42-0c73-deab23bd83d6@linux.vnet.ibm.com>
 <a22a6445-528f-9070-f2f7-b981cee3878e@linux.vnet.ibm.com>
Date: Wed, 2 Aug 2017 07:55:30 -0300
MIME-Version: 1.0
In-Reply-To: <a22a6445-528f-9070-f2f7-b981cee3878e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cfa76a51-9a6b-e5a6-9f6c-c526c566cb6b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/01/2017 11:39 AM, Daniel Henrique Barboza wrote:
>
>
> On 08/01/2017 11:05 AM, Nathan Fontenot wrote:
>
>>
>> At this point I don't think we need this patch to disable auto online
>> for ppc64. I would be curious if this is still broken with the latest
>> mainline code though.
>
> If the auto_online feature is already working in upstream 4.13 kernel 
> then I don't see
> a reason to apply this patch either. We can leave it as a FYI/reminder 
> of a problem
> that was happening in 4.11 and got solved later on.

I've compiled an upstream kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
and the problem with LMB hotplug is still reproducible.

This means that it would be good to have any sort of mechanism (such as 
the one this
patch proposes) to remove this option from the pseries kernel until it 
is fixed.

Here is the stack trace:


Last login: Tue Aug  1 19:26:21 on hvc0
[danielhb@localhost ~]$ uname -a
Linux localhost.localdomain 4.13.0-rc3+ #1 SMP Tue Aug 1 21:29:14 CDT 
2017 ppc64le ppc64le ppc64le GNU/Linux
[danielhb@localhost ~]$ QEMU 2.9.90 monitor - type 'help' for more 
information
(qemu)
(qemu) object_add memory-backend-ram,id=ram1,size=1G
(qemu) device_add pc-dimm,id=dimm1,memdev=ram1
(qemu) [  617.757086] kernel BUG at mm/memory_hotplug.c:1936!
[  617.757245] Oops: Exception in kernel mode, sig: 5 [#1]
[  617.757332] SMP NR_CPUS=1024
[  617.757333] NUMA
[  617.757396] pSeries
[  617.757479] Modules linked in: ip6t_rpfilter ip6t_REJECT 
nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute 
bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 
ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack 
iptable_mangle iptable_raw iptable_security ebtable_filter ebtables 
ip6table_filter ip6_tables sunrpc ghash_generic vmx_crypto xfs libcrc32c 
bochs_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops 
ttm drm virtio_blk ibmvscsi virtio_pci ibmveth scsi_transport_srp 
i2c_core virtio_ring virtio crc32c_vpmsum
[  617.758577] CPU: 6 PID: 5 Comm: kworker/u16:0 Not tainted 4.13.0-rc3+ #1
[  617.758741] Workqueue: pseries hotplug workque pseries_hp_work_fn
[  617.758852] task: c0000000feb9e780 task.stack: c0000000fe118000
[  617.759047] NIP: c00000000037322c LR: c0000000003731b8 CTR: 
0000000000000000
[  617.759171] REGS: c0000000fe11b790 TRAP: 0700   Not tainted (4.13.0-rc3+)
[  617.759275] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[  617.759284]   CR: 22002424  XER: 20000000
[  617.759450] CFAR: c0000000003731bc SOFTE: 1
[  617.759450] GPR00: c0000000003731b8 c0000000fe11ba10 c00000000141f100 
0000000000000001
[  617.759450] GPR04: 0000000000000000 00000000000001a0 c0000000015dac30 
0000000000008b80
[  617.759450] GPR08: 0000000000000007 0000000000000002 c0000000e9873480 
303078302d303030
[  617.759450] GPR12: 0000000000002200 c00000000fd83c00 c000000000137f88 
c0000000fe1f0e40
[  617.759450] GPR16: 0000000000000000 0000000000000001 0000000000000004 
0000000000000001
[  617.759450] GPR20: c0000000fffffc28 0000000000000010 c0000000ebb1c184 
0000000000000010
[  617.759450] GPR24: c0000000fffffea0 c0000000f0aec4a0 c0000000fffffc28 
0000000000000000
[  617.759450] GPR28: 0000000000000000 c000000001347f08 0000000010000000 
0000000100000000
[  617.760679] NIP [c00000000037322c] remove_memory+0xfc/0x110
[  617.760766] LR [c0000000003731b8] remove_memory+0x88/0x110
[  617.760849] Call Trace:
[  617.760895] [c0000000fe11ba10] [c0000000003731b8] 
remove_memory+0x88/0x110 (unreliable)
[  617.761032] [c0000000fe11ba50] [c0000000000cb0e0] 
dlpar_add_lmb+0x280/0x480
[  617.761214] [c0000000fe11bb30] [c0000000000cc83c] 
dlpar_memory+0xa5c/0xe50
[  617.761319] [c0000000fe11bbf0] [c0000000000c3b88] 
handle_dlpar_errorlog+0xf8/0x160
[  617.761443] [c0000000fe11bc60] [c0000000000c3c84] 
pseries_hp_work_fn+0x94/0xa0
[  617.761568] [c0000000fe11bc90] [c00000000012e3e8] 
process_one_work+0x248/0x540
[  617.761697] [c0000000fe11bd30] [c00000000012e768] 
worker_thread+0x88/0x5c0
[  617.761857] [c0000000fe11bdc0] [c00000000013812c] kthread+0x1ac/0x1c0
[  617.761962] [c0000000fe11be30] [c00000000000bc9c] 
ret_from_kernel_thread+0x5c/0xc0
[  617.762085] Instruction dump:
[  617.762149] 4be09a9d 60000000 4bd95ac5 60000000 38210040 e8010010 
eb81ffe0 eba1ffe8
[  617.762274] ebc1fff0 7c0803a6 ebe1fff8 4e800020 <0fe00000> 00000000 
00000000 00000000
[  617.762403] ---[ end trace feaa62099c5987b9 ]---


Thanks,


Daniel

>
>
> Thanks,
>
>
> Daniel
>
>>
>> -Nathan
>>>> However, this change
>>>> alone isn't enough to prevent situations such as [1], where
>>>> distros can enable the option unaware of the consequences of
>>>> doing it (e.g. breaking LMB hotplug altogether).
>>>>
>>>> Instead of relying on all distros knowing that pseries can't handle
>>>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y after 943db62c316c, this patch
>>>> changes mm/Kconfig to make the MEMORY_HOTPLUG_DEFAULT_ONLINE config
>>>> unavailable for the PPC64 arch.
>>>>
>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1476380
>>>>
>>>> Fixes: 943db62c316c ("powerpc/pseries: Revert 'Auto-online 
>>>> hotplugged memory'")
>>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>>> ---
>>>>   mm/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> I don't own that file, so we at least need an Ack from the mm folks.
>>>
>>> cheers
>>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 48b1af4..a342c77 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -169,7 +169,7 @@ config MEMORY_HOTPLUG_SPARSE
>>>>   config MEMORY_HOTPLUG_DEFAULT_ONLINE
>>>>           bool "Online the newly added memory blocks by default"
>>>>           default n
>>>> -        depends on MEMORY_HOTPLUG
>>>> +        depends on MEMORY_HOTPLUG && !PPC64
>>>>           help
>>>>         This option sets the default policy setting for memory hotplug
>>>>         onlining policy 
>>>> (/sys/devices/system/memory/auto_online_blocks) which
>>>> -- 
>>>> 2.9.4
>
