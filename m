Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 24CB4DDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:45:05 +1100 (EST)
Date: Fri, 9 Feb 2007 16:29:56 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] pmi: initial version
Message-ID: <20070209222956.GH1827@localdomain>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209184530.4c8bc2be@localhost>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christian-

Some minor comments.

Christian Krafft wrote:
> This patch adds driver code for the PMI device found in future IBM products.
> PMI stands for "Platform Management Interrupt" and is a way to communicate
> with the BMC. It provides bidirectional communication with a low latency.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> Index: linux/arch/powerpc/Kconfig
> ===================================================================
> --- linux.orig/arch/powerpc/Kconfig
> +++ linux/arch/powerpc/Kconfig
> @@ -524,6 +524,7 @@ config PPC_IBM_CELL_BLADE
>  	select MMIO_NVRAM
>  	select PPC_UDBG_16550
>  	select UDBG_RTAS_CONSOLE
> +#	select PPC_PMI

Did you mean for this to be commented out?

<snip>

> +static void __iomem *of_iomap(struct device_node *np)
> +{
> +	struct resource res;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return NULL;
> +
> +	pr_debug("Resource start: 0x%lx\n", res.start);
> +        pr_debug("Resource end: 0x%lx\n", res.end);

You need a tab instead of spaces.


> +
> +	return ioremap(res.start, 1 + res.end - res.start);
> +}
> +
> +static int pmi_irq_handler(int irq, void *dev_id)
> +{
> +	struct pmi_data *data;
> +	int type;
> +	struct pmi_handler *handler;
> +
> +	data = dev_id;
> +
> +	BUG_ON(!data);

Not necessary, you'll oops in two lines anyway if data is NULL.


> +
> +	pr_debug("pmi: got a PMI message\n");
> +
> +	spin_lock(&data->pmi_spinlock);
> +	type = ioread8(data->pmi_reg + PMI_READ_TYPE);
> +	spin_unlock(&data->pmi_spinlock);
> +
> +	pr_debug("pmi: message type is %d\n", type);
> +
> +	if (type & PMI_ACK) {
> +		BUG_ON(!data->msg);
> +		BUG_ON(!data->completion);
> +		pr_debug("pmi: got an ACK\n");
> +		data->msg->type = type;
> +		data->msg->data0 = ioread8(data->pmi_reg + PMI_READ_DATA0);
> +		data->msg->data1 = ioread8(data->pmi_reg + PMI_READ_DATA1);
> +		data->msg->data2 = ioread8(data->pmi_reg + PMI_READ_DATA2);

Should these accesses to data->pmi_reg be performed while holding
data->pmi_spinlock as well?


> +		complete(data->completion);
> +		return IRQ_HANDLED;
> +	}
> +
> +	spin_lock(&data->handler_spinlock);
> +	list_for_each_entry(handler, &data->handler, node) {
> +		pr_debug("pmi: notifying handlers\n");
> +		if (handler->type == type) {
> +			pr_debug("pmi: notify handler %p\n", handler);
> +			handler->handle_pmi_message(data->dev, data->msg);
> +		}
> +	}
> +	spin_unlock(&data->handler_spinlock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static struct of_device_id pmi_match[] = {
> +	{ .type = "ibm,pmi", .name = "pmi" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, pmi_match);
> +
> +static int pmi_of_probe(struct of_device *dev,
> +			const struct of_device_id *match)
> +{
> +	DEFINE_SPINLOCK(handler_spinlock);
> +	DEFINE_SPINLOCK(pmi_spinlock);
> +
> +	struct device_node *np = dev->node;
> +	struct pmi_data *data;
> +	int rc;
> +
> +	data = kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
> +	if (!data) {
> +		printk(KERN_ERR "pmi: could not allocate memory.\n");
> +		return -EFAULT;

-ENOMEM is the appropriate error code here.


> +	}
> +
> +	data->pmi_reg = of_iomap(np);
> +
> +	if (!data->pmi_reg) {
> +		printk(KERN_ERR "pmi: invalid register address.\n");
> +		kfree(data);
> +		return -EFAULT;
> +	}
> +
> +	INIT_LIST_HEAD(&data->handler);
> +
> +	data->irq = irq_of_parse_and_map(np, 0);
> +	if (data->irq == NO_IRQ) {
> +		printk(KERN_ERR "pmi: invalid interrupt.\n");
> +		iounmap(data->pmi_reg);
> +		kfree(data);
> +		return -EFAULT;
> +	}
> +
> +	data->handler_spinlock = handler_spinlock;
> +	data->pmi_spinlock = pmi_spinlock;
> +
> +	rc = request_irq(data->irq, pmi_irq_handler,
> +			IRQF_SHARED, "pmi", data);
> +	if (rc) {
> +		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
> +			data->irq, rc);
> +		iounmap(data->pmi_reg);
> +		kfree(data);

Consider using goto to reduce duplication of the iounmap, kfree sequence.

> +		return -EFAULT;

Just return rc; request_irq returns standard error codes.

<snip>

> +void pmi_send_message(struct of_device *device, struct pmi_message *msg)
> +{
> +	struct pmi_data *data;
> +	unsigned long flags;
> +	DECLARE_COMPLETION_ONSTACK(completion);
> +
> +	BUG_ON(!device || !msg);

This BUG_ON is also unnecessary, and could actually make debugging
more difficult since it wouldn't be immediately apparent which
condition triggered it.

> +
> +	data = device->dev.driver_data;
> +	pr_debug("pmi_send_message: data is %p\n", data);
> +
> +	mutex_lock(&data->msg_mutex);
> +
> +	data->msg = msg;
> +
> +	pr_debug("pmi_send_message: msg is %p\n", msg);
> +
> +	data->completion = &completion;
> +
> +	spin_lock_irqsave(&data->pmi_spinlock, flags);
> +	iowrite8(msg->data0, data->pmi_reg + PMI_WRITE_DATA0);
> +	iowrite8(msg->data1, data->pmi_reg + PMI_WRITE_DATA1);
> +	iowrite8(msg->data2, data->pmi_reg + PMI_WRITE_DATA2);
> +	iowrite8(msg->type, data->pmi_reg + PMI_WRITE_TYPE);
> +	spin_unlock_irqrestore(&data->pmi_spinlock, flags);
> +
> +	pr_debug(KERN_INFO "pmi_send_message: wait for completion %p\n", data->completion);
> +
> +	wait_for_completion_interruptible_timeout(data->completion, PMI_TIMEOUT);
> +
> +	data->msg = NULL;
> +	data->completion = NULL;
> +
> +	mutex_unlock(&data->msg_mutex);
> +}
> +EXPORT_SYMBOL_GPL(pmi_send_message);
...
> +EXPORT_SYMBOL_GPL(pmi_register_handler);
...
> +EXPORT_SYMBOL_GPL(pmi_unregister_handler);

Are the symbol exports necessary?

<snip>

> +void pmi_register_handler(struct of_device *, struct pmi_handler *);
> +void pmi_unregister_handler(struct of_device *, struct pmi_handler *);
> +
> +void pmi_send_message(struct of_device *, struct pmi_message *);

Are there users of these functions?
