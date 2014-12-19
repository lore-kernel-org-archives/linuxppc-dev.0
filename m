Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA9BE1A0BB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 16:32:40 +1100 (AEDT)
Message-ID: <5493B877.9060202@ozlabs.org>
Date: Fri, 19 Dec 2014 13:32:39 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V3] powerpc, powernv: Add OPAL platform event driver
References: <1416921665-15855-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1416921665-15855-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

> This patch creates a new OPAL platform event character driver
> which will give userspace clients the access to these events
> and process them effectively. Following platforms events are
> currently supported with this platform driver.
> 
> 	(1) Environmental and Power Warning (EPOW)
> 	(2) Delayed Power Off (DPO)
> 
> The user interface for this driver is /dev/opal_event character
> device file where the user space clients can poll and read for
> new opal platform events. The expected sequence of events driven
> from user space should be like the following.
> 
> 	(1) Open the character device file
> 	(2) Poll on the file for POLLIN event
> 	(3) When unblocked, must attempt to read PLAT_EVENT_MAX_SIZE size
> 	(4) Kernel driver will pass at most one opal_plat_event structure
> 	(5) Poll again for more new events

Why is the poll() required? Can't read() just block if there are no
events (and !O_NONBLOCK, of course).

> @@ -281,6 +282,7 @@ enum OpalMessageType {
>  	OPAL_MSG_EPOW,
>  	OPAL_MSG_SHUTDOWN,
>  	OPAL_MSG_HMI_EVT,
> +	OPAL_MSG_DPO,
>  	OPAL_MSG_TYPE_MAX,
>  };

I'd suggest adding the DPO interface definitions as a separate change,
but that's no huge deal.

>  
> @@ -452,6 +454,46 @@ struct opal_msg {
>  	__be64 params[8];
>  };
>  
> +/*
> + * EPOW status sharing (OPAL and the host)
> + *
> + * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
> + * with individual elements being 16 bits wide to fetch the system
> + * wide EPOW status. Each element in the buffer will contain the
> + * EPOW status in it's bit representation for a particular EPOW sub
> + * class as defiend here. So multiple detailed EPOW status bits
> + * specific for any sub class can be represented in a single buffer
> + * element as it's bit representation.
> + */

Why do we have this in separate u16s? This just results in a really
sparse bitmask.

I guess the FW interface is already defined though, right?

[Minor grammar nit: "it's" is short for "it is", which isn't what you
want here :)]

> -int64_t opal_get_epow_status(__be64 *status);
> +int64_t opal_get_epow_status(uint16_t *status, uint16_t *length);

Please keep the endian annotations there.

> +int64_t opal_get_dpo_status(int64_t *dpo_timeout);

and __be64 * here.

> +
> +/* EPOW classification */
> +enum epow_condition {
> +	EPOW_SYSPOWER_CHNG	= 0,	/* Power */
> +	EPOW_SYSPOWER_FAIL	= 1,
> +	EPOW_SYSPOWER_INCL	= 2,
> +	EPOW_SYSPOWER_UPS	= 3,
> +	EPOW_SYSTEMP_AMB	= 4,	/* Temperature */
> +	EPOW_SYSTEMP_INT	= 5,
> +	EPOW_SYSTEMP_HMD	= 6,
> +	EPOW_SYSCOOL_INSF	= 7,	/* Cooling */
> +	EPOW_MAX = 8,
> +};
> +
> +/* OPAL EPOW event */
> +struct epow_event {
> +	__u64	epow[EPOW_MAX];		/* Detailed system EPOW status */

Why an array of u64s when you're only using one bit of each? Do we
expect other status details to be set in each of these?

If not, you're converting from one sparse bitmask (the OPAL
interface) to another different sparse bitmask (the kernel interface).
Either keep them the same, or use a more sensible format.

Also, are you expecting a single epow_event to have multiple conditons
set? If not, no need for a bitmask at all.

> +	__u64	timeout;		/* Timeout to shutdown in secs */
> +};
> +
> +/* OPAL DPO event */
> +struct dpo_event {
> +	__u64	orig_timeout;		/* Platform provided timeout in secs */
> +	__u64	remain_timeout;		/* Timeout to shutdown in secs */
> +};

Will all of these events have a timeout? If so, just put a timeout in
struct opal_plat_event.

Why does the DPO timeout have orig/remain timeouts, but not the EPOW one?

See below, but perhaps we want a absolute timeout here, instead of
relative? (which is essentially invalid as soon as you've read it).

> +
> +/* OPAL event */
> +struct opal_plat_event {
> +	__u32	type;			/* Type of OPAL platform event */
> +#define OPAL_PLAT_EVENT_TYPE_EPOW	0
> +#define OPAL_PLAT_EVENT_TYPE_DPO	1
> +#define OPAL_PLAT_EVENT_TYPE_MAX	2
> +	__u32	size;			/* Size of OPAL platform event */
> +	union {
> +		struct epow_event epow;	/* EPOW platform event */
> +		struct dpo_event  dpo;	/* DPO platform event */
> +	};
> +};
> +
> +/*
> + * Suggested read size
> + *
> + * The user space client should attempt to read OPAL_PLAT_EVENT_READ_SIZE
> + * amount of data from the character device file '/dev/opal_event' at any
> + * point of time. The kernel driver will pass an entire opal_plat_event
> + * structure in every read. This ensures that minium data the user space
> + * client gets from the kernel is one opal_plat_event structure.
> + */
> +#define	PLAT_EVENT_MAX_SIZE	4096

-> OPAL_PLAT_EVENT_MAX_SIZE - this it a global header.

> +/*
> + * opal_event_read
> + *
> + * User client needs to attempt to read PLAT_EVENT_MAX_SIZE amount of data
> + * from the file descriptor at a time. The driver will pass a single node
> + * from the list if available at a time and then delete the node from the list.
> + */
> +static ssize_t opal_event_read(struct file *filep,
> +			char __user *buf, size_t len, loff_t *off)
> +{
> +	struct opal_platform_evt *evt;
> +	unsigned long flags;
> +
> +	if (len < sizeof(struct opal_plat_event))
> +		return -EINVAL;

Maybe -EMSGSIZE?

> +
> +	/* Fetch the first node on the list */
> +	spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
> +	if (list_empty(&opal_event_queue)) {
> +		spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
> +		return 0;
> +	}
> +
> +	/* Fetch and delete from the list */
> +	evt = list_first_entry(&opal_event_queue,
> +					struct opal_platform_evt, link);
> +	list_del(&evt->link);
> +
> +	/*
> +	 * Update the remaining timeout for DPO event.
> +	 * This can only be updated during the read time.
> +	 */
> +	if (evt->opal_event.type == OPAL_PLAT_EVENT_TYPE_DPO) {
> +		unsigned long timeout;
> +
> +		if (opal_dpo_target &&
> +				evt->opal_event.dpo.orig_timeout) {
> +			timeout = (opal_dpo_target - jiffies) / HZ;
> +			evt->opal_event.dpo.remain_timeout = timeout;
> +		}
> +	}

Would it make more sense to just put one timestamp in here (when we
first see the event from OPAL), of the actual timeout? What's the global
opal_dpo_target for? Doesn't that just mean subsequent DPO events will
invalidate others' timeouts?

Also, do you need the spinlock held here? You've already dequeued the item
from the list. If you keep the opal_dpo_target global, you'll need to do
updates with the lock held too.

> +	spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
> +
> +	if (copy_to_user(buf, &evt->opal_event,
> +		sizeof(struct opal_plat_event))) {
> +
> +		/*
> +		 * Copy to user has failed. The event node had
> +		 * been deleted from the list. Lets add it back
> +		 * there.
> +		 */
> +		spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
> +		list_add_tail(&evt->link, &opal_event_queue);
> +		spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
> +		return -EFAULT;
> +	}
> +
> +	kfree(evt);
> +	return sizeof(struct opal_plat_event);
> +}
> +
> +/*
> + * opal_event_poll
> + *
> + * Poll is unblocked right away with POLLIN when data is available.
> + * When data is not available, the process will have to block till
> + * it gets waked up and data is available to read.
> + */
> +static unsigned int opal_event_poll(struct file *file, poll_table *wait)
> +{
> +	poll_wait(file, &opal_plat_evt_wait, wait);
> +	if (!list_empty(&opal_event_queue))
> +		return POLLIN;
> +	return 0;
> +}
> +
> +/*
> + * opal_event_open
> + *
> + * This makes sure that only one process can open the
> + * character device file at any point of time. Others
> + * attempting to open the file descriptor will either
> + * get EBUSY (with O_NONBLOCK flag) or wait for the
> + * other process to close the file descriptor.
> + */
> +static int opal_event_open(struct inode *inode, struct file *file)
> +{
> +	int err;
> +
> +	mutex_lock(&opal_plat_evt_mutex);
> +	while (opal_event_open_flag) {
> +		mutex_unlock(&opal_plat_evt_mutex);
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EBUSY;

O_NONBLOCK would signify that all subsequent operations are
non-blocking, not just the open. It happens that this is the case
(because of your requirement on poll()), but it shouldn't be.

Just return -EBUSY, and get rid of the wait queue.

> +/* Process the received EPOW information */
> +void process_epow(__u64 *epow, int16_t *epow_status, int max_epow_class)
> +{
> +	/*
> +	 * Platform might have returned less number of EPOW
> +	 * subclass status than asked for. This situation
> +	 * happens when the platform firmware is older compared
> +	 * to the kernel.
> +	 */
> +
> +	if (!max_epow_class) {
> +		pr_warn("EPOW: OPAL_SYSEPOW_POWER subclass not present\n");
> +		return;
> +	}
> +
> +	/* Power */
> +	max_epow_class--;
> +	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_CHNG) {
> +		pr_info("EPOW: Power configuration changed\n");
> +		epow[EPOW_SYSPOWER_CHNG] = 1;
> +	}
> +
> +	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_FAIL) {
> +		pr_info("EPOW: Impending system power failure\n");
> +		epow[EPOW_SYSPOWER_FAIL] = 1;
> +	}
> +
> +	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_INCL) {
> +		pr_info("EPOW: Incomplete system power\n");
> +		epow[EPOW_SYSPOWER_INCL] = 1;
> +	}
> +
> +	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_UPS) {
> +		pr_info("EPOW: System on UPS power\n");
> +		epow[EPOW_SYSPOWER_UPS] = 1;
> +	}
> +
> +	if (!max_epow_class) {
> +		pr_warn("EPOW: OPAL_SYSEPOW_TEMP subclass not present\n");
> +		return;
> +	}
> +
> +	/* Temperature */
> +	max_epow_class--;
> +	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_AMB) {
> +		pr_info("EPOW: Over ambient temperature\n");
> +		epow[EPOW_SYSTEMP_AMB] = 1;
> +	}
> +
> +	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_INT) {
> +		pr_info("EPOW: Over internal temperature\n");
> +		epow[EPOW_SYSTEMP_INT] = 1;
> +	}
> +
> +	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_HMD) {
> +		pr_info("EPOW: Over internal humidity\n");
> +		epow[EPOW_SYSTEMP_HMD] = 1;
> +	}
> +
> +	if (!max_epow_class) {
> +		pr_warn("EPOW: OPAL_SYSEPOW_COOLING subclass not present\n");
> +		return;
> +	}
> +
> +	/* Cooling */
> +	max_epow_class--;
> +	if (epow_status[OPAL_SYSEPOW_COOLING] & OPAL_SYSCOOL_INSF) {
> +		pr_info("EPOW: Insufficient cooling\n");
> +		epow[EPOW_SYSCOOL_INSF] = 1;
> +	}
> +}

This is fairly verbose, due to the separate u64s in the epow types.

> +
> +/*
> + * fetch_epow_status
> + *
> + * Fetch the system EPOW status through an OPAL call and
> + * validate the number of EPOW sub class status received.
> + */
> +static void fetch_epow_status(int16_t *epow_status, int16_t *n_epow)
> +{
> +	int rc;
> +
> +	memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
> +	*n_epow = OPAL_SYSEPOW_MAX;
> +	rc = opal_get_epow_status(epow_status, n_epow);
> +	if (rc != OPAL_SUCCESS) {
> +		pr_err("EPOW: OPAL call failed\n");
> +		memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
> +		*n_epow = 0;
> +		return;
> +	}
> +	if (!(*n_epow))
> +		pr_err("EPOW: No subclass status received\n");
> +}

Endian conversion?

> +
> +/*
> + * fetch_dpo_timeout
> + *
> + * Fetch the system DPO timeout status through an OPAL call.
> + */
> +static void fetch_dpo_timeout(int64_t *dpo_timeout)
> +{
> +	int rc;
> +
> +	rc = opal_get_dpo_status(dpo_timeout);
> +	if (rc == OPAL_WRONG_STATE) {
> +		pr_info("DPO: Not initiated by OPAL\n");
> +		*dpo_timeout = 0;
> +	}
> +}

And here too?

> +
> +/*
> + * valid_epow
> + *
> + * Validate the received EPOW event status. This ensures
> + * that there are valid status for various EPOW sub classes
> + * and their individual events.
> + */
> +static bool valid_epow(int16_t *epow_status, int16_t n_epow)
> +{
> +	int i;
> +
> +	/* EPOW sub classes present */
> +	if (!n_epow)
> +		return false;
> +
> +	/* EPOW events present */
> +	for (i = 0; i < n_epow; i++) {
> +		if (epow_status[i])
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * epow_exclude
> + *
> + * XXX: EPOW events on the action exclude list. System shutdown
> + * would not be scheduled for all these platform events. In future
> + * this should be communicated from the platform firmware through
> + * device tree attributes.
> + */

Exclude from what? System shutdown, right? You have the logic between
this and the subsequent function reversed, which makes it a little
complex to red.

Maybe make this epow_event_is_actionable()?

> +/*
> + * opal_event_handle_basic
> + *
> + * Sets up the basic information for an opal platform event,
> + * activates the timer, adds to the list and wakes up waiting
> + * threads on the character device.
> + */
> +static void opal_event_handle_basic(struct opal_platform_evt *evt,
> +				unsigned long type, unsigned long timeout)
> +{
> +	unsigned long flags;
> +
> +	evt->opal_event.type = type;
> +	switch (type) {
> +	case OPAL_PLAT_EVENT_TYPE_EPOW:
> +		evt->opal_event.size = sizeof(struct epow_event);
> +		evt->opal_event.epow.timeout = timeout;
> +		if (actionable_epow(evt->opal_event.epow.epow))
> +			opal_event_start_timer(OPAL_PLAT_EVENT_TYPE_EPOW,
> +							OPAL_EPOW_TIMEOUT);
> +		break;
> +	case  OPAL_PLAT_EVENT_TYPE_DPO:
> +		evt->opal_event.size = sizeof(struct dpo_event);
> +		evt->opal_event.dpo.orig_timeout = timeout;
> +		opal_event_start_timer(OPAL_PLAT_EVENT_TYPE_DPO, timeout);
> +		break;
> +	default:
> +		pr_err("Unknown event type\n");
> +		break;
> +	}
> +	spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
> +	list_add_tail(&evt->link, &opal_event_queue);
> +	spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
> +	wake_up_interruptible(&opal_plat_evt_wait);
> +}
> +
> +/*
> + * opal_event_existing_status
> + *
> + * Fetch and process existing opal platform event conditions
> + * present on the system. If events detected, add them to the
> + * list which can be consumed by the user space right away.
> + */
> +static void opal_event_existing_status(void)
> +{
> +	struct opal_platform_evt *evt;
> +	int64_t dpo_timeout;
> +	int16_t	epow_status[OPAL_SYSEPOW_MAX], n_epow;
> +
> +	fetch_epow_status(epow_status, &n_epow);
> +	if (valid_epow(epow_status, n_epow)) {
> +		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
> +		if (!evt) {
> +			pr_err("EPOW: Memory allocation for event failed\n");
> +			return;
> +		}
> +		process_epow(evt->opal_event.epow.epow, epow_status, n_epow);
> +		opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_EPOW,
> +							OPAL_EPOW_TIMEOUT);
> +	}
> +
> +	fetch_dpo_timeout(&dpo_timeout);
> +	if (dpo_timeout) {
> +		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
> +		if (!evt) {
> +			pr_err("DPO: Memory allocation for event failed\n");
> +			return;
> +		}
> +		opal_dpo_target = jiffies + dpo_timeout * HZ;
> +		opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_DPO,
> +								dpo_timeout);
> +	}
> +}
> +
> +/* Platform EPOW message received */
> +static int opal_epow_event(struct notifier_block *nb,
> +				unsigned long msg_type, void *msg)
> +{
> +	struct opal_platform_evt *evt;
> +	int16_t	epow_status[OPAL_SYSEPOW_MAX], n_epow;
> +
> +	if (msg_type != OPAL_MSG_EPOW)
> +		return 0;
> +
> +	fetch_epow_status(epow_status, &n_epow);
> +	if (!valid_epow(epow_status, n_epow))
> +		return -EINVAL;
> +
> +	pr_debug("EPOW event: Power(%x) Thermal(%x) Cooling(%x)\n",
> +			epow_status[0], epow_status[1], epow_status[2]);
> +	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
> +	if (!evt) {
> +		pr_err("EPOW: Memory allocation for event failed\n");
> +		return -ENOMEM;
> +	}
> +	process_epow(evt->opal_event.epow.epow, epow_status, n_epow);
> +	opal_event_handle_basic(evt,
> +				OPAL_PLAT_EVENT_TYPE_EPOW, OPAL_EPOW_TIMEOUT);
> +	return 0;
> +}
> +
> +/* Platform DPO message received */
> +static int opal_dpo_event(struct notifier_block *nb,
> +				unsigned long msg_type, void *msg)
> +{
> +	struct opal_platform_evt *evt;
> +	int64_t dpo_timeout;
> +
> +	if (msg_type != OPAL_MSG_DPO)
> +		return 0;
> +
> +	fetch_dpo_timeout(&dpo_timeout);
> +	if (!dpo_timeout)
> +		return -EINVAL;
> +
> +	pr_debug("DPO event: Timeout:%llu\n", dpo_timeout);
> +	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
> +	if (!evt) {
> +		pr_err("DPO: Memory allocation for event failed\n");
> +		return -ENOMEM;
> +	}
> +	opal_dpo_target = jiffies + dpo_timeout * HZ;
> +	opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_DPO, dpo_timeout);
> +	return 0;
> +}

Okay, these are a little messy:

1) an inocoming EPOW/DPO event will invoke both notifier callbacks

2) the notifier callback will check if it's the right handler for the
   msg_type, and handle the event, so we get separate code paths
   for EPOW & DPO.

3) both callbacks then converge on a single code path, by calling
   opal_event_basic with a specific type argument. Here we get
   a single code path for EPOW & DPO.

4) opal_event_basic then checks the type, and performs separate
   functions depending on EPOW vs. DPO

- and then the logic (and code) is repeated for the
opal_existing_event_status function

Can you unify this, so there's less duplication and conditional code?

Also, are you sure you can kzalloc(GFP_KERNEL) here?


> +/* Platform driver probe */
> +static int opal_event_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	if (opal_event_probe_finished) {
> +		pr_err("%s getting called once again\n", __func__);
> +		return 0;
> +	}
> +	opal_event_probe_finished = true;
> +
> +	init_timer(&opal_event_timer);
> +	opal_event_timer.function = opal_event_timeout;
> +	opal_event_open_flag = false;
> +	opal_dpo_target = 0;
> +
> +	ret = alloc_chrdev_region(&opal_event_dev, 0,
> +					OPAL_EVENT_MAX_DEVS, "opal_event");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "aloc_chrdev_region failed\n");
> +		return ret;
> +	}
> +
> +	opal_event_class = class_create(THIS_MODULE, "opal_event");
> +	if (IS_ERR(opal_event_class)) {
> +		ret = PTR_ERR(opal_event_class);
> +		dev_err(&pdev->dev, "class_create failed with %d\n", ret);
> +		goto fail_chrdev;
> +	}
> +
> +	dev = device_create(opal_event_class, &pdev->dev,
> +					opal_event_dev, NULL, "opal_event");
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		dev_err(&pdev->dev, "device_create failed with %d\n", ret);
> +		goto fail_class;
> +	}
> +
> +	cdev_init(&opal_event_cdev, &fops);
> +	ret = cdev_add(&opal_event_cdev, opal_event_dev, OPAL_EVENT_MAX_DEVS);
> +	if (ret < 0) {
> +		dev_err(dev, "cdev_add failed\n");
> +		ret = -EINVAL;
> +		goto fail_device;
> +	}
>

You can probably avoid a lot of this by using a miscdev. Do we need a
whole chardev class here?

> +static int __init opal_platform_event_init(void)
> +{
> +	opal_event_probe_finished = false;
> +	return platform_driver_register(&opal_event_driver);
> +}
> +
> +static void __exit opal_platform_event_exit(void)
> +{
> +	platform_driver_unregister(&opal_event_driver);
> +}
> +module_init(opal_platform_event_init);
> +module_exit(opal_platform_event_exit);


You can replace all of this with:

module_platform_driver(opal_event_driver);

And your probe function should only be called once. Are you sure you need
that opal_event_probe_finished check?

Regards,


Jeremy
