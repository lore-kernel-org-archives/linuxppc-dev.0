Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 247/493] drivers/block: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:16 -0500
Message-Id: <1353349642-3677-247-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, iss_storagedev@hp.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Geoff Levand <geoff@infradead.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jim Paris <jim@jtan.com>,
 virtualization@lists.linux-foundation.org,
 Chirag Kantharia <chirag.kantharia@hp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chirag Kantharia <chirag.kantharia@hp.com> 
Cc: Geoff Levand <geoff@infradead.org> 
Cc: Jim Paris <jim@jtan.com> 
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: iss_storagedev@hp.com 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/block/cciss.c      | 62 +++++++++++++++++++++++-----------------------
 drivers/block/cpqarray.c   |  6 ++---
 drivers/block/nvme.c       | 10 ++++----
 drivers/block/ps3disk.c    |  2 +-
 drivers/block/ps3vram.c    |  4 +--
 drivers/block/sunvdc.c     |  6 ++---
 drivers/block/swim.c       |  6 ++---
 drivers/block/swim3.c      |  2 +-
 drivers/block/umem.c       |  2 +-
 drivers/block/virtio_blk.c |  4 +--
 drivers/block/xsysace.c    |  6 ++---
 11 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index b40068f..3096c79 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -181,8 +181,8 @@ static void cciss_geometry_inquiry(ctlr_info_t *h, int logvol,
 			sector_t total_size,
 			unsigned int block_size, InquiryData_struct *inq_buff,
 				   drive_info_struct *drv);
-static void __devinit cciss_interrupt_mode(ctlr_info_t *);
-static int __devinit cciss_enter_simple_mode(struct ctlr_info *h);
+static void cciss_interrupt_mode(ctlr_info_t *);
+static int cciss_enter_simple_mode(struct ctlr_info *h);
 static void start_io(ctlr_info_t *h);
 static int sendcmd_withirq(ctlr_info_t *h, __u8 cmd, void *buff, size_t size,
 			__u8 page_code, unsigned char scsi3addr[],
@@ -199,13 +199,13 @@ static void cciss_device_release(struct device *dev);
 static void cciss_free_gendisk(ctlr_info_t *h, int drv_index);
 static void cciss_free_drive_info(ctlr_info_t *h, int drv_index);
 static inline u32 next_command(ctlr_info_t *h);
-static int __devinit cciss_find_cfg_addrs(struct pci_dev *pdev,
+static int cciss_find_cfg_addrs(struct pci_dev *pdev,
 	void __iomem *vaddr, u32 *cfg_base_addr, u64 *cfg_base_addr_index,
 	u64 *cfg_offset);
-static int __devinit cciss_pci_find_memory_BAR(struct pci_dev *pdev,
+static int cciss_pci_find_memory_BAR(struct pci_dev *pdev,
 	unsigned long *memory_bar);
 static inline u32 cciss_tag_discard_error_bits(ctlr_info_t *h, u32 tag);
-static __devinit int write_driver_ver_to_cfgtable(
+static int write_driver_ver_to_cfgtable(
 	CfgTable_struct __iomem *cfgtable);
 
 /* performant mode helper functions */
@@ -550,7 +550,7 @@ static const struct file_operations cciss_proc_fops = {
 	.write	 = cciss_proc_write,
 };
 
-static void __devinit cciss_procinit(ctlr_info_t *h)
+static void cciss_procinit(ctlr_info_t *h)
 {
 	struct proc_dir_entry *pde;
 
@@ -2663,7 +2663,7 @@ static int fill_cmd(ctlr_info_t *h, CommandList_struct *c, __u8 cmd, void *buff,
 	return status;
 }
 
-static int __devinit cciss_send_reset(ctlr_info_t *h, unsigned char *scsi3addr,
+static int cciss_send_reset(ctlr_info_t *h, unsigned char *scsi3addr,
 	u8 reset_type)
 {
 	CommandList_struct *c;
@@ -3919,7 +3919,7 @@ static void  calc_bucket_map(int bucket[], int num_buckets,
 	}
 }
 
-static void __devinit cciss_wait_for_mode_change_ack(ctlr_info_t *h)
+static void cciss_wait_for_mode_change_ack(ctlr_info_t *h)
 {
 	int i;
 
@@ -3933,7 +3933,7 @@ static void __devinit cciss_wait_for_mode_change_ack(ctlr_info_t *h)
 	}
 }
 
-static __devinit void cciss_enter_performant_mode(ctlr_info_t *h,
+static void cciss_enter_performant_mode(ctlr_info_t *h,
 	u32 use_short_tags)
 {
 	/* This is a bit complicated.  There are 8 registers on
@@ -4000,7 +4000,7 @@ static __devinit void cciss_enter_performant_mode(ctlr_info_t *h,
 					" performant mode\n");
 }
 
-static void __devinit cciss_put_controller_into_performant_mode(ctlr_info_t *h)
+static void cciss_put_controller_into_performant_mode(ctlr_info_t *h)
 {
 	__u32 trans_support;
 
@@ -4062,7 +4062,7 @@ clean_up:
  * controllers that are capable. If not, we use IO-APIC mode.
  */
 
-static void __devinit cciss_interrupt_mode(ctlr_info_t *h)
+static void cciss_interrupt_mode(ctlr_info_t *h)
 {
 #ifdef CONFIG_PCI_MSI
 	int err;
@@ -4108,7 +4108,7 @@ default_int_mode:
 	return;
 }
 
-static int __devinit cciss_lookup_board_id(struct pci_dev *pdev, u32 *board_id)
+static int cciss_lookup_board_id(struct pci_dev *pdev, u32 *board_id)
 {
 	int i;
 	u32 subsystem_vendor_id, subsystem_device_id;
@@ -4134,7 +4134,7 @@ static inline bool cciss_board_disabled(ctlr_info_t *h)
 	return ((command & PCI_COMMAND_MEMORY) == 0);
 }
 
-static int __devinit cciss_pci_find_memory_BAR(struct pci_dev *pdev,
+static int cciss_pci_find_memory_BAR(struct pci_dev *pdev,
 	unsigned long *memory_bar)
 {
 	int i;
@@ -4151,7 +4151,7 @@ static int __devinit cciss_pci_find_memory_BAR(struct pci_dev *pdev,
 	return -ENODEV;
 }
 
-static int __devinit cciss_wait_for_board_state(struct pci_dev *pdev,
+static int cciss_wait_for_board_state(struct pci_dev *pdev,
 	void __iomem *vaddr, int wait_for_ready)
 #define BOARD_READY 1
 #define BOARD_NOT_READY 0
@@ -4179,7 +4179,7 @@ static int __devinit cciss_wait_for_board_state(struct pci_dev *pdev,
 	return -ENODEV;
 }
 
-static int __devinit cciss_find_cfg_addrs(struct pci_dev *pdev,
+static int cciss_find_cfg_addrs(struct pci_dev *pdev,
 	void __iomem *vaddr, u32 *cfg_base_addr, u64 *cfg_base_addr_index,
 	u64 *cfg_offset)
 {
@@ -4195,7 +4195,7 @@ static int __devinit cciss_find_cfg_addrs(struct pci_dev *pdev,
 	return 0;
 }
 
-static int __devinit cciss_find_cfgtables(ctlr_info_t *h)
+static int cciss_find_cfgtables(ctlr_info_t *h)
 {
 	u64 cfg_offset;
 	u32 cfg_base_addr;
@@ -4224,7 +4224,7 @@ static int __devinit cciss_find_cfgtables(ctlr_info_t *h)
 	return 0;
 }
 
-static void __devinit cciss_get_max_perf_mode_cmds(struct ctlr_info *h)
+static void cciss_get_max_perf_mode_cmds(struct ctlr_info *h)
 {
 	h->max_commands = readl(&(h->cfgtable->MaxPerformantModeCommands));
 
@@ -4245,7 +4245,7 @@ static void __devinit cciss_get_max_perf_mode_cmds(struct ctlr_info *h)
  * max commands, max SG elements without chaining, and with chaining,
  * SG chain block size, etc.
  */
-static void __devinit cciss_find_board_params(ctlr_info_t *h)
+static void cciss_find_board_params(ctlr_info_t *h)
 {
 	cciss_get_max_perf_mode_cmds(h);
 	h->nr_cmds = h->max_commands - 4 - cciss_tape_cmds;
@@ -4304,7 +4304,7 @@ static inline void cciss_p600_dma_prefetch_quirk(ctlr_info_t *h)
 	pci_write_config_dword(h->pdev, PCI_COMMAND_PARITY, dma_refetch);
 }
 
-static int __devinit cciss_pci_init(ctlr_info_t *h)
+static int cciss_pci_init(ctlr_info_t *h)
 {
 	int prod_index, err;
 
@@ -4424,7 +4424,7 @@ static void free_hba(ctlr_info_t *h)
 }
 
 /* Send a message CDB to the firmware. */
-static __devinit int cciss_message(struct pci_dev *pdev, unsigned char opcode, unsigned char type)
+static int cciss_message(struct pci_dev *pdev, unsigned char opcode, unsigned char type)
 {
 	typedef struct {
 		CommandListHeader_struct CommandHeader;
@@ -4571,13 +4571,13 @@ static int cciss_controller_hard_reset(struct pci_dev *pdev,
 	return 0;
 }
 
-static __devinit void init_driver_version(char *driver_version, int len)
+static void init_driver_version(char *driver_version, int len)
 {
 	memset(driver_version, 0, len);
 	strncpy(driver_version, "cciss " DRIVER_NAME, len - 1);
 }
 
-static __devinit int write_driver_ver_to_cfgtable(
+static int write_driver_ver_to_cfgtable(
 	CfgTable_struct __iomem *cfgtable)
 {
 	char *driver_version;
@@ -4594,7 +4594,7 @@ static __devinit int write_driver_ver_to_cfgtable(
 	return 0;
 }
 
-static __devinit void read_driver_ver_from_cfgtable(
+static void read_driver_ver_from_cfgtable(
 	CfgTable_struct __iomem *cfgtable, unsigned char *driver_ver)
 {
 	int i;
@@ -4603,7 +4603,7 @@ static __devinit void read_driver_ver_from_cfgtable(
 		driver_ver[i] = readb(&cfgtable->driver_version[i]);
 }
 
-static __devinit int controller_reset_failed(
+static int controller_reset_failed(
 	CfgTable_struct __iomem *cfgtable)
 {
 
@@ -4627,7 +4627,7 @@ static __devinit int controller_reset_failed(
 
 /* This does a hard reset of the controller using PCI power management
  * states or using the doorbell register. */
-static __devinit int cciss_kdump_hard_reset_controller(struct pci_dev *pdev)
+static int cciss_kdump_hard_reset_controller(struct pci_dev *pdev)
 {
 	u64 cfg_offset;
 	u32 cfg_base_addr;
@@ -4772,7 +4772,7 @@ unmap_vaddr:
 	return rc;
 }
 
-static __devinit int cciss_init_reset_devices(struct pci_dev *pdev)
+static int cciss_init_reset_devices(struct pci_dev *pdev)
 {
 	int rc, i;
 
@@ -4806,7 +4806,7 @@ static __devinit int cciss_init_reset_devices(struct pci_dev *pdev)
 	return 0;
 }
 
-static __devinit int cciss_allocate_cmd_pool(ctlr_info_t *h)
+static int cciss_allocate_cmd_pool(ctlr_info_t *h)
 {
 	h->cmd_pool_bits = kmalloc(BITS_TO_LONGS(h->nr_cmds) *
 		sizeof(unsigned long), GFP_KERNEL);
@@ -4825,7 +4825,7 @@ static __devinit int cciss_allocate_cmd_pool(ctlr_info_t *h)
 	return 0;
 }
 
-static __devinit int cciss_allocate_scatterlists(ctlr_info_t *h)
+static int cciss_allocate_scatterlists(ctlr_info_t *h)
 {
 	int i;
 
@@ -4893,7 +4893,7 @@ static int cciss_request_irq(ctlr_info_t *h,
 	return -1;
 }
 
-static int __devinit cciss_kdump_soft_reset(ctlr_info_t *h)
+static int cciss_kdump_soft_reset(ctlr_info_t *h)
 {
 	if (cciss_send_reset(h, CTLR_LUNID, CCISS_RESET_TYPE_CONTROLLER)) {
 		dev_warn(&h->pdev->dev, "Resetting array controller failed.\n");
@@ -4952,7 +4952,7 @@ static void cciss_undo_allocations_after_kdump_soft_reset(ctlr_info_t *h)
  *  stealing all these major device numbers.
  *  returns the number of block devices registered.
  */
-static int __devinit cciss_init_one(struct pci_dev *pdev,
+static int cciss_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
 	int i;
@@ -5207,7 +5207,7 @@ static void cciss_shutdown(struct pci_dev *pdev)
 	free_irq(h->intr[h->intr_mode], h);
 }
 
-static int __devinit cciss_enter_simple_mode(struct ctlr_info *h)
+static int cciss_enter_simple_mode(struct ctlr_info *h)
 {
 	u32 trans_support;
 
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 389e314..34973bc 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -388,7 +388,7 @@ static void __devexit cpqarray_remove_one_eisa (int i)
 }
 
 /* pdev is NULL for eisa */
-static int __devinit cpqarray_register_ctlr( int i, struct pci_dev *pdev)
+static int cpqarray_register_ctlr( int i, struct pci_dev *pdev)
 {
 	struct request_queue *q;
 	int j;
@@ -505,7 +505,7 @@ Enomem4:
 	return -1;
 }
 
-static int __devinit cpqarray_init_one( struct pci_dev *pdev,
+static int cpqarray_init_one( struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	int i;
@@ -742,7 +742,7 @@ __setup("smart2=", cpqarray_setup);
 /*
  * Find an EISA controller's signature.  Set up an hba if we find it.
  */
-static int __devinit cpqarray_eisa_detect(void)
+static int cpqarray_eisa_detect(void)
 {
 	int i=0, j;
 	__u32 board_id;
diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 1f7acff..8a7dc4c 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -975,7 +975,7 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
 }
 
-static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
+static struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 					int qid, int cq_size, int vector)
 {
 	int result;
@@ -1011,7 +1011,7 @@ static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 	return ERR_PTR(result);
 }
 
-static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result = 0;
 	u32 aqa;
@@ -1408,7 +1408,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
-static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
+static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
 
@@ -1481,7 +1481,7 @@ static void nvme_free_queues(struct nvme_dev *dev)
 		nvme_free_queue(dev, i);
 }
 
-static int __devinit nvme_dev_add(struct nvme_dev *dev)
+static int nvme_dev_add(struct nvme_dev *dev)
 {
 	int res, nn, i;
 	struct nvme_ns *ns, *next;
@@ -1619,7 +1619,7 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
-static int __devinit nvme_probe(struct pci_dev *pdev,
+static int nvme_probe(struct pci_dev *pdev,
 						const struct pci_device_id *id)
 {
 	int bars, result = -ENOMEM;
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index da0abc1..d754a88 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -401,7 +401,7 @@ static unsigned long ps3disk_mask;
 
 static DEFINE_MUTEX(ps3disk_mask_mutex);
 
-static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
+static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
 	struct ps3disk_private *priv;
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index f58cdcf..75e112d 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -536,7 +536,7 @@ static const struct file_operations ps3vram_proc_fops = {
 	.release	= single_release,
 };
 
-static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
+static void ps3vram_proc_init(struct ps3_system_bus_device *dev)
 {
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct proc_dir_entry *pde;
@@ -618,7 +618,7 @@ static void ps3vram_make_request(struct request_queue *q, struct bio *bio)
 	} while (bio);
 }
 
-static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
+static int ps3vram_probe(struct ps3_system_bus_device *dev)
 {
 	struct ps3vram_priv *priv;
 	int error, status;
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9dcf76a..9af2797 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -592,7 +592,7 @@ static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
 	return err;
 }
 
-static int __devinit vdc_alloc_tx_ring(struct vdc_port *port)
+static int vdc_alloc_tx_ring(struct vdc_port *port)
 {
 	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 	unsigned long len, entry_size;
@@ -725,7 +725,7 @@ static struct vio_driver_ops vdc_vio_ops = {
 	.handshake_complete	= vdc_handshake_complete,
 };
 
-static void __devinit print_version(void)
+static void print_version(void)
 {
 	static int version_printed;
 
@@ -733,7 +733,7 @@ static void __devinit print_version(void)
 		printk(KERN_INFO "%s", version);
 }
 
-static int __devinit vdc_port_probe(struct vio_dev *vdev,
+static int vdc_port_probe(struct vio_dev *vdev,
 				    const struct vio_device_id *id)
 {
 	struct mdesc_handle *hp;
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 314f0b4..989f5bd 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -788,7 +788,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 	return get_disk(swd->unit[drive].disk);
 }
 
-static int __devinit swim_add_floppy(struct swim_priv *swd,
+static int swim_add_floppy(struct swim_priv *swd,
 				     enum drive_location location)
 {
 	struct floppy_state *fs = &swd->unit[swd->floppy_count];
@@ -812,7 +812,7 @@ static int __devinit swim_add_floppy(struct swim_priv *swd,
 	return 0;
 }
 
-static int __devinit swim_floppy_init(struct swim_priv *swd)
+static int swim_floppy_init(struct swim_priv *swd)
 {
 	int err;
 	int drive;
@@ -875,7 +875,7 @@ exit_put_disks:
 	return err;
 }
 
-static int __devinit swim_probe(struct platform_device *dev)
+static int swim_probe(struct platform_device *dev)
 {
 	struct resource *res;
 	struct swim __iomem *swim_base;
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 89ddab1..83a97d9 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1194,7 +1194,7 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 	return rc;
 }
 
-static int __devinit swim3_attach(struct macio_dev *mdev, const struct of_device_id *match)
+static int swim3_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct gendisk *disk;
 	int index, rc;
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index eb0d821..970d107 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -789,7 +789,7 @@ static const struct block_device_operations mm_fops = {
 	.revalidate_disk = mm_revalidate,
 };
 
-static int __devinit mm_pci_probe(struct pci_dev *dev,
+static int mm_pci_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	int ret = -ENODEV;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index dbba5cf..9f64e5cb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -696,7 +696,7 @@ static const struct device_attribute dev_attr_cache_type_rw =
 	__ATTR(cache_type, S_IRUGO|S_IWUSR,
 	       virtblk_cache_type_show, virtblk_cache_type_store);
 
-static int __devinit virtblk_probe(struct virtio_device *vdev)
+static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
 	struct request_queue *q;
@@ -963,7 +963,7 @@ static unsigned int features[] = {
 
 /*
  * virtio_blk causes spurious section mismatch warning by
- * simultaneously referring to a __devinit and a __devexit function.
+ * simultaneously referring to a and a __devexit function.
  * Use __refdata to avoid this warning.
  */
 static struct virtio_driver __refdata virtio_blk = {
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index d925121..cc49230 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -961,7 +961,7 @@ static const struct block_device_operations ace_fops = {
 /* --------------------------------------------------------------------
  * SystemACE device setup/teardown code
  */
-static int __devinit ace_setup(struct ace_device *ace)
+static int ace_setup(struct ace_device *ace)
 {
 	u16 version;
 	u16 val;
@@ -1092,7 +1092,7 @@ static void __devexit ace_teardown(struct ace_device *ace)
 	iounmap(ace->baseaddr);
 }
 
-static int __devinit
+static int
 ace_alloc(struct device *dev, int id, resource_size_t physaddr,
 	  int irq, int bus_width)
 {
@@ -1151,7 +1151,7 @@ static void __devexit ace_free(struct device *dev)
  * Platform Bus Support
  */
 
-static int __devinit ace_probe(struct platform_device *dev)
+static int ace_probe(struct platform_device *dev)
 {
 	resource_size_t physaddr = 0;
 	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
-- 
1.8.0
