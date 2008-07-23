Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E805EDF14D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:31:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIVX8M025397
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:31:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIVXiL094904
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:31:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIVW8d010383
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:31:33 -0600
Date: Wed, 23 Jul 2008 13:31:33 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 10/16 v4] powerpc: vio bus support for CMO
Message-ID: <20080723183132.GM12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

This is a large patch but the normal code path is not affected.  For
non-pSeries platforms the code is ifdef'ed out and for non-CMO enabled
pSeries systems this does not affect the normal code path.  Devices that
do not perform DMA operations do not need modification with this patch.
The function get_desired_dma was renamed from get_io_entitlement for
clarity.

Overview

Cooperative Memory Overcommitment (CMO) allows for a set of OS partitions
to be run with less RAM than the aggregate needs of the group of
partitions.  The firmware will balance memory between the partitions
and page in/out memory as needed.  Based on the number and type of IO
adpaters preset each partition is allocated an amount of memory for
DMA operations and this allocation will be guaranteed to the partition;
this is referred to as the partition's 'entitlement'.

Partitions running in a CMO environment can only have virtual IO devices
present.  The VIO bus layer will manage the IO entitlement for the system.
Accounting, at a system and per-device level, is tracked in the VIO bus
code and exposed via sysfs.  A set of dma_ops functions are added to
the bus to allow for this accounting.

Bus initialization

At initialization, the bus will calculate the minimum needs of the system
based on providing each device present with a standard minimum entitlement
along with a spare allocation for the bus to handle hotplug events.
If the minimum needs can not be met the system boot will be halted.

Device changes

The significant changes for devices while running under CMO are that the
devices must specify how much dedicated IO entitlement they desire and
must also handle DMA mapping errors that can occur due to constrained
IO memory.  The virtual IO drivers are modified to silence errors when
DMA mappings fail for CMO and handle these failures gracefully.

Each devices will be guaranteed a minimum entitlement that can always
be mapped.  Devices will specify how much entitlement they desire and
the VIO bus will attempt to provide for this.  Devices can change their
desired entitlement level at any point in time to address particular needs
(via vio_cmo_set_dev_desired()), not just at device probe time.

VIO bus changes

The system will have a particular entitlement level available from which
it can provide memory to the devices.  The bus defines two pools of memory
within this entitlement, the reserved and excess pools.  Each device is
provided with it's own entitlement no less than a system defined minimum
entitlement and no greater than what the device has specified as it's
desired entitlement.  The entitlement provided to devices comes from the
reserve pool.  The reserve pool can also contain a spare allocation as
large as the system defined minimum entitlement which is used for device
hotplug events.  Any entitlement not needed to fulfill the needs of a
reserve pool is placed in the excess pool.  Each device is guaranteed
that it can map up to it's entitled level; additional mapping are possible
as long as there is unmapped memory in the excess pool.

Bus probe

As the system starts, each device is given an entitlement equal only
to the system defined minimum entitlement.  The reserve pool is equal
to the sum of these entitlements, plus a spare allocation.  The VIO bus
also tracks the aggregate desired entitlement of all the devices.  If the
system desired entitlement is greater than the size of the reserve pool,
when devices unmap IO memory it will be reserved and a balance operation
will be scheduled for some time in the future.

Entitlement balancing

The balance function tries to fairly distribute entitlement between the
devices in the system with the goal of providing each device with it's
desired amount of entitlement.  Devices using more than what would be
ideal will have their entitled set-point adjusted; this will effectively
set a goal for lower IO memory usage as future mappings can fail and
deallocations will trigger a balance operation to distribute the newly
unmapped memory.  A fair distribution of entitlement can take several
balance operations to achieve.  Entitlement changes and device DLPAR
events will alter the state of CMO and will trigger balance operations.

Hotplug events

The VIO bus allows for changes in system entitlement at run-time via
'vio_cmo_entitlement_update()'.  When devices are added the hotplug
device event will be preceded by a system entitlement increase and this
is reversed when devices are removed.

The following changes are made that the VIO bus layer for CMO:
 * add IO memory accounting per device structure.
 * add IO memory entitlement query function to driver structure.
 * during vio bus probe, if CMO is enabled, check that driver has
   memory entitlement query function defined.  Fail if function not defined.
 * fail to register driver if io entitlement function not defined.
 * create set of dma_ops at vio level for CMO that will track allocations
   and return DMA failures once entitlement is reached.  Entitlement will
   limited by overall system entitlement.  Devices will have a reserved
   quantity of memory that is guaranteed, the rest can be used as available.
 * expose entitlement, current allocation, desired allocation, and the
   allocation error counter for devices to the user through sysfs
 * provide mechanism for changing a device's desired entitlement at run time
   for devices as an exported function and sysfs tunable
 * track any DMA failures for entitled IO memory for each vio device.
 * check entitlement against available system entitlement on device add
 * track entitlement metrics (high water mark, current usage)
 * provide function to reset high water mark
 * provide minimum and desired entitlement numbers at a bus level
 * provide drivers with a minimum guaranteed entitlement
 * balance available entitlement between devices to satisfy their needs
 * handle system entitlement changes and device hotplug

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
Change to add a call to align the return from the device's
get_desired_dma() function with IOMMU_PAGE_ALIGN().  Changed accounting
to round to IOMMU_PAGE_SIZE rather than PAGE_SIZE to properly count
mapping when using a 64k page kernel with 4k page hardware support.

Removed a comment referring to a non-existent structure member.

Corrected entitlement accounting in map_sg.  The ibmvscsi driver
maps pages via map_sg and frees the sg list by calling unmap_single.
This exposes a problem where the code had been using the length field
in the scatterlist to account for the allocation when the mapping was
created but the dma_length would be used when the mapping was destroyed.
The iommu code does coalesce the pages so the dma_length can be smaller
and would result in an entitlement accounting leak.  This patch frees
up the entitlement after calling the iommu map_sg code when pages have
been coalesced.

Added Kconfig entry for this with dependencies that will ensure h_get_mpp
=66rom lparcfg is available when the new functionality is compiled.

---
 arch/powerpc/kernel/vio.c              | 1033 ++++++++++++++++++++++++++++=
+++++
 arch/powerpc/platforms/pseries/Kconfig |   13 +
 include/asm-powerpc/vio.h              |   27 +
 3 files changed, 1064 insertions(+), 9 deletions(-)

Index: b/arch/powerpc/kernel/vio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1,11 +1,12 @@
 /*
  * IBM PowerPC Virtual I/O Infrastructure Support.
  *
- *    Copyright (c) 2003-2005 IBM Corp.
+ *    Copyright (c) 2003,2008 IBM Corp.
  *     Dave Engebretsen engebret@us.ibm.com
  *     Santiago Leon santil@us.ibm.com
  *     Hollis Blanchard <hollisb@us.ibm.com>
  *     Stephen Rothwell
+ *     Robert Jennings <rcjenn@us.ibm.com>
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -46,6 +47,996 @@ static struct vio_dev vio_bus_device  =3D=20
 	.dev.bus =3D &vio_bus_type,
 };
=20
+#ifdef CONFIG_PPC_SMLPAR
+/**
+ * vio_cmo_pool - A pool of IO memory for CMO use
+ *
+ * @size: The size of the pool in bytes
+ * @free: The amount of free memory in the pool
+ */
+struct vio_cmo_pool {
+	size_t size;
+	size_t free;
+};
+
+/* How many ms to delay queued balance work */
+#define VIO_CMO_BALANCE_DELAY 100
+
+/* Portion out IO memory to CMO devices by this chunk size */
+#define VIO_CMO_BALANCE_CHUNK 131072
+
+/**
+ * vio_cmo_dev_entry - A device that is CMO-enabled and requires entitleme=
nt
+ *
+ * @vio_dev: struct vio_dev pointer
+ * @list: pointer to other devices on bus that are being tracked
+ */
+struct vio_cmo_dev_entry {
+	struct vio_dev *viodev;
+	struct list_head list;
+};
+
+/**
+ * vio_cmo - VIO bus accounting structure for CMO entitlement
+ *
+ * @lock: spinlock for entire structure
+ * @balance_q: work queue for balancing system entitlement
+ * @device_list: list of CMO-enabled devices requiring entitlement
+ * @entitled: total system entitlement in bytes
+ * @reserve: pool of memory from which devices reserve entitlement, incl. =
spare
+ * @excess: pool of excess entitlement not needed for device reserves or s=
pare
+ * @spare: IO memory for device hotplug functionality
+ * @min: minimum necessary for system operation
+ * @desired: desired memory for system operation
+ * @curr: bytes currently allocated
+ * @high: high water mark for IO data usage
+ */
+struct vio_cmo {
+	spinlock_t lock;
+	struct delayed_work balance_q;
+	struct list_head device_list;
+	size_t entitled;
+	struct vio_cmo_pool reserve;
+	struct vio_cmo_pool excess;
+	size_t spare;
+	size_t min;
+	size_t desired;
+	size_t curr;
+	size_t high;
+} vio_cmo;
+
+/**
+ * vio_cmo_OF_devices - Count the number of OF devices that have DMA windo=
ws
+ */
+static int vio_cmo_num_OF_devs(void)
+{
+	struct device_node *node_vroot;
+	int count =3D 0;
+
+	/*
+	 * Count the number of vdevice entries with an
+	 * ibm,my-dma-window OF property
+	 */
+	node_vroot =3D of_find_node_by_name(NULL, "vdevice");
+	if (node_vroot) {
+		struct device_node *of_node;
+		struct property *prop;
+
+		for_each_child_of_node(node_vroot, of_node) {
+			prop =3D of_find_property(of_node, "ibm,my-dma-window",
+			                       NULL);
+			if (prop)
+				count++;
+		}
+	}
+	of_node_put(node_vroot);
+	return count;
+}
+
+/**
+ * vio_cmo_alloc - allocate IO memory for CMO-enable devices
+ *
+ * @viodev: VIO device requesting IO memory
+ * @size: size of allocation requested
+ *
+ * Allocations come from memory reserved for the devices and any excess
+ * IO memory available to all devices.  The spare pool used to service
+ * hotplug must be equal to %VIO_CMO_MIN_ENT for the excess pool to be
+ * made available.
+ *
+ * Return codes:
+ *  0 for successful allocation and -ENOMEM for a failure
+ */
+static inline int vio_cmo_alloc(struct vio_dev *viodev, size_t size)
+{
+	unsigned long flags;
+	size_t reserve_free =3D 0;
+	size_t excess_free =3D 0;
+	int ret =3D -ENOMEM;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+
+	/* Determine the amount of free entitlement available in reserve */
+	if (viodev->cmo.entitled > viodev->cmo.allocated)
+		reserve_free =3D viodev->cmo.entitled - viodev->cmo.allocated;
+
+	/* If spare is not fulfilled, the excess pool can not be used. */
+	if (vio_cmo.spare >=3D VIO_CMO_MIN_ENT)
+		excess_free =3D vio_cmo.excess.free;
+
+	/* The request can be satisfied */
+	if ((reserve_free + excess_free) >=3D size) {
+		vio_cmo.curr +=3D size;
+		if (vio_cmo.curr > vio_cmo.high)
+			vio_cmo.high =3D vio_cmo.curr;
+		viodev->cmo.allocated +=3D size;
+		size -=3D min(reserve_free, size);
+		vio_cmo.excess.free -=3D size;
+		ret =3D 0;
+	}
+
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+	return ret;
+}
+
+/**
+ * vio_cmo_dealloc - deallocate IO memory from CMO-enable devices
+ * @viodev: VIO device freeing IO memory
+ * @size: size of deallocation
+ *
+ * IO memory is freed by the device back to the correct memory pools.
+ * The spare pool is replenished first from either memory pool, then
+ * the reserve pool is used to reduce device entitlement, the excess
+ * pool is used to increase the reserve pool toward the desired entitlement
+ * target, and then the remaining memory is returned to the pools.
+ *
+ */
+static inline void vio_cmo_dealloc(struct vio_dev *viodev, size_t size)
+{
+	unsigned long flags;
+	size_t spare_needed =3D 0;
+	size_t excess_freed =3D 0;
+	size_t reserve_freed =3D size;
+	size_t tmp;
+	int balance =3D 0;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+	vio_cmo.curr -=3D size;
+
+	/* Amount of memory freed from the excess pool */
+	if (viodev->cmo.allocated > viodev->cmo.entitled) {
+		excess_freed =3D min(reserve_freed, (viodev->cmo.allocated -
+		                                   viodev->cmo.entitled));
+		reserve_freed -=3D excess_freed;
+	}
+
+	/* Remove allocation from device */
+	viodev->cmo.allocated -=3D (reserve_freed + excess_freed);
+
+	/* Spare is a subset of the reserve pool, replenish it first. */
+	spare_needed =3D VIO_CMO_MIN_ENT - vio_cmo.spare;
+
+	/*
+	 * Replenish the spare in the reserve pool from the excess pool.
+	 * This moves entitlement into the reserve pool.
+	 */
+	if (spare_needed && excess_freed) {
+		tmp =3D min(excess_freed, spare_needed);
+		vio_cmo.excess.size -=3D tmp;
+		vio_cmo.reserve.size +=3D tmp;
+		vio_cmo.spare +=3D tmp;
+		excess_freed -=3D tmp;
+		spare_needed -=3D tmp;
+		balance =3D 1;
+	}
+
+	/*
+	 * Replenish the spare in the reserve pool from the reserve pool.
+	 * This removes entitlement from the device down to VIO_CMO_MIN_ENT,
+	 * if needed, and gives it to the spare pool. The amount of used
+	 * memory in this pool does not change.
+	 */
+	if (spare_needed && reserve_freed) {
+		tmp =3D min(spare_needed, min(reserve_freed,
+		                            (viodev->cmo.entitled -
+		                             VIO_CMO_MIN_ENT)));
+
+		vio_cmo.spare +=3D tmp;
+		viodev->cmo.entitled -=3D tmp;
+		reserve_freed -=3D tmp;
+		spare_needed -=3D tmp;
+		balance =3D 1;
+	}
+
+	/*
+	 * Increase the reserve pool until the desired allocation is met.
+	 * Move an allocation freed from the excess pool into the reserve
+	 * pool and schedule a balance operation.
+	 */
+	if (excess_freed && (vio_cmo.desired > vio_cmo.reserve.size)) {
+		tmp =3D min(excess_freed, (vio_cmo.desired - vio_cmo.reserve.size));
+
+		vio_cmo.excess.size -=3D tmp;
+		vio_cmo.reserve.size +=3D tmp;
+		excess_freed -=3D tmp;
+		balance =3D 1;
+	}
+
+	/* Return memory from the excess pool to that pool */
+	if (excess_freed)
+		vio_cmo.excess.free +=3D excess_freed;
+
+	if (balance)
+		schedule_delayed_work(&vio_cmo.balance_q, VIO_CMO_BALANCE_DELAY);
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+}
+
+/**
+ * vio_cmo_entitlement_update - Manage system entitlement changes
+ *
+ * @new_entitlement: new system entitlement to attempt to accommodate
+ *
+ * Increases in entitlement will be used to fulfill the spare entitlement
+ * and the rest is given to the excess pool.  Decreases, if they are
+ * possible, come from the excess pool and from unused device entitlement
+ *
+ * Returns: 0 on success, -ENOMEM when change can not be made
+ */
+int vio_cmo_entitlement_update(size_t new_entitlement)
+{
+	struct vio_dev *viodev;
+	struct vio_cmo_dev_entry *dev_ent;
+	unsigned long flags;
+	size_t avail, delta, tmp;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+
+	/* Entitlement increases */
+	if (new_entitlement > vio_cmo.entitled) {
+		delta =3D new_entitlement - vio_cmo.entitled;
+
+		/* Fulfill spare allocation */
+		if (vio_cmo.spare < VIO_CMO_MIN_ENT) {
+			tmp =3D min(delta, (VIO_CMO_MIN_ENT - vio_cmo.spare));
+			vio_cmo.spare +=3D tmp;
+			vio_cmo.reserve.size +=3D tmp;
+			delta -=3D tmp;
+		}
+
+		/* Remaining new allocation goes to the excess pool */
+		vio_cmo.entitled +=3D delta;
+		vio_cmo.excess.size +=3D delta;
+		vio_cmo.excess.free +=3D delta;
+
+		goto out;
+	}
+
+	/* Entitlement decreases */
+	delta =3D vio_cmo.entitled - new_entitlement;
+	avail =3D vio_cmo.excess.free;
+
+	/*
+	 * Need to check how much unused entitlement each device can
+	 * sacrifice to fulfill entitlement change.
+	 */
+	list_for_each_entry(dev_ent, &vio_cmo.device_list, list) {
+		if (avail >=3D delta)
+			break;
+
+		viodev =3D dev_ent->viodev;
+		if ((viodev->cmo.entitled > viodev->cmo.allocated) &&
+		    (viodev->cmo.entitled > VIO_CMO_MIN_ENT))
+				avail +=3D viodev->cmo.entitled -
+				         max_t(size_t, viodev->cmo.allocated,
+				               VIO_CMO_MIN_ENT);
+	}
+
+	if (delta <=3D avail) {
+		vio_cmo.entitled -=3D delta;
+
+		/* Take entitlement from the excess pool first */
+		tmp =3D min(vio_cmo.excess.free, delta);
+		vio_cmo.excess.size -=3D tmp;
+		vio_cmo.excess.free -=3D tmp;
+		delta -=3D tmp;
+
+		/*
+		 * Remove all but VIO_CMO_MIN_ENT bytes from devices
+		 * until entitlement change is served
+		 */
+		list_for_each_entry(dev_ent, &vio_cmo.device_list, list) {
+			if (!delta)
+				break;
+
+			viodev =3D dev_ent->viodev;
+			tmp =3D 0;
+			if ((viodev->cmo.entitled > viodev->cmo.allocated) &&
+			    (viodev->cmo.entitled > VIO_CMO_MIN_ENT))
+				tmp =3D viodev->cmo.entitled -
+				      max_t(size_t, viodev->cmo.allocated,
+				            VIO_CMO_MIN_ENT);
+			viodev->cmo.entitled -=3D min(tmp, delta);
+			delta -=3D min(tmp, delta);
+		}
+	} else {
+		spin_unlock_irqrestore(&vio_cmo.lock, flags);
+		return -ENOMEM;
+	}
+
+out:
+	schedule_delayed_work(&vio_cmo.balance_q, 0);
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+	return 0;
+}
+
+/**
+ * vio_cmo_balance - Balance entitlement among devices
+ *
+ * @work: work queue structure for this operation
+ *
+ * Any system entitlement above the minimum needed for devices, or
+ * already allocated to devices, can be distributed to the devices.
+ * The list of devices is iterated through to recalculate the desired
+ * entitlement level and to determine how much entitlement above the
+ * minimum entitlement is allocated to devices.
+ *
+ * Small chunks of the available entitlement are given to devices until
+ * their requirements are fulfilled or there is no entitlement left to giv=
e.
+ * Upon completion sizes of the reserve and excess pools are calculated.
+ *
+ * The system minimum entitlement level is also recalculated here.
+ * Entitlement will be reserved for devices even after vio_bus_remove to
+ * accommodate reloading the driver.  The OF tree is walked to count the
+ * number of devices present and this will remove entitlement for devices
+ * that have actually left the system after having vio_bus_remove called.
+ */
+static void vio_cmo_balance(struct work_struct *work)
+{
+	struct vio_cmo *cmo;
+	struct vio_dev *viodev;
+	struct vio_cmo_dev_entry *dev_ent;
+	unsigned long flags;
+	size_t avail =3D 0, level, chunk, need;
+	int devcount =3D 0, fulfilled;
+
+	cmo =3D container_of(work, struct vio_cmo, balance_q.work);
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+
+	/* Calculate minimum entitlement and fulfill spare */
+	cmo->min =3D vio_cmo_num_OF_devs() * VIO_CMO_MIN_ENT;
+	BUG_ON(cmo->min > cmo->entitled);
+	cmo->spare =3D min_t(size_t, VIO_CMO_MIN_ENT, (cmo->entitled - cmo->min));
+	cmo->min +=3D cmo->spare;
+	cmo->desired =3D cmo->min;
+
+	/*
+	 * Determine how much entitlement is available and reset device
+	 * entitlements
+	 */
+	avail =3D cmo->entitled - cmo->spare;
+	list_for_each_entry(dev_ent, &vio_cmo.device_list, list) {
+		viodev =3D dev_ent->viodev;
+		devcount++;
+		viodev->cmo.entitled =3D VIO_CMO_MIN_ENT;
+		cmo->desired +=3D (viodev->cmo.desired - VIO_CMO_MIN_ENT);
+		avail -=3D max_t(size_t, viodev->cmo.allocated, VIO_CMO_MIN_ENT);
+	}
+
+	/*
+	 * Having provided each device with the minimum entitlement, loop
+	 * over the devices portioning out the remaining entitlement
+	 * until there is nothing left.
+	 */
+	level =3D VIO_CMO_MIN_ENT;
+	while (avail) {
+		fulfilled =3D 0;
+		list_for_each_entry(dev_ent, &vio_cmo.device_list, list) {
+			viodev =3D dev_ent->viodev;
+
+			if (viodev->cmo.desired <=3D level) {
+				fulfilled++;
+				continue;
+			}
+
+			/*
+			 * Give the device up to VIO_CMO_BALANCE_CHUNK
+			 * bytes of entitlement, but do not exceed the
+			 * desired level of entitlement for the device.
+			 */
+			chunk =3D min_t(size_t, avail, VIO_CMO_BALANCE_CHUNK);
+			chunk =3D min(chunk, (viodev->cmo.desired -
+			                    viodev->cmo.entitled));
+			viodev->cmo.entitled +=3D chunk;
+
+			/*
+			 * If the memory for this entitlement increase was
+			 * already allocated to the device it does not come
+			 * from the available pool being portioned out.
+			 */
+			need =3D max(viodev->cmo.allocated, viodev->cmo.entitled)-
+			       max(viodev->cmo.allocated, level);
+			avail -=3D need;
+
+		}
+		if (fulfilled =3D=3D devcount)
+			break;
+		level +=3D VIO_CMO_BALANCE_CHUNK;
+	}
+
+	/* Calculate new reserve and excess pool sizes */
+	cmo->reserve.size =3D cmo->min;
+	cmo->excess.free =3D 0;
+	cmo->excess.size =3D 0;
+	need =3D 0;
+	list_for_each_entry(dev_ent, &vio_cmo.device_list, list) {
+		viodev =3D dev_ent->viodev;
+		/* Calculated reserve size above the minimum entitlement */
+		if (viodev->cmo.entitled)
+			cmo->reserve.size +=3D (viodev->cmo.entitled -
+			                      VIO_CMO_MIN_ENT);
+		/* Calculated used excess entitlement */
+		if (viodev->cmo.allocated > viodev->cmo.entitled)
+			need +=3D viodev->cmo.allocated - viodev->cmo.entitled;
+	}
+	cmo->excess.size =3D cmo->entitled - cmo->reserve.size;
+	cmo->excess.free =3D cmo->excess.size - need;
+
+	cancel_delayed_work(container_of(work, struct delayed_work, work));
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+}
+
+static void *vio_dma_iommu_alloc_coherent(struct device *dev, size_t size,
+                                          dma_addr_t *dma_handle, gfp_t fl=
ag)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	void *ret;
+
+	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE))) {
+		atomic_inc(&viodev->cmo.allocs_failed);
+		return NULL;
+	}
+
+	ret =3D dma_iommu_ops.alloc_coherent(dev, size, dma_handle, flag);
+	if (unlikely(ret =3D=3D NULL)) {
+		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+		atomic_inc(&viodev->cmo.allocs_failed);
+	}
+
+	return ret;
+}
+
+static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
+                                        void *vaddr, dma_addr_t dma_handle)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+
+	dma_iommu_ops.free_coherent(dev, size, vaddr, dma_handle);
+
+	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+}
+
+static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
+                                           size_t size,
+                                           enum dma_data_direction directi=
on,
+                                           struct dma_attrs *attrs)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	dma_addr_t ret =3D DMA_ERROR_CODE;
+
+	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE))) {
+		atomic_inc(&viodev->cmo.allocs_failed);
+		return ret;
+	}
+
+	ret =3D dma_iommu_ops.map_single(dev, vaddr, size, direction, attrs);
+	if (unlikely(dma_mapping_error(ret))) {
+		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+		atomic_inc(&viodev->cmo.allocs_failed);
+	}
+
+	return ret;
+}
+
+static void vio_dma_iommu_unmap_single(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+
+	dma_iommu_ops.unmap_single(dev, dma_handle, size, direction, attrs);
+
+	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+}
+
+static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sg=
list,
+                                int nelems, enum dma_data_direction direct=
ion,
+                                struct dma_attrs *attrs)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	struct scatterlist *sgl;
+	int ret, count =3D 0;
+	size_t alloc_size =3D 0;
+
+	for (sgl =3D sglist; count < nelems; count++, sgl++)
+		alloc_size +=3D roundup(sgl->length, IOMMU_PAGE_SIZE);
+
+	if (vio_cmo_alloc(viodev, alloc_size)) {
+		atomic_inc(&viodev->cmo.allocs_failed);
+		return 0;
+	}
+
+	ret =3D dma_iommu_ops.map_sg(dev, sglist, nelems, direction, attrs);
+
+	if (unlikely(!ret)) {
+		vio_cmo_dealloc(viodev, alloc_size);
+		atomic_inc(&viodev->cmo.allocs_failed);
+	}
+
+	for (sgl =3D sglist, count =3D 0; count < ret; count++, sgl++)
+		alloc_size -=3D roundup(sgl->dma_length, IOMMU_PAGE_SIZE);
+	if (alloc_size)
+		vio_cmo_dealloc(viodev, alloc_size);
+
+	return ret;
+}
+
+static void vio_dma_iommu_unmap_sg(struct device *dev,
+		struct scatterlist *sglist, int nelems,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	struct scatterlist *sgl;
+	size_t alloc_size =3D 0;
+	int count =3D 0;
+
+	for (sgl =3D sglist; count < nelems; count++, sgl++)
+		alloc_size +=3D roundup(sgl->dma_length, IOMMU_PAGE_SIZE);
+
+	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
+
+	vio_cmo_dealloc(viodev, alloc_size);
+}
+
+struct dma_mapping_ops vio_dma_mapping_ops =3D {
+	.alloc_coherent =3D vio_dma_iommu_alloc_coherent,
+	.free_coherent  =3D vio_dma_iommu_free_coherent,
+	.map_single     =3D vio_dma_iommu_map_single,
+	.unmap_single   =3D vio_dma_iommu_unmap_single,
+	.map_sg         =3D vio_dma_iommu_map_sg,
+	.unmap_sg       =3D vio_dma_iommu_unmap_sg,
+};
+
+/**
+ * vio_cmo_set_dev_desired - Set desired entitlement for a device
+ *
+ * @viodev: struct vio_dev for device to alter
+ * @new_desired: new desired entitlement level in bytes
+ *
+ * For use by devices to request a change to their entitlement at runtime =
or
+ * through sysfs.  The desired entitlement level is changed and a balancing
+ * of system resources is scheduled to run in the future.
+ */
+void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired)
+{
+	unsigned long flags;
+	struct vio_cmo_dev_entry *dev_ent;
+	int found =3D 0;
+
+	if (!firmware_has_feature(FW_FEATURE_CMO))
+		return;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+	if (desired < VIO_CMO_MIN_ENT)
+		desired =3D VIO_CMO_MIN_ENT;
+
+	/*
+	 * Changes will not be made for devices not in the device list.
+	 * If it is not in the device list, then no driver is loaded
+	 * for the device and it can not receive entitlement.
+	 */
+	list_for_each_entry(dev_ent, &vio_cmo.device_list, list)
+		if (viodev =3D=3D dev_ent->viodev) {
+			found =3D 1;
+			break;
+		}
+	if (!found)
+		return;
+
+	/* Increase/decrease in desired device entitlement */
+	if (desired >=3D viodev->cmo.desired) {
+		/* Just bump the bus and device values prior to a balance*/
+		vio_cmo.desired +=3D desired - viodev->cmo.desired;
+		viodev->cmo.desired =3D desired;
+	} else {
+		/* Decrease bus and device values for desired entitlement */
+		vio_cmo.desired -=3D viodev->cmo.desired - desired;
+		viodev->cmo.desired =3D desired;
+		/*
+		 * If less entitlement is desired than current entitlement, move
+		 * any reserve memory in the change region to the excess pool.
+		 */
+		if (viodev->cmo.entitled > desired) {
+			vio_cmo.reserve.size -=3D viodev->cmo.entitled - desired;
+			vio_cmo.excess.size +=3D viodev->cmo.entitled - desired;
+			/*
+			 * If entitlement moving from the reserve pool to the
+			 * excess pool is currently unused, add to the excess
+			 * free counter.
+			 */
+			if (viodev->cmo.allocated < viodev->cmo.entitled)
+				vio_cmo.excess.free +=3D viodev->cmo.entitled -
+				                       max(viodev->cmo.allocated, desired);
+			viodev->cmo.entitled =3D desired;
+		}
+	}
+	schedule_delayed_work(&vio_cmo.balance_q, 0);
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+}
+
+/**
+ * vio_cmo_bus_probe - Handle CMO specific bus probe activities
+ *
+ * @viodev - Pointer to struct vio_dev for device
+ *
+ * Determine the devices IO memory entitlement needs, attempting
+ * to satisfy the system minimum entitlement at first and scheduling
+ * a balance operation to take care of the rest at a later time.
+ *
+ * Returns: 0 on success, -EINVAL when device doesn't support CMO, and
+ *          -ENOMEM when entitlement is not available for device or
+ *          device entry.
+ *
+ */
+static int vio_cmo_bus_probe(struct vio_dev *viodev)
+{
+	struct vio_cmo_dev_entry *dev_ent;
+	struct device *dev =3D &viodev->dev;
+	struct vio_driver *viodrv =3D to_vio_driver(dev->driver);
+	unsigned long flags;
+	size_t size;
+
+	/*
+	 * Check to see that device has a DMA window and configure
+	 * entitlement for the device.
+	 */
+	if (of_get_property(viodev->dev.archdata.of_node,
+	                    "ibm,my-dma-window", NULL)) {
+		/* Check that the driver is CMO enabled and get desired DMA */
+		if (!viodrv->get_desired_dma) {
+			dev_err(dev, "%s: device driver does not support CMO\n",
+			        __func__);
+			return -EINVAL;
+		}
+
+		viodev->cmo.desired =3D IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev)=
);
+		if (viodev->cmo.desired < VIO_CMO_MIN_ENT)
+			viodev->cmo.desired =3D VIO_CMO_MIN_ENT;
+		size =3D VIO_CMO_MIN_ENT;
+
+		dev_ent =3D kmalloc(sizeof(struct vio_cmo_dev_entry),
+		                  GFP_KERNEL);
+		if (!dev_ent)
+			return -ENOMEM;
+
+		dev_ent->viodev =3D viodev;
+		spin_lock_irqsave(&vio_cmo.lock, flags);
+		list_add(&dev_ent->list, &vio_cmo.device_list);
+	} else {
+		viodev->cmo.desired =3D 0;
+		size =3D 0;
+		spin_lock_irqsave(&vio_cmo.lock, flags);
+	}
+
+	/*
+	 * If the needs for vio_cmo.min have not changed since they
+	 * were last set, the number of devices in the OF tree has
+	 * been constant and the IO memory for this is already in
+	 * the reserve pool.
+	 */
+	if (vio_cmo.min =3D=3D ((vio_cmo_num_OF_devs() + 1) *
+	                    VIO_CMO_MIN_ENT)) {
+		/* Updated desired entitlement if device requires it */
+		if (size)
+			vio_cmo.desired +=3D (viodev->cmo.desired -
+		                        VIO_CMO_MIN_ENT);
+	} else {
+		size_t tmp;
+
+		tmp =3D vio_cmo.spare + vio_cmo.excess.free;
+		if (tmp < size) {
+			dev_err(dev, "%s: insufficient free "
+			        "entitlement to add device. "
+			        "Need %lu, have %lu\n", __func__,
+				size, (vio_cmo.spare + tmp));
+			spin_unlock_irqrestore(&vio_cmo.lock, flags);
+			return -ENOMEM;
+		}
+
+		/* Use excess pool first to fulfill request */
+		tmp =3D min(size, vio_cmo.excess.free);
+		vio_cmo.excess.free -=3D tmp;
+		vio_cmo.excess.size -=3D tmp;
+		vio_cmo.reserve.size +=3D tmp;
+
+		/* Use spare if excess pool was insufficient */
+		vio_cmo.spare -=3D size - tmp;
+
+		/* Update bus accounting */
+		vio_cmo.min +=3D size;
+		vio_cmo.desired +=3D viodev->cmo.desired;
+	}
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+	return 0;
+}
+
+/**
+ * vio_cmo_bus_remove - Handle CMO specific bus removal activities
+ *
+ * @viodev - Pointer to struct vio_dev for device
+ *
+ * Remove the device from the cmo device list.  The minimum entitlement
+ * will be reserved for the device as long as it is in the system.  The
+ * rest of the entitlement the device had been allocated will be returned
+ * to the system.
+ */
+static void vio_cmo_bus_remove(struct vio_dev *viodev)
+{
+	struct vio_cmo_dev_entry *dev_ent;
+	unsigned long flags;
+	size_t tmp;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+	if (viodev->cmo.allocated) {
+		dev_err(&viodev->dev, "%s: device had %lu bytes of IO "
+		        "allocated after remove operation.\n",
+		        __func__, viodev->cmo.allocated);
+		BUG();
+	}
+
+	/*
+	 * Remove the device from the device list being maintained for
+	 * CMO enabled devices.
+	 */
+	list_for_each_entry(dev_ent, &vio_cmo.device_list, list)
+		if (viodev =3D=3D dev_ent->viodev) {
+			list_del(&dev_ent->list);
+			kfree(dev_ent);
+			break;
+		}
+
+	/*
+	 * Devices may not require any entitlement and they do not need
+	 * to be processed.  Otherwise, return the device's entitlement
+	 * back to the pools.
+	 */
+	if (viodev->cmo.entitled) {
+		/*
+		 * This device has not yet left the OF tree, it's
+		 * minimum entitlement remains in vio_cmo.min and
+		 * vio_cmo.desired
+		 */
+		vio_cmo.desired -=3D (viodev->cmo.desired - VIO_CMO_MIN_ENT);
+
+		/*
+		 * Save min allocation for device in reserve as long
+		 * as it exists in OF tree as determined by later
+		 * balance operation
+		 */
+		viodev->cmo.entitled -=3D VIO_CMO_MIN_ENT;
+
+		/* Replenish spare from freed reserve pool */
+		if (viodev->cmo.entitled && (vio_cmo.spare < VIO_CMO_MIN_ENT)) {
+			tmp =3D min(viodev->cmo.entitled, (VIO_CMO_MIN_ENT -
+			                                 vio_cmo.spare));
+			vio_cmo.spare +=3D tmp;
+			viodev->cmo.entitled -=3D tmp;
+		}
+
+		/* Remaining reserve goes to excess pool */
+		vio_cmo.excess.size +=3D viodev->cmo.entitled;
+		vio_cmo.excess.free +=3D viodev->cmo.entitled;
+		vio_cmo.reserve.size -=3D viodev->cmo.entitled;
+
+		/*
+		 * Until the device is removed it will keep a
+		 * minimum entitlement; this will guarantee that
+		 * a module unload/load will result in a success.
+		 */
+		viodev->cmo.entitled =3D VIO_CMO_MIN_ENT;
+		viodev->cmo.desired =3D VIO_CMO_MIN_ENT;
+		atomic_set(&viodev->cmo.allocs_failed, 0);
+	}
+
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+}
+
+static void vio_cmo_set_dma_ops(struct vio_dev *viodev)
+{
+	vio_dma_mapping_ops.dma_supported =3D dma_iommu_ops.dma_supported;
+	viodev->dev.archdata.dma_ops =3D &vio_dma_mapping_ops;
+}
+
+/**
+ * vio_cmo_bus_init - CMO entitlement initialization at bus init time
+ *
+ * Set up the reserve and excess entitlement pools based on available
+ * system entitlement and the number of devices in the OF tree that
+ * require entitlement in the reserve pool.
+ */
+static void vio_cmo_bus_init(void)
+{
+	struct hvcall_mpp_data mpp_data;
+	int err;
+
+	memset(&vio_cmo, 0, sizeof(struct vio_cmo));
+	spin_lock_init(&vio_cmo.lock);
+	INIT_LIST_HEAD(&vio_cmo.device_list);
+	INIT_DELAYED_WORK(&vio_cmo.balance_q, vio_cmo_balance);
+
+	/* Get current system entitlement */
+	err =3D h_get_mpp(&mpp_data);
+
+	/*
+	 * On failure, continue with entitlement set to 0, will panic()
+	 * later when spare is reserved.
+	 */
+	if (err !=3D H_SUCCESS) {
+		printk(KERN_ERR "%s: unable to determine system IO "\
+		       "entitlement. (%d)\n", __func__, err);
+		vio_cmo.entitled =3D 0;
+	} else {
+		vio_cmo.entitled =3D mpp_data.entitled_mem;
+	}
+
+	/* Set reservation and check against entitlement */
+	vio_cmo.spare =3D VIO_CMO_MIN_ENT;
+	vio_cmo.reserve.size =3D vio_cmo.spare;
+	vio_cmo.reserve.size +=3D (vio_cmo_num_OF_devs() *
+	                         VIO_CMO_MIN_ENT);
+	if (vio_cmo.reserve.size > vio_cmo.entitled) {
+		printk(KERN_ERR "%s: insufficient system entitlement\n",
+		       __func__);
+		panic("%s: Insufficient system entitlement", __func__);
+	}
+
+	/* Set the remaining accounting variables */
+	vio_cmo.excess.size =3D vio_cmo.entitled - vio_cmo.reserve.size;
+	vio_cmo.excess.free =3D vio_cmo.excess.size;
+	vio_cmo.min =3D vio_cmo.reserve.size;
+	vio_cmo.desired =3D vio_cmo.reserve.size;
+}
+
+/* sysfs device functions and data structures for CMO */
+
+#define viodev_cmo_rd_attr(name)                                        \
+static ssize_t viodev_cmo_##name##_show(struct device *dev,             \
+                                        struct device_attribute *attr,  \
+                                         char *buf)                     \
+{                                                                       \
+	return sprintf(buf, "%lu\n", to_vio_dev(dev)->cmo.name);        \
+}
+
+static ssize_t viodev_cmo_allocs_failed_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	return sprintf(buf, "%d\n", atomic_read(&viodev->cmo.allocs_failed));
+}
+
+static ssize_t viodev_cmo_allocs_failed_reset(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	atomic_set(&viodev->cmo.allocs_failed, 0);
+	return count;
+}
+
+static ssize_t viodev_cmo_desired_set(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct vio_dev *viodev =3D to_vio_dev(dev);
+	size_t new_desired;
+	int ret;
+
+	ret =3D strict_strtoul(buf, 10, &new_desired);
+	if (ret)
+		return ret;
+
+	vio_cmo_set_dev_desired(viodev, new_desired);
+	return count;
+}
+
+viodev_cmo_rd_attr(desired);
+viodev_cmo_rd_attr(entitled);
+viodev_cmo_rd_attr(allocated);
+
+static ssize_t name_show(struct device *, struct device_attribute *, char =
*);
+static ssize_t devspec_show(struct device *, struct device_attribute *, ch=
ar *);
+static struct device_attribute vio_cmo_dev_attrs[] =3D {
+	__ATTR_RO(name),
+	__ATTR_RO(devspec),
+	__ATTR(cmo_desired,       S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
+	       viodev_cmo_desired_show, viodev_cmo_desired_set),
+	__ATTR(cmo_entitled,      S_IRUGO, viodev_cmo_entitled_show,      NULL),
+	__ATTR(cmo_allocated,     S_IRUGO, viodev_cmo_allocated_show,     NULL),
+	__ATTR(cmo_allocs_failed, S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
+	       viodev_cmo_allocs_failed_show, viodev_cmo_allocs_failed_reset),
+	__ATTR_NULL
+};
+
+/* sysfs bus functions and data structures for CMO */
+
+#define viobus_cmo_rd_attr(name)                                        \
+static ssize_t                                                          \
+viobus_cmo_##name##_show(struct bus_type *bt, char *buf)                \
+{                                                                       \
+	return sprintf(buf, "%lu\n", vio_cmo.name);                     \
+}
+
+#define viobus_cmo_pool_rd_attr(name, var)                              \
+static ssize_t                                                          \
+viobus_cmo_##name##_pool_show_##var(struct bus_type *bt, char *buf)     \
+{                                                                       \
+	return sprintf(buf, "%lu\n", vio_cmo.name.var);                 \
+}
+
+static ssize_t viobus_cmo_high_reset(struct bus_type *bt, const char *buf,
+                                     size_t count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vio_cmo.lock, flags);
+	vio_cmo.high =3D vio_cmo.curr;
+	spin_unlock_irqrestore(&vio_cmo.lock, flags);
+
+	return count;
+}
+
+viobus_cmo_rd_attr(entitled);
+viobus_cmo_pool_rd_attr(reserve, size);
+viobus_cmo_pool_rd_attr(excess, size);
+viobus_cmo_pool_rd_attr(excess, free);
+viobus_cmo_rd_attr(spare);
+viobus_cmo_rd_attr(min);
+viobus_cmo_rd_attr(desired);
+viobus_cmo_rd_attr(curr);
+viobus_cmo_rd_attr(high);
+
+static struct bus_attribute vio_cmo_bus_attrs[] =3D {
+	__ATTR(cmo_entitled, S_IRUGO, viobus_cmo_entitled_show, NULL),
+	__ATTR(cmo_reserve_size, S_IRUGO, viobus_cmo_reserve_pool_show_size, NULL=
),
+	__ATTR(cmo_excess_size, S_IRUGO, viobus_cmo_excess_pool_show_size, NULL),
+	__ATTR(cmo_excess_free, S_IRUGO, viobus_cmo_excess_pool_show_free, NULL),
+	__ATTR(cmo_spare,   S_IRUGO, viobus_cmo_spare_show,   NULL),
+	__ATTR(cmo_min,     S_IRUGO, viobus_cmo_min_show,     NULL),
+	__ATTR(cmo_desired, S_IRUGO, viobus_cmo_desired_show, NULL),
+	__ATTR(cmo_curr,    S_IRUGO, viobus_cmo_curr_show,    NULL),
+	__ATTR(cmo_high,    S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
+	       viobus_cmo_high_show, viobus_cmo_high_reset),
+	__ATTR_NULL
+};
+
+static void vio_cmo_sysfs_init(void)
+{
+	vio_bus_type.dev_attrs =3D vio_cmo_dev_attrs;
+	vio_bus_type.bus_attrs =3D vio_cmo_bus_attrs;
+}
+#else /* CONFIG_PPC_SMLPAR */
+/* Dummy functions for iSeries platform */
+int vio_cmo_entitlement_update(size_t new_entitlement) { return 0; }
+void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired) {}
+static int vio_cmo_bus_probe(struct vio_dev *viodev) { return 0; }
+static void vio_cmo_bus_remove(struct vio_dev *viodev) {}
+static void vio_cmo_set_dma_ops(struct vio_dev *viodev) {}
+static void vio_cmo_bus_init() {}
+static void vio_cmo_sysfs_init() { }
+#endif /* CONFIG_PPC_SMLPAR */
+EXPORT_SYMBOL(vio_cmo_entitlement_update);
+EXPORT_SYMBOL(vio_cmo_set_dev_desired);
+
 static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
 	const unsigned char *dma_window;
@@ -114,8 +1105,17 @@ static int vio_bus_probe(struct device *
 		return error;
=20
 	id =3D vio_match_device(viodrv->id_table, viodev);
-	if (id)
+	if (id) {
+		memset(&viodev->cmo, 0, sizeof(viodev->cmo));
+		if (firmware_has_feature(FW_FEATURE_CMO)) {
+			error =3D vio_cmo_bus_probe(viodev);
+			if (error)
+				return error;
+		}
 		error =3D viodrv->probe(viodev, id);
+		if (error)
+			vio_cmo_bus_remove(viodev);
+	}
=20
 	return error;
 }
@@ -125,12 +1125,23 @@ static int vio_bus_remove(struct device=20
 {
 	struct vio_dev *viodev =3D to_vio_dev(dev);
 	struct vio_driver *viodrv =3D to_vio_driver(dev->driver);
+	struct device *devptr;
+	int ret =3D 1;
+
+	/*
+	 * Hold a reference to the device after the remove function is called
+	 * to allow for CMO accounting cleanup for the device.
+	 */
+	devptr =3D get_device(dev);
=20
 	if (viodrv->remove)
-		return viodrv->remove(viodev);
+		ret =3D viodrv->remove(viodev);
=20
-	/* driver can't remove */
-	return 1;
+	if (!ret && firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_bus_remove(viodev);
+
+	put_device(devptr);
+	return ret;
 }
=20
 /**
@@ -215,7 +1226,11 @@ struct vio_dev *vio_register_device_node
 			viodev->unit_address =3D *unit_address;
 	}
 	viodev->dev.archdata.of_node =3D of_node_get(of_node);
-	viodev->dev.archdata.dma_ops =3D &dma_iommu_ops;
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dma_ops(viodev);
+	else
+		viodev->dev.archdata.dma_ops =3D &dma_iommu_ops;
 	viodev->dev.archdata.dma_data =3D vio_build_iommu_table(viodev);
 	viodev->dev.archdata.numa_node =3D of_node_to_nid(of_node);
=20
@@ -245,6 +1260,9 @@ static int __init vio_bus_init(void)
 	int err;
 	struct device_node *node_vroot;
=20
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_sysfs_init();
+
 	err =3D bus_register(&vio_bus_type);
 	if (err) {
 		printk(KERN_ERR "failed to register VIO bus\n");
@@ -262,6 +1280,9 @@ static int __init vio_bus_init(void)
 		return err;
 	}
=20
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_bus_init();
+
 	node_vroot =3D of_find_node_by_name(NULL, "vdevice");
 	if (node_vroot) {
 		struct device_node *of_node;
Index: b/include/asm-powerpc/vio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -39,16 +39,32 @@
 #define VIO_IRQ_DISABLE		0UL
 #define VIO_IRQ_ENABLE		1UL
=20
+/*
+ * VIO CMO minimum entitlement for all devices and spare entitlement
+ */
+#define VIO_CMO_MIN_ENT 1562624
+
 struct iommu_table;
=20
-/*
- * The vio_dev structure is used to describe virtual I/O devices.
+/**
+ * vio_dev - This structure is used to describe virtual I/O devices.
+ *
+ * @desired: set from return of driver's get_desired_dma() function
+ * @entitled: bytes of IO data that has been reserved for this device.
+ * @allocated: bytes of IO data currently in use by the device.
+ * @allocs_failed: number of DMA failures due to insufficient entitlement.
  */
 struct vio_dev {
 	const char *name;
 	const char *type;
 	uint32_t unit_address;
 	unsigned int irq;
+	struct {
+		size_t desired;
+		size_t entitled;
+		size_t allocated;
+		atomic_t allocs_failed;
+	} cmo;
 	struct device dev;
 };
=20
@@ -56,12 +72,19 @@ struct vio_driver {
 	const struct vio_device_id *id_table;
 	int (*probe)(struct vio_dev *dev, const struct vio_device_id *id);
 	int (*remove)(struct vio_dev *dev);
+	/* A driver must have a get_desired_dma() function to
+	 * be loaded in a CMO environment if it uses DMA.
+	 */
+	unsigned long (*get_desired_dma)(struct vio_dev *dev);
 	struct device_driver driver;
 };
=20
 extern int vio_register_driver(struct vio_driver *drv);
 extern void vio_unregister_driver(struct vio_driver *drv);
=20
+extern int vio_cmo_entitlement_update(size_t);
+extern void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired=
);
+
 extern void __devinit vio_unregister_device(struct vio_dev *dev);
=20
 struct device_node;
