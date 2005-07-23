Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 6903067D60
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:15:21 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 71so626388wri
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 07:15:20 -0700 (PDT)
Message-ID: <528646bc05072307157b4d132d@mail.gmail.com>
Date: Sat, 23 Jul 2005 10:15:20 -0400
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 2/3] support for mpc52xx PSC as an SPI bus master
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SPI bus master driver for the Freescale MPC52xx.

Note: This patch as it stands right now will compile cleanly, but may
not bind the driver to the PSC.  arch/ppc/syslib/mpc52xx_devices.c
needs to be modified to rename the desired PSC platform devices to
match the driver.  (rename  to "mpc52xx-psc:spi")  This is a board
specific hack, and I need to make it cleaner before I resubmit this
patch.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

diff -ruNp linux-spi/arch/ppc/platforms/lite5200.c
linux-spi-mpc5200/arch/ppc/platforms/lite5200.c
--- linux-spi/arch/ppc/platforms/lite5200.c=092005-06-17 15:48:29.000000000=
 -0400
+++ linux-spi-mpc5200/arch/ppc/platforms/lite5200.c=092005-07-23
03:17:39.000000000 -0400
@@ -76,6 +76,21 @@ lite5200_map_irq(struct pci_dev *dev, un
 }
 #endif
=20
+#if defined(CONFIG_SPI_BUS_MPC52XX_PSC) ||
defined(CONFIG_SPI_BUS_MPC52XX_PSC_MODULE)
+void
+spi_mpc52xx_psc_slave_select(int psc_id, int slave_id)
+{
+}
+
+void
+spi_mpc52xx_psc_slave_deselect(int psc_id)
+{
+}
+
+EXPORT_SYMBOL(spi_mpc52xx_psc_slave_select);
+EXPORT_SYMBOL(spi_mpc52xx_psc_slave_deselect);
+#endif
+
 static void __init
 lite5200_setup_cpu(void)
 {
@@ -107,15 +122,30 @@ lite5200_setup_cpu(void)
 =09else
 =09=09out_be16(&cdm->fd_counters, 0x5555);
=20
+=09/* Setup clocks for PSC3 SPI mode */
+=09out_be16(&cdm->mclken_div_psc3, 0x8020);  /* Enable MClk for PSC3 */
+
 =09/* Get port mux config */
 =09port_config =3D in_be32(&gpio->port_config);
=20
 =09/* 48Mhz internal, pin is GPIO */
-=09port_config &=3D ~0x00800000;
+=09port_config &=3D ~PORT_CONFIG_IR_USB_CLK;
=20
-=09/* USB port */
-=09port_config &=3D ~0x00007000;=09/* Differential mode - USB1 only */
-=09port_config |=3D  0x00001000;
+=09/* USB port: Differential mode; USB1 only */
+=09port_config &=3D ~(PORT_CONFIG_USB_SE | PORT_CONFIG_USB_MASK);
+=09port_config |=3D  PORT_CONFIG_USB_USB;
+
+=09/* PSC2 (I2S Codec mode) */
+=09port_config &=3D ~PORT_CONFIG_PSC2_MASK;
+=09port_config |=3D  PORT_CONFIG_PSC2_CODEC; /* Codec mode */
+
+=09/* PSC3 (SPI Codec mode) */
+=09port_config &=3D ~PORT_CONFIG_PSC3_MASK;
+=09port_config |=3D  PORT_CONFIG_PSC3_CODEC; /* Codec mode */
+
+=09/* PSC6 (I2S Codec mode) */
+=09port_config &=3D ~PORT_CONFIG_IRDA_MASK;
+=09port_config |=3D  PORT_CONFIG_IRDA_CODEC; /* Codec mode */
=20
 =09/* Commit port config */
 =09out_be32(&gpio->port_config, port_config);
diff -ruNp linux-spi/drivers/spi/Kconfig linux-spi-mpc5200/drivers/spi/Kcon=
fig
--- linux-spi/drivers/spi/Kconfig=092005-07-22 17:08:00.000000000 -0400
+++ linux-spi-mpc5200/drivers/spi/Kconfig=092005-07-22 17:16:13.000000000 -=
0400
@@ -20,6 +20,13 @@ config SPI
 comment "SPI Bus Drivers"
 =09depends on SPI
=20
+config SPI_BUS_MPC52XX_PSC
+=09tristate "SPI bus via MPC52xx PSC port"
+=09depends on SPI && PPC_MPC52xx
+=09help
+=09  Say Y here if you want to use an MPC52xx PSC port as an SPI bus
+=09  master.
+
 comment "SPI slaves"
 =09depends on SPI
=20
diff -ruNp linux-spi/drivers/spi/Makefile linux-spi-mpc5200/drivers/spi/Mak=
efile
--- linux-spi/drivers/spi/Makefile=092005-07-22 17:08:00.000000000 -0400
+++ linux-spi-mpc5200/drivers/spi/Makefile=092005-07-22 17:16:13.000000000 =
-0400
@@ -3,3 +3,4 @@
 #
=20
 obj-$(CONFIG_SPI)=09=09=09+=3D spi-core.o
+obj-$(CONFIG_SPI_BUS_MPC52XX_PSC)=09+=3D spi-mpc52xx-psc.o
diff -ruNp linux-spi/drivers/spi/spi-mpc52xx-psc.c
linux-spi-mpc5200/drivers/spi/spi-mpc52xx-psc.c
--- linux-spi/drivers/spi/spi-mpc52xx-psc.c=091969-12-31 19:00:00.000000000=
 -0500
+++ linux-spi-mpc5200/drivers/spi/spi-mpc52xx-psc.c=092005-07-22
17:16:13.000000000 -0400
@@ -0,0 +1,307 @@
+/*
+ * drivers/spi/mpc5xxx-psc.c
+ *
+ * Driver for the SPI mode of the MPC52xx PSC peripherals
+ *
+ * Maintainer : Grant Likely <glikely@gmail.com>
+ *
+ * This file is in the public domain
+ */
+
+/* Platform device Usage :
+ * (Blatantly copied from drivers/serial/mpc52xx_uart.c)
+ *
+ * Since PSCs can have multiple function, the correct driver for each one
+ * is selected based on the name assigned to the psc.  By convention, the
+ * function is appended to the device name in the board setup code.  For
+ * example, this spi psc driver will only bind to mpc52xx_psc.spi devices.
+ *
+ * The driver init all necessary registers to place the PSC in spi mode.
+ * However, the pin multiplexing aren't changed and should be set either
+ * by the bootloader or in the platform init code.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/spi.h>
+
+#include <asm/io.h>
+#include <asm/mpc52xx.h>
+#include <asm/mpc52xx_psc.h>
+
+
+/* The magic data is all in this structure.  This structure contains
+ * everything we need to keep track of the PSC
+ */
+struct mpc52xx_psc_spi_port {
+=09struct platform_device *pdev;=09=09/* PSC dev (on platform bus) */
+=09struct mpc52xx_psc __iomem *psc;=09/* PSC registers */
+=09struct spi_bus spi_bus;
+=09int irq;=09=09=09=09/* Assigned irq */
+
+=09/* Current state variables */
+=09struct semaphore sema; /* mutex to enforce one transfer at a time */
+=09wait_queue_head_t wait_queue; /* Wait on this queue during transfer */
+
+=09/* Warning: The following fields are not protected by a mutex.
+=09 * They can only be changed before a transfer starts or after
+=09 * a transfer ends.  During a transfer the isr will fiddle with
+=09 * them */
+=09int rx_count;=09=09/* remaining bytes to be received */
+=09uint8_t *rx_ptr;=09/* pointer for next RX character */
+};
+#define to_spi_port(bus) container_of(bus, struct
mpc52xx_psc_spi_port, spi_bus);
+
+struct mpc52xx_psc_spi_port mpc52xx_psc_spi_ports[MPC52xx_PSC_MAXNUM];
+
+
+/* Dynamically update the alarm level so interrupts don't occur too fast *=
/
+static void mpc52xx_psc_spi_adjust_alarm(struct mpc52xx_psc_spi_port *port=
)
+{
+=09struct mpc52xx_psc __iomem *psc =3D port->psc;
+=09int alarm;
+
+=09alarm =3D 0x200 - port->rx_count;
+=09if (alarm < 0) alarm =3D 0;
+=09if (alarm > 0x1ff) alarm =3D 0x1ff;
+=09out_be16(&psc->rfalarm, alarm);
+}
+
+static irqreturn_t
+mpc52xx_psc_spi_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+=09struct mpc52xx_psc_spi_port *port =3D (struct uart_port *)dev_id;
+=09struct mpc52xx_psc __iomem *psc =3D port->psc;
+=09int num, i;
+
+=09if ( irq !=3D port->irq ) {
+=09=09printk( KERN_WARNING "mpc52xx_psc_spi: " \
+=09=09        "Received wrong int %d. Waiting for %d\n",
+=09=09       irq, port->irq);
+=09=09return IRQ_NONE;
+=09}
+=09
+=09if (in_be16(&psc->mpc52xx_psc_isr) & MPC52xx_PSC_IMR_RXRDY)
+=09{
+=09=09num =3D in_be16(&psc->rfnum);
+
+=09=09/* Discard unexpected rx data */
+=09=09if ((!port->rx_count) || (!port->rx_ptr))
+=09=09{
+=09=09=09printk(KERN_WARNING "mpc52xx_psc_spi: "
+=09=09=09=09"discarding %i unexpected bytes\n", num);
+=09=09=09for (i =3D 0; i < num; i++)
+=09=09=09=09in_8(&psc->mpc52xx_psc_buffer_8);
+=09=09=09return IRQ_NONE;
+=09=09}
+
+=09=09/* Don't overflow the buffer */
+=09=09if (num > port->rx_count)
+=09=09=09num =3D port->rx_count;
+
+=09=09/* Transfer data into rx buffer */
+=09=09ioread8_rep(&psc->mpc52xx_psc_buffer_8, port->rx_ptr, num);
+=09=09port->rx_ptr +=3D num;
+=09=09port->rx_count -=3D num;
+
+=09=09/* Dynamically update the alarm level so interrupts don't
+=09=09 * occur too frequently */
+=09=09mpc52xx_psc_spi_adjust_alarm(port);
+
+=09=09/* Only wakeup process if data transfer is complete */
+=09=09if (port->rx_count =3D=3D 0)
+=09=09=09wake_up_interruptible(&port->wait_queue);
+=09}
+
+=09return IRQ_NONE;
+}
+
+static int mpc52xx_psc_spi_startup(struct mpc52xx_psc_spi_port *port)
+{
+=09int ret;
+=09struct mpc52xx_psc __iomem *psc =3D port->psc;
+
+=09ret =3D request_irq(port->irq, mpc52xx_psc_spi_isr,
+=09=09SA_INTERRUPT | SA_SAMPLE_RANDOM, "mpc52xx_psc_spi", port);
+=09if (ret)
+=09{
+=09=09printk(KERN_ALERT "mpc52xx_psc_spi: request_irq failed (%i)\n",
+=09=09=09ret);
+=09=09return ret;
+=09}
+
+=09init_MUTEX(&port->sema);
+=09init_waitqueue_head(&port->wait_queue);
+=09port->rx_count =3D 0;
+=09port->rx_ptr =3D NULL;
+
+=09/* Reset the PSC into a known state */
+=09out_8(&psc->command, MPC52xx_PSC_RST_RX);
+=09out_8(&psc->command, MPC52xx_PSC_RST_TX);
+=09out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+
+=09/* Interrupts must be based on alarm levels */
+=09out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
+=09out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
+
+=09/* Configure 8bit codec mode as an SPI master and use EOF flags */
+=09out_be32(&psc->sicr, MPC52xx_PSC_SICR_SIM_CODEC8 |
+=09                     MPC52xx_PSC_SICR_GENCLK |
+=09                     MPC52xx_PSC_SICR_SPI |
+=09                     MPC52xx_PSC_SICR_MSTR |
+=09                     MPC52xx_PSC_SICR_USEEOF );
+=09out_be16(&psc->ccr, 0x070F);
+
+=09/* Set 2ms DTL delay */
+=09out_8(&psc->ctur, 0x00);
+=09out_8(&psc->ctlr, 0x84);
+}
+
+static int mpc52xx_psc_spi_transfer(struct spi_bus *bus, int id, int clked=
ge,
+=09=09=09=09uint8_t *in, const uint8_t *out, size_t count)
+{
+=09struct mpc52xx_psc_spi_port *port;
+=09struct mpc52xx_psc __iomem *psc;
+=09uint32_t=09sicr;
+=09int err;
+
+=09port =3D to_spi_port(bus);
+=09psc =3D port->psc;
+
+=09//printk(KERN_ALERT "mpc52xx_psc_spi: transfer; count=3D%i\n", count);
+
+=09if (count < 1)
+=09=09return -1;
+
+=09/* Grab the semaphore, only one transfer allowed at a time */
+=09err =3D down_interruptible(&port->sema);
+=09if (err)
+=09=09return err;
+
+=09/* Disable SPI interrupts so rx buffer can be manipulated */
+=09out_be16(&psc->mpc52xx_psc_imr, 0);
+
+=09/* Set the clock polarity */
+=09sicr =3D in_be32(&psc->sicr);
+=09if (clkedge =3D=3D SPI_CLKEDGE_RISING)
+=09=09sicr &=3D ~MPC52xx_PSC_SICR_CPOL; /* Clear means rising edge */
+=09else
+=09=09sicr |=3D MPC52xx_PSC_SICR_CPOL; /* Set means falling edge */
+=09out_be32(&psc->sicr, sicr);
+
+=09/* Initialize the receive buffer; this can be done without locking
+=09 * because the ISR doesn't touch it until after interrupts are
+=09 * enabled
+=09 */
+=09port->rx_ptr =3D in;
+=09port->rx_count =3D count;
+=09mpc52xx_psc_spi_adjust_alarm(port);
+
+=09/* Select the slave, start the engine and transfer data to fifo */
+=09spi_mpc52xx_psc_slave_select(port->pdev->id, id);
+=09iowrite8(MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE, &psc->command);
+=09if (count > 1)
+=09=09iowrite8_rep(&psc->mpc52xx_psc_buffer_8, out, count-1);
+
+=09/* Signal EOF for the last byte to terminate the transfer */
+=09iowrite8(MPC52xx_PSC_IRCR2_NXTEOF, &psc->ircr2);
+=09iowrite8(out[count-1], &psc->mpc52xx_psc_buffer_8);
+
+=09/* Enable interrupts and go to sleep until transfer is complete*/
+=09out_be16(&psc->mpc52xx_psc_imr, MPC52xx_PSC_IMR_RXRDY);
+=09err =3D wait_event_interruptible(port->wait_queue, port->rx_count =3D=
=3D 0);
+
+=09/* Terminate the transfer, and deselect the slave */
+=09port->rx_ptr =3D NULL;
+=09out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+=09spi_mpc52xx_psc_slave_deselect(port->pdev->id);
+
+=09/* Release the semaphore to allow other transfers */
+=09up(&port->sema);
+=09return err;
+}
+
+static struct spi_bus_ops mpc52xx_psc_spi_ops =3D {
+=09.transfer =3D mpc52xx_psc_spi_transfer,
+};
+
+static int __devinit
+mpc52xx_psc_spi_probe(struct device *dev)
+{
+=09struct platform_device *pdev =3D to_platform_device(dev);
+=09struct resource *res =3D pdev->resource;
+=09struct mpc52xx_psc_spi_port *port;
+=09int idx =3D pdev->id;
+=09int i;
+
+=09printk(KERN_ALERT "mpc52xx-psc-spi: probing idx=3D%i\n", idx);
+
+=09if ((idx !=3D 0) && (idx !=3D 1) && (idx !=3D2) && (idx !=3D 5))
+=09{
+=09=09printk(KERN_ALERT "mpc52xx-psc-spi: PSC%i can't do SPI\n",
+=09=09       idx+1);
+=09=09return -ENODEV;
+=09}
+
+=09port =3D &mpc52xx_psc_spi_ports[idx];
+=09port->pdev =3D pdev;
+=09for (i =3D 0; i < pdev->num_resources; i++, res++)
+=09{
+=09=09if (res->flags & IORESOURCE_MEM)
+=09=09=09port->psc =3D (struct mpc52xx_psc __iomem *) res->start;
+=09=09else if (res->flags & IORESOURCE_IRQ)
+=09=09=09port->irq =3D res->start;
+=09}
+
+=09mpc52xx_psc_spi_startup(port);
+=09port->spi_bus.ops =3D &mpc52xx_psc_spi_ops;
+=09port->spi_bus.dev.parent =3D dev;  /* The psc is the parent of the bus =
*/
+=09spi_bus_register(&port->spi_bus);
+
+=09/* Ahhh!!! Run away from the board specific hack (This won't be=20
+=09 * part of the real patch)
+=09 */
+=09spi_device_create(&port->spi_bus, "ks8995m_spi", 0);
+=09spi_device_create(&port->spi_bus, "tlv320aic26", 1);
+=09return 0;
+}
+
+static int=20
+mpc52xx_psc_spi_remove(struct device *dev)
+{
+=09return 0;
+}
+
+static struct device_driver mpc52xx_psc_spi_platform_driver =3D {
+=09.name=09=09=3D "mpc52xx-psc:spi",
+=09.bus=09=09=3D &platform_bus_type,
+=09.probe=09=09=3D mpc52xx_psc_spi_probe,
+=09.remove=09=09=3D mpc52xx_psc_spi_remove,
+};
+
+static int __init mpc52xx_psc_spi_init(void)
+{
+=09int ret;
+
+=09printk(KERN_ALERT "mpc52xx_psc_spi: initializing\n");
+
+=09ret =3D driver_register(&mpc52xx_psc_spi_platform_driver);
+=09return ret;
+
+
+}
+
+static void __exit mpc52xx_psc_spi_exit(void)
+{
+=09driver_unregister(&mpc52xx_psc_spi_platform_driver);
+=09printk(KERN_ALERT "mpc52xx_psc_spi: exiting\n");
+}
+
+module_init(mpc52xx_psc_spi_init);
+module_exit(mpc52xx_psc_spi_exit);
+
+MODULE_AUTHOR("Grant Likely <glikely@gmail.com>");
+MODULE_DESCRIPTION("Freescale MPC52xx PSC driver for SPI mode");
+MODULE_LICENSE("Dual BSD/GPL");
diff -ruNp linux-spi/include/asm-ppc/mpc52xx.h
linux-spi-mpc5200/include/asm-ppc/mpc52xx.h
--- linux-spi/include/asm-ppc/mpc52xx.h=092005-06-17 15:48:29.000000000 -04=
00
+++ linux-spi-mpc5200/include/asm-ppc/mpc52xx.h=092005-07-23
02:29:41.000000000 -0400
@@ -146,6 +146,28 @@ enum ppc_sys_devices {
 #define MPC52xx_XLB_ARB_IRQ=09=09(MPC52xx_PERP_IRQ_BASE + 21)
 #define MPC52xx_BDLC_IRQ=09=09(MPC52xx_PERP_IRQ_BASE + 22)
=20
+/* CDM Cloke enable bits */
+#define MPC52xx_CDM_CLKENABLE_MEM_CLK=09=09(0x00080000)
+#define MPC52xx_CDM_CLKENABLE_PCI_CLK=09=09(0x00040000)
+#define MPC52xx_CDM_CLKENABLE_LPC_CLK=09=09(0x00020000)
+#define MPC52xx_CDM_CLKENABLE_SIT_CLK=09=09(0x00010000)
+#define MPC52xx_CDM_CLKENABLE_SCOM_CLK=09=09(0x00008000)
+#define MPC52xx_CDM_CLKENABLE_ATA_CLK=09=09(0x00004000)
+#define MPC52xx_CDM_CLKENABLE_ETH_CLK=09=09(0x00002000)
+#define MPC52xx_CDM_CLKENABLE_USB_CLK=09=09(0x00001000)
+#define MPC52xx_CDM_CLKENABLE_SPI_CLK=09=09(0x00000800)
+#define MPC52xx_CDM_CLKENABLE_BDLC_CLK=09=09(0x00000400)
+#define MPC52xx_CDM_CLKENABLE_IRRX_CLK=09=09(0x00000200)
+#define MPC52xx_CDM_CLKENABLE_IRTX_CLK=09=09(0x00000100)
+#define MPC52xx_CDM_CLKENABLE_PSC345_CLK=09(0x00000080)
+#define MPC52xx_CDM_CLKENABLE_PSC2_CLK=09=09(0x00000040)
+#define MPC52xx_CDM_CLKENABLE_PSC1_CLK=09=09(0x00000020)
+#define MPC52xx_CDM_CLKENABLE_PSC6_CLK=09=09(0x00000010)
+#define MPC52xx_CDM_CLKENABLE_MSCAN_CLK=09=09(0x00000008)
+#define MPC52xx_CDM_CLKENABLE_I2C_CLK=09=09(0x00000004)
+#define MPC52xx_CDM_CLKENABLE_TIMER_CLK=09=09(0x00000002)
+#define MPC52xx_CDM_CLKENABLE_GPIO_CLK=09=09(0x00000001)
+
=20
=20
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
@@ -266,6 +288,49 @@ struct mpc52xx_rtc {
 };
=20
 /* GPIO */
+#define PORT_CONFIG_CS1=09=09=090x80000000
+#define PORT_CONFIG_ALT_MASK=09=090x30000000
+#define PORT_CONFIG_CS7=09=09=090x08000000
+#define PORT_CONFIG_CS6=09=09=090x04000000
+#define PORT_CONFIG_ATA=09=09=090x03000000
+#define PORT_CONFIG_IR_USB_CLK=09=090x00800000
+#define PORT_CONFIG_IRDA_MASK=09=090x00700000 /* PSC6 */
+#define PORT_CONFIG_IRDA_GPIO=09=090x00000000
+#define PORT_CONFIG_IRDA_UART=09=090x00500000
+#define PORT_CONFIG_IRDA_CODEC=09=090x00700000
+#define PORT_CONFIG_ETHER_MASK=09=090x000F0000
+#define PORT_CONFIG_PCI_DIS=09=090x00008000
+#define PORT_CONFIG_USB_SE=09=090x00004000 /* Single ended mode */
+#define PORT_CONFIG_USB_MASK=09=090x00004000 /* (USB1 or 2 UARTs) */
+#define PORT_CONFIG_USB_USB=09=090x00001000
+#define PORT_CONFIG_USB_2UART=09=090x00002000
+#define PORT_CONFIG_PSC3_MASK=09=090x00000F00
+#define PORT_CONFIG_PSC3_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC3_USB2=09=090x00000100
+#define PORT_CONFIG_PSC3_UART=09=090x00000400
+#define PORT_CONFIG_PSC3_UARTE_CD=090x00000500
+#define PORT_CONFIG_PSC3_CODEC=09=090x00000600
+#define PORT_CONFIG_PSC3_CODEC_MCLK=090x00000700
+#define PORT_CONFIG_PSC3_SPI=09=090x00000800
+#define PORT_CONFIG_PSC3_SPI_UART=090x00000C00
+#define PORT_CONFIG_PSC3_SPI_UARTE=090x00000D00
+#define PORT_CONFIG_PSC3_SPI_CODEC=090x00000E00
+#define PORT_CONFIG_PSC2_MASK=09=090x00000070
+#define PORT_CONFIG_PSC2_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC2_CAN=09=090x00000010
+#define PORT_CONFIG_PSC2_AC97=09=090x00000020
+#define PORT_CONFIG_PSC2_UART=09=090x00000040
+#define PORT_CONFIG_PSC2_UARTE_CD=090x00000050
+#define PORT_CONFIG_PSC2_CODEC=09=090x00000060
+#define PORT_CONFIG_PSC2_CODEC_MCLK=090x00000070
+#define PORT_CONFIG_PSC1_MASK=09=090x00000007
+#define PORT_CONFIG_PSC1_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC1_AC97=09=090x00000002
+#define PORT_CONFIG_PSC1_UART=09=090x00000004
+#define PORT_CONFIG_PSC1_UARTE_CD=090x00000005
+#define PORT_CONFIG_PSC1_CODEC=09=090x00000006
+#define PORT_CONFIG_PSC1_CODEC_MCLK=090x00000007
+
 struct mpc52xx_gpio {
 =09u32=09port_config;=09/* GPIO + 0x00 */
 =09u32=09simple_gpioe;=09/* GPIO + 0x04 */
diff -ruNp linux-spi/include/asm-ppc/mpc52xx_psc.h
linux-spi-mpc5200/include/asm-ppc/mpc52xx_psc.h
--- linux-spi/include/asm-ppc/mpc52xx_psc.h=092005-06-17 15:48:29.000000000=
 -0400
+++ linux-spi-mpc5200/include/asm-ppc/mpc52xx_psc.h=092005-07-22
17:16:13.000000000 -0400
@@ -72,6 +72,51 @@
 #define MPC52xx_PSC_D_CTS=09=090x10
 #define MPC52xx_PSC_D_DCD=09=090x20
=20
+/* PSC Serial Interface Control Register (SICR) bits */
+/* SICR Field masks */
+#define MPC52xx_PSC_SICR_ACRB=09=090x80000000
+#define MPC52xx_PSC_SICR_AWR=09=090x40000000
+#define MPC52xx_PSC_SICR_DTS1=09=090x20000000
+#define MPC52xx_PSC_SICR_SHDIR=09=090x10000000
+#define MPC52xx_PSC_SICR_SIM=09=090x0F000000
+#define MPC52xx_PSC_SICR_GENCLK=09=090x00800000
+#define MPC52xx_PSC_SICR_MULTIWD=090x00400000
+#define MPC52xx_PSC_SICR_CLKPOL=09=090x00200000
+#define MPC52xx_PSC_SICR_SYNCPOL=090x00100000
+#define MPC52xx_PSC_SICR_CELLSLAVE=090x00080000
+#define MPC52xx_PSC_SICR_CELL2XCLK=090x00040000
+#define MPC52xx_PSC_SICR_SPI=09=090x00008000
+#define MPC52xx_PSC_SICR_MSTR=09=090x00004000
+#define MPC52xx_PSC_SICR_CPOL=09=090x00002000
+#define MPC52xx_PSC_SICR_CPHA=09=090x00001000
+#define MPC52xx_PSC_SICR_USEEOF=09=090x00000800
+/* Operation modes */
+#define MPC52xx_PSC_SICR_SIM_UART=09=090x00000000
+#define MPC52xx_PSC_SICR_SIM_UART_DCD=09=090x08000000
+#define MPC52xx_PSC_SICR_SIM_CODEC8=09=090x01000000
+#define MPC52xx_PSC_SICR_SIM_CODEC16=09=090x02000000
+#define MPC52xx_PSC_SICR_SIM_AC97=09=090x03000000
+#define MPC52xx_PSC_SICR_SIM_SIR=09=090x04000000
+#define MPC52xx_PSC_SICR_SIM_SIR_DCD=09=090x0C000000
+#define MPC52xx_PSC_SICR_SIM_MIR=09=090x05000000
+#define MPC52xx_PSC_SICR_SIM_FIR=09=090x06000000
+#define MPC52xx_PSC_SICR_SIM_CODEC24=09=090x07000000
+#define MPC52xx_PSC_SICR_SIM_CODEC32=09=090x0F000000
+
+/* IRCR1 bit masks */
+#define MPC52xx_PSC_IRCR1_FD=09=09=090x04
+#define MPC52xx_PSC_IRCR1_SIPEN=09=09=090x02
+#define MPC52xx_PSC_IRCR1_SPUL=09=09=090x01
+
+/* IRCR2 bit masks */
+#define MPC52xx_PSC_IRCR2_SIPREQ=09=090x04
+#define MPC52xx_PSC_IRCR2_ABORT=09=09=090x02
+#define MPC52xx_PSC_IRCR2_NXTEOF=09=090x01
+
+/* Codec Clock Register fields */
+#define MPC52xx_PSC_CCR_FRAME_SYNC_DIV=09=090xFF00
+#define MPC52xx_PSC_CCR_BIT_CLK_DIV=09=090xFF00
+
 /* PSC mode fields */
 #define MPC52xx_PSC_MODE_5_BITS=09=09=090x00
 #define MPC52xx_PSC_MODE_6_BITS=09=09=090x01
@@ -187,5 +232,10 @@ struct mpc52xx_psc {
 =09u16=09=09tflwfptr;=09/* PSC + 0x9e */
 };
=20
+#if defined(CONFIG_SPI_BUS_MPC52XX_PSC) ||
defined(CONFIG_SPI_BUS_MPC52XX_PSC_MODULE)
+/* Helper functions for selecting slaves SPI mode */
+extern void spi_mpc52xx_psc_slave_select(int psc_id, int slave_id);
+extern void spi_mpc52xx_psc_slave_deselect(int psc_id);
+#endif
=20
 #endif  /* __ASM_MPC52xx_PSC_H__ */
