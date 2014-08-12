Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B53D31A0285
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 11:47:58 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 12 Aug 2014 11:47:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E0F812CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 11:47:52 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7C1mTGc13369434
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 11:48:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7C1lpX9025335
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 11:47:51 +1000
Date: Tue, 12 Aug 2014 11:47:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/pseries: Failure on removing device node
Message-ID: <20140812014747.GA5369@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407748580-3412-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53E8D021.1010908@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E8D021.1010908@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 11, 2014 at 09:16:01AM -0500, Nathan Fontenot wrote:
>On 08/11/2014 04:16 AM, Gavin Shan wrote:

[Removing stable from cc list to avoid mail flooding]

>> While running command "drmgr -c phb -r -s 'PHB 528'", following
>> backtrace jumped out because the target device node isn't marked
>> with OF_DETACHED by of_detach_node(), which caused by error
>> returned from memory hotplug related reconfig notifier when
>> disabling CONFIG_MEMORY_HOTREMOVE. The patch fixes it.
>> 
>
>Could you provide some more context here.
>
>Your comment claims that you hit an error while trying to remove a PHB,
>but the fix you provided is for memory hotplug. This changes the
>rturn code to zero which usually inidcates success except that
>your comment states you disabled memory hotplug remove.
>

Yep, here's more information about it: The notification callbacks
are called in sequence as they are regsitered. For of_reconfig_notifier,
following callbacks would be called in sequence:

arch/powerpc/platforms/pseries/setup.c::pci_dn_reconfig_notifier()
                               iommu.c::iommu_reconfig_notifier()
                               hotplug-cpu.c::pseries_smp_notifier()
                               hotplug-memory.c::pseries_memory_notifier()

Writing "remove_node xxxx" to /proc/powerpc/ofdt will invoke of_detach_node()
which bails early without marking OF_DETACHED for the device node if any
error returned from of_reconfig_notifier callbacks. The error was contributed
by hotplug-memory.c::pseries_memory_notifier() with disabled CONFIG_MEMORY_HOTREMOVE.

int of_detach_node(struct device_node *np)
{
        struct device_node *parent;
        unsigned long flags;
        int rc = 0;

        rc = of_reconfig_notify(OF_RECONFIG_DETACH_NODE, np);
        if (rc)
                return rc;
        :
        :
        of_node_set_flag(np, OF_DETACHED);          <<< It's missed.
        raw_spin_unlock_irqrestore(&devtree_lock, flags);
        :
}

When releasing the device node, we run into warning as the device
node wasn't marked with flag OF_DETACHED.

static void of_node_release(struct kobject *kobj)
{
        struct device_node *node = kobj_to_device_node(kobj);
        struct property *prop = node->properties;

        /* We should never be releasing nodes that haven't been detached. */
        if (!of_node_check_flag(node, OF_DETACHED)) {
                pr_err("ERROR: Bad of_node_put() on %s\n", node->full_name);
                dump_stack();
                return;
        }
        :
        :
}

>I think the fix we need to have here is to update the version of
>pseries_remove_mem_node() when CONFIG_MEMORY_HOTREMOVE is disabled
>to validate that the node is a memory node and return the proper value
>instead of just returning -EOPNOTSUPP in all cases. 
>

I guess you suggested to add following piece of code in pseries_remove_mem_node()
when CONFIG_MEMORY_HOTREMOVE is disabled? If so, we can't avoid the issue and it's
not helping anything. I think returning 0 might be enough here.

static inline int pseries_remove_mem_node(struct device_node *np)
{
        type = of_get_property(np, "device_type", NULL);
        if (type == NULL || strcmp(type, "memory") != 0)
                return 0;

        return -EOPNOTSUPP
}

>The pseries_remove_mem_node() routine when memory removed is enabled
>already does this.
>

Yes, we don't have problem for this case because PHB or PCI adapter
device nodes occasionally have "reg" property. Otherwise, it also
fails.

Thanks,
Gavin

>-Nathan
>
>> ERROR: Bad of_node_put() on /pci@800000020000210/ethernet@0
>> CPU: 14 PID: 2252 Comm: drmgr Tainted: G        W     3.16.0+ #427
>> Call Trace:
>> [c000000012a776a0] [c000000000013d9c] .show_stack+0x88/0x148 (unreliable)
>> [c000000012a77750] [c00000000083cd34] .dump_stack+0x7c/0x9c
>> [c000000012a777d0] [c0000000006807c4] .of_node_release+0x58/0xe0
>> [c000000012a77860] [c00000000038a7d0] .kobject_release+0x174/0x1b8
>> [c000000012a77900] [c00000000038a884] .kobject_put+0x70/0x78
>> [c000000012a77980] [c000000000681680] .of_node_put+0x28/0x34
>> [c000000012a77a00] [c000000000681ea8] .__of_get_next_child+0x64/0x70
>> [c000000012a77a90] [c000000000682138] .of_find_node_by_path+0x1b8/0x20c
>> [c000000012a77b40] [c000000000051840] .ofdt_write+0x308/0x688
>> [c000000012a77c20] [c000000000238430] .proc_reg_write+0xb8/0xd4
>> [c000000012a77cd0] [c0000000001cbeac] .vfs_write+0xec/0x1f8
>> [c000000012a77d70] [c0000000001cc3b0] .SyS_write+0x58/0xa0
>> [c000000012a77e30] [c00000000000a064] syscall_exit+0x0/0x98
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index 7995135..24abc5c 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -146,7 +146,7 @@ static inline int pseries_remove_memblock(unsigned long base,
>>  }
>>  static inline int pseries_remove_mem_node(struct device_node *np)
>>  {
>> -	return -EOPNOTSUPP;
>> +	return 0;
>>  }
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>>  
>> 
