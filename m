Return-Path: <jallen@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F35051A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 07:15:54 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 15:15:52 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E605738C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:15:49 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOKFnX110158186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 20:15:49 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOKFmwr010807
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:15:49 -0500
Subject: Re: [PATCH v2] memory-hotplug: Fix kernel warning during memory
 hotplug on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, gregkh@linuxfoundation.org
References: <5638ED37.3090500@linux.vnet.ibm.com>
 <1447118489.13889.11.camel@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: John Allen <jallen@linux.vnet.ibm.com>
Message-ID: <5654C572.4090400@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 14:15:46 -0600
MIME-Version: 1.0
In-Reply-To: <1447118489.13889.11.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 11/09/2015 07:21 PM, Michael Ellerman wrote:
> Hi John,
> 
> On Tue, 2015-11-03 at 11:21 -0600, John Allen wrote:
>> This patch fixes a bug where a kernel warning is triggered when performing
>> a memory hotplug on ppc64. This warning may also occur on any architecture
>> that has multiple sections per memory block.
> 
> So it looks like the only arches that enable this code at all are powerpc, sh
> and x86 (via CONFIG_ARCH_MEMORY_PROBE). And it sounds like on x86 it's just
> there for debugging, ACPI is meant to notify you of memory hotplug by the
> sounds.
> 
> Do any of sh or x86 have "multiple sections per memory block" ?
> 
> If not then this bug would only apply to powerpc, which would be useful to
> know.

Sorry for the delayed response. It looks like your reply got buried in my
lkml folder instead of going straight to my inbox.

My understanding is that x86 may use multiple sections per block. I
think we would have to assume that any architecture that uses this code
could potentially hit this issue.

> 
> And what is the actual warning? ie. what does the code look like. My line 210
> of memory.c is a printk() not a WARN.

In mainline, the warning is at line 200:

	if (WARN_ON_ONCE(!pfn_valid(pfn)))
		return false;

> 
> 
>> [   78.300767] ------------[ cut here ]------------
>> [   78.300768] WARNING: at ../drivers/base/memory.c:210
>> [   78.300769] Modules linked in: rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag af_packet xfs libcrc32c ibmveth(X) rtc_generic btrfs xor raid6_pq xts
>> gf128mul dm_crypt sd_mod sr_mod cdrom crc_t10dif ibmvscsi(X) scsi_transport_srp scsi_tgt dm_mod sg scsi_mod autofs4
>> [   78.300789] Supported: Yes, External
>> [   78.300791] CPU: 1 PID: 3090 Comm: systemd-udevd Tainted: G              X 3.12.45-1-default #1
>> [   78.300793] task: c0000004d7d1d970 ti: c0000004d7b90000 task.ti: c0000004d7b90000
>> [   78.300794] NIP: c0000000004fcff8 LR: c0000000004fda84 CTR: 0000000000000000
>> [   78.300795] REGS: c0000004d7b93930 TRAP: 0700   Tainted: G              X  (3.12.45-1-default)
>> [   78.300796] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24088848  XER: 00000000
>> [   78.300800] CFAR: c0000000004fcf98 SOFTE: 1
>> GPR00: 0000000000000537 c0000004d7b93bb0 c000000000e7f200 0000000000053000
>> GPR04: 0000000000001000 0000000000000001 c000000000e0f200 0000000000000000
>> GPR08: 0000000000000000 0000000000000001 0000000000000537 00000000014dc000
>> GPR12: 0000000000054000 c00000000e7f0900 0000000010041040 0000000000000000
>> GPR16: 00000100206f0010 000000001003ff78 000000001006c824 00000000100410b0
>> GPR20: 000000001003ff90 000000001006c00c 000001002073cd20 00000100206f0760
>> GPR24: 00000100206f85a0 c00000000076d950 c0000004ef7c95e0 c0000004d7b93e00
>> GPR28: c0000004de601738 0000000000000001 c000000001218f80 00000000003fffff
>> [   78.300818] NIP [c0000000004fcff8] memory_block_action+0x258/0x2e0
>> [   78.300820] LR [c0000000004fda84] memory_subsys_online+0x54/0x100
>> [   78.300821] Call Trace:
>> [   78.300822] [c0000004d7b93bb0] [c000000009071ce0] 0xc000000009071ce0 (unreliable)
>> [   78.300824] [c0000004d7b93c40] [c0000000004fda84] memory_subsys_online+0x54/0x100
>> [   78.300826] [c0000004d7b93c70] [c0000000004df784] device_online+0xb4/0x120
>> [   78.300828] [c0000004d7b93cb0] [c0000000004fd738] store_mem_state+0x88/0x220
>> [   78.300830] [c0000004d7b93cf0] [c0000000004db448] dev_attr_store+0x68/0xa0
>> [   78.300833] [c0000004d7b93d30] [c00000000031f938] sysfs_write_file+0xf8/0x1d0
>> [   78.300835] [c0000004d7b93d90] [c00000000027d29c] vfs_write+0xec/0x250
>> [   78.300837] [c0000004d7b93de0] [c00000000027dfdc] SyS_write+0x6c/0xf0
>> [   78.300839] [c0000004d7b93e30] [c00000000000a17c] syscall_exit+0x0/0x7c
>> [   78.300840] Instruction dump:
>> [   78.300841] 780a0560 79482ea4 7ce94214 2fa70000 41de0014 7d09402a 396b4000 7907ffe3
>> [   78.300844] 4082ff54 3cc2fff9 8926b83a 69290001 <0b090000> 2fa90000 40de006c 3860fff0
>> [   78.300847] ---[ end trace dfec8da06ebbc762 ]---
> 
> For change logs I think it's nice to trim the oops a bit. Others probably have
> different opinions but I'd remove the printk timestamp, the GPRs and some of
> the other regs and the instruction dump, so more like:
> 
>   WARNING: at ../drivers/base/memory.c:210
>   CPU: 1 PID: 3090 Comm: systemd-udevd Tainted: G              X 3.12.45-1-default #1
>   NIP [c0000000004fcff8] memory_block_action+0x258/0x2e0
>   LR [c0000000004fda84] memory_subsys_online+0x54/0x100
>   Call Trace:
>   [c0000004d7b93bb0] [c000000009071ce0] 0xc000000009071ce0 (unreliable)
>   [c0000004d7b93c40] [c0000000004fda84] memory_subsys_online+0x54/0x100
>   [c0000004d7b93c70] [c0000000004df784] device_online+0xb4/0x120
>   [c0000004d7b93cb0] [c0000000004fd738] store_mem_state+0x88/0x220
>   [c0000004d7b93cf0] [c0000000004db448] dev_attr_store+0x68/0xa0
>   [c0000004d7b93d30] [c00000000031f938] sysfs_write_file+0xf8/0x1d0
>   [c0000004d7b93d90] [c00000000027d29c] vfs_write+0xec/0x250
>   [c0000004d7b93de0] [c00000000027dfdc] SyS_write+0x6c/0xf0
>   [c0000004d7b93e30] [c00000000000a17c] syscall_exit+0x0/0x7c
> 
> 
> Also looking at the trace, it's from 3.12.45-1, which is pretty old. Have you
> also tested on mainline?

All testing and debugging was done on a mainline kernel. The traces with
the 3.12 kernel were just what was submitted in the initial bug report.

> 
>> The warning is triggered because there is a udev rule that automatically
>> tries to online memory after it has been added. The udev rule varies from
>> distro to distro, but will generally look something like:
>>
>> SUBSYSTEM=="memory", ACTION=="add", ATTR{state}=="offline", ATTR{state}="online"
>>
>> On any architecture that uses memory_probe_store to reserve memory,
>> this can interrupt the memory reservation process. This patch modifies
>> memory_probe_store to take the hotplug sysfs lock to prevent the online
>> of added memory before the completion of the probe.
> 
> So presumably it's add_memory() that is causing a uevent to fire? I can't see
> where that happens but I guess it's in there somewhere.
> 
> And that's a problem because we've only added one (or some) of the sections, so
> the memory block is not fully populated, and then the add path hits the warning
> because of that. Am I right?

Yes, that's right. While we are in the process of reserving the sections of the
block,the uevent gets triggered and calls store_mem_state(). This then calls
pages_correctly_reserved() which finds that the block has only been partially
reserved, triggering the warning.

> 
>> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
>> ---
>> v2: Move call to unlock_device_hotplug under "out" label
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index bece691..7c50415 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -422,6 +422,10 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
>>  	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
>>  		return -EINVAL;
>>
>> +	ret = lock_device_hotplug_sysfs();
>> +	if (ret)
>> +		return ret;
>> +
>>  	for (i = 0; i < sections_per_block; i++) {
>>  		nid = memory_add_physaddr_to_nid(phys_addr);
>>  		ret = add_memory(nid, phys_addr,
>> @@ -434,6 +438,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
>>
>>  	ret = count;
>>  out:
>> +	unlock_device_hotplug();
>>  	return ret;
>>  }
>>
> 
> This looks OK. What I don't know is what the locking rules in add_memory() are.
> It takes the mem_hotplug lock, which is also a mutex. I suspect it's fine to
> nest the mem_hotplug lock within the sysfs one, but it would be good if you can
> try and confirm. Also if you run with lockdep enabled it should tell you if
> you've got it wrong.

My assumption is that nesting the locks in this way is alright. We can see this
same nesting structure used in store_mem_state(). I never ran into any locking
issues in my testing, but I can test with lockdep enabled if you think that's
necessary.

-John

> 
> cheers
> 
> 
