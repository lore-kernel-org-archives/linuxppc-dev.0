Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 158B6DDF6D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:07:58 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3LE7q9N266980
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 14:07:52 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3LE7qMR1757216
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 15:07:52 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3LE7p7G030044
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 14:07:51 GMT
Message-ID: <480C9FE2.4030601@linux.vnet.ibm.com>
Date: Mon, 21 Apr 2008 16:08:34 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>
	<480BA937.7050603@linux.vnet.ibm.com>
	<1208727408.7009.0.camel@pasglop>
	<480C80B6.30904@linux.vnet.ibm.com>
	<480C87BD.8090207@ru.mvista.com>
In-Reply-To: <480C87BD.8090207@ru.mvista.com>
Content-Type: multipart/mixed; boundary="------------010809060305030200030502"
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010809060305030200030502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Sergei Shtylyov wrote:
> Hello.
> 
> Christian Ehrhardt wrote:
> 
>>> Cheers,
>>> Ben.
> 
>> For comparison I defined DEBUG in the good kernel (arch=ppc) and that 
>> is what the initialization prints (pci ...:0a:1 is the secondary head 
>> of the same graphic card an it's not an issue if thats not allocated):
[...]
>    You've changed fb_base_phys and mmio_base_phys to resource_size_t 
> which is 64-bit, so use %llx to print them.
> 
Thanks your absolutely right, I sometimes forget that I need long long for 64bit on 32bit archs (and ignored the warnings :-( ).
I corrected the printk format strings and attached the new logs.

[...]
>> +else {
>> +printk(KERN_ERR"%s - continue with start 0x%0lx on %p\n", __func__, (this->end + 1), this->sibling);
>> +}
>>                 new->start = this->end + 1;
>>                 this = this->sibling;
> 
>    And here. Yet it's not clear why you call resource's 'end' 'start'...

It's the new->start that get's calculated one line after that new else part.
I printed that one to to see a bit how the loop iterates the resource elements.

> 
> WBR, Sergei


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization

--------------010809060305030200030502
Content-Type: text/plain;
 name="pci_resource_issue_bootmsg_badkernel.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_resource_issue_bootmsg_badkernel.txt"

With DEBUG in arch/powerpc/kernel/pci-common.c, debug in commandline and a patch with some printk's (I attached the patch because it is the usual "put printk's everywhere" so the diff helps to understand where the prints come from). Corrected prinf format specifiers according to the comments from Sergei Shtylyov.

PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:00:00.0
Try to map irq for 0000:00:00.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.1...
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0365060 (PCI IO)
__request_resource - request 0xcf8045b0 name '/plb/pci@1ec000000' start 0x0 end 0xfffff
__request_resource - no conflict parent 0xc0365060 sibling 0x00000000
PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0365038 (PCI mem)
__request_resource - request 0xcf8045d8 name '/plb/pci@1ec000000' start 0x180000000 end 0x18fffffff
__request_resource - no conflict parent 0xc0365038 sibling 0x00000000
PCI: Assigning unassigned resouces...
pci_assign_unassigned_resources -#1- bus 0xcf82d400
pci_assign_unassigned_resources -#2- bus 0xcf82d400
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_assign_resource - second pci_bus_alloc_resource call
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x8000000 startcalc 0xffffffff, align 0x8000000
find_resource - size 0x8000000, min 0x180000000, max 0xffffffffffffffff
find_resource - found start 0x180000000 end 0x187ffffff
__request_resource - request 0xcf810578 name '0000:00:0a.0' start 0x180000000 end 0x187ffffff
__request_resource - no conflict parent 0xcf8045d8 sibling 0x00000000
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_assign_resource - second pci_bus_alloc_resource call
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x8000000 startcalc 0xffffffff, align 0x8000000
find_resource - size 0x8000000, min 0x180000000, max 0xffffffffffffffff
find_resource - continue with start 0x188000000 on 0x00000000
find_resource - found start 0x188000000 end 0x18fffffff
__request_resource - request 0xcf810178 name '0000:00:0a.1' start 0x188000000 end 0x18fffffff
__request_resource - no conflict parent 0xcf8045d8 sibling 0x00000000
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_assign_resource - second pci_bus_alloc_resource call
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x20000 startcalc 0xffffffff, align 0x20000
find_resource - size 0x20000, min 0x180000000, max 0xffffffffffffffff
find_resource - continue with start 0x188000000 on 0xcf810178
find_resource - continue with start 0x190000000 on 0x00000000
find_resource - no this - exit
PCI: pci_assign_resource - Failed to allocate mem resource #6:20000@190000000 for 0000:00:0a.0
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x10000 startcalc 0xffffffff, align 0x10000
find_resource - size 0x10000, min 0x180000000, max 0xffffffffffffffff
find_resource - continue with start 0x188000000 on 0xcf810178
find_resource - continue with start 0x190000000 on 0x00000000
find_resource - no this - exit
PCI: pci_assign_resource - Failed to allocate mem resource #2:10000@190000000 for 0000:00:0a.0
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x10000 startcalc 0xffffffff, align 0x10000
find_resource - size 0x10000, min 0x180000000, max 0xffffffffffffffff
find_resource - continue with start 0x188000000 on 0xcf810178
find_resource - continue with start 0x190000000 on 0x00000000
find_resource - no this - exit
PCI: pci_assign_resource - Failed to allocate mem resource #1:10000@190000000 for 0000:00:0a.1
pci_assign_resource - allocate with IORESOURCE_PREFETCH
pci_bus_alloc_resource - enter
pci_bus_alloc_resource - call allocate ressource size 0x100 startcalc 0xffffffff, align 0x100
find_resource - size 0x100, min 0x1000, max 0xffffffffffffffff
find_resource - found start 0x1000 end 0x10ff
__request_resource - request 0xcf8105a0 name '0000:00:0a.0' start 0x1000 end 0x10ff
__request_resource - no conflict parent 0xcf8045b0 sibling 0x00000000

[...]

radeonfb_pci_register BEGIN
radeonfb_pci_register - resource0 0x180000000 - 0x187ffffff
radeonfb_pci_register - resource1 0x1000 - 0x10ff
radeonfb_pci_register - resource2 0x0 - 0x0
radeonfb_pci_register - got pci ressources fb_base_phys 0x180000000 mmio_base_phys 0x0
__request_resource - request 0xcf8bfd20 name 'radeonfb framebuffer' start 0x180000000 end 0x187ffffff
__request_resource - request 0xcf8bfd20 name 'radeonfb framebuffer' start 0x180000000 end 0x187ffffff
__request_resource - request 0xcf8bfd20 name 'radeonfb framebuffer' start 0x180000000 end 0x187ffffff
__request_resource - no conflict parent 0xcf810578 sibling 0x00000000
radeonfb_pci_register - call ioremap for base 0x0 and size 16384
__ioremap(): phys addr 0x0 is RAM lr 0xc029df88 - mem_init_done 1 highmem@0x10000000
radeonfb (0000:00:0a.0): cannot map MMIO
radeonfb: probe of 0000:00:0a.0 failed with error -5


--------------010809060305030200030502
Content-Type: text/x-patch;
 name="debug_pci_radeonfb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug_pci_radeonfb.diff"

Subject: [PATCH] : ! debug only ! - printk's in pci ressource handling

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This defines debug for pci and put's some printk's to keep track of the pci
ressource handling. This patch is just for reference to understand the
resulting boot message log.
The patch is ugly - but for debugging only ;-)

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kernel/pci-common.c |    2 ++
 arch/powerpc/mm/pgtable_32.c     |    4 ++--
 drivers/pci/bus.c                |    3 +++
 drivers/pci/setup-res.c          |   12 ++++++++----
 drivers/video/aty/radeon_base.c  |    7 +++++++
 drivers/video/aty/radeonfb.h     |    4 ++--
 kernel/resource.c                |   17 ++++++++++++++++-
 7 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -37,6 +37,8 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
+
+#define DEBUG
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -183,8 +183,8 @@ __ioremap(phys_addr_t addr, unsigned lon
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
 	if (mem_init_done && (p < virt_to_phys(high_memory))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
-		       (unsigned long long)p, __builtin_return_address(0));
+		printk("__ioremap(): phys addr 0x%llx is RAM lr 0x%p - mem_init_done %d highmem@0x%p\n",
+		       (unsigned long long)p, __builtin_return_address(0), mem_init_done, virt_to_phys(high_memory));
 		return NULL;
 	}
 
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -42,6 +42,8 @@ pci_bus_alloc_resource(struct pci_bus *b
 {
 	int i, ret = -ENOMEM;
 
+printk(KERN_ERR"%s - enter\n", __func__);
+
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
@@ -59,6 +61,7 @@ pci_bus_alloc_resource(struct pci_bus *b
 		    !(res->flags & IORESOURCE_PREFETCH))
 			continue;
 
+printk(KERN_ERR"%s - call allocate ressource size 0x%0llx startcalc 0x%0x, align 0x%0llx\n", __func__, size, (r->start ? : min,-1), align);
 		/* Ok, try it out.. */
 		ret = allocate_resource(r, res, size,
 					r->start ? : min,
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -544,10 +544,12 @@ pci_assign_unassigned_resources(void)
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
 	list_for_each_entry(bus, &pci_root_buses, node) {
+printk(KERN_ERR"%s -#1- bus 0x%p\n",__func__, bus);
 		pci_bus_size_bridges(bus);
 	}
 	/* Depth last, allocate resources and update the hardware. */
 	list_for_each_entry(bus, &pci_root_buses, node) {
+printk(KERN_ERR"%s -#2- bus 0x%p\n",__func__, bus);
 		pci_bus_assign_resources(bus);
 		pci_enable_bridges(bus);
 	}
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -142,10 +142,13 @@ int pci_assign_resource(struct pci_dev *
 	   required alignment in the "start" field. */
 	align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
 
+printk(KERN_ERR"%s - allocate with IORESOURCE_PREFETCH\n", __func__);
+
 	/* First, try exact prefetching match.. */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH,
 				     pcibios_align_resource, dev);
+
 
 	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
 		/*
@@ -154,13 +157,14 @@ int pci_assign_resource(struct pci_dev *
 		 * But a prefetching area can handle a non-prefetching
 		 * window (it will just not perform as well).
 		 */
+printk(KERN_ERR"%s - second pci_bus_alloc_resource call\n", __func__);
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate %s resource "
-			"#%d:%llx@%llx for %s\n",
+		printk(KERN_ERR "PCI: %s - Failed to allocate %s resource "
+			"#%d:%llx@%llx for %s\n", __func__,
 			res->flags & IORESOURCE_IO ? "I/O" : "mem",
 			resno, (unsigned long long)size,
 			(unsigned long long)res->start, pci_name(dev));
@@ -197,8 +201,8 @@ int pci_assign_resource_fixed(struct pci
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate %s resource "
-				"#%d:%llx@%llx for %s\n",
+		printk(KERN_ERR "PCI: %s - Failed to allocate %s resource "
+				"#%d:%llx@%llx for %s\n", __func__,
 			res->flags & IORESOURCE_IO ? "I/O" : "mem",
 			resno, (unsigned long long)(res->end - res->start + 1),
 			(unsigned long long)res->start, pci_name(dev));
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2160,6 +2160,10 @@ static int __devinit radeonfb_pci_regist
 	int ret;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
+
+printk(KERN_ERR"%s - resource0 0x%0llx - 0x%0llx\n", __func__, pdev->resource[0].start, pdev->resource[0].end);
+printk(KERN_ERR"%s - resource1 0x%0llx - 0x%0llx\n", __func__, pdev->resource[1].start, pdev->resource[1].end);
+printk(KERN_ERR"%s - resource2 0x%0llx - 0x%0llx\n", __func__, pdev->resource[2].start, pdev->resource[2].end);
 	
 	/* Enable device in PCI config */
 	ret = pci_enable_device(pdev);
@@ -2198,6 +2202,8 @@ static int __devinit radeonfb_pci_regist
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+printk(KERN_ERR"%s - got pci ressources fb_base_phys 0x%0llx mmio_base_phys 0x%0llx\n", __func__,rinfo->fb_base_phys,rinfo->mmio_base_phys);
+
 	/* request the mem regions */
 	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
@@ -2214,6 +2220,7 @@ static int __devinit radeonfb_pci_regist
 	}
 
 	/* map the regions */
+printk(KERN_ERR "%s - call ioremap for base 0x%0llx and size %d\n",__func__, rinfo->mmio_base_phys, RADEON_REGSIZE);
 	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
 		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n",
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -287,8 +287,8 @@ struct radeonfb_info {
 
 	char			name[DEVICE_NAME_SIZE];
 
-	unsigned long		mmio_base_phys;
-	unsigned long		fb_base_phys;
+	resource_size_t		mmio_base_phys;
+	resource_size_t		fb_base_phys;
 
 	void __iomem		*mmio_base;
 	void __iomem		*fb_base;
diff --git a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -152,6 +152,9 @@ static struct resource * __request_resou
 	resource_size_t end = new->end;
 	struct resource *tmp, **p;
 
+printk(KERN_ERR"%s - request 0x%p name '%s' start 0x%0llx end 0x%0llx\n",
+			__func__, new, new->name, start, end);
+
 	if (end < start)
 		return root;
 	if (start < root->start)
@@ -165,6 +168,7 @@ static struct resource * __request_resou
 			new->sibling = tmp;
 			*p = new;
 			new->parent = root;
+printk(KERN_ERR"%s - no conflict parent 0x%p sibling 0x%p\n",__func__, new->parent, new->sibling);
 			return NULL;
 		}
 		p = &tmp->sibling;
@@ -305,6 +309,8 @@ static int find_resource(struct resource
 {
 	struct resource *this = root->child;
 
+printk(KERN_ERR"%s - size 0x%0llx, min 0x%0llx, max 0x%0llx\n", __func__, size, min, max);
+
 	new->start = root->start;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
@@ -328,10 +334,16 @@ static int find_resource(struct resource
 			alignf(alignf_data, new, size, align);
 		if (new->start < new->end && new->end - new->start >= size - 1) {
 			new->end = new->start + size - 1;
+printk(KERN_ERR"%s - found start 0x%0llx end 0x%0llx\n", __func__, new->start, new->end);
 			return 0;
 		}
-		if (!this)
+		if (!this) {
+printk(KERN_ERR"%s - no this - exit\n", __func__);
 			break;
+}
+else {
+printk(KERN_ERR"%s - continue with start 0x%0llx on 0x%p\n", __func__, (this->end + 1), this->sibling);
+}
 		new->start = this->end + 1;
 		this = this->sibling;
 	}
@@ -385,6 +397,9 @@ int insert_resource(struct resource *par
 {
 	int result;
 	struct resource *first, *next;
+
+printk(KERN_ERR"%s - insert 0x%p (start 0x%0llx end 0x%0llx) under parent 0x%p\n",
+			__func__, new, new->start, new->end, parent);
 
 	write_lock(&resource_lock);
 

--------------010809060305030200030502--
