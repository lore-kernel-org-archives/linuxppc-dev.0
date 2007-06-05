Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 3E11CDDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 00:13:00 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <62dbe474663a3a3e91268f0bdc2f6479@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Tue, 5 Jun 2007 09:12:50 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon Jun 4 23:00:05 EST 2007, Michael Ellerman wrote:
> This patch adds support for the setup and decoding of MSIs
> on Axon-based Cell systems.
>
> This still needs a bit of cleanup, but sending now for an early review.

Ok here is some from someone without the documentation.

> diff --git a/arch/powerpc/platforms/cell/axon_msi.c 
> b/arch/powerpc/platforms/cell/axon_msi.c
> new file mode 100644
> index 0000000..2709853
> --- /dev/null
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
...
> +/*
> + * MSIC Control Register
> + */
> +#define MSIC_CTRL_REG_ADDR     0x6F
> +
> +/* Flags */

Comments might be a bit verbose, the defines explain them.

> +#define MSIC_ENABLE            0x0001  /* Bit 31 */
> +#define MSIC_FIFO_FULL_ENABLE  0x0002  /* Bit 30 */
> +#define MSIC_IRQ_ENABLE                0x0008  /* Bit 28 */
> +#define MSIC_FULL_STOP_ENABLE  0x0010  /* Bit 27 */
> +
> +/* Size configuration constants */
> +#define MSIC_SIZE_MASK         0x0180  /* Bits 22:23 */
> +#define MSIC_SIZE_SHIFT                (7)
> +#define        MSIC_SIZE_32K           0x0
> +#define        MSIC_SIZE_64K           0x1
> +#define        MSIC_SIZE_128K          0x2
> +#define        MSIC_SIZE_256K          0x3
> +
> +/* The size we're actually using */
> +#define MSIC_FIFO_SIZE         MSIC_SIZE_32K

Oh, so those were fifo sizes.
Not a config var?

> +
> +/* Different representations of the fifo size */
> +#define MSIC_FIFO_SHIFT                (MSIC_FIFO_SIZE + 0xF)

Where did the 0xF come from? everything was derived up until now.

Why is it 0xF and not 15?  (We often do shifts in decimal where there 
isn't another reason to choose the base.)

> +#define MSIC_FIFO_BYTES                (1 << MSIC_FIFO_SHIFT)
> +#define MSIC_FIFO_MASK         (MSIC_FIFO_BYTES - 1)
> +#define MSIC_FIFO_ORDER                max(MSIC_FIFO_SHIFT - 
> PAGE_SHIFT, 0)
> +
> +/*
> + * MSIC Base Address registers (FIFO location)
> + */

At first I thought you were referring to location relative to fifo, but 
now I realize its the location and size of the fifo.

> +#define MSIC_BASE_ADDR_HI_REG  0x72
> +#define MSIC_BASE_ADDR_LO_REG  0x73
> +
> +#define MSIC_READ_OFFSET_REG   0x74
> +#define MSIC_WRITE_OFFSET_REG  0x75
> +
> +#define MSIC_DCR_BASE          MSIC_CTRL_REG_ADDR
> +#define MSIC_DCR_SIZE          (MSIC_WRITE_OFFSET_REG - 
> MSIC_CTRL_REG_ADDR)
> +
> +
> +struct axon_msic {
> +       struct device_node *dn;
> +       struct irq_host *irq_host;
> +       void *fifo;
> +       dcr_host_t dcr_host;
> +       struct list_head list;
> +       u32 read_offset;
> +};
> +
> +
> +static LIST_HEAD(axon_msic_list);
> +
> +static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +       struct axon_msic *msic = get_irq_data(irq);
> +       u32 write_offset, msi;
> +       unsigned int cirq;
> +
> +       write_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
> +       pr_debug("axon_msi: original write_offset 0x%x\n", 
> write_offset);
> +
> +       /* write_offset doesn't wrap properly, so we have to mask it */
> +       write_offset &= MSIC_FIFO_MASK;
> +
> +       while (msic->read_offset != write_offset) {
> +               msi  = le32_to_cpup((__le32*)(msic->fifo + 
> msic->read_offset));
> +               msi &= 0xFFFF;
> +
> +               pr_debug("axon_msi: woff %x roff %x @ %p msi %x msi at 
> 0 %x\n",
> +                       write_offset, msic->read_offset,
> +                       msic->fifo + msic->read_offset, msi, 
> *(u32*)msic->fifo);
> +
> +               msic->read_offset += 0x10;

Another magic number.   Is this the size of an entry?

> +               msic->read_offset &= MSIC_FIFO_MASK;
> +

If we increment by 0x10, how do we know write_offset or the original 
read_offset is aligned to that value and we terminate?   Should the 
MSIC_FIFO_MASK mask off the low order bits?

> +               cirq = irq_linear_revmap(msic->irq_host, msi);
> +               if (cirq != NO_IRQ)
> +                       generic_handle_irq(cirq);
> +               else
> +                       pr_debug("axon_msi: mapped to NO_IRQ!\n");
> +       }
> +
> +       dcr_write(msic->dcr_host, MSIC_READ_OFFSET_REG, 
> msic->read_offset);
> +
> +       desc->chip->eoi(irq);
> +}
> +
> +static struct axon_msic *find_msi_translator(struct pci_dev *dev)
> +{
> +       struct irq_host *irq_host;
> +       struct device_node *np, *tmp;
> +       const phandle *ph;
> +
> +       np = pci_device_to_OF_node(dev);
> +       if (!np) {
> +               dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
> +               return NULL;
> +       }
> +
> +       for (; np; tmp = of_get_parent(np), of_node_put(np), np = tmp) 
> {
> +               ph = of_get_property(np, "msi-translator", NULL);
> +               if (ph)
> +                       break;
> +       }
> +
> +       if (!ph) {
> +               dev_dbg(&dev->dev, "axon_msi: no msi-translator 
> found\n");
> +               goto out_error;
> +       }
> +
> +       tmp = np;
> +       np = of_find_node_by_phandle(*ph);
> +       if (!np) {
> +               dev_dbg(&dev->dev, "axon_msi: invalid msi-translator 
> found\n");

msi-translator device not found?  It's not clear this is the property 
(nor above).

> +               goto out_error;
> +       }
> +
> +       irq_host = irq_find_host(np);
> +       if (!irq_host) {
> +               dev_dbg(&dev->dev, "axon_msi: no irq_host found\n");
> +               goto out_error;
> +       }
> +
> +       return irq_host->host_data;
> +
> +out_error:
> +       of_node_put(np);
> +       of_node_put(tmp);
> +
> +       return NULL;
> +}
> +
> +static int axon_msi_check_device(struct pci_dev *dev, int nvec, int 
> type)
> +{
> +       if (!find_msi_translator(dev))
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg 
> *msg)
> +{
> +       struct device_node *np, *tmp;
> +       int pos, len;
> +       u16 flags;
> +       const u32 *prop;
> +
> +       np = pci_device_to_OF_node(dev);
> +       if (!np) {
> +               dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
> +               return -ENODEV;
> +       }
> +
> +       pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +       if (!pos || pci_read_config_word(dev, pos + PCI_MSI_FLAGS, 
> &flags)) {
> +               dev_err(&dev->dev, "axon_msi: error reading config 
> space!\n");
> +               return -EIO;
> +       }

What about MSIX ?

> +
> +       for (; np; tmp = of_get_parent(np), of_node_put(np), np = tmp) 
> {
> +               if (flags & PCI_MSI_FLAGS_64BIT) {
> +                       prop = of_get_property(np, "msi-address-64", 
> &len);
> +                       if (prop)
> +                               break;
> +               }
> +
> +               prop = of_get_property(np, "msi-address-32", &len);
> +               if (prop)
> +                       break;
> +       }
> +       of_node_put(np);
> +
> +       if (!prop) {
> +               dev_dbg(&dev->dev, "axon_msi: no msi-address-(32|64) 
> found\n");
> +               return -ENOENT;
> +       }
> +
> +       switch (len) {
> +       case 8:
> +               msg->address_hi = prop[0];
> +               msg->address_lo = prop[1];
> +               break;
> +       case 4:
> +               msg->address_hi = 0;
> +               msg->address_lo = prop[0];
> +               break;
> +       default:
> +               dev_dbg(&dev->dev, "axon_msi: malformed 
> msi-address-(32|64)\n");
> +               return -EINVAL;
> +       }

How about of_read_number into a u64 and then write out the pieces?  
Should be more compact?

> +
> +       return 0;
> +}

...

> +static int axon_msi_notify_reboot(struct notifier_block *nb,
> +                                 unsigned long code, void *data)
> +{
> +       struct axon_msic *msic;
> +       u32 tmp;
> +
> +       list_for_each_entry(msic, &axon_msic_list, list) {
> +               tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG_ADDR);
> +               tmp &= ~MSIC_ENABLE;
> +               dcr_write(msic->dcr_host, MSIC_CTRL_REG_ADDR, tmp);
> +               pr_debug("axon_msi: disabling %s\n", 
> msic->dn->full_name);

disabled?  (or move print)

> +       }
> +
> +       return 0;
> +}
> +
> +static struct notifier_block axon_msi_reboot_notifier = {
> +       .notifier_call = axon_msi_notify_reboot
> +};
> +
> +static int axon_msi_setup_one(struct device_node *node)
> +{
> +       struct page *page;
> +       struct axon_msic *msic;
> +       unsigned int virq;
> +
> +       pr_debug("axon_msi: setting up dn %s\n", node->full_name);
> +
> +       msic = kzalloc(sizeof(struct axon_msic), GFP_KERNEL);
> +       if (!msic) {
> +               printk(KERN_ERR "axon_msi: couldn't allocate msic\n");

Add node->name here (all of the error outs)

> +               goto out_put;
> +       }
>
...

> +       list_add(&msic->list, &axon_msic_list);
>
what is the locking for this list?


milton
