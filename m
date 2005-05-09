Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id DDB3667B1F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:01:18 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j49C5q1j007078
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 15:05:55 +0300 (EEST)
Message-ID: <427F4D41.10908@intracom.gr>
Date: Mon, 09 May 2005 14:45:05 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
	Eugene Surovegin <ebs@ebshome.net>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------050001050200000802000403"
Subject: [PATCH  04/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050001050200000802000403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

The following patch is a combined FCC/FEC ethernet driver
for the Freescale line of PowerQUICCs.

FECs on 8xx and FCCs on 82xx are supported.

This part of the patch contains the mii drivers.

Regards

Pantelis

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------050001050200000802000403
Content-Type: text/x-patch;
 name="fs_enet-04.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-04.patch"

--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mii-bitbang.c
@@ -0,0 +1,394 @@
+/*
+ * XXX blah blah
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+#ifdef CONFIG_8xx
+static int bitbang_prep_bit(__u8 **dirp, __u8 **datp, __u8 *mskp, int port, int bit)
+{
+	immap_t *im = (immap_t *)IMAP_ADDR;
+	void *dir, *dat, *ppar;
+	int adv;
+	__u8 msk;
+
+	switch (port) {
+		case fsiop_porta:
+			dir = &im->im_ioport.iop_padir;
+			dat = &im->im_ioport.iop_padat;
+			ppar = &im->im_ioport.iop_papar;
+			break;
+
+		case fsiop_portb:
+			dir = &im->im_cpm.cp_pbdir;
+			dat = &im->im_cpm.cp_pbdat;
+			ppar = &im->im_cpm.cp_pbpar;
+			break;
+
+		case fsiop_portc:
+			dir = &im->im_ioport.iop_pcdir;
+			dat = &im->im_ioport.iop_pcdat;
+			ppar = &im->im_ioport.iop_pcpar;
+			break;
+
+		case fsiop_portd:
+			dir = &im->im_ioport.iop_pddir;
+			dat = &im->im_ioport.iop_pddat;
+			ppar = &im->im_ioport.iop_pdpar;
+			break;
+
+		case fsiop_porte:
+			dir = &im->im_cpm.cp_pedir;
+			dat = &im->im_cpm.cp_pedat;
+			ppar = &im->im_cpm.cp_pepar;
+			break;
+
+		default:
+			printk(KERN_ERR DRV_MODULE_NAME
+			       "Illegal port value %d!\n", port);
+			return -EINVAL;
+	}
+
+	adv = bit >> 3;
+	dir = (char *)dir + adv;
+	dat = (char *)dat + adv;
+	ppar = (char *)ppar + adv;
+
+	msk = 1 << (7 - (bit & 7));
+	if ((in_8(ppar) & msk) != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       "pin %d on port %d is not general purpose!\n", bit, port);
+		return -EINVAL;
+	}
+
+	*dirp = dir;
+	*datp = dat;
+	*mskp = msk;
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_8260
+static int bitbang_prep_bit(__u8 **dirp, __u8 **datp, __u8 *mskp, int port, int bit)
+{
+	iop_cpm2_t *io = &((cpm2_map_t *)CPM_MAP_ADDR)->im_ioport;
+	void *dir, *dat, *ppar;
+	int adv;
+	__u8 msk;
+
+	switch (port) {
+		case fsiop_porta:
+			dir = &io->iop_pdira;
+			dat = &io->iop_pdata;
+			ppar = &io->iop_ppara;
+			break;
+
+		case fsiop_portb:
+			dir = &io->iop_pdirb;
+			dat = &io->iop_pdatb;
+			ppar = &io->iop_pparb;
+			break;
+
+		case fsiop_portc:
+			dir = &io->iop_pdirc;
+			dat = &io->iop_pdatc;
+			ppar = &io->iop_pparc;
+			break;
+
+		case fsiop_portd:
+			dir = &io->iop_pdird;
+			dat = &io->iop_pdatd;
+			ppar = &io->iop_ppard;
+			break;
+
+		default:
+			printk(KERN_ERR DRV_MODULE_NAME
+			       "Illegal port value %d!\n", port);
+			return -EINVAL;
+	}
+
+	adv = bit >> 3;
+	dir = (char *)dir + adv;
+	dat = (char *)dat + adv;
+	ppar = (char *)ppar + adv;
+
+	msk = 1 << (7 - (bit & 7));
+	if ((in_8(ppar) & msk) != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       "pin %d on port %d is not general purpose!\n", bit, port);
+		return -EINVAL;
+	}
+
+	*dirp = dir;
+	*datp = dat;
+	*mskp = msk;
+
+	return 0;
+}
+#endif
+
+static inline void bb_set(__u8 *p, __u8 m)
+{
+	out_8(p, in_8(p) | m);
+}
+
+static inline void bb_clr(__u8 *p, __u8 m)
+{
+	out_8(p, in_8(p) & ~m);
+}
+
+static inline int bb_read(__u8 *p, __u8 m)
+{
+	return (in_8(p) & m) != 0;
+}
+
+static inline void mdio_active(struct fs_enet_mii_bus *bus)
+{
+	bb_set(bus->bitbang.mdio_dir, bus->bitbang.mdio_msk);
+}
+
+static inline void mdio_tristate(struct fs_enet_mii_bus *bus)
+{
+	bb_clr(bus->bitbang.mdio_dir, bus->bitbang.mdio_msk);
+}
+
+static inline int mdio_read(struct fs_enet_mii_bus *bus)
+{
+	return bb_read(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+}
+
+static inline void mdio(struct fs_enet_mii_bus *bus, int what)
+{
+	if (what)
+		bb_set(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+	else
+		bb_clr(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+}
+
+static inline void mdc(struct fs_enet_mii_bus *bus, int what)
+{
+	if (what)
+		bb_set(bus->bitbang.mdc_dat, bus->bitbang.mdc_msk);
+	else
+		bb_clr(bus->bitbang.mdc_dat, bus->bitbang.mdc_msk);
+}
+
+static inline void mii_delay(struct fs_enet_mii_bus *bus)
+{
+	udelay(bus->bus_info->i.bitbang.delay);
+}
+
+/* Utility to send the preamble, address, and register (common to read and write). */
+static void bitbang_pre(struct fs_enet_mii_bus *bus, int read, __u8 addr, __u8 reg)
+{
+	int j;
+
+	/*
+	 * Send a 32 bit preamble ('1's) with an extra '1' bit for good measure.
+	 * The IEEE spec says this is a PHY optional requirement.  The AMD
+	 * 79C874 requires one after power up and one after a MII communications
+	 * error.  This means that we are doing more preambles than we need,
+	 * but it is safer and will be much more robust.
+	 */
+
+	mdio_active(bus);
+	mdio(bus, 1);
+	for (j = 0; j < 32; j++) {
+		mdc(bus, 0);
+		mii_delay(bus);
+		mdc(bus, 1);
+		mii_delay(bus);
+	}
+
+	/* send the start bit (01) and the read opcode (10) or write (10) */
+	mdc(bus, 0);
+	mdio(bus, 0);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 0);
+	mdio(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 0);
+	mdio(bus, read);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 0);
+	mdio(bus, !read);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+
+	/* send the PHY address */
+	for (j = 0; j < 5; j++) {
+		mdc(bus, 0);
+		mdio(bus, (addr & 0x10) != 0);
+		mii_delay(bus);
+		mdc(bus, 1);
+		mii_delay(bus);
+		addr <<= 1;
+	}
+
+	/* send the register address */
+	for (j = 0; j < 5; j++) {
+		mdc(bus, 0);
+		mdio(bus, (reg & 0x10) != 0);
+		mii_delay(bus);
+		mdc(bus, 1);
+		mii_delay(bus);
+		reg <<= 1;
+	}
+}
+
+static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
+{
+	__u16 rdreg;
+	int ret, j;
+	__u8 addr = phy_id & 0xff;
+	__u8 reg = location & 0xff;
+
+	bitbang_pre(bus, 1, addr, reg);
+
+	/* tri-state our MDIO I/O pin so we can read */
+	mdc(bus, 0);
+	mdio_tristate(bus);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+
+	/* check the turnaround bit: the PHY should be driving it to zero */
+	if (mdio_read(bus) != 0) {
+		/* puts ("PHY didn't drive TA low\n"); */
+		for (j = 0; j < 32; j++) {
+			mdc(bus, 0);
+			mii_delay(bus);
+			mdc(bus, 1);
+			mii_delay(bus);
+		}
+		ret = -1;
+		goto out;
+	}
+
+	mdc(bus, 0);
+	mii_delay(bus);
+
+	/* read 16 bits of register data, MSB first */
+	rdreg = 0;
+	for (j = 0; j < 16; j++) {
+		mdc(bus, 1);
+		mii_delay(bus);
+		rdreg <<= 1;
+		rdreg |= mdio_read(bus);
+		mdc(bus, 0);
+		mii_delay(bus);
+	}
+
+	mdc(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 0);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+
+	ret = rdreg;
+out:
+	return ret;
+}
+
+static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int val)
+{
+	int j;
+	__u8 addr = phy_id & 0xff;
+	__u8 reg = location & 0xff;
+	__u16 value = val & 0xffff;
+
+	bitbang_pre(bus, 0, addr, reg);
+
+	/* send the turnaround (10) */
+	mdc(bus, 0);
+	mdio(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+	mdc(bus, 0);
+	mdio(bus, 0);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+
+	/* write 16 bits of register data, MSB first */
+	for (j = 0; j < 16; j++) {
+		mdc(bus, 0);
+		mdio(bus, (value & 0x8000) != 0);
+		mii_delay(bus);
+		mdc(bus, 1);
+		mii_delay(bus);
+		value <<= 1;
+	}
+
+	/*
+	 * Tri-state the MDIO line.
+	 */
+	mdio_tristate(bus);
+	mdc(bus, 0);
+	mii_delay(bus);
+	mdc(bus, 1);
+	mii_delay(bus);
+}
+
+int fs_mii_bitbang_init(struct fs_enet_mii_bus *bus)
+{
+	const struct fs_mii_bus_info *bi = bus->bus_info;
+	int r;
+
+	r = bitbang_prep_bit(&bus->bitbang.mdio_dir,
+			 &bus->bitbang.mdio_dat,
+			 &bus->bitbang.mdio_msk,
+			 bi->i.bitbang.mdio_port,
+			 bi->i.bitbang.mdio_bit);
+	if (r != 0)
+		return r;
+
+	r = bitbang_prep_bit(&bus->bitbang.mdc_dir,
+			 &bus->bitbang.mdc_dat,
+			 &bus->bitbang.mdc_msk,
+			 bi->i.bitbang.mdc_port,
+			 bi->i.bitbang.mdc_bit);
+	if (r != 0)
+		return r;
+
+	bus->mii_read = mii_read;
+	bus->mii_write = mii_write;
+
+	return 0;
+}
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mii-fixed.c
@@ -0,0 +1,81 @@
+/*
+ * XXX blah blah
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+static const __u16 mii_regs[7] = {
+	0x3100,
+	0x786d,
+	0x0fff,
+	0x0fff,
+	0x01e1,
+	0x45e1,
+	0x0003,
+};
+
+static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
+{
+	int ret = 0;
+
+	if ((unsigned int)location >= ARRAY_SIZE(mii_regs))
+		return -1;
+
+	if (location != 5)
+		ret = mii_regs[location];
+	else
+		ret = bus->fixed.lpa;
+
+	return ret;
+}
+
+static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int val)
+{
+	/* do nothing */
+}
+
+int fs_mii_fixed_init(struct fs_enet_mii_bus *bus)
+{
+	const struct fs_mii_bus_info *bi = bus->bus_info;
+
+	bus->fixed.lpa = 0x45e1;	/* default 100Mb, full duplex */
+
+	/* if speed is fixed at 10Mb, remove 100Mb modes */
+	if (bi->i.fixed.speed == 10)
+		bus->fixed.lpa &= ~LPA_100;
+
+	/* if duplex is half, remove full duplex modes */
+	if (bi->i.fixed.duplex == 0)
+		bus->fixed.lpa &= ~LPA_DUPLEX;
+
+	bus->mii_read = mii_read;
+	bus->mii_write = mii_write;
+
+	return 0;
+}

--------------050001050200000802000403--
