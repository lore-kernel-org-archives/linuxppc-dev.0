Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW5sr2vGqzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 16:53:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/17] powerpc/vas: Implement a simple FTW driver
In-Reply-To: <1502233622-9330-17-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-17-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 16:53:19 +1000
Message-ID: <874ltaskrk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suka,

Some comments inline ...


Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> The Fast Thread Wake-up (FTW) driver provides user space applications an
> interface to the Core-to-Core functionality in POWER9. The driver provides
> the device node/ioctl API to applications and uses the external interfaces
> to the VAS driver to interact with the VAS hardware.
>
> A follow-on patch provides detailed description of the API for the driver.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                             |   1 +
>  arch/powerpc/platforms/powernv/Kconfig  |  16 ++
>  arch/powerpc/platforms/powernv/Makefile |   1 +
>  arch/powerpc/platforms/powernv/nx-ftw.c | 486 ++++++++++++++++++++++++++++++++

AFAICS this has nothing to do with NX, so why is it called nx-ftw ?

Also aren't we going to want to use this on pseries eventually? If so
should it go in arch/powerpc/sysdev ?

> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index e4db292..dc60046 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>  obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
>  obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
>  obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o
> +obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
> diff --git a/arch/powerpc/platforms/powernv/nx-ftw.c b/arch/powerpc/platforms/powernv/nx-ftw.c
> new file mode 100644
> index 0000000..a0b6388
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/nx-ftw.c
> @@ -0,0 +1,486 @@

Missing license header.

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <asm/cputable.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/cdev.h>
> +#include <linux/mutex.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/uaccess.h>
> +#include <linux/bootmem.h>
> +#include <asm/opal-api.h>
> +#include <asm/opal.h>
> +#include <asm/page.h>
> +#include <asm/vas.h>
> +#include <asm/reg.h>

Please try and trim the list to what you need.

> +
> +/*
> + * NX-FTW is a device driver used to provide user space access to the
> + * Core-to-Core aka Fast Thread Wakeup (FTW) functionality provided by
> + * the Virtual Accelerator Subsystem (VAS) in POWER9 systems. See also
> + * arch/powerpc/platforms/powernv/vas*.
> + *
> + * The driver creates the device node /dev/crypto/nx-ftw that can be
> + * used as follows:
> + *
> + *	fd = open("/dev/crypto/nx-ftw", O_RDWR);
> + *	rc = ioctl(fd, VAS_RX_WIN_OPEN, &rxattr);
> + *	rc = ioctl(fd, VAS_TX_WIN_OPEN, &txattr);
> + *	paste_addr = mmap(NULL, PAGE_SIZE, prot, MAP_SHARED, fd, 0ULL).
> + *	vas_copy(&crb, 0, 1);
> + *	vas_paste(paste_addr, 0, 1);
> + *
> + * where "vas_copy" and "vas_paste" are defined in copy-paste.h.
> + */
> +
> +static char		*nxftw_dev_name = "nx-ftw";
> +static atomic_t		nxftw_instid = ATOMIC_INIT(0);
> +static dev_t		nxftw_devt;
> +static struct dentry	*nxftw_debugfs;
> +static struct class	*nxftw_dbgfs_class;

The class doesn't go in debugfs, which is what "dbgfs" says to me.

> +/*
> + * Wrapper object for the nx-ftw device node - there is just one

Just "device".

"device node" is ambiguous vs device tree.

> + * instance of this node for the whole system.

So why not put the globals above in here also?

> + */
> +struct nxftw_dev {
> +	struct cdev cdev;
> +	struct device *device;
> +	char *name;
> +	atomic_t refcount;
> +} nxftw_device;
> +
> +/*
> + * One instance per open of a nx-ftw device. Each nxftw_instance is
> + * associated with a VAS window, after the caller issues VAS_RX_WIN_OPEN
> + * or VAS_TX_WIN_OPEN ioctl.
> + */
> +struct nxftw_instance {
> +	int instance;
> +	bool tx_win;
> +	struct vas_window *window;
> +};
> +
> +#define VAS_DEFAULT_VAS_ID	0
> +#define POWERNV_LPID		0	/* TODO: For VM/KVM guests? */

mfspr(SPRN_LPID)

would seem to do the trick?

> +static char *nxftw_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "crypto/%s", dev_name(dev));

This isn't a crypto device?

> +}
> +
> +static int nxftw_open(struct inode *inode, struct file *fp)
> +{
> +	int minor;
> +	struct nxftw_instance *nxti;

instance would be a better name.

> +	minor = MINOR(inode->i_rdev);

Not used?

> +	nxti = kzalloc(sizeof(*nxti), GFP_KERNEL);
> +	if (!nxti)
> +		return -ENOMEM;
> +
> +	nxti->instance = atomic_inc_return(&nxftw_instid);

And this would read better if the variable was "id". eg.

	instance->id = atomic_inc_return(&next_instance_id);

> +	nxti->window = NULL;
> +
> +	fp->private_data = nxti;
> +	return 0;
> +}
> +
> +static int validate_txwin_user_attr(struct vas_tx_win_open_attr *uattr)
> +{
> +	int i;
> +
> +	if (uattr->version != 1)
> +		return -EINVAL;
> +
> +	if (uattr->flags & ~VAS_FLAGS_HIGH_PRI)
> +		return -EINVAL;
> +
> +	if (uattr->reserved1 || uattr->reserved2)
> +		return -EINVAL;
> +
> +	for (i = 0; i < sizeof(uattr->reserved3) / sizeof(uint64_t); i++) {
> +		if (uattr->reserved3[i])
> +			return -EINVAL;
> +	}

That struct is a mess and needs to be reworked.

> +	return 0;
> +}
> +
> +static bool validate_rxwin_user_attr(struct vas_rx_win_open_attr *uattr)
> +{
> +	int i;
> +
> +	if (uattr->version != 1)
> +		return -EINVAL;
> +
> +	for (i = 0; i < sizeof(uattr->reserved) / sizeof(uint64_t); i++) {
> +		if (uattr->reserved[i])
> +			return -EINVAL;
> +	}

Ditto.

> +	return 0;
> +}
> +
> +#ifdef vas_debug

This is dead code, which makes it very easy for it to get out of sync
with the vas_rx_win_attr for example.

Better to just make these pr_debug() in the only caller, that way they
get type checked.

> +static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
> +{
> +	pr_err("NX-FTW: user %d, nx %d, fault %d, ntfy %d, intr %d early %d\n",
> +			attr->user_win ? 1 : 0,
> +			attr->nx_win ? 1 : 0,
> +			attr->fault_win ? 1 : 0,
> +			attr->notify_disable ? 1 : 0,
> +			attr->intr_disable ? 1 : 0,
> +			attr->notify_early ? 1 : 0);
> +
> +	pr_err("NX-FTW: rx_fifo %p, rx_fifo_size %d, max value 0x%x\n",
> +			attr->rx_fifo, attr->rx_fifo_size,
> +			VAS_RX_FIFO_SIZE_MAX);
> +
> +}
> +#else
> +static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
> +{
> +}
> +#endif
> +
> +static int nxftw_ioc_open_rx_window(struct file *fp, unsigned long arg)
> +{
> +	int rc;
> +	struct vas_rx_win_open_attr uattr;
> +	struct vas_rx_win_attr rxattr;
> +	struct nxftw_instance *nxti = fp->private_data;
> +	struct vas_window *win;

	struct vas_rx_win_open_attr uattr;
	struct vas_rx_win_attr rxattr;
	struct nxftw_instance *nxti;
	struct vas_window *win;
	int rc;

        nxti = fp->private_data;

Ah much better :)

Aka. reverse-christmas-tree.

> +
> +	rc = copy_from_user(&uattr, (void *)arg, sizeof(uattr));

Nicer would be:

	void __user *uptr = (void *)arg;

	rc = copy_from_user(&uattr, uptr, sizeof(uattr));

> +	if (rc) {
> +		pr_devel("%s(): copy_from_user() returns %d\n", __func__, rc);
> +		return -EFAULT;
> +	}
> +
> +	rc = validate_rxwin_user_attr(&uattr);
> +	if (rc)
> +		return rc;
> +
> +	memset(&rxattr, 0, sizeof(rxattr));
> +
> +	rxattr.lnotify_lpid = POWERNV_LPID;
> +
> +	/*
> +	 * Only caller can own the window for now. Not sure if there is need
> +	 * for process P1 to make P2 the owner of a window. If so, we need to
> +	 * find P2, make sure we have permissions, get a reference etc.
> +	 */
> +	rxattr.lnotify_pid = mfspr(SPRN_PID);
> +	rxattr.lnotify_tid = mfspr(SPRN_TIDR);
> +	rxattr.rx_fifo = NULL;
> +	rxattr.rx_fifo_size = 0;
> +	rxattr.intr_disable = true;
> +	rxattr.user_win = true;

vas_init_rx_win_attr() ?

> +
> +	dump_rx_win_attr(&rxattr);
> +
> +	/*
> +	 * TODO: Rather than the default vas id, choose an instance of VAS
> +	 *	 based on the chip the caller is running.
> +	 */

Seems like that will be a common pattern so maybe the vas core should
handle it for callers who want it.

> +	win = vas_rx_win_open(VAS_DEFAULT_VAS_ID, VAS_COP_TYPE_FTW, &rxattr);
> +	if (IS_ERR(win)) {
> +		pr_devel("%s() vas_rx_win_open() failed, %ld\n", __func__,
> +				PTR_ERR(win));
> +		return PTR_ERR(win);
> +	}
> +
> +	nxti->window = win;
> +	uattr.rx_win_handle = vas_win_id(win);
> +
> +	rc = copy_to_user((void *)arg, &uattr, sizeof(uattr));
> +	if (rc) {
> +		pr_devel("%s(): copy_to_user() failed, %d\n", __func__, rc);
> +		return -EFAULT;
> +	}

You defined the ioctl as:

  #define VAS_RX_WIN_OPEN		_IOW('v', 2, struct vas_rx_win_open_attr)

But you're reading and writing from the user arg, so it should be _IOWR.

> +
> +	return 0;
> +}
> +
> +static int nxftw_ioc_open_tx_window(struct file *fp, unsigned long arg)
> +{
> +	int rc;
> +	enum vas_cop_type cop;
> +	struct vas_window *win;
> +	struct vas_tx_win_open_attr uattr;
> +	struct vas_tx_win_attr txattr;

Those two struct names are quite confusing.

> +	struct nxftw_instance *nxti = fp->private_data;
> +
> +	rc = copy_from_user(&uattr, (void *)arg, sizeof(uattr));
> +	if (rc) {
> +		pr_devel("%s(): copy_from_user() failed, %d\n", __func__, rc);
> +		return -EFAULT;
> +	}

All you use is rx_win_handle, so why does this ioctl take the whole struct?

> +	cop = VAS_COP_TYPE_FTW;
> +
> +	rc = validate_txwin_user_attr(&uattr);
> +	if (rc)
> +		return rc;
> +
> +	pr_devel("Pid %d: Opening txwin, cop %d, PIDR %ld\n",
> +				task_pid_nr(current), cop, mfspr(SPRN_PID));
> +
> +	vas_init_tx_win_attr(&txattr, cop);
> +
> +	txattr.lpid = POWERNV_LPID;
> +	txattr.pidr = mfspr(SPRN_PID);
> +	txattr.pid = task_pid_nr(current);

Why is that in txattr?

The pid can be freed and given to another process so it's fishy to be
saving the pid without also holding a reference on the task.

> +	txattr.user_win = true;

Has been done for us.

> +	txattr.pswid = uattr.rx_win_handle;
> +
> +	win = vas_tx_win_open(VAS_DEFAULT_VAS_ID, cop, &txattr);
> +	if (IS_ERR(win)) {
> +		pr_devel("%s() vas_tx_win_open() failed, %ld\n", __func__,
> +					PTR_ERR(win));
> +		return PTR_ERR(win);
> +	}
> +	nxti->window = win;
> +	nxti->tx_win = true;

is_tx would be clearer IMHO.

> +	return 0;
> +}
> +
> +static int nxftw_release(struct inode *inode, struct file *fp)
> +{
> +	struct nxftw_instance *nxti;
> +
> +	nxti = fp->private_data;
> +
> +	vas_win_close(nxti->window);
> +	nxti->window = NULL;
> +
> +	kfree(nxti);
> +	fp->private_data = NULL;

Flipping the order of those would be preferable though it's not actually
a bug.

> +	atomic_dec(&nxftw_instid);
> +
> +	return 0;
> +}
> +
> +static ssize_t nxftw_write(struct file *fp, const char __user *buf,
> +			size_t len, loff_t *offsetp)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static ssize_t nxftw_read(struct file *fp, char __user *buf, size_t len,
> +			loff_t *offsetp)
> +{
> +	return -ENOTSUPP;
> +}

Do you need those?

> +static int nxftw_vma_fault(struct vm_fault *vmf)
> +{
> +	u64 offset;
> +	unsigned long vaddr;
> +	uint64_t pbaddr_start;
> +	struct nxftw_instance *nxti;
> +	struct vm_area_struct *vma = vmf->vma;
> +
> +	nxti = vma->vm_private_data;
> +	offset = vmf->pgoff << PAGE_SHIFT;
> +	vaddr = (unsigned long)vmf->address;
> +
> +	pbaddr_start = vas_win_paste_addr(nxti->window);
> +
> +	pr_devel("%s() instance %d, pbaddr 0x%llx, vaddr 0x%lx,"
> +			"offset %llx, pgoff 0x%lx, vma-start 0x%zx,"
> +			"size %zd\n", __func__, nxti->instance,
> +			pbaddr_start, vaddr, offset, vmf->pgoff,
> +			vma->vm_start, vma->vm_end-vma->vm_start);
> +
> +	vm_insert_pfn(vma, vaddr, (pbaddr_start + offset) >> PAGE_SHIFT);
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +const struct vm_operations_struct nxftw_vm_ops = {
> +	.fault = nxftw_vma_fault,
> +};

Is there some particular reason you need to implement those, you appear
to be just mapping a page into the address space. Can't you just use
remap_pfn_range() in your mmap routine?

> +static int nxftw_mmap(struct file *fp, struct vm_area_struct *vma)
> +{
> +	struct nxftw_instance *nxti = fp->private_data;
> +
> +	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
> +		pr_devel("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
> +				(vma->vm_end - vma->vm_start), PAGE_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure instance has an open send window */
> +	if (!nxti->window || !nxti->tx_win) {
> +		pr_devel("%s(): No send window open?\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* flags, page_prot from cxl_mmap(), except we want cachable */
> +	vma->vm_flags |= VM_IO | VM_PFNMAP;
> +	vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
> +
> +	vma->vm_ops = &nxftw_vm_ops;
> +	vma->vm_private_data = nxti;

ie. here.

See eg. opal-prd.c for an example.

> +	return 0;
> +}
> +
> +static long nxftw_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct nxftw_instance *nxti;
> +
> +	nxti = fp->private_data;

Not used.
> +
> +	pr_devel("%s() cmd 0x%x, TX_WIN_OPEN 0x%lx\n", __func__, cmd,
> +			VAS_TX_WIN_OPEN);

Can we drop that?

> +	switch (cmd) {
> +
> +	case VAS_TX_WIN_OPEN:
> +		return nxftw_ioc_open_tx_window(fp, arg);
> +
> +	case VAS_RX_WIN_OPEN:
> +		return nxftw_ioc_open_rx_window(fp, arg);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +const struct file_operations nxftw_fops = {
> +	.owner = THIS_MODULE,
> +	.open = nxftw_open,
> +	.release = nxftw_release,
> +	.read = nxftw_read,
> +	.write = nxftw_write,
> +	.mmap = nxftw_mmap,
> +	.unlocked_ioctl = nxftw_ioctl,
> +};
> +
> +
> +int nxftw_file_init(void)
> +{
> +	int rc;
> +	dev_t devno;
> +
> +	rc = alloc_chrdev_region(&nxftw_devt, 1, 1, "nx-ftw");
> +	if (rc) {
> +		pr_err("Unable to allocate nxftw major number: %i\n", rc);
> +		return rc;
> +	}
> +
> +	pr_devel("NX-FTW device allocated, dev [%i,%i]\n", MAJOR(nxftw_devt),
> +			MINOR(nxftw_devt));
> +
> +	nxftw_dbgfs_class = class_create(THIS_MODULE, "nxftw");
> +	if (IS_ERR(nxftw_dbgfs_class)) {
> +		pr_err("Unable to create NX-FTW class\n");
> +		rc = PTR_ERR(nxftw_dbgfs_class);
> +		goto err;
> +	}
> +	nxftw_dbgfs_class->devnode = nxftw_devnode;
> +
> +	cdev_init(&nxftw_device.cdev, &nxftw_fops);
> +
> +	devno = MKDEV(MAJOR(nxftw_devt), 0);
> +	if (cdev_add(&nxftw_device.cdev, devno, 1)) {
> +		pr_err("NX-FTW: cdev_add() failed\n");
> +		goto err;
> +	}
> +
> +	nxftw_device.device = device_create(nxftw_dbgfs_class, NULL,
> +			devno, NULL, nxftw_dev_name, MINOR(devno));
> +	if (IS_ERR(nxftw_device.device)) {
> +		pr_err("Unable to create nxftw-%d\n", MINOR(devno));
> +		goto err;
> +	}
> +
> +	pr_devel("%s: Added dev [%d,%d]\n", __func__, MAJOR(devno),
> +			MINOR(devno));
> +	return 0;
> +
> +err:
> +	unregister_chrdev_region(nxftw_devt, 1);
> +	return rc;
> +}
> +
> +void nxftw_file_exit(void)
> +{
> +	dev_t devno;
> +
> +	pr_devel("NX-FTW: %s entered\n", __func__);
> +
> +	cdev_del(&nxftw_device.cdev);
> +	devno = MKDEV(MAJOR(nxftw_devt), MINOR(nxftw_devt));
> +	device_destroy(nxftw_dbgfs_class, devno);
> +
> +	class_destroy(nxftw_dbgfs_class);
> +	unregister_chrdev_region(nxftw_devt, 1);
> +}
> +
> +
> +/*
> + * Create a debugfs entry. Not sure what for yet, though
> + */

Please just drop it.

> +int __init nxftw_debugfs_init(void)
> +{
> +	struct dentry *ent;
> +
> +	ent = debugfs_create_dir("nxftw", NULL);
> +	if (IS_ERR(ent)) {
> +		pr_devel("nxftw: %s(): error creating dbgfs dir\n", __func__);
> +		return PTR_ERR(ent);
> +	}
> +	nxftw_debugfs = ent;
> +
> +	return 0;
> +}
> +
> +void nxftw_debugfs_exit(void)
> +{
> +	debugfs_remove_recursive(nxftw_debugfs);
> +}
> +
> +int __init nxftw_init(void)
> +{
> +	int rc;
> +
> +	rc = nxftw_file_init();
> +	if (rc)
> +		return rc;
> +
> +	rc = nxftw_debugfs_init();
> +	if (rc)
> +		goto free_file;
> +
> +	pr_err("NX-FTW Device initialized\n");

That's not an error.

> +
> +	return 0;
> +
> +free_file:
> +	nxftw_file_exit();
> +	return rc;
> +}
> +
> +void __init nxftw_exit(void)
> +{
> +	pr_devel("NX-FTW Device exiting\n");
> +	nxftw_debugfs_exit();
> +	nxftw_file_exit();
> +}
> +
> +module_init(nxftw_init);
> +module_exit(nxftw_exit);

This can't be a module, so you shouldn't be using these.

Or these:

> +MODULE_DESCRIPTION("IBM NX Fast Thread Wakeup Device");
> +MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
> +MODULE_LICENSE("GPL");

cheers
