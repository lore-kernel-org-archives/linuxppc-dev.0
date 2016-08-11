Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8ymK3S4vzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:29:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7B6TAio147176
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:29:35 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9u88dm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:29:35 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 16:29:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 221352BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:29:29 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7B6TTD729098012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:29:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7B6TSFS003369
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:29:28 +1000
Date: Thu, 11 Aug 2016 16:29:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <fa66d691-6059-e1dd-0aa2-69346d49f16e@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa66d691-6059-e1dd-0aa2-69346d49f16e@au1.ibm.com>
Message-Id: <20160811062927.GA3787@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 03:01:44PM +1000, Andrew Donnellan wrote:
>On 11/08/16 07:45, Mauricio Faria de Oliveira wrote:
>
>In cxl, we currently call:
>
>	pci_remove_root_bus(phb->bus);
>	pcibios_free_controller(phb);
>
>which appears to break with this patch after I wire up
>pci_set_host_bridge_release() in cxl, as phb can be freed before we call
>pcibios_free_controller().
>

pcibios_free_controller() isn't called when bridge's release_fn() is wired
up by pci_set_host_bridge_release(). So you can keep the code as what
you have and no changes needed.

>It seems slightly wrong for me to write:
>
>	struct pci_bus *bus = phb->bus;
>	pcibios_free_controller(phb);
>	pci_remove_root_bus(bus);
>

Yeah, the sequence needs to be reversed. The released PHB instance could
possibly be accessed inside pci_remove_root_bus(). 

Thanks,
Gavin

>
>>
>>Test-case:
>>
>>  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.0
>>  <...> /sys/block/sdaa -> ../devices/pci0021:01/0021:01:00.0/<...>
>>
>>  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.1
>>  <...> /sys/block/sdab -> ../devices/pci0021:01/0021:01:00.1/<...>
>>
>>  # cat >/dev/sdaa & pid1=$!
>>  # cat >/dev/sdab & pid2=$!
>>
>>  # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
>>  Validating PHB DLPAR capability...yes.
>>  [  479.547020] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
>>  [  479.547049] pci_hp_remove_devices:    Removing 0021:01:00.0...
>>  ...
>>  [  483.536303] pci_hp_remove_devices:    Removing 0021:01:00.1...
>>  ...
>>  [  497.072130] pci_bus 0021:01: busn_res: [bus 01-ff] is released
>>  [  497.072209] rpadlpar_io: slot PHB 33 removed
>>
>>  # kill -9 $pid1
>>  # kill -9 $pid2
>>  [  506.604458] pcibios_host_bridge_release: domain 33, dynamic 1
>>
>>Suggested-By: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
>>
>
>Missing a '---' here :)
>
>>Changelog:
>> - v3: different approach: struct pci_host_bridge.release_fn()
>> - v2: different approach: struct pci_controller.refcount
>>---
>> arch/powerpc/include/asm/pci-bridge.h |  2 ++
>> arch/powerpc/kernel/pci-common.c      | 15 ++++++++++++++-
>> arch/powerpc/platforms/pseries/pci.c  |  3 +++
>> 3 files changed, 19 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index b5e88e4..9b11631 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -54,6 +54,7 @@ struct pci_controller_ops {
>>  */
>> struct pci_controller {
>> 	struct pci_bus *bus;
>>+	struct pci_host_bridge *bridge; /* associated 'PHB' in PCI subsystem */
>> 	char is_dynamic;
>> #ifdef CONFIG_PPC64
>> 	int node;
>>@@ -301,6 +302,7 @@ extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>> /* Allocate & free a PCI host bridge structure */
>> extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
>> extern void pcibios_free_controller(struct pci_controller *phb);
>>+extern void pcibios_host_bridge_release(struct pci_host_bridge *bridge);
>>
>> #ifdef CONFIG_PCI
>> extern int pcibios_vaddr_is_ioport(void __iomem *address);
>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>index a5c0153..c5b5f60 100644
>>--- a/arch/powerpc/kernel/pci-common.c
>>+++ b/arch/powerpc/kernel/pci-common.c
>>@@ -145,11 +145,23 @@ void pcibios_free_controller(struct pci_controller *phb)
>> 	list_del(&phb->list_node);
>> 	spin_unlock(&hose_spinlock);
>>
>>-	if (phb->is_dynamic)
>>+	/* if the associated pci_host_bridge has a release_fn(), rely on that. */
>>+	if (!phb->bridge->release_fn && phb->is_dynamic)
>> 		kfree(phb);
>> }
>> EXPORT_SYMBOL_GPL(pcibios_free_controller);
>>
>>+void pcibios_host_bridge_release(struct pci_host_bridge *bridge)
>>+{
>>+	struct pci_controller *phb = (struct pci_controller *) bridge->release_data;
>>+
>>+	pr_debug("domain %d, dynamic %d\n", phb->global_number, phb->is_dynamic);
>>+
>>+	if (phb->is_dynamic)
>>+		kfree(phb);
>>+}
>>+EXPORT_SYMBOL_GPL(pcibios_host_bridge_release);
>
>I figure this is being exported so we can use it in cxl.
>
>-- 
>Andrew Donnellan              OzLabs, ADL Canberra
>andrew.donnellan@au1.ibm.com  IBM Australia Limited
