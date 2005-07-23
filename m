Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 9E54167D60
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:17:29 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i25so621263wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 07:17:27 -0700 (PDT)
Message-ID: <528646bc0507230717502d172d@mail.gmail.com>
Date: Sat, 23 Jul 2005 10:17:27 -0400
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 3/3] support for ks8995m managed switch on the SPI bus
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

Add support for reading and writing Micrel ks8995m managed switch
register set from user space over the SPI bus.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

diff -ruNp linux-spi-mpc5200/drivers/spi/Kconfig
linux-spi-mpc5200-ks8995m/drivers/spi/Kconfig
--- linux-spi-mpc5200/drivers/spi/Kconfig=092005-07-22 17:16:13.000000000 -=
0400
+++ linux-spi-mpc5200-ks8995m/drivers/spi/Kconfig=092005-07-23
02:59:02.000000000 -0400
@@ -30,5 +30,12 @@ config SPI_BUS_MPC52XX_PSC
 comment "SPI slaves"
 =09depends on SPI
=20
+config KS8995M
+=09tristate "Micrel/Kendin KS8995M Ethernet Switch SPI interface driver"
+=09depends on SPI
+=09help
+=09  Say Y here if you need to control a Kendin/Micrel KS8995M managed
+=09  Ethernet switch via the SPI interface.
+
 endmenu
=20
diff -ruNp linux-spi-mpc5200/drivers/spi/Makefile
linux-spi-mpc5200-ks8995m/drivers/spi/Makefile
--- linux-spi-mpc5200/drivers/spi/Makefile=092005-07-22 17:16:13.000000000 =
-0400
+++ linux-spi-mpc5200-ks8995m/drivers/spi/Makefile=092005-07-23
02:59:02.000000000 -0400
@@ -4,3 +4,4 @@
=20
 obj-$(CONFIG_SPI)=09=09=09+=3D spi-core.o
 obj-$(CONFIG_SPI_BUS_MPC52XX_PSC)=09+=3D spi-mpc52xx-psc.o
+obj-$(CONFIG_KS8995M)=09=09=09+=3D ks8995m.o
diff -ruNp linux-spi-mpc5200/drivers/spi/ks8995m.c
linux-spi-mpc5200-ks8995m/drivers/spi/ks8995m.c
--- linux-spi-mpc5200/drivers/spi/ks8995m.c=091969-12-31 19:00:00.000000000=
 -0500
+++ linux-spi-mpc5200-ks8995m/drivers/spi/ks8995m.c=092005-07-23
03:10:37.000000000 -0400
@@ -0,0 +1,237 @@
+/*
+ * drivers/spi/ks8995m-spi.c
+ *
+ * Micrel/Kendin KS8995M managed switch SPI interface driver
+ *
+ * Maintainer : Grant Likely <glikely@gmail.com>
+ *
+ * This file is in the public domain
+ */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/interrupt.h>
+#include <linux/spi.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+#define KS8995M_NUM_REGS  (128)
+
+struct ks8995m_data {
+=09struct cdev cdev;
+=09struct spi_device *spi_dev;
+=09uint8_t in_buff[KS8995M_NUM_REGS+2];
+=09uint8_t out_buff[KS8995M_NUM_REGS+2];
+};
+
+static int ks8995m_major;
+static int ks8995m_minor;
+static int ks8995m_minor_offset =3D 0;
+
+/* Forward method declarations for cdev */
+static int ks8995m_open(struct inode *inode, struct file *filp);
+static ssize_t ks8995m_read(struct file *filp, char __user *buff,
+=09=09=09=09size_t count, loff_t *offp);
+static ssize_t ks8995m_write(struct file *filp, const char __user *buff,
+=09=09=09=09size_t count, loff_t *offp);
+static int ks8995m_release(struct inode *inode, struct file *filp);
+
+static struct file_operations ks8995m_fops =3D {
+=09.owner =3D THIS_MODULE,
+=09.open =3D ks8995m_open,
+=09.read =3D ks8995m_read,
+=09.write =3D ks8995m_write,
+=09.release =3D ks8995m_release,
+};
+
+static int ks8995m_open(struct inode *inode, struct file *filp)
+{
+=09struct ks8995m_data *data =3D container_of(inode->i_cdev, struct
ks8995m_data, cdev);
+
+=09/* Private data is always set to the ks8995m_data structure */
+=09filp->private_data =3D data;
+=09return 0;
+}
+
+static ssize_t ks8995m_check_size(int start, int count)
+{
+=09if ((count < 1) || (start > KS8995M_NUM_REGS))
+=09=09return 0;
+
+=09if (start + count > KS8995M_NUM_REGS)
+=09=09count =3D KS8995M_NUM_REGS - start;
+
+=09return count;
+}
+
+static ssize_t ks8995m_read(struct file *filp, char __user *buff,
+=09=09=09=09size_t count, loff_t *offp)
+{
+=09struct ks8995m_data *data =3D filp->private_data;
+=09struct spi_bus *bus;
+=09int ret;
+
+=09count =3D ks8995m_check_size(*offp, count);
+=09if (!count)
+=09=09return 0;
+
+=09data->out_buff[0] =3D 0x03; /* read command */
+=09data->out_buff[1] =3D *offp; /* address */
+=09memset(&data->out_buff[2], 0, count);
+
+=09bus =3D to_spi_bus(data->spi_dev->dev.parent);
+
+=09ret =3D bus->ops->transfer(bus, data->spi_dev->id, SPI_CLKEDGE_RISING,
+=09=09=09=09data->in_buff, data->out_buff, count+2);
+=09if (ret)
+=09=09return ret;
+
+=09copy_to_user(buff, &data->in_buff[2], count);
+=09*offp +=3D count;
+
+=09return count;
+}
+
+static ssize_t ks8995m_write(struct file *filp, const char __user *buff,
+=09=09=09=09size_t count, loff_t *offp)
+{
+=09struct ks8995m_data *data =3D filp->private_data;
+=09struct spi_bus *bus;
+=09int ret;
+
+=09count =3D ks8995m_check_size(*offp, count);
+=09if (!count)
+=09=09return 0;
+
+=09data->out_buff[0] =3D 0x02; /* write command */
+=09data->out_buff[1] =3D *offp; /* address */
+=09copy_from_user(&data->out_buff[2], buff, count);
+
+=09bus =3D to_spi_bus(data->spi_dev->dev.parent);
+
+=09ret =3D bus->ops->transfer(bus, data->spi_dev->id, SPI_CLKEDGE_RISING,
+=09=09=09=09data->in_buff, data->out_buff, count+2);
+=09if (ret)
+=09=09return ret;
+
+=09*offp +=3D count;
+
+=09return count;
+}
+
+static int ks8995m_release(struct inode *inode, struct file *filp)
+{
+=09return 0;
+}
+
+static int ks8995m_probe (struct device *dev)
+{
+=09struct ks8995m_data *data;
+=09struct spi_device *spi_dev;
+=09int devno, err;
+
+=09spi_dev =3D to_spi_dev(dev);
+=09printk("ks8995m_probe(dev->bus_id=3D%s) (name=3D%s)\n",
+=09=09dev->bus_id, spi_dev->name);
+
+=09data =3D kmalloc(sizeof(struct ks8995m_data), GFP_KERNEL);
+=09if (!data)
+=09{
+=09=09printk(KERN_ALERT "Could not allocate driver memory\n");
+=09=09return -ENOMEM;
+=09}
+=09memset(data, 0, sizeof(struct ks8995m_data));
+
+=09dev->driver_data =3D data;
+
+=09data->spi_dev =3D spi_dev;
+=09cdev_init(&data->cdev, &ks8995m_fops);
+=09data->cdev.owner =3D THIS_MODULE;
+=09data->cdev.ops =3D &ks8995m_fops;
+
+=09devno =3D MKDEV(ks8995m_major, ks8995m_minor + ks8995m_minor_offset++);
+=09err =3D cdev_add(&data->cdev, devno, 1);
+=09if (err)
+=09{
+=09=09printk(KERN_INFO "ks8995m: could not register char dev\n");
+=09=09return -1;
+=09}
+
+=09return 0;
+}
+
+static int ks8995m_remove (struct device *dev)
+{
+=09struct ks8995m_data *data =3D dev->driver_data;
+
+=09printk("ks8995_spi_remove(dev->bus_id=3D%s)\n", dev->bus_id);
+
+=09cdev_del(&data->cdev);
+=09kfree(data);
+=09dev->driver_data =3D NULL;
+
+=09return 0;
+}
+
+static struct spi_driver ks8995m_driver =3D {
+=09.name =3D "ks8995m",
+=09.module =3D THIS_MODULE,
+=09.driver =3D {
+=09=09.probe =3D ks8995m_probe,
+=09=09.remove =3D ks8995m_remove,
+=09},
+};
+
+static int __init ks8995m_init(void)
+{
+=09dev_t dev;
+=09int ret;
+
+=09printk(KERN_ALERT "ks8995m: initializing\n");
+
+=09if (alloc_chrdev_region(&dev, 0, 128, "ks8995m"))
+=09{
+=09=09printk(KERN_ALERT "ks8995m: could not allocate chrdev\n");
+=09=09goto fail_alloc_chrdev;
+=09}
+=09ks8995m_major =3D MAJOR(dev);
+=09ks8995m_minor =3D MINOR(dev);
+
+=09printk(KERN_ALERT "ks8995m: allocated chrdev region (%i:%i)!\n",
+=09       ks8995m_major, ks8995m_minor);
+
+=09ret =3D spi_driver_register(&ks8995m_driver);
+=09if (ret)
+=09{
+=09=09printk(KERN_ALERT "ks8995m: could not register driver\n");
+=09=09goto fail_register;
+=09}
+
+
+=09return 0;
+
+fail_register:
+
+fail_alloc_chrdev:
+=09return -1;
+}
+
+static void __exit ks8995m_exit(void)
+{
+=09int devno =3D MKDEV(ks8995m_major, ks8995m_minor);
+
+=09spi_driver_unregister(&ks8995m_driver);
+=09unregister_chrdev_region(devno, 128);
+
+=09printk(KERN_ALERT "ks8995m: exiting\n");
+}
+
+module_init(ks8995m_init);
+module_exit(ks8995m_exit);
+
+MODULE_AUTHOR("Grant Likely <glikely@gmail.com>");
+MODULE_DESCRIPTION("SPI register interface for ks8995m managed switch");
+MODULE_LICENSE("Dual BSD/GPL");
