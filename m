Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87C4E1A0069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:15:08 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 22 Sep 2014 19:15:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 968E73E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 19:15:04 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8MNAuZV9634128
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 01:10:56 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s8N1JZde006043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 19:19:36 -0600
Message-ID: <5420C995.9050104@linux.vnet.ibm.com>
Date: Mon, 22 Sep 2014 18:15:01 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/5] pseries: Create device hotplug entry point
References: <54174CB7.2080704@linux.vnet.ibm.com>
 <1410937632.27681.11.camel@concordia> <5419DDB8.1070001@linux.vnet.ibm.com>
In-Reply-To: <5419DDB8.1070001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2014 12:15 PM, Nathan Fontenot wrote:
> On 09/17/2014 02:07 AM, Michael Ellerman wrote:
>>
>> On Mon, 2014-09-15 at 15:31 -0500, Nathan Fontenot wrote:
>>> For pseries system the kernel will be notified of hotplug requests in
>>> the form of rtas hotplug events. 
>>
>> Can you flesh that design out a bit for me, I don't entirely get how it's going
>> to work.
>>
>> The kernel gets the rtas hotplug events (in rtasd.c) and spits them out to
>> userspace, which then writes them back in ?
>>
>>> This patch creates a common routine that can handle these requests in both
>>> the PowerVM anbd PowerKVM environments, handle_dlpar_errorlog(). This also
>>                 ^
>>> creates the initial memory hotplug request handling stub.
>>>
>>> For PowerVM this patch also creates a new /proc file that the drmgr
>>> command will use to write rtas hotplug events to.
>>
>> Why is this different between phyp and KVM?
>>
>>> For future PowerKVM handling the rtas check-exception code can pass
>>> any rtas hotplug events received to handle_dlpar_errorlog().
>>
>> Internally to the kernel you mean?
>>
> 
> Perhaps a better explanation of how things work today and where I see
> them going is needed. I was trying to avoid a long explanation and I
> don't think my shortened explanation worked. I'll include this in v2
> of the patchset too.
> 
> The current hotplug (or dlpar) of devices (the process is generally the
> same for memory, cpu, and pci) on PowerVM systems is initiated
> from the HMC, which communicates the request to the partitions through
> the RSCT framework. The RSCT framework then invokes the drmgr command.
> The drmgr command performs the hotplug operation by doing some pieces,
> such as most of the rtas calls and device tree parsing, in userspace
> and make requests to the kernel to online/offline the device, update the
> device tree and add/remove the device.
> 
> For PowerKVM the approach is to follow what is currently being done for
> pci hotplug. A hotplug request is initiated from the host. QEMU then
> sends an EPOW interrupt to the guest which causes the guest to make the
> rtas,check-exception call. In QEMU, the rtas,check-exception call
> returns a rtas hotplug event to the guest. I was using this same framework
> to also enable memory (and next cpu) hotplug.
> 
> You are correct that the current pci hotplug path for PowerKVM involves
> the kernel receiving the rtas event, passing it to rtas_errd in userspace,
> and having rtas_errd invoke drmgr. The drmgr command then handles the request
> as described above for PowerVM systems.
> 
> There is no need for this circuitous route, we should just handle the entire
> hotplug of devices in the kernel. What I am hoping to do is to enable this
> by moving the code to handle hotplug from drmgr into the kernel and 
> provide a single path for handling hotplug for PowerVM and PowerKVM. To
> make this work for PowerKVM we will update the kernel rtas code to
> recognize rtas hotplug events returned from rtas,check-exception calls
> and call handle_dlpar_errorlog(). The hotplug rtas event is never sent out
> to userspace.

Wouldn't we still want the event surfaced to userspace so that it can at
least be logged?

-Tyrel

> 
> For PowerVM systems, I created the /proc/powerpc/dlpar file that a rtas
> hotplug event can be written to and passed to handle_dlpar_errorlog().
> There is no chance of updating how we receive hotplug requests on PowerVM
> systems.
> 
> Hopefully that explains the design better.
> 
>>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>>> index a2450b8..574ec73 100644
>>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>>> @@ -16,7 +16,9 @@
>>>  #include <linux/cpu.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/of.h>
>>> +#include <linux/proc_fs.h>
>>>  #include "offline_states.h"
>>> +#include "pseries.h"
>>>  
>>>  #include <asm/prom.h>
>>>  #include <asm/machdep.h>
>>> @@ -530,13 +532,72 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>>  	return count;
>>>  }
>>>  
>>> +#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>>
>> That is really confusing, but I think it's just a diff artifact?
> 
> Yes, diff artifact.
> 
>>
>>> +static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
>>> +{
>>> +	struct pseries_errorlog *pseries_log;
>>> +	struct pseries_hp_errorlog *hp_elog;
>>> +	int rc = -EINVAL;
>>> +
>>> +	pseries_log = get_pseries_errorlog(error_log,
>>> +					   PSERIES_ELOG_SECT_ID_HOTPLUG);
>>> +	if (!pseries_log)
>>> +		return rc;
>>> +
>>> +	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
>>> +	if (!hp_elog)
>>> +		return rc;
>>
>> I don't see how that can happen?
>>
>> struct pseries_errorlog {
>> 	__be16 id;			/* 0x00 2-byte ASCII section ID	*/
>> 	__be16 length;			/* 0x02 Section length in bytes	*/
>> 	uint8_t version;		/* 0x04 Section version		*/
>> 	uint8_t subtype;		/* 0x05 Section subtype		*/
>> 	__be16 creator_component;	/* 0x06 Creator component ID	*/
>> 	uint8_t data[];			/* 0x08 Start of section data	*/
>> };
>>
>> Should you be checking for length == 0 instead ?
>>
> 
> You are correct.
>  
>> Also I think the code will probably end up cleaner if you do the endian
>> conversions immediately when you read the hp_elog, rather than passing it
>> around in BE and having to remember to convert at all the usages.
>>
> 
> Agreed. I'll clean that up.
> 
>>> +	switch (hp_elog->resource) {
>>> +	case PSERIES_HP_ELOG_RESOURCE_MEM:
>>> +		rc = dlpar_memory(hp_elog);
>>> +		break;
>>
>> Please add:
>>
>>   default:
>> 	pr_warn_ratelimited("Unknown resource ..")
>>
>> Or something.
> 
> can do.
> 
>>
>>
>>> +	}
>>> +
>>> +	return rc;
>>> +}
>>> +
>>> +static ssize_t dlpar_write(struct file *file, const char __user *buf,
>>> +			   size_t count, loff_t *offset)
>>> +{
>>> +	char *event_buf;
>>> +	int rc;
>>> +
>>> +	event_buf = kmalloc(count + 1, GFP_KERNEL);
>>
>> Why + 1 ? It's not null-terminated AFAICS.
> 
> I think that's just habit. You're correct, it's not needed.
> 
>>
>>> +	if (!event_buf)
>>> +		return -ENOMEM;
>>> +
>>> +	rc = copy_from_user(event_buf, buf, count);
>>> +	if (rc) {
>>> +		kfree(event_buf);
>>> +		return rc;
>>> +	}
>>> +
>>> +	rc = handle_dlpar_errorlog((struct rtas_error_log *)event_buf);
>>
>> If you start with a struct rtas_error_log * you shouldn't need any casts.
> 
> good point.
> 
>>
>>> +	kfree(event_buf);
>>> +	return rc ? rc : count;
>>> +}
>>> +
>>> +static const struct file_operations dlpar_fops = {
>>> +	.write = dlpar_write,
>>> +	.llseek = noop_llseek,
>>> +};
>>> +
>>>  static int __init pseries_dlpar_init(void)
>>>  {
>>> +	struct proc_dir_entry *proc_ent;
>>> +
>>> +	proc_ent = proc_create("powerpc/dlpar", S_IWUSR, NULL, &dlpar_fops);
>>> +	if (proc_ent)
>>> +		proc_set_size(proc_ent, 0);
>>
>>   else
>> 	error message at least please
>>
>> Why are we putting it in /proc, can't it go in /sys/kernel like the mobility
>> stuff?
> 
> I have no personal preference, I'll move it to /sys/kernel and update the
> creation handling.
> 
>>
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> index 24abc5c..0e60e15 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> @@ -20,6 +22,9 @@
>>>  #include <asm/machdep.h>
>>>  #include <asm/prom.h>
>>>  #include <asm/sparsemem.h>
>>> +#include <asm/rtas.h>
>>> +
>>> +DEFINE_MUTEX(dlpar_mem_mutex);
>>
>> static ?
> 
> yes, that should have been static.
> 
>>
>>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>>> index b94516b..28bd994 100644
>>> --- a/arch/powerpc/platforms/pseries/pseries.h
>>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>>> @@ -62,6 +63,15 @@ extern int dlpar_detach_node(struct device_node *);
>>>  extern int dlpar_acquire_drc(u32);
>>>  extern int dlpar_release_drc(u32);
>>>  
>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>> +extern int dlpar_memory(struct pseries_hp_errorlog *);
>>> +#else
>>> +static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>> +{
>>> +	return -ENOTSUPP;
>>
>> EOPNOTSUPP is a bit more standard.
> 
> ok.
> 
> Thanks for all the feedback.
> 
> -Nathan
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
