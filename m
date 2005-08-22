Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id D5FCB68044
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 05:23:48 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so1056714wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 12:23:46 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 22 Aug 2005 22:21:50 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OXiCDnyPAOpWIAX"
Message-Id: <200508222221.50618.pantelis.antoniou@gmail.com>
Subject: [PATCH 2/3] fs_enet: hardware
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_OXiCDnyPAOpWIAX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi 

This is a snapshot of the work in progress of the new
fs_enet driver. It's aim is to replace all the various
SCC/FCC/FEC drivers for the Freescale PQs.

Don't expect it to work on your board just yet, just take
a look and comment.

This part contains the hardware specific files (MACs & MIIs)

Regards

Pantelis

--Boundary-00=_OXiCDnyPAOpWIAX
Content-Type: text/plain;
  charset="us-ascii";
  name="fs_enet-hw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fs_enet-hw.patch"

--- /dev/null
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -0,0 +1,572 @@
+/*
+ * FCC driver for Motorola MPC82xx (PQ2).
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
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
+#include <linux/fs.h>
+
+#include <asm/immap_cpm2.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+/* FCC access macros */
+
+#define __fcc_out32(addr, x)	out_be32((unsigned *)addr, x)
+#define __fcc_out16(addr, x)	out_be16((unsigned short *)addr, x)
+#define __fcc_out8(addr, x)	out_8((unsigned char *)addr, x)
+#define __fcc_in32(addr)	in_be32((unsigned *)addr)
+#define __fcc_in16(addr)	in_be16((unsigned short *)addr)
+#define __fcc_in8(addr)		in_8((unsigned char *)addr)
+
+/* parameter space */
+
+/* write, read, set bits, clear bits */
+#define W32(_p, _m, _v)	__fcc_out32(&(_p)->_m, (_v))
+#define R32(_p, _m)	__fcc_in32(&(_p)->_m)
+#define S32(_p, _m, _v)	W32(_p, _m, R32(_p, _m) | (_v))
+#define C32(_p, _m, _v)	W32(_p, _m, R32(_p, _m) & ~(_v))
+
+#define W16(_p, _m, _v)	__fcc_out16(&(_p)->_m, (_v))
+#define R16(_p, _m)	__fcc_in16(&(_p)->_m)
+#define S16(_p, _m, _v)	W16(_p, _m, R16(_p, _m) | (_v))
+#define C16(_p, _m, _v)	W16(_p, _m, R16(_p, _m) & ~(_v))
+
+#define W8(_p, _m, _v)	__fcc_out8(&(_p)->_m, (_v))
+#define R8(_p, _m)	__fcc_in8(&(_p)->_m)
+#define S8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) | (_v))
+#define C8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) & ~(_v))
+
+/*************************************************/
+
+#define FCC_MAX_MULTICAST_ADDRS	64
+
+#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
+#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | (VAL & 0xffff))
+#define mk_mii_end		0
+
+#define MAX_CR_CMD_LOOPS	10000
+
+static inline int fcc_cr_cmd(struct fs_enet_private *fep, u32 mcn, u32 op)
+{
+	const struct fs_platform_info *fpi = fep->fpi;
+		
+	cpm2_map_t *immap = fs_enet_immap;
+	cpm_cpm2_t *cpmp = &immap->im_cpm;
+	u32 v;
+	
+	/* Currently I don't know what feature call will look like. But 
+	I guess there'd be something like do_cpm_cmd() which will require page & sblock*/
+	v = mk_cr_cmd(fpi->cp_page,fpi->cp_block , mcn, op);
+	W32(cpmp, cp_cpcr, v | CPM_CR_FLG);
+	while ((R32(cpmp, cp_cpcr) & CPM_CR_FLG) != 0)
+		;
+
+	return 0;
+}
+
+static int do_pd_setup(struct fs_enet_private *fep)
+{
+	struct platform_device *pdev = to_platform_device(fep->dev); 
+	struct resource	*r; 
+	
+
+	/* Fill out IRQ field */
+	fep->interrupt = platform_get_irq(pdev, 0);
+	
+	/* Attach the memory for the FCC Parameter RAM */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fcc_pram");
+	fep->fcc.ep = (void*)r->start;
+	
+	if(fep->fcc.ep == NULL)
+		return -EINVAL;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fcc_regs");
+	fep->fcc.fccp =(void*)r->start;
+
+	if(fep->fcc.fccp == NULL)
+		return -EINVAL;
+
+	fep->fcc.fcccp = (void*)fep->fpi->fcc_regs_c;
+
+	if(fep->fcc.fcccp == NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+#define FCC_NAPI_RX_EVENT_MSK	(FCC_ENET_RXF | FCC_ENET_RXB)
+#define FCC_RX_EVENT		(FCC_ENET_RXF)
+#define FCC_TX_EVENT		(FCC_ENET_TXB)
+#define FCC_ERR_EVENT_MSK	(FCC_ENET_TXE | FCC_ENET_BSY)
+
+static int setup_data(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->fcc.idx = fs_get_fcc_index(fpi->fs_no);
+	if ((unsigned int)fep->fcc.idx >= 3)	/* max 3 FCCs */
+		return -EINVAL;
+	
+	fep->fcc.mem = (void*)fpi->mem_offset;
+	
+	if(do_pd_setup(fep) != 0)
+		return -EINVAL;
+
+	fep->ev_napi_rx = FCC_NAPI_RX_EVENT_MSK;
+	fep->ev_rx = FCC_RX_EVENT;
+	fep->ev_tx = FCC_TX_EVENT;
+	fep->ev_err = FCC_ERR_EVENT_MSK;
+
+	return 0;
+}
+
+static int allocate_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->ring_base = dma_alloc_coherent(fep->dev,
+					    (fpi->tx_ring + fpi->rx_ring) *
+					    sizeof(cbd_t), &fep->ring_mem_addr,
+					    GFP_KERNEL);
+	if (fep->ring_base == NULL) {
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void free_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	if(fep->ring_base)
+		dma_free_coherent(fep->dev, (fpi->tx_ring + fpi->rx_ring)
+					* sizeof(cbd_t),
+					fep->ring_base,
+					fep->ring_mem_addr);
+}
+
+static void cleanup_data(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static void set_promiscuous_mode(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	S32(fccp, fcc_fpsmr, FCC_PSMR_PRO);
+}
+
+static void set_multicast_start(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_enet_t *ep = fep->fcc.ep;
+
+	W32(ep, fen_gaddrh, 0);
+	W32(ep, fen_gaddrl, 0);
+}
+
+static void set_multicast_one(struct net_device *dev, const u8 *mac)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_enet_t *ep = fep->fcc.ep;
+	u16 taddrh, taddrm, taddrl;
+
+	taddrh = ((u16)mac[5] << 8) | mac[4];
+	taddrm = ((u16)mac[3] << 8) | mac[2];
+	taddrl = ((u16)mac[1] << 8) | mac[0];
+
+	W16(ep, fen_taddrh, taddrh);
+	W16(ep, fen_taddrm, taddrm);
+	W16(ep, fen_taddrl, taddrl);
+	fcc_cr_cmd(fep, 0x0C, CPM_CR_SET_GADDR);
+}
+
+static void set_multicast_finish(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+	fcc_enet_t *ep = fep->fcc.ep;
+
+	/* clear promiscuous always */
+	C32(fccp, fcc_fpsmr, FCC_PSMR_PRO);
+
+	/* if all multi or too many multicasts; just enable all */
+	if ((dev->flags & IFF_ALLMULTI) != 0 ||
+	    dev->mc_count > FCC_MAX_MULTICAST_ADDRS) {
+
+		W32(ep, fen_gaddrh, 0xffffffff);
+		W32(ep, fen_gaddrl, 0xffffffff);
+	}
+
+	/* read back */
+	fep->fcc.gaddrh = R32(ep, fen_gaddrh);
+	fep->fcc.gaddrl = R32(ep, fen_gaddrl);
+}
+
+static void set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *pmc;
+
+	if ((dev->flags & IFF_PROMISC) == 0) {
+		set_multicast_start(dev);
+		for (pmc = dev->mc_list; pmc != NULL; pmc = pmc->next)
+			set_multicast_one(dev, pmc->dmi_addr);
+		set_multicast_finish(dev);
+	} else
+		set_promiscuous_mode(dev);
+}
+
+static void restart(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	fcc_t *fccp = fep->fcc.fccp;
+	fcc_c_t *fcccp = fep->fcc.fcccp;
+	fcc_enet_t *ep = fep->fcc.ep;
+	dma_addr_t rx_bd_base_phys, tx_bd_base_phys;
+	u16 paddrh, paddrm, paddrl;
+	u16 mem_addr;
+	const unsigned char *mac;
+	int i;
+
+	C32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
+
+	/* clear everything (slow & steady does it) */
+	for (i = 0; i < sizeof(*ep); i++)
+		__fcc_out8((char *)ep + i, 0);
+
+	/* get physical address */
+	rx_bd_base_phys = fep->ring_mem_addr;
+	tx_bd_base_phys = rx_bd_base_phys + sizeof(cbd_t) * fpi->rx_ring;
+
+	/* point to bds */
+	W32(ep, fen_genfcc.fcc_rbase, rx_bd_base_phys);
+	W32(ep, fen_genfcc.fcc_tbase, tx_bd_base_phys);
+
+	/* Set maximum bytes per receive buffer.
+	 * It must be a multiple of 32.
+	 */
+	W16(ep, fen_genfcc.fcc_mrblr, PKT_MAXBLR_SIZE);
+
+	W32(ep, fen_genfcc.fcc_rstate, (CPMFCR_GBL | CPMFCR_EB) << 24);
+	W32(ep, fen_genfcc.fcc_tstate, (CPMFCR_GBL | CPMFCR_EB) << 24);
+
+	/* Allocate space in the reserved FCC area of DPRAM for the
+	 * internal buffers.  No one uses this space (yet), so we
+	 * can do this.  Later, we will add resource management for
+	 * this area.
+	 */
+	
+	mem_addr = (u32)fep->fcc.mem; /* de-fixup dpram offset*/
+
+	W16(ep, fen_genfcc.fcc_riptr, (mem_addr & 0xffff));
+	W16(ep, fen_genfcc.fcc_tiptr, ((mem_addr + 32) & 0xffff));
+	W16(ep, fen_padptr, mem_addr + 64);
+	
+	/* fill with special symbol...  */
+	memset(fep->fcc.mem + fpi->dpram_offset + 64, 0x88, 32);
+
+	W32(ep, fen_genfcc.fcc_rbptr, 0);
+	W32(ep, fen_genfcc.fcc_tbptr, 0);
+	W32(ep, fen_genfcc.fcc_rcrc, 0);
+	W32(ep, fen_genfcc.fcc_tcrc, 0);
+	W16(ep, fen_genfcc.fcc_res1, 0);
+	W32(ep, fen_genfcc.fcc_res2, 0);
+
+	/* no CAM */
+	W32(ep, fen_camptr, 0);
+
+	/* Set CRC preset and mask */
+	W32(ep, fen_cmask, 0xdebb20e3);
+	W32(ep, fen_cpres, 0xffffffff);
+
+	W32(ep, fen_crcec, 0);		/* CRC Error counter       */
+	W32(ep, fen_alec, 0);		/* alignment error counter */
+	W32(ep, fen_disfc, 0);		/* discard frame counter   */
+	W16(ep, fen_retlim, 15);	/* Retry limit threshold   */
+	W16(ep, fen_pper, 0);		/* Normal persistence      */
+
+	/* set group address */
+	W32(ep, fen_gaddrh, fep->fcc.gaddrh);
+	W32(ep, fen_gaddrl, fep->fcc.gaddrh);
+
+	/* Clear hash filter tables */
+	W32(ep, fen_iaddrh, 0);
+	W32(ep, fen_iaddrl, 0);
+
+	/* Clear the Out-of-sequence TxBD  */
+	W16(ep, fen_tfcstat, 0);
+	W16(ep ,fen_tfclen, 0);
+	W32(ep, fen_tfcptr, 0);
+
+	W16(ep, fen_mflr, PKT_MAXBUF_SIZE);   /* maximum frame length register */
+	W16(ep, fen_minflr, PKT_MINBUF_SIZE); /* minimum frame length register */
+
+	/* set address */
+	mac = dev->dev_addr;
+	paddrh = ((u16)mac[5] << 8) | mac[4];
+	paddrm = ((u16)mac[3] << 8) | mac[2];
+	paddrl = ((u16)mac[1] << 8) | mac[0];
+
+	W16(ep, fen_paddrh, paddrh);
+	W16(ep, fen_paddrm, paddrm);
+	W16(ep, fen_paddrl, paddrl);
+
+	W16(ep, fen_taddrh, 0);
+	W16(ep, fen_taddrm, 0);
+	W16(ep, fen_taddrl, 0);
+
+	W16(ep, fen_maxd1, 1520);	/* maximum DMA1 length */
+	W16(ep, fen_maxd2, 1520);	/* maximum DMA2 length */
+
+	/* Clear stat counters, in case we ever enable RMON */
+	W32(ep, fen_octc, 0);
+	W32(ep, fen_colc, 0);
+	W32(ep, fen_broc, 0);
+	W32(ep, fen_mulc, 0);
+	W32(ep, fen_uspc, 0);
+	W32(ep, fen_frgc, 0);
+	W32(ep, fen_ospc, 0);
+	W32(ep, fen_jbrc, 0);
+	W32(ep, fen_p64c, 0);
+	W32(ep, fen_p65c, 0);
+	W32(ep, fen_p128c, 0);
+	W32(ep, fen_p256c, 0);
+	W32(ep, fen_p512c, 0);
+	W32(ep, fen_p1024c, 0);
+
+	W16(ep, fen_rfthr, 0);	/* Suggested by manual */
+	W16(ep, fen_rfcnt, 0);
+	W16(ep, fen_cftype, 0);
+
+	fs_init_bds(dev);
+
+	/* adjust to speed (for RMII mode) */
+	if (fpi->use_rmii) {
+		if (fep->speed == 100)
+			C8(fcccp, fcc_gfemr, 0x20);
+		else
+			S8(fcccp, fcc_gfemr, 0x20);
+	}
+
+	fcc_cr_cmd(fep, 0x0c, CPM_CR_INIT_TRX);
+
+	/* clear events */
+	W16(fccp, fcc_fcce, 0xffff);
+
+	/* Enable interrupts we wish to service */
+	W16(fccp, fcc_fccm, FCC_ENET_TXE | FCC_ENET_RXF | FCC_ENET_TXB);
+
+	/* Set GFMR to enable Ethernet operating mode */
+	W32(fccp, fcc_gfmr, FCC_GFMR_TCI | FCC_GFMR_MODE_ENET);
+
+	/* set sync/delimiters */
+	W16(fccp, fcc_fdsr, 0xd555);
+
+	W32(fccp, fcc_fpsmr, FCC_PSMR_ENCRC);
+
+	if (fpi->use_rmii)
+		S32(fccp, fcc_fpsmr, FCC_PSMR_RMII);
+
+	/* adjust to duplex mode */
+	if (fep->duplex)
+		S32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
+	else
+		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
+
+	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
+}
+
+static void stop(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	/* stop ethernet */
+	C32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
+
+	/* clear events */
+	W16(fccp, fcc_fcce, 0xffff);
+
+	/* clear interrupt mask */
+	W16(fccp, fcc_fccm, 0);
+
+	fs_cleanup_bds(dev);
+}
+
+static void pre_request_irq(struct net_device *dev, int irq)
+{
+	/* nothing */
+}
+
+static void post_free_irq(struct net_device *dev, int irq)
+{
+	/* nothing */
+}
+
+static void napi_clear_rx_event(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	W16(fccp, fcc_fcce, FCC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_enable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	S16(fccp, fcc_fccm, FCC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_disable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	C16(fccp, fcc_fccm, FCC_NAPI_RX_EVENT_MSK);
+}
+
+static void rx_bd_done(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static void tx_kickstart(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static u32 get_int_events(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	return (u32)R16(fccp, fcc_fcce);
+}
+
+static void clear_int_events(struct net_device *dev, u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	W16(fccp, fcc_fcce, int_events & 0xffff);
+}
+
+static void ev_error(struct net_device *dev, u32 int_events)
+{
+	printk(KERN_WARNING DRV_MODULE_NAME
+	       ": %s FS_ENET ERROR(s) 0x%x\n", dev->name, int_events);
+}
+
+int get_regs(struct net_device *dev, void *p, int *sizep)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (*sizep < sizeof(fcc_t) + sizeof(fcc_c_t) + sizeof(fcc_enet_t))
+		return -EINVAL;
+
+	memcpy_fromio(p, fep->fcc.fccp, sizeof(fcc_t));
+	p = (char *)p + sizeof(fcc_t);
+
+	memcpy_fromio(p, fep->fcc.fcccp, sizeof(fcc_c_t));
+	p = (char *)p + sizeof(fcc_c_t);
+
+	memcpy_fromio(p, fep->fcc.ep, sizeof(fcc_enet_t));
+
+	return 0;
+}
+
+int get_regs_len(struct net_device *dev)
+{
+	return sizeof(fcc_t) + sizeof(fcc_c_t) + sizeof(fcc_enet_t);
+}
+
+/* Some transmit errors cause the transmitter to shut
+ * down.  We now issue a restart transmit.  Since the
+ * errors close the BD and update the pointers, the restart
+ * _should_ pick up without having to reset any of our
+ * pointers either.  Also, To workaround 8260 device erratum 
+ * CPM37, we must disable and then re-enable the transmitter
+ * following a Late Collision, Underrun, or Retry Limit error.
+ */
+void tx_restart(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	C32(fccp, fcc_gfmr, FCC_GFMR_ENT);
+	udelay(10);
+	S32(fccp, fcc_gfmr, FCC_GFMR_ENT);
+
+	fcc_cr_cmd(fep, 0x0C, CPM_CR_RESTART_TX);
+}
+
+/*************************************************************************/
+
+const struct fs_ops fs_fcc_ops = {
+	.setup_data		= setup_data,
+	.cleanup_data		= cleanup_data,
+	.set_multicast_list	= set_multicast_list,
+	.restart		= restart,
+	.stop			= stop,
+	.pre_request_irq	= pre_request_irq,
+	.post_free_irq		= post_free_irq,
+	.napi_clear_rx_event	= napi_clear_rx_event,
+	.napi_enable_rx		= napi_enable_rx,
+	.napi_disable_rx	= napi_disable_rx,
+	.rx_bd_done		= rx_bd_done,
+	.tx_kickstart		= tx_kickstart,
+	.get_int_events		= get_int_events,
+	.clear_int_events	= clear_int_events,
+	.ev_error		= ev_error,
+	.get_regs		= get_regs,
+	.get_regs_len		= get_regs_len,
+	.tx_restart		= tx_restart,
+	.allocate_bd		= allocate_bd,
+	.free_bd		= free_bd,
+};
--- /dev/null
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -0,0 +1,653 @@
+/*
+ * Freescale Ethernet controllers
+ *
+ * Copyright (c) 2005 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
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
+#include <linux/fs.h>
+
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_8xx
+#include <asm/8xx_immap.h>
+#include <asm/pgtable.h>
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+#endif
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+#if defined(CONFIG_CPM1)
+/* for a CPM1 __raw_xxx's are sufficient */
+#define __fs_out32(addr, x)	__raw_writel(x, addr)
+#define __fs_out16(addr, x)	__raw_writew(x, addr)
+#define __fs_in32(addr)	__raw_readl(addr)
+#define __fs_in16(addr)	__raw_readw(addr)
+#else
+/* for others play it safe */
+#define __fs_out32(addr, x)	out_be32(addr, x)
+#define __fs_out16(addr, x)	out_be16(addr, x)
+#define __fs_in32(addr)	in_be32(addr)
+#define __fs_in16(addr)	in_be16(addr)
+#endif
+
+/* write */
+#define FW(_fecp, _reg, _v) __fs_out32(&(_fecp)->fec_ ## _reg, (_v))
+
+/* read */
+#define FR(_fecp, _reg)	__fs_in32(&(_fecp)->fec_ ## _reg)
+
+/* set bits */
+#define FS(_fecp, _reg, _v) FW(_fecp, _reg, FR(_fecp, _reg) | (_v))
+
+/* clear bits */
+#define FC(_fecp, _reg, _v) FW(_fecp, _reg, FR(_fecp, _reg) & ~(_v))
+
+
+/* CRC polynomium used by the FEC for the multicast group filtering */
+#define FEC_CRC_POLY   0x04C11DB7
+
+#define FEC_MAX_MULTICAST_ADDRS	64
+
+/* Interrupt events/masks.
+*/
+#define FEC_ENET_HBERR	0x80000000U	/* Heartbeat error          */
+#define FEC_ENET_BABR	0x40000000U	/* Babbling receiver        */
+#define FEC_ENET_BABT	0x20000000U	/* Babbling transmitter     */
+#define FEC_ENET_GRA	0x10000000U	/* Graceful stop complete   */
+#define FEC_ENET_TXF	0x08000000U	/* Full frame transmitted   */
+#define FEC_ENET_TXB	0x04000000U	/* A buffer was transmitted */
+#define FEC_ENET_RXF	0x02000000U	/* Full frame received      */
+#define FEC_ENET_RXB	0x01000000U	/* A buffer was received    */
+#define FEC_ENET_MII	0x00800000U	/* MII interrupt            */
+#define FEC_ENET_EBERR	0x00400000U	/* SDMA bus error           */
+
+#define FEC_ECNTRL_PINMUX	0x00000004
+#define FEC_ECNTRL_ETHER_EN	0x00000002
+#define FEC_ECNTRL_RESET	0x00000001
+
+#define FEC_RCNTRL_BC_REJ	0x00000010
+#define FEC_RCNTRL_PROM		0x00000008
+#define FEC_RCNTRL_MII_MODE	0x00000004
+#define FEC_RCNTRL_DRT		0x00000002
+#define FEC_RCNTRL_LOOP		0x00000001
+
+#define FEC_TCNTRL_FDEN		0x00000004
+#define FEC_TCNTRL_HBC		0x00000002
+#define FEC_TCNTRL_GTS		0x00000001
+
+
+/* Make MII read/write commands for the FEC.
+*/
+#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
+#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | (VAL & 0xffff))
+#define mk_mii_end		0
+
+#define FEC_MII_LOOPS	10000
+
+/*
+ * Delay to wait for FEC reset command to complete (in us) 
+ */
+#define FEC_RESET_DELAY		50
+
+static int whack_reset(fec_t * fecp)
+{
+	int i;
+
+	FW(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_RESET);
+	for (i = 0; i < FEC_RESET_DELAY; i++) {
+		if ((FR(fecp, ecntrl) & FEC_ECNTRL_RESET) == 0)
+			return 0;	/* OK */
+		udelay(1);
+	}
+
+	return -1;
+}
+
+static int do_pd_setup(struct fs_enet_private *fep)
+{
+	struct platform_device *pdev = to_platform_device(fep->dev); 
+	struct resource	*r;
+	
+	/* Fill out IRQ field */
+	fep->interrupt = platform_get_irq_byname(pdev,"interrupt");
+	
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	fep->fec.fecp =(void*)r->start;
+
+	if(fep->fec.fecp == NULL)
+		return -EINVAL;
+
+	return 0;
+	
+}
+
+#define FEC_NAPI_RX_EVENT_MSK	(FEC_ENET_RXF | FEC_ENET_RXB)
+#define FEC_RX_EVENT		(FEC_ENET_RXF)
+#define FEC_TX_EVENT		(FEC_ENET_TXF)
+#define FEC_ERR_EVENT_MSK	(FEC_ENET_HBERR | FEC_ENET_BABR | \
+				 FEC_ENET_BABT | FEC_ENET_EBERR)
+
+static int setup_data(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (do_pd_setup(fep) != 0)
+		return -EINVAL;
+
+	fep->fec.hthi = 0;
+	fep->fec.htlo = 0;
+
+	fep->ev_napi_rx = FEC_NAPI_RX_EVENT_MSK;
+	fep->ev_rx = FEC_RX_EVENT;
+	fep->ev_tx = FEC_TX_EVENT;
+	fep->ev_err = FEC_ERR_EVENT_MSK;
+
+	return 0;
+}
+
+static int allocate_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	
+	fep->ring_base = dma_alloc_coherent(fep->dev,
+					    (fpi->tx_ring + fpi->rx_ring) *
+					    sizeof(cbd_t), &fep->ring_mem_addr,
+					    GFP_KERNEL);
+	if (fep->ring_base == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	if(fep->ring_base)
+		dma_free_coherent(fep->dev, (fpi->tx_ring + fpi->rx_ring)
+					* sizeof(cbd_t),
+					fep->ring_base,
+					fep->ring_mem_addr);
+}
+
+static void cleanup_data(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static void set_promiscuous_mode(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FS(fecp, r_cntrl, FEC_RCNTRL_PROM);
+}
+
+static void set_multicast_start(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->fec.hthi = 0;
+	fep->fec.htlo = 0;
+}
+
+static void set_multicast_one(struct net_device *dev, const u8 *mac)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	int temp, hash_index, i, j;
+	u32 crc, csrVal;
+	u8 byte, msb;
+
+	crc = 0xffffffff;
+	for (i = 0; i < 6; i++) {
+		byte = mac[i];
+		for (j = 0; j < 8; j++) {
+			msb = crc >> 31;
+			crc <<= 1;
+			if (msb ^ (byte & 0x1))
+				crc ^= FEC_CRC_POLY;
+			byte >>= 1;
+		}
+	}
+
+	temp = (crc & 0x3f) >> 1;
+	hash_index = ((temp & 0x01) << 4) |
+		     ((temp & 0x02) << 2) |
+		     ((temp & 0x04)) |
+		     ((temp & 0x08) >> 2) |
+		     ((temp & 0x10) >> 4);
+	csrVal = 1 << hash_index;
+	if (crc & 1)
+		fep->fec.hthi |= csrVal;
+	else
+		fep->fec.htlo |= csrVal;
+}
+
+static void set_multicast_finish(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	/* if all multi or too many multicasts; just enable all */
+	if ((dev->flags & IFF_ALLMULTI) != 0 ||
+	    dev->mc_count > FEC_MAX_MULTICAST_ADDRS) {
+		fep->fec.hthi = 0xffffffffU;
+		fep->fec.htlo = 0xffffffffU;
+	}
+
+	FC(fecp, r_cntrl, FEC_RCNTRL_PROM);
+	FW(fecp, hash_table_high, fep->fec.hthi);
+	FW(fecp, hash_table_low, fep->fec.htlo);
+}
+
+static void set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *pmc;
+
+	if ((dev->flags & IFF_PROMISC) == 0) {
+		set_multicast_start(dev);
+		for (pmc = dev->mc_list; pmc != NULL; pmc = pmc->next)
+			set_multicast_one(dev, pmc->dmi_addr);
+		set_multicast_finish(dev);
+	} else
+		set_promiscuous_mode(dev);
+}
+
+static void restart(struct net_device *dev)
+{
+#ifdef CONFIG_DUET
+	immap_t *immap = fs_enet_immap;
+	u32 cptr;
+#endif
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+	const struct fs_platform_info *fpi = fep->fpi;
+	dma_addr_t rx_bd_base_phys, tx_bd_base_phys;
+	int r;
+	u32 addrhi, addrlo;
+
+	r = whack_reset(fep->fec.fecp);
+	if (r != 0)
+		printk(KERN_ERR DRV_MODULE_NAME
+				": %s FEC Reset FAILED!\n", dev->name);
+
+	/*
+	 * Set station address. 
+	 */
+	addrhi = ((u32) dev->dev_addr[0] << 24) |
+		 ((u32) dev->dev_addr[1] << 16) |
+		 ((u32) dev->dev_addr[2] <<  8) |
+		  (u32) dev->dev_addr[3];
+	addrlo = ((u32) dev->dev_addr[4] << 24) |
+		 ((u32) dev->dev_addr[5] << 16);
+	FW(fecp, addr_low, addrhi);
+	FW(fecp, addr_high, addrlo);
+
+	/*
+	 * Reset all multicast. 
+	 */
+	FW(fecp, hash_table_high, fep->fec.hthi);
+	FW(fecp, hash_table_low, fep->fec.htlo);
+
+	/*
+	 * Set maximum receive buffer size. 
+	 */
+	FW(fecp, r_buff_size, PKT_MAXBLR_SIZE);
+	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
+
+	/* get physical address */
+	rx_bd_base_phys = fep->ring_mem_addr;
+	tx_bd_base_phys = rx_bd_base_phys + sizeof(cbd_t) * fpi->rx_ring;
+
+	/*
+	 * Set receive and transmit descriptor base. 
+	 */
+	FW(fecp, r_des_start, rx_bd_base_phys);
+	FW(fecp, x_des_start, tx_bd_base_phys);
+
+	fs_init_bds(dev);
+
+	/*
+	 * Enable big endian and don't care about SDMA FC. 
+	 */
+	FW(fecp, fun_code, 0x78000000);
+
+	/*
+	 * Set MII speed. 
+	 */
+	FW(fecp, mii_speed, fep->mii_bus->fec.mii_speed);
+
+	/*
+	 * Clear any outstanding interrupt. 
+	 */
+	FW(fecp, ievent, 0xffc0);
+	FW(fecp, ivec, (fep->interrupt / 2) << 29);
+	
+
+	/*
+	 * adjust to speed (only for DUET & RMII) 
+	 */
+#ifdef CONFIG_DUET
+	if (fpi->use_rmii) {
+		cptr = in_be32(&immap->im_cpm.cp_cptr);
+		switch (fs_get_fec_index(fpi->fs_no)) {
+		case 0:
+			cptr |= 0x100;
+			if (fep->speed == 10)
+				cptr |= 0x0000010;
+			else if (fep->speed == 100)
+				cptr &= ~0x0000010;
+			break;
+		case 1:
+			cptr |= 0x80;
+			if (fep->speed == 10)
+				cptr |= 0x0000008;
+			else if (fep->speed == 100)
+				cptr &= ~0x0000008;
+			break;
+		default:
+			BUG();	/* should never happen */
+			break;
+		}
+		out_be32(&immap->im_cpm.cp_cptr, cptr);
+	}
+#endif
+
+	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+	/*
+	 * adjust to duplex mode 
+	 */
+	if (fep->duplex) {
+		FC(fecp, r_cntrl, FEC_RCNTRL_DRT);
+		FS(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD enable */
+	} else {
+		FS(fecp, r_cntrl, FEC_RCNTRL_DRT);
+		FC(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD disable */
+	}
+
+	/*
+	 * Enable interrupts we wish to service. 
+	 */
+	FW(fecp, imask, FEC_ENET_TXF | FEC_ENET_TXB |
+	   FEC_ENET_RXF | FEC_ENET_RXB);
+
+	/*
+	 * And last, enable the transmit and receive processing. 
+	 */
+	FW(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
+	FW(fecp, r_des_active, 0x01000000);
+}
+
+static void stop(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+	const struct fs_mii_bus_info *bi = bus->bus_info;
+	int i;
+
+	if ((FR(fecp, ecntrl) & FEC_ECNTRL_ETHER_EN) == 0)
+		return;		/* already down */
+
+	FW(fecp, x_cntrl, 0x01);	/* Graceful transmit stop */
+	for (i = 0; ((FR(fecp, ievent) & 0x10000000) == 0) &&
+	     i < FEC_RESET_DELAY; i++)
+		udelay(1);
+
+	if (i == FEC_RESET_DELAY)
+		printk(KERN_WARNING DRV_MODULE_NAME
+		       ": %s FEC timeout on graceful transmit stop\n",
+		       dev->name);
+	/*
+	 * Disable FEC. Let only MII interrupts. 
+	 */
+	FW(fecp, imask, 0);
+	FC(fecp, ecntrl, FEC_ECNTRL_ETHER_EN);
+
+	fs_cleanup_bds(dev);
+
+	/* shut down FEC1? that's where the mii bus is */
+	if (fep->fec.idx == 0 && bus->refs > 1 && bi->method == fsmii_fec) {
+		FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+		FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
+		FW(fecp, ievent, FEC_ENET_MII);
+		FW(fecp, mii_speed, bus->fec.mii_speed);
+	}
+}
+
+static void pre_request_irq(struct net_device *dev, int irq)
+{
+	immap_t *immap = fs_enet_immap;
+	u32 siel;
+
+	/* SIU interrupt */
+	if (irq >= SIU_IRQ0 && irq < SIU_LEVEL7) {
+
+		siel = in_be32(&immap->im_siu_conf.sc_siel);
+		if ((irq & 1) == 0)
+			siel |= (0x80000000 >> irq);
+		else
+			siel &= ~(0x80000000 >> (irq & ~1));
+		out_be32(&immap->im_siu_conf.sc_siel, siel);
+	}
+}
+
+static void post_free_irq(struct net_device *dev, int irq)
+{
+	/* nothing */
+}
+
+static void napi_clear_rx_event(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FW(fecp, ievent, FEC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_enable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FS(fecp, imask, FEC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_disable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FC(fecp, imask, FEC_NAPI_RX_EVENT_MSK);
+}
+
+static void rx_bd_done(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FW(fecp, r_des_active, 0x01000000);
+}
+
+static void tx_kickstart(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FW(fecp, x_des_active, 0x01000000);
+}
+
+static u32 get_int_events(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	return FR(fecp, ievent) & FR(fecp, imask);
+}
+
+static void clear_int_events(struct net_device *dev, u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FW(fecp, ievent, int_events);
+}
+
+static void ev_error(struct net_device *dev, u32 int_events)
+{
+	printk(KERN_WARNING DRV_MODULE_NAME
+	       ": %s FEC ERROR(s) 0x%x\n", dev->name, int_events);
+}
+
+int get_regs(struct net_device *dev, void *p, int *sizep)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (*sizep < sizeof(fec_t))
+		return -EINVAL;
+
+	memcpy_fromio(p, fep->fec.fecp, sizeof(fec_t));
+
+	return 0;
+}
+
+int get_regs_len(struct net_device *dev)
+{
+	return sizeof(fec_t);
+}
+
+void tx_restart(struct net_device *dev)
+{
+	/* nothing */
+}
+
+/*************************************************************************/
+
+const struct fs_ops fs_fec_ops = {
+	.setup_data		= setup_data,
+	.cleanup_data		= cleanup_data,
+	.set_multicast_list	= set_multicast_list,
+	.restart		= restart,
+	.stop			= stop,
+	.pre_request_irq	= pre_request_irq,
+	.post_free_irq		= post_free_irq,
+	.napi_clear_rx_event	= napi_clear_rx_event,
+	.napi_enable_rx		= napi_enable_rx,
+	.napi_disable_rx	= napi_disable_rx,
+	.rx_bd_done		= rx_bd_done,
+	.tx_kickstart		= tx_kickstart,
+	.get_int_events		= get_int_events,
+	.clear_int_events	= clear_int_events,
+	.ev_error		= ev_error,
+	.get_regs		= get_regs,
+	.get_regs_len		= get_regs_len,
+	.tx_restart		= tx_restart,
+	.allocate_bd		= allocate_bd,
+	.free_bd		= free_bd,
+};
+
+/***********************************************************************/
+
+static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
+{
+	fec_t *fecp = bus->fec.fecp;
+	int i, ret = -1;
+
+	if ((FR(fecp, r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
+		BUG();
+
+	/* Add PHY address to register command.  */
+	FW(fecp, mii_data, (phy_id << 23) | mk_mii_read(location));
+
+	for (i = 0; i < FEC_MII_LOOPS; i++)
+		if ((FR(fecp, ievent) & FEC_ENET_MII) != 0)
+			break;
+
+	if (i < FEC_MII_LOOPS) {
+		FW(fecp, ievent, FEC_ENET_MII);
+		ret = FR(fecp, mii_data) & 0xffff;
+	}
+
+	return ret;
+}
+
+static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int value)
+{
+	fec_t *fecp = bus->fec.fecp;
+	int i;
+
+	/* this must never happen */
+	if ((FR(fecp, r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
+		BUG();
+
+	/* Add PHY address to register command.  */
+	FW(fecp, mii_data, (phy_id << 23) | mk_mii_write(location, value));
+
+	for (i = 0; i < FEC_MII_LOOPS; i++)
+		if ((FR(fecp, ievent) & FEC_ENET_MII) != 0)
+			break;
+
+	if (i < FEC_MII_LOOPS)
+		FW(fecp, ievent, FEC_ENET_MII);
+}
+
+int fs_mii_fec_init(struct fs_enet_mii_bus *bus)
+{
+	bd_t *bd = (bd_t *)__res;
+	const struct fs_mii_bus_info *bi = bus->bus_info;
+	fec_t *fecp;
+
+	if (bi->id != 0)
+		return -1;
+
+	bus->fec.fecp = &((immap_t *)fs_enet_immap)->im_cpm.cp_fec;
+	bus->fec.mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2)
+				& 0x3F) << 1;
+
+	fecp = bus->fec.fecp;
+
+	FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+	FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
+	FW(fecp, ievent, FEC_ENET_MII);
+	FW(fecp, mii_speed, bus->fec.mii_speed);
+
+	bus->mii_read = mii_read;
+	bus->mii_write = mii_write;
+
+	return 0;
+}
--- /dev/null
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -0,0 +1,517 @@
+/*
+ * Ethernet on Serial Communications Controller (SCC) driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ * 
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
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
+#include <linux/fs.h>
+
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_8xx
+#include <asm/8xx_immap.h>
+#include <asm/pgtable.h>
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+#endif
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+#if defined(CONFIG_CPM1)
+/* for a 8xx __raw_xxx's are sufficient */
+#define __fs_out32(addr, x)	__raw_writel(x, addr)
+#define __fs_out16(addr, x)	__raw_writew(x, addr)
+#define __fs_out8(addr, x)	__raw_writeb(x, addr)
+#define __fs_in32(addr)	__raw_readl(addr)
+#define __fs_in16(addr)	__raw_readw(addr)
+#define __fs_in8(addr)	__raw_readb(addr)
+#else
+/* for others play it safe */
+#define __fs_out32(addr, x)	out_be32(addr, x)
+#define __fs_out16(addr, x)	out_be16(addr, x)
+#define __fs_in32(addr)	in_be32(addr)
+#define __fs_in16(addr)	in_be16(addr)
+#endif
+
+/* write, read, set bits, clear bits */
+#define W32(_p, _m, _v) __fs_out32(&(_p)->_m, (_v))
+#define R32(_p, _m)     __fs_in32(&(_p)->_m)
+#define S32(_p, _m, _v) W32(_p, _m, R32(_p, _m) | (_v))
+#define C32(_p, _m, _v) W32(_p, _m, R32(_p, _m) & ~(_v))
+
+#define W16(_p, _m, _v) __fs_out16(&(_p)->_m, (_v))
+#define R16(_p, _m)     __fs_in16(&(_p)->_m)
+#define S16(_p, _m, _v) W16(_p, _m, R16(_p, _m) | (_v))
+#define C16(_p, _m, _v) W16(_p, _m, R16(_p, _m) & ~(_v))
+
+#define W8(_p, _m, _v)  __fs_out8(&(_p)->_m, (_v))
+#define R8(_p, _m)      __fs_in8(&(_p)->_m)
+#define S8(_p, _m, _v)  W8(_p, _m, R8(_p, _m) | (_v))
+#define C8(_p, _m, _v)  W8(_p, _m, R8(_p, _m) & ~(_v))
+
+#define SCC_MAX_MULTICAST_ADDRS	64
+
+/*
+ * Delay to wait for SCC reset command to complete (in us) 
+ */
+#define SCC_RESET_DELAY		50
+
+static inline int scc_cr_cmd(struct fs_enet_private *fep, u32 op)
+{
+	cpm8xx_t *cpmp = &((immap_t *)fs_enet_immap)->im_cpm;
+	u32 v, ch;
+
+	ch = fep->scc.idx << 2;
+	v = mk_cr_cmd(ch, op);
+	W16(cpmp, cp_cpcr, v | CPM_CR_FLG);
+	while ((R16(cpmp, cp_cpcr) & CPM_CR_FLG) != 0)
+		udelay(10);
+
+	return 0;
+}
+
+static int do_pd_setup(struct fs_enet_private *fep)
+{
+	struct platform_device *pdev = to_platform_device(fep->dev);
+	struct resource *r;
+
+	/* Fill out IRQ field */
+	fep->interrupt = platform_get_irq_byname(pdev, "interrupt");
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	fep->scc.sccp = (void *)r->start;
+
+	if (fep->scc.sccp == NULL)
+		return -EINVAL;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram");
+	fep->scc.ep = (void *)r->start;
+
+	if (fep->scc.ep == NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+#define SCC_NAPI_RX_EVENT_MSK	(SCCE_ENET_RXF | SCCE_ENET_RXB)
+#define SCC_RX_EVENT		(SCCE_ENET_RXF)
+#define SCC_TX_EVENT		(SCCE_ENET_TXB)
+#define SCC_ERR_EVENT_MSK	(SCCE_ENET_TXE | SCCE_ENET_BSY)
+
+static int setup_data(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->scc.idx = fs_get_scc_index(fpi->fs_no);
+	if ((unsigned int)fep->fcc.idx > 4)	/* max 4 SCCs */
+		return -EINVAL;
+
+	do_pd_setup(fep);
+
+	fep->scc.hthi = 0;
+	fep->scc.htlo = 0;
+
+	fep->ev_napi_rx = SCC_NAPI_RX_EVENT_MSK;
+	fep->ev_rx = SCC_RX_EVENT;
+	fep->ev_tx = SCC_TX_EVENT;
+	fep->ev_err = SCC_ERR_EVENT_MSK;
+
+	return 0;
+}
+
+static int allocate_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->ring_mem_addr = cpm_dpalloc((fpi->tx_ring + fpi->rx_ring) *
+					 sizeof(cbd_t), 8);
+	if (IS_DPERR(fep->ring_mem_addr)) {
+		return -ENOMEM;
+	}
+
+	fep->ring_base = cpm_dpram_addr(fep->ring_mem_addr);
+
+	return 0;
+}
+
+static void free_bd(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->ring_base)
+		cpm_dpfree(fep->ring_mem_addr);
+}
+
+static void cleanup_data(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static void set_promiscuous_mode(struct net_device *dev)
+{				
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	S16(sccp, scc_psmr, SCC_PSMR_PRO);
+}
+
+static void set_multicast_start(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_enet_t *ep = fep->scc.ep;
+
+	W16(ep, sen_gaddr1, 0);
+	W16(ep, sen_gaddr2, 0);
+	W16(ep, sen_gaddr3, 0);
+	W16(ep, sen_gaddr4, 0);
+}
+
+static void set_multicast_one(struct net_device *dev, const u8 * mac)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_enet_t *ep = fep->scc.ep;
+	u16 taddrh, taddrm, taddrl;
+
+	taddrh = ((u16) mac[5] << 8) | mac[4];
+	taddrm = ((u16) mac[3] << 8) | mac[2];
+	taddrl = ((u16) mac[1] << 8) | mac[0];
+
+	W16(ep, sen_taddrh, taddrh);
+	W16(ep, sen_taddrm, taddrm);
+	W16(ep, sen_taddrl, taddrl);
+	scc_cr_cmd(fep, CPM_CR_SET_GADDR);
+}
+
+static void set_multicast_finish(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+	scc_enet_t *ep = fep->scc.ep;
+
+	/* clear promiscuous always */
+	C16(sccp, scc_psmr, SCC_PSMR_PRO);
+
+	/* if all multi or too many multicasts; just enable all */
+	if ((dev->flags & IFF_ALLMULTI) != 0 ||
+	    dev->mc_count > SCC_MAX_MULTICAST_ADDRS) {
+
+		W16(ep, sen_gaddr1, 0xffff);
+		W16(ep, sen_gaddr2, 0xffff);
+		W16(ep, sen_gaddr3, 0xffff);
+		W16(ep, sen_gaddr4, 0xffff);
+	}
+}
+
+static void set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *pmc;
+
+	if ((dev->flags & IFF_PROMISC) == 0) {
+		set_multicast_start(dev);
+		for (pmc = dev->mc_list; pmc != NULL; pmc = pmc->next)
+			set_multicast_one(dev, pmc->dmi_addr);
+		set_multicast_finish(dev);
+	} else
+		set_promiscuous_mode(dev);
+}
+
+/*
+ * This function is called to start or restart the FEC during a link
+ * change.  This only happens when switching between half and full
+ * duplex.
+ */
+static void restart(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+	scc_enet_t *ep = fep->scc.ep;
+	const struct fs_platform_info *fpi = fep->fpi;
+	u16 paddrh, paddrm, paddrl;
+	const unsigned char *mac;
+	int i;
+
+	C32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+
+	/* clear everything (slow & steady does it) */
+	for (i = 0; i < sizeof(*ep); i++)
+		__fs_out8((char *)ep + i, 0);
+
+	/* point to bds */
+	W16(ep, sen_genscc.scc_rbase, fep->ring_mem_addr);
+	W16(ep, sen_genscc.scc_tbase,
+	    fep->ring_mem_addr + sizeof(cbd_t) * fpi->rx_ring);
+
+	/* Initialize function code registers for big-endian.
+	 */
+	W8(ep, sen_genscc.scc_rfcr, SCC_EB);
+	W8(ep, sen_genscc.scc_tfcr, SCC_EB);
+
+	/* Set maximum bytes per receive buffer.
+	 * This appears to be an Ethernet frame size, not the buffer
+	 * fragment size.  It must be a multiple of four.
+	 */
+	W16(ep, sen_genscc.scc_mrblr, 0x5f0);
+
+	/* Set CRC preset and mask.
+	 */
+	W32(ep, sen_cpres, 0xffffffff);
+	W32(ep, sen_cmask, 0xdebb20e3);
+
+	W32(ep, sen_crcec, 0);	/* CRC Error counter */
+	W32(ep, sen_alec, 0);	/* alignment error counter */
+	W32(ep, sen_disfc, 0);	/* discard frame counter */
+
+	W16(ep, sen_pads, 0x8888);	/* Tx short frame pad character */
+	W16(ep, sen_retlim, 15);	/* Retry limit threshold */
+
+	W16(ep, sen_maxflr, 0x5ee);	/* maximum frame length register */
+
+	W16(ep, sen_minflr, PKT_MINBUF_SIZE);	/* minimum frame length register */
+
+	W16(ep, sen_maxd1, 0x000005f0);	/* maximum DMA1 length */
+	W16(ep, sen_maxd2, 0x000005f0);	/* maximum DMA2 length */
+
+	/* Clear hash tables.
+	 */
+	W16(ep, sen_gaddr1, 0);
+	W16(ep, sen_gaddr2, 0);
+	W16(ep, sen_gaddr3, 0);
+	W16(ep, sen_gaddr4, 0);
+	W16(ep, sen_iaddr1, 0);
+	W16(ep, sen_iaddr2, 0);
+	W16(ep, sen_iaddr3, 0);
+	W16(ep, sen_iaddr4, 0);
+
+	/* set address 
+	 */
+	mac = dev->dev_addr;
+	paddrh = ((u16) mac[5] << 8) | mac[4];
+	paddrm = ((u16) mac[3] << 8) | mac[2];
+	paddrl = ((u16) mac[1] << 8) | mac[0];
+
+	W16(ep, sen_paddrh, paddrh);
+	W16(ep, sen_paddrm, paddrm);
+	W16(ep, sen_paddrl, paddrl);
+
+	W16(ep, sen_pper, 0);
+	W16(ep, sen_taddrl, 0);
+	W16(ep, sen_taddrm, 0);
+	W16(ep, sen_taddrh, 0);
+
+	fs_init_bds(dev);
+
+	scc_cr_cmd(fep, CPM_CR_INIT_TRX);
+
+	W16(sccp, scc_scce, 0xffff);
+
+	/* Enable interrupts we wish to service. 
+	 */
+	W16(sccp, scc_sccm, SCCE_ENET_TXE | SCCE_ENET_RXF | SCCE_ENET_TXB);
+
+	/* Set GSMR_H to enable all normal operating modes.
+	 * Set GSMR_L to enable Ethernet to MC68160.
+	 */
+	W32(sccp, scc_gsmrh, 0);
+	W32(sccp, scc_gsmrl,
+	    SCC_GSMRL_TCI | SCC_GSMRL_TPL_48 | SCC_GSMRL_TPP_10 |
+	    SCC_GSMRL_MODE_ENET);
+
+	/* Set sync/delimiters.
+	 */
+	W16(sccp, scc_dsr, 0xd555);
+
+	/* Set processing mode.  Use Ethernet CRC, catch broadcast, and
+	 * start frame search 22 bit times after RENA.
+	 */
+	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
+
+	/* Set full duplex mode if needed */
+	if (fep->duplex)
+		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
+
+	S32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+}
+
+static void stop(struct net_device *dev)	
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+	int i;
+
+	for (i = 0; (R16(sccp, scc_sccm) == 0) && i < SCC_RESET_DELAY; i++)
+		udelay(1);
+
+	if (i == SCC_RESET_DELAY)
+		printk(KERN_WARNING DRV_MODULE_NAME
+		       ": %s SCC timeout on graceful transmit stop\n",
+		       dev->name);
+
+	W16(sccp, scc_sccm, 0);
+	C32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+
+	fs_cleanup_bds(dev);
+}
+
+static void pre_request_irq(struct net_device *dev, int irq)
+{
+	immap_t *immap = fs_enet_immap;
+	u32 siel;
+
+	/* SIU interrupt */
+	if (irq >= SIU_IRQ0 && irq < SIU_LEVEL7) {
+
+		siel = in_be32(&immap->im_siu_conf.sc_siel);
+		if ((irq & 1) == 0)
+			siel |= (0x80000000 >> irq);
+		else
+			siel &= ~(0x80000000 >> (irq & ~1));
+		out_be32(&immap->im_siu_conf.sc_siel, siel);
+	}
+}
+
+static void post_free_irq(struct net_device *dev, int irq)
+{
+	/* nothing */
+}
+
+static void napi_clear_rx_event(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	W16(sccp, scc_scce, SCC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_enable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	S16(sccp, scc_sccm, SCC_NAPI_RX_EVENT_MSK);
+}
+
+static void napi_disable_rx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	C16(sccp, scc_sccm, SCC_NAPI_RX_EVENT_MSK);
+}
+
+static void rx_bd_done(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static void tx_kickstart(struct net_device *dev)
+{
+	/* nothing */
+}
+
+static u32 get_int_events(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	return (u32) R16(sccp, scc_scce);
+}
+
+static void clear_int_events(struct net_device *dev, u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	scc_t *sccp = fep->scc.sccp;
+
+	W16(sccp, scc_scce, int_events & 0xffff);
+}
+
+static void ev_error(struct net_device *dev, u32 int_events)
+{
+	printk(KERN_WARNING DRV_MODULE_NAME
+	       ": %s SCC ERROR(s) 0x%x\n", dev->name, int_events);
+}
+
+static int get_regs(struct net_device *dev, void *p, int *sizep)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (*sizep < sizeof(scc_t) + sizeof(scc_enet_t))
+		return -EINVAL;
+
+	memcpy_fromio(p, fep->scc.sccp, sizeof(scc_t));
+	p = (char *)p + sizeof(scc_t);
+
+	memcpy_fromio(p, fep->scc.ep, sizeof(scc_enet_t));
+
+	return 0;
+}
+
+static int get_regs_len(struct net_device *dev)
+{
+	return sizeof(scc_t) + sizeof(scc_enet_t);
+}
+
+static void tx_restart(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	scc_cr_cmd(fep, CPM_CR_RESTART_TX);
+}
+
+/*************************************************************************/
+
+const struct fs_ops fs_scc_ops = {
+	.setup_data		= setup_data,
+	.cleanup_data		= cleanup_data,
+	.set_multicast_list	= set_multicast_list,
+	.restart		= restart,
+	.stop			= stop,
+	.pre_request_irq	= pre_request_irq,
+	.post_free_irq		= post_free_irq,
+	.napi_clear_rx_event	= napi_clear_rx_event,
+	.napi_enable_rx		= napi_enable_rx,
+	.napi_disable_rx	= napi_disable_rx,
+	.rx_bd_done		= rx_bd_done,
+	.tx_kickstart		= tx_kickstart,
+	.get_int_events		= get_int_events,
+	.clear_int_events	= clear_int_events,
+	.ev_error		= ev_error,
+	.get_regs		= get_regs,
+	.get_regs_len		= get_regs_len,
+	.tx_restart		= tx_restart,
+	.allocate_bd		= allocate_bd,
+	.free_bd		= free_bd,
+};
--- /dev/null
+++ b/drivers/net/fs_enet/mii-bitbang.c
@@ -0,0 +1,405 @@
+/*
+ * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ * 
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
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
+static int bitbang_prep_bit(u8 **dirp, u8 **datp, u8 *mskp, int port, int bit)
+{
+	immap_t *im = (immap_t *)fs_enet_immap;
+	void *dir, *dat, *ppar;
+	int adv;
+	u8 msk;
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
+static int bitbang_prep_bit(u8 **dirp, u8 **datp, u8 *mskp, int port, int bit)
+{
+	iop_cpm2_t *io = &((cpm2_map_t *)fs_enet_immap)->im_ioport;
+	void *dir, *dat, *ppar;
+	int adv;
+	u8 msk;
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
+static inline void bb_set(u8 *p, u8 m)
+{
+	out_8(p, in_8(p) | m);
+}
+
+static inline void bb_clr(u8 *p, u8 m)
+{
+	out_8(p, in_8(p) & ~m);
+}
+
+static inline int bb_read(u8 *p, u8 m)
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
+static void bitbang_pre(struct fs_enet_mii_bus *bus, int read, u8 addr, u8 reg)
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
+	u16 rdreg;
+	int ret, j;
+	u8 addr = phy_id & 0xff;
+	u8 reg = location & 0xff;
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
+		/* PHY didn't drive TA low */
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
+	u8 addr = phy_id & 0xff;
+	u8 reg = location & 0xff;
+	u16 value = val & 0xffff;
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
+++ b/drivers/net/fs_enet/mii-fixed.c
@@ -0,0 +1,92 @@
+/*
+ * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ * 
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
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
+static const u16 mii_regs[7] = {
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

--Boundary-00=_OXiCDnyPAOpWIAX--
