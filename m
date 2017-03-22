Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpFG76w0WzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 03:17:51 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MG8snF114461
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 12:17:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vkdr5n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 12:17:48 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 12:17:47 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MGHj2643909314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:17:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BDB72805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 12:17:41 -0400 (EDT)
Received: from oc1554177480.ibm.com (unknown [9.53.92.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 1E5FB2804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 12:17:41 -0400 (EDT)
Subject: Re: [FIX PATCH v1] powerpc/pseries: Fix reference count leak during
 CPU unplug
To: linuxppc-dev@lists.ozlabs.org
References: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
 <cd939dd8-c04a-54df-2b4f-e1b90e3c6cc7@linux.vnet.ibm.com>
 <20170313102910.GA21558@in.ibm.com>
 <c135c292-d88f-d209-bd96-21c8aa7b2c68@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 22 Mar 2017 11:17:44 -0500
MIME-Version: 1.0
In-Reply-To: <c135c292-d88f-d209-bd96-21c8aa7b2c68@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <263a1d33-b9f5-e957-320f-f890e4485e09@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get the error when removing a CPU that has been hotplugged after boot.

On 03/14/2017 03:42 PM, Tyrel Datwyler wrote:
> On 03/13/2017 03:29 AM, Bharata B Rao wrote:
>> On Thu, Mar 09, 2017 at 01:34:00PM -0800, Tyrel Datwyler wrote:
>>> On 03/08/2017 08:37 PM, Bharata B Rao wrote:
>>>> The following warning is seen when a CPU is hot unplugged on a PowerKVM
>>>> guest:
>>>
>>> Is this the case with cpus present at boot? What about cpus hotplugged
>>> after boot?
>>
>> I have observed this for CPUs that are hotplugged.
> 
> If removing a cpu present at boot works, but removing one that has been
> hotplugged after boot reproduces the problem it is more likely the case
> that we failed to take a reference during hotplug or released a
> reference we shouldn't have. I'd have to go look at the hot add path.
> 
>>
>>>
>>> My suspicion is that the refcount was wrong to begin with. See my
>>> comments below. The use of the of_node_put() calls is correct as in each
>>> case we incremented the ref count earlier in the same function.
>>>
>>>>
>>>> refcount_t: underflow; use-after-free.
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 0 PID: 53 at lib/refcount.c:128 refcount_sub_and_test+0xd8/0xf0
>>>> Modules linked in:
>>>> CPU: 0 PID: 53 Comm: kworker/u510:1 Not tainted 4.11.0-rc1 #3
>>>> Workqueue: pseries hotplug workque pseries_hp_work_fn
>>>> task: c0000000fb475000 task.stack: c0000000fb81c000
>>>> NIP: c0000000006f0808 LR: c0000000006f0804 CTR: c0000000007b98c0
>>>> REGS: c0000000fb81f710 TRAP: 0700   Not tainted  (4.11.0-rc1)
>>>> MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
>>>>   CR: 48002222  XER: 20000000
>>>> CFAR: c000000000c438e0 SOFTE: 1
>>>> GPR00: c0000000006f0804 c0000000fb81f990 c000000001573b00 0000000000000026
>>>> GPR04: 0000000000000000 000000000000016c 667265652e0d0a73 652d61667465722d
>>>> GPR08: 0000000000000007 0000000000000007 0000000000000001 0000000000000006
>>>> GPR12: 0000000000002200 c00000000ff40000 c00000000010c578 c0000001f11b9f40
>>>> GPR16: c0000001fe0312a8 c0000001fe031078 c0000001fe031020 0000000000000001
>>>> GPR20: 0000000000000000 0000000000000000 c000000001454808 fffffffffffffef7
>>>> GPR24: 0000000000000000 c0000001f1677648 0000000000000000 0000000000000000
>>>> GPR28: 0000000010000008 c000000000e4d3d8 0000000000000000 c0000001eaae07d8
>>>> NIP [c0000000006f0808] refcount_sub_and_test+0xd8/0xf0
>>>> LR [c0000000006f0804] refcount_sub_and_test+0xd4/0xf0
>>>> Call Trace:
>>>> [c0000000fb81f990] [c0000000006f0804] refcount_sub_and_test+0xd4/0xf0 (unreliable)
>>>> [c0000000fb81f9f0] [c0000000006d04b4] kobject_put+0x44/0x2a0
>>>> [c0000000fb81fa70] [c0000000009d5284] of_node_put+0x34/0x50
>>>> [c0000000fb81faa0] [c0000000000aceb8] dlpar_cpu_remove_by_index+0x108/0x130
>>>> [c0000000fb81fb30] [c0000000000ae128] dlpar_cpu+0x78/0x550
>>>> [c0000000fb81fbe0] [c0000000000a7b40] handle_dlpar_errorlog+0xc0/0x160
>>>> [c0000000fb81fc50] [c0000000000a7c74] pseries_hp_work_fn+0x94/0xa0
>>>> [c0000000fb81fc80] [c000000000102cec] process_one_work+0x23c/0x540
>>>> [c0000000fb81fd20] [c00000000010309c] worker_thread+0xac/0x620
>>>> [c0000000fb81fdc0] [c00000000010c6c4] kthread+0x154/0x1a0
>>>> [c0000000fb81fe30] [c00000000000bbe0] ret_from_kernel_thread+0x5c/0x7c
>>>>
>>>> Fix this by ensuring that of_node_put() is called only from the
>>>> error path in dlpar_cpu_remove_by_index(). In the normal path,
>>>> of_node_put() happens as part of dlpar_detach_node().
>>>>
>>>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>>>> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>>>> ---
>>>> Changes in v1:
>>>> - Fixed the refcount problem in the userspace driven unplug path
>>>>   in addition to in-kernel unplug path. (Sachin Sant)
>>>>
>>>> v0: https://patchwork.ozlabs.org/patch/736547/
>>>>
>>>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 12 ++++++++----
>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> index 7bc0e91..c5ed510 100644
>>>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> @@ -619,7 +619,8 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>>>>  	}
>>>>
>>>>  	rc = dlpar_cpu_remove(dn, drc_index);
>>>> -	of_node_put(dn);
>>>> +	if (rc)
>>>> +		of_node_put(dn);
>>>
>>> I think there is another issue at play here because this is wrong.
>>> Regardless of whether the dlpar_cpu_remove() succeeds or fails we still
>>> need of_node_put() for both cases because we incremented the ref count
>>> earlier in this function with a call to cpu_drc_index_to_dn() call. That
>>> call doesn't, but shoul, document that it returns a device_node with
>>> incremented refcount.
>>>
>>>>  	return rc;
>>>>  }
>>>>
>>>> @@ -856,9 +857,12 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>>>  	}
>>>>
>>>>  	rc = dlpar_cpu_remove(dn, drc_index);
>>>> -	of_node_put(dn);
>>>> -
>>>> -	return rc ? rc : count;
>>>> +	if (rc) {
>>>> +		of_node_put(dn);
>>>> +		return rc;
>>>> +	} else {
>>>> +		return count;
>>>> +	}
>>>
>>> Same comment as above. The call earlier in the function to
>>> of_find_node_by_path() returned a device_node struct with its ref count
>>> incremented. So, regardless of whether dlpar_cpu_remove() succeeds or
>>> fails we need decrement the ref count with of_node_put().
>>>
>>> Looking closer at the call paths for attach and detach one will notice
>>> that __of_attach_node_sysfs() does not take a device_node reference with
>>> of_node_get(), but __of_detach_node_sysfs() does a of_node_put(). In the
>>> old days we use to keep the device tree in /proc. Now it lives in sysfs
>>> and is symlinked to /proc for userspace ABI reasons. Further, pseries
>>> was the only platform in those days that did any sort of dynamic OF
>>> operations. So, in those dark days we were responsible for calling
>>> of_node_put in dlpar_detach_node() to decrement the of_node_init()
>>> reference. Looking at the comments in __of_detach_node_sysfs() it seems
>>> that they expect to decrement that reference there now.
>>>
>>> void __of_detach_node_sysfs(struct device_node *np)
>>> {
>>>
>>> ...snip...
>>>
>>>         /* finally remove the kobj_init ref */
>>>         of_node_put(np);
>>> }
>>>
>>
>> So you suggest that adding of_node_get() to __of_attach_node_sysfs()
>> is the right fix ?
> 
> If I understand that this only creates for hot-added cpus then no. Also
> for this to be the correct fix I would expect to see this recreate for
> all hot-remove operations such as memory and pci devices as well.
> 
> -Tyrel
> 
>>
>> Regards,
>> Bharata.
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
