Return-Path: <krafft@de.ibm.com>
Date: Mon, 12 Feb 2007 10:12:22 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [patch 1/1] pmi: initial version
Message-ID: <20070212101222.24abe14c@localhost>
In-Reply-To: <20070209222956.GH1827@localdomain>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
	<20070209222956.GH1827@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nathan,

thanks for your comments.
Will send an updated version.

On Fri, 9 Feb 2007 16:29:56 -0600
Nathan Lynch <ntl@pobox.com> wrote:

> Hi Christian-
>=20
> Some minor comments.
>=20
> Christian Krafft wrote:
> > This patch adds driver code for the PMI device found in future IBM prod=
ucts.
> > PMI stands for "Platform Management Interrupt" and is a way to communic=
ate
> > with the BMC. It provides bidirectional communication with a low latenc=
y.
> >=20
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> >=20
> > Index: linux/arch/powerpc/Kconfig
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux.orig/arch/powerpc/Kconfig
> > +++ linux/arch/powerpc/Kconfig
> > @@ -524,6 +524,7 @@ config PPC_IBM_CELL_BLADE
> >  	select MMIO_NVRAM
> >  	select PPC_UDBG_16550
> >  	select UDBG_RTAS_CONSOLE
> > +#	select PPC_PMI
>=20
> Did you mean for this to be commented out?

no, good point ;-)

>=20
> <snip>
>=20
> > +static void __iomem *of_iomap(struct device_node *np)
> > +{
> > +	struct resource res;
> > +
> > +	if (of_address_to_resource(np, 0, &res))
> > +		return NULL;
> > +
> > +	pr_debug("Resource start: 0x%lx\n", res.start);
> > +        pr_debug("Resource end: 0x%lx\n", res.end);
>=20
> You need a tab instead of spaces.

copy and past bug,

>=20
>=20
> > +
> > +	return ioremap(res.start, 1 + res.end - res.start);
> > +}
> > +
> > +static int pmi_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct pmi_data *data;
> > +	int type;
> > +	struct pmi_handler *handler;
> > +
> > +	data =3D dev_id;
> > +
> > +	BUG_ON(!data);
>=20
> Not necessary, you'll oops in two lines anyway if data is NULL.

ok,

>=20
>=20
> > +
> > +	pr_debug("pmi: got a PMI message\n");
> > +
> > +	spin_lock(&data->pmi_spinlock);
> > +	type =3D ioread8(data->pmi_reg + PMI_READ_TYPE);
> > +	spin_unlock(&data->pmi_spinlock);
> > +
> > +	pr_debug("pmi: message type is %d\n", type);
> > +
> > +	if (type & PMI_ACK) {
> > +		BUG_ON(!data->msg);
> > +		BUG_ON(!data->completion);
> > +		pr_debug("pmi: got an ACK\n");
> > +		data->msg->type =3D type;
> > +		data->msg->data0 =3D ioread8(data->pmi_reg + PMI_READ_DATA0);
> > +		data->msg->data1 =3D ioread8(data->pmi_reg + PMI_READ_DATA1);
> > +		data->msg->data2 =3D ioread8(data->pmi_reg + PMI_READ_DATA2);
>=20
> Should these accesses to data->pmi_reg be performed while holding
> data->pmi_spinlock as well?

yep, good catch.

>=20
>=20
> > +		complete(data->completion);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	spin_lock(&data->handler_spinlock);
> > +	list_for_each_entry(handler, &data->handler, node) {
> > +		pr_debug("pmi: notifying handlers\n");
> > +		if (handler->type =3D=3D type) {
> > +			pr_debug("pmi: notify handler %p\n", handler);
> > +			handler->handle_pmi_message(data->dev, data->msg);
> > +		}
> > +	}
> > +	spin_unlock(&data->handler_spinlock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +
> > +static struct of_device_id pmi_match[] =3D {
> > +	{ .type =3D "ibm,pmi", .name =3D "pmi" },
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, pmi_match);
> > +
> > +static int pmi_of_probe(struct of_device *dev,
> > +			const struct of_device_id *match)
> > +{
> > +	DEFINE_SPINLOCK(handler_spinlock);
> > +	DEFINE_SPINLOCK(pmi_spinlock);
> > +
> > +	struct device_node *np =3D dev->node;
> > +	struct pmi_data *data;
> > +	int rc;
> > +
> > +	data =3D kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
> > +	if (!data) {
> > +		printk(KERN_ERR "pmi: could not allocate memory.\n");
> > +		return -EFAULT;
>=20
> -ENOMEM is the appropriate error code here.

will be updated.

>=20
>=20
> > +	}
> > +
> > +	data->pmi_reg =3D of_iomap(np);
> > +
> > +	if (!data->pmi_reg) {
> > +		printk(KERN_ERR "pmi: invalid register address.\n");
> > +		kfree(data);
> > +		return -EFAULT;
> > +	}
> > +
> > +	INIT_LIST_HEAD(&data->handler);
> > +
> > +	data->irq =3D irq_of_parse_and_map(np, 0);
> > +	if (data->irq =3D=3D NO_IRQ) {
> > +		printk(KERN_ERR "pmi: invalid interrupt.\n");
> > +		iounmap(data->pmi_reg);
> > +		kfree(data);
> > +		return -EFAULT;
> > +	}
> > +
> > +	data->handler_spinlock =3D handler_spinlock;
> > +	data->pmi_spinlock =3D pmi_spinlock;
> > +
> > +	rc =3D request_irq(data->irq, pmi_irq_handler,
> > +			IRQF_SHARED, "pmi", data);
> > +	if (rc) {
> > +		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
> > +			data->irq, rc);
> > +		iounmap(data->pmi_reg);
> > +		kfree(data);
>=20
> Consider using goto to reduce duplication of the iounmap, kfree sequence.
>=20
> > +		return -EFAULT;
>=20
> Just return rc; request_irq returns standard error codes.

ok,

>=20
> <snip>
>=20
> > +void pmi_send_message(struct of_device *device, struct pmi_message *ms=
g)
> > +{
> > +	struct pmi_data *data;
> > +	unsigned long flags;
> > +	DECLARE_COMPLETION_ONSTACK(completion);
> > +
> > +	BUG_ON(!device || !msg);
>=20
> This BUG_ON is also unnecessary, and could actually make debugging
> more difficult since it wouldn't be immediately apparent which
> condition triggered it.

right,

>=20
> > +
> > +	data =3D device->dev.driver_data;
> > +	pr_debug("pmi_send_message: data is %p\n", data);
> > +
> > +	mutex_lock(&data->msg_mutex);
> > +
> > +	data->msg =3D msg;
> > +
> > +	pr_debug("pmi_send_message: msg is %p\n", msg);
> > +
> > +	data->completion =3D &completion;
> > +
> > +	spin_lock_irqsave(&data->pmi_spinlock, flags);
> > +	iowrite8(msg->data0, data->pmi_reg + PMI_WRITE_DATA0);
> > +	iowrite8(msg->data1, data->pmi_reg + PMI_WRITE_DATA1);
> > +	iowrite8(msg->data2, data->pmi_reg + PMI_WRITE_DATA2);
> > +	iowrite8(msg->type, data->pmi_reg + PMI_WRITE_TYPE);
> > +	spin_unlock_irqrestore(&data->pmi_spinlock, flags);
> > +
> > +	pr_debug(KERN_INFO "pmi_send_message: wait for completion %p\n", data=
->completion);
> > +
> > +	wait_for_completion_interruptible_timeout(data->completion, PMI_TIMEO=
UT);
> > +
> > +	data->msg =3D NULL;
> > +	data->completion =3D NULL;
> > +
> > +	mutex_unlock(&data->msg_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(pmi_send_message);
> ...
> > +EXPORT_SYMBOL_GPL(pmi_register_handler);
> ...
> > +EXPORT_SYMBOL_GPL(pmi_unregister_handler);
>=20
> Are the symbol exports necessary?
>=20
> <snip>
>=20
> > +void pmi_register_handler(struct of_device *, struct pmi_handler *);
> > +void pmi_unregister_handler(struct of_device *, struct pmi_handler *);
> > +
> > +void pmi_send_message(struct of_device *, struct pmi_message *);
>=20
> Are there users of these functions?
>=20

yes, they will be used by the cbe_cpufreq driver.
I will send a patch for it, as soon as i was able to test it,
hopefully today or tomorrow.


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
