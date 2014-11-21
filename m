Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2105C1A1F30
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:50:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Fri, 21 Nov 2014 17:50:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EBA4A2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:50:30 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAL7nvtR42467514
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:50:05 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAL7nw1k000904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:49:58 +1100
Message-ID: <1416556173.2855.67.camel@cyril>
Subject: Re: [PATCH v2 3/6] pseries: Create new device hotplug entry point
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 21 Nov 2014 18:49:33 +1100
In-Reply-To: <546A6DEE.8080708@linux.vnet.ibm.com>
References: <546A6C23.1080800@linux.vnet.ibm.com>
 <546A6DEE.8080708@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-11-17 at 15:51 -0600, Nathan Fontenot wrote:
> Create a new entry point for device hotplug on pseries that will
> work for both PowerVM and PowerKVM systems.
> 
> The current process to hotplug (or dlpar) devices (generally the same
> process for memory, cpu, and pci devices) on PowerVM systems is initiated
> from the HMC, which communicates the request to the partitions through
> the RSCT framework. The RSCT framework then invokes the drmgr command.
> The drmgr command performs the hotplug operation by doing some pieces,
> such as most of the rtas calls and device tree parsing, in userspace
> and make requests to the kernel to online/offline the device, update the
> device tree and add/remove the device.
> 
> For PowerKVM the approach for device hotplug is to follow what is currently
> being done for pci hotplug. A hotplug request is initiated from the host,
> QEMU then generates an EPOW interrupt to the guest which causes the guest
> to make the rtas,check-exception call. In QEMU, the rtas,check-exception call
> returns a rtas hotplug event to the guest.

Please forgive my ignorance of the exact details of how this all works.
I've been trying to wrap my head around how it works in a little more
detail than your high level overview. Correct me where I go wrong.

So the EPOW interrupt comes in and QEMU receives the
rtas,check-exception call and returns the rtas hotplug event. As you
state below, the connection of the arrival of the rtas hotplug event to
the hotplug code will be made in a subsequent patch.

Here is my understanding of what happens when a hotplug event gets
processed.
An LMB is selected
from /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory in the
device tree which is populated at boot time (although it's possible that
it can updated once the guest is running?) either because it matches a
specific drc-index or simply because it is in the list and we are to
hotplug 'count' LMBs. So there's a maximum amount of memory that can be
hotplugged (without device tree updates...)?

Once selected the kernel informs the hypervisor that it is going to use
that LMB with two RTAS calls, 'get-sensor-state' and 'set-indicator'
which first checks the actual state of that LMB with the hypervisor and
then marks it as 'in use' (in dlpar_acquire_drc).

After that, find the (NUMA?) node id of the memory and inform the
generic kernel about this new memory.

For some reason memblock needs to be informed separately (does it need
to be informed exactly?), which as you pointed out in the previous
version of this patchset you're not sure why it isn't done in
add_memory, and you still do it because it's what currently happens? I'd
very much like to know why this sequence of events but I suspect the
explanation might get quite involved.

Finally mark the LMB as assigned in its device tree node. This is
bookkeeping right?

This process is repeated for each LMB that should be added.

In the event a failure a best effort rollback is done, as you mentioned
in the previous version, it may not always be possible but at least it's
attempted.

Once all this succeeds update the device tree.

Basically the exact reverse of this process happens for unplug.

I do have questions about this process: What is the most likely part to
fail? I have no idea how feasible it would be but perhaps trying to do
the likely failure on all the LBMs might help unwinding and perhaps
provide a guarantee that it can be completely rolled back. I'm really
not sure but by the looks of things are going to be pretty reversible up
until device_online.

I can't help but notice the duplication with memory_probe_store
(although that doesn't do any rollback). Probably unavoidable and its
really not much code.

Thanks in advance for the clarifications,

Cyril
> 
> Please note that the current pci hotplug path for PowerKVM involves the
> kernel receiving the rtas hotplug event, passing it to rtas_errd in
> userspace, and having rtas_errd invoke drmgr. The drmgr command then
> handles the request as described above for PowerVM systems. This is to
> be updated to perform pci completely in the kernel in a later patch set.
> 
> There is no need for this circuitous route, we should handle the entire
> hotplug of devices in the kernel. What I am planning is to enable this
> by moving the code to handle device hotplug from drmgr into the kernel to
> provide a single path for both PowerVM and PowerKVM systems. This patch
> provides the common entry point. For PowerKVM a future update to the kernel
> rtas code will recognize rtas hotplug events returned from
> rtas,check-exception calls and use the common entry point to handle device
> hotplug entirely in the kernel.
> 
> For PowerVM systems, this patch creates the /sys/kernel/dlpar file that rtas
> hotplug events can be written to by drmgr and passed to the common entry point.
> There is no chance of updating how we receive hotplug requests on PowerVM
> systems.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/dlpar.c          |   72 ++++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   19 ++++++
>  arch/powerpc/platforms/pseries/pseries.h        |   10 +++
>  3 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index c22bb1b..ec825d3 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -10,6 +10,8 @@
>   * 2 as published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt)	"dlpar: " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
> @@ -535,13 +537,79 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  	return count;
>  }
>  
> +#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
> +
> +static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
> +{
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_hp_errorlog *hp_elog;
> +	int rc;
> +
> +	pseries_log = get_pseries_errorlog(error_log,
> +					   PSERIES_ELOG_SECT_ID_HOTPLUG);

> +	if (!pseries_log || (pseries_log->length == 0))
> +		return -EINVAL;
> +
> +	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
Maybe rather than doing this here it might be worth having a function
that returns you a pseries_hp_errorlog from a pseries_errorlog but also
with everything in CPU endian which will make 5/6 and 6/6 look nicer.
> +
> +	/* Go ahead and convert the hotplug type to the correct endianness
> +	 * to avoid converting it everywhere we use it.
> +	 */
> +	switch (hp_elog->id_type) {
> +	case PSERIES_HP_ELOG_ID_DRC_COUNT:
> +		hp_elog->_drc_u.drc_count =
> +					be32_to_cpu(hp_elog->_drc_u.drc_count);
> +	case PSERIES_HP_ELOG_ID_DRC_INDEX:
> +		hp_elog->_drc_u.drc_index =
> +					be32_to_cpu(hp_elog->_drc_u.drc_index);
> +	}
You're converting __be32 to CPU endian but storing them back into a
__be32? This will upset sparse.
Should this not also have a default case?

> +
> +	switch (hp_elog->resource) {
> +	case PSERIES_HP_ELOG_RESOURCE_MEM:
> +		rc = dlpar_memory(hp_elog);
> +		break;
> +	default:
> +		pr_warn_ratelimited("Invalid resource (%d) specified\n",
> +				    hp_elog->resource);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static ssize_t dlpar_store(struct file *filp, struct kobject *kobj,
> +			   struct bin_attribute *bin_attr, char *buf,
> +			   loff_t pos, size_t count)
> +{
> +	struct rtas_error_log *error_log;
> +	int rc;
> +
> +	error_log = kmalloc(count, GFP_KERNEL);
> +	if (!error_log)
> +		return -ENOMEM;
> +
> +	memcpy(error_log, buf, count);
> +
> +	rc = handle_dlpar_errorlog(error_log);
> +	kfree(error_log);
> +	return rc ? rc : count;
> +}
> +
> +static BIN_ATTR(dlpar, S_IWUSR, NULL, dlpar_store, 0);
> +
>  static int __init pseries_dlpar_init(void)
>  {
> +	int rc;
> +
> +#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>  	ppc_md.cpu_probe = dlpar_cpu_probe;
>  	ppc_md.cpu_release = dlpar_cpu_release;
> +#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>  
> -	return 0;
> +	rc = sysfs_create_bin_file(kernel_kobj, &bin_attr_dlpar);
> +
> +	return rc;
>  }
>  machine_device_initcall(pseries, pseries_dlpar_init);
>  
> -#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 3cb256c..69d178b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -9,6 +9,8 @@
>   *      2 of the License, or (at your option) any later version.
>   */
>  
> +#define pr_fmt(fmt)	"pseries-hotplug-mem: " fmt
> +
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/memblock.h>
> @@ -134,6 +136,23 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> +int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
> +{
> +	int rc = 0;
> +
> +	lock_device_hotplug();
> +
> +	switch (hp_elog->action) {
> +	default:
> +		pr_err("Invalid action (%d) specified\n", hp_elog->action);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	unlock_device_hotplug();
> +	return rc;
> +}
> +
>  static int pseries_add_mem_node(struct device_node *np)
>  {
>  	const char *type;
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 239bee5..40e0339 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -11,6 +11,7 @@
>  #define _PSERIES_PSERIES_H
>  
>  #include <linux/interrupt.h>
> +#include <asm/rtas.h>
>  
>  struct device_node;
>  
> @@ -63,6 +64,15 @@ extern int dlpar_detach_node(struct device_node *);
>  int dlpar_acquire_drc(u32 drc_index);
>  int dlpar_release_drc(u32 drc_index);
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
> +#else
> +static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  /* PCI root bridge prepare function override for pseries */
>  struct pci_host_bridge;
>  int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
