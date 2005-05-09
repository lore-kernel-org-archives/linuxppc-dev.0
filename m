Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 073A867B1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:01:17 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j49C5nsR007006
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 15:05:54 +0300 (EEST)
Message-ID: <427F4D3F.1010802@intracom.gr>
Date: Mon, 09 May 2005 14:45:03 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
	Eugene Surovegin <ebs@ebshome.net>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------010908020602020507020705"
Subject: [PATCH  03/04] Freescale Ethernet combined driver
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
--------------010908020602020507020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

The following patch is a combined FCC/FEC ethernet driver
for the Freescale line of PowerQUICCs.

FECs on 8xx and FCCs on 82xx are supported.

This part of the patch contains the mac drivers
for FEC & FCC.

Regards

Pantelis

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------010908020602020507020705
Content-Type: text/x-patch;
 name="fs_enet-03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-03.patch"

--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fcc.c
@@ -0,0 +1,508 @@
+/*
+ * FCC driver for Motorola MPC8xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * Released under the GPL
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
+/* be safe version */
+#if 1
+#define __fcc_out32(addr, x)	out_be32((unsigned *)addr, x)
+#define __fcc_out16(addr, x)	out_be16((unsigned short *)addr, x)
+#define __fcc_out8(addr, x)	out_8((unsigned char *)addr, x)
+#define __fcc_in32(addr)	in_be32((unsigned *)addr)
+#define __fcc_in16(addr)	in_be16((unsigned short *)addr)
+#define __fcc_in8(addr)		in_8((unsigned char *)addr)
+#else
+#define __fcc_out32(addr, x)	__raw_writel(x, addr)
+#define __fcc_out16(addr, x)	__raw_writew(x, addr)
+#define __fcc_out8(addr, x)	__raw_writeb(x, addr)
+#define __fcc_in32(addr)	__raw_readl(addr)
+#define __fcc_in16(addr)	__raw_readw(addr)
+#define __fcc_in8(addr)		__raw_readb(addr)
+#endif
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
+static inline int fcc_cr_cmd(struct fs_enet_private *fep, __u32 mcn, __u32 op)
+{
+	cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
+	cpm_cpm2_t *cpmp = &immap->im_cpm;
+	__u32 pg, sbc, v;
+
+	pg = CPM_CR_FCC1_PAGE + fep->fcc.idx;
+	sbc = CPM_CR_FCC1_SBLOCK + fep->fcc.idx;
+	v = mk_cr_cmd(pg, sbc, mcn, op);
+	W32(cpmp, cp_cpcr, v | CPM_CR_FLG);
+	while ((R32(cpmp, cp_cpcr) & CPM_CR_FLG) != 0)
+		;
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
+	cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->fcc.idx = fs_get_fcc_index(fpi->fs_no);
+	if ((unsigned int)fep->fcc.idx >= 3)	/* max 3 FCCs */
+		return -EINVAL;
+
+	fep->fcc.fccp = &immap->im_fcc[fep->fcc.idx];
+	fep->fcc.ep = &immap->im_dprambase[PROFF_FCC1 + fep->fcc.idx * 0x100];
+	fep->fcc.fcccp = &immap->im_fcc_c[fep->fcc.idx];
+
+	fep->ev_napi_rx = FCC_NAPI_RX_EVENT_MSK;
+	fep->ev_rx = FCC_RX_EVENT;
+	fep->ev_tx = FCC_TX_EVENT;
+	fep->ev_err = FCC_ERR_EVENT_MSK;
+
+	return 0;
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
+static void set_multicast_one(struct net_device *dev, const __u8 *mac)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_enet_t *ep = fep->fcc.ep;
+	__u16 taddrh, taddrm, taddrl;
+
+	taddrh = ((__u16)mac[5] << 8) | mac[4];
+	taddrm = ((__u16)mac[3] << 8) | mac[2];
+	taddrl = ((__u16)mac[1] << 8) | mac[0];
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
+static void set_mac_address(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_enet_t *ep = fep->fcc.ep;
+	__u16 paddrh, paddrm, paddrl;
+	const unsigned char *mac = dev->dev_addr;
+
+	paddrh = ((__u16)mac[5] << 8) | mac[4];
+	paddrm = ((__u16)mac[3] << 8) | mac[2];
+	paddrl = ((__u16)mac[1] << 8) | mac[0];
+
+	W16(ep, fen_paddrh, paddrh);
+	W16(ep, fen_paddrm, paddrm);
+	W16(ep, fen_paddrl, paddrl);
+}
+
+static void restart(struct net_device *dev, int duplex, int speed)
+{
+	cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+	fcc_enet_t *ep = fep->fcc.ep;
+	__u16 paddrh, paddrm, paddrl;
+	__u16 mem_addr;
+	const unsigned char *mac;
+	int i;
+
+	C32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
+
+	/* clear everything (slow & steady does it) */
+	for (i = 0; i < sizeof(*ep); i++)
+		__fcc_out8((char *)ep + i, 0);
+
+	/* point to bds */
+	W32(ep, fen_genfcc.fcc_rbase, iopa((__u32)fep->rx_bd_base));
+	W32(ep, fen_genfcc.fcc_tbase, iopa((__u32)fep->tx_bd_base));
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
+	mem_addr = CPM_FCC_SPECIAL_BASE + fep->fcc.idx * 128;
+	W16(ep, fen_genfcc.fcc_riptr, (mem_addr & 0xffff));
+	W16(ep, fen_genfcc.fcc_tiptr, ((mem_addr + 32) & 0xffff));
+	W16(ep, fen_padptr, mem_addr + 64);
+	for (i = 64; i < 128; i++)
+		__fcc_out8(immap->im_dprambase + mem_addr + i, 0x88);
+
+	W32(ep, fen_genfcc.fcc_rbptr, 0);
+	W32(ep, fen_genfcc.fcc_tbptr, 0);
+	W32(ep, fen_genfcc.fcc_rcrc, 0);
+	W32(ep, fen_genfcc.fcc_tcrc, 0);
+	W32(ep, fen_genfcc.fcc_res1, 0);
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
+	paddrh = ((__u16)mac[5] << 8) | mac[4];
+	paddrm = ((__u16)mac[3] << 8) | mac[2];
+	paddrl = ((__u16)mac[1] << 8) | mac[0];
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
+	fcc_cr_cmd(fep, 0x0c, CPM_CR_INIT_TRX);
+
+	W16(ep, fen_genfcc.fcc_mrblr, PKT_MAXBLR_SIZE);
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
+	W32(fccp, fcc_fpsmr, FCC_PSMR_ENCRC | FCC_PSMR_RMII);
+
+	/* adjust to duplex mode */
+	if (duplex)
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
+static __u32 get_int_events(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	return (__u32)R16(fccp, fcc_fcce);
+}
+
+static void clear_int_events(struct net_device *dev, __u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	W16(fccp, fcc_fcce, int_events & 0xffff);
+}
+
+static void ev_error(struct net_device *dev, __u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	(void)fep;
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
+	.set_promiscuous_mode	= set_promiscuous_mode,
+	.set_multicast_start	= set_multicast_start,
+	.set_multicast_one	= set_multicast_one,
+	.set_multicast_finish	= set_multicast_finish,
+	.set_mac_address	= set_mac_address,
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
+};
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
@@ -0,0 +1,633 @@
+/*
+ * Freescale Ethernet controllers
+ *
+ * Copyright (c) 2005 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * Released under the GPL
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
+/* FEC access macros */
+#if defined(CONFIG_8xx)
+/* for a 8xx __raw_xxx's are sufficient */
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
+#define FW(_fecp, _reg, _v) __fs_out32(&(_fecp)->fs_ ## _reg, (_v))
+
+/* read */
+#define FR(_fecp, _reg)	__fs_in32(&(_fecp)->fs_ ## _reg)
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
+#define FEC_NAPI_RX_EVENT_MSK	(FEC_ENET_RXF | FEC_ENET_RXB)
+#define FEC_RX_EVENT		(FEC_ENET_RXF)
+#define FEC_TX_EVENT		(FEC_ENET_TXF)
+#define FEC_ERR_EVENT_MSK	(FEC_ENET_HBERR | FEC_ENET_BABR | \
+				 FEC_ENET_BABT | FEC_ENET_EBERR)
+
+static int setup_data(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+
+	fep->fec.idx = fs_get_fec_index(fpi->fs_no);
+	switch (fep->fec.idx) {
+		case 0:
+			fep->fec.fecp = &((immap_t *)IMAP_ADDR)->im_cpm.cp_fec;
+			break;
+#ifdef CONFIG_DUET
+		case 1:
+			fep->fec.fecp = &((immap_t *)IMAP_ADDR)->im_cpm.cp_fec2;
+			break;
+#endif
+		default:
+			return -EINVAL;
+	}
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
+static void set_multicast_one(struct net_device *dev, const __u8 *mac)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	int temp, hash_index, i, j;
+	__u32 crc, csrVal;
+	__u8 byte, msb;
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
+static void set_mac_address(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+	__u32 addrhi, addrlo;
+
+	/*
+	 * Set station address. 
+	 */
+	addrhi = ((__u32) dev->dev_addr[0] << 24) |
+		 ((__u32) dev->dev_addr[1] << 16) |
+	   	 ((__u32) dev->dev_addr[2] <<  8) |
+	    	  (__u32) dev->dev_addr[3];
+	addrlo = ((__u32) dev->dev_addr[4] << 24) |
+	    	 ((__u32) dev->dev_addr[5] << 16);
+	FW(fecp, addr_low, addrhi);
+	FW(fecp, addr_high, addrlo);
+}
+
+/*
+ * This function is called to start or restart the FEC during a link
+ * change.  This only happens when switching between half and full
+ * duplex.
+ */
+static void restart(struct net_device *dev, int duplex, int speed)
+{
+#ifdef CONFIG_DUET
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	__u32 cptr;
+#endif
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+	const struct fs_platform_info *fpi = fep->fpi;
+	int r;
+	__u32 addrhi, addrlo;
+
+	r = whack_reset(fep->fec.fecp);
+	if (r != 0)
+		printk(KERN_ERR DRV_MODULE_NAME
+				": %s FEC Reset FAILED!\n", dev->name);
+
+	/*
+	 * Set station address. 
+	 */
+	addrhi = ((__u32) dev->dev_addr[0] << 24) |
+		 ((__u32) dev->dev_addr[1] << 16) |
+		 ((__u32) dev->dev_addr[2] <<  8) |
+		 (__u32) dev->dev_addr[3];
+	addrlo = ((__u32) dev->dev_addr[4] << 24) |
+		 ((__u32) dev->dev_addr[5] << 16);
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
+	/*
+	 * Set receive and transmit descriptor base. 
+	 */
+	FW(fecp, r_des_start, iopa((__u32)fep->rx_bd_base));
+	FW(fecp, x_des_start, iopa((__u32)fep->tx_bd_base));
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
+	FW(fecp, ivec, (fpi->fs_irq / 2) << 29);
+
+	/*
+	 * adjust to speed (only for DUET & RMII) 
+	 */
+#ifdef CONFIG_DUET
+	cptr = in_be32(&immap->im_cpm.cp_cptr);
+	switch (fs_get_fec_index(fpi->fs_no)) {
+	case 0:
+		/*
+		 * check if in RMII mode 
+		 */
+		if ((cptr & 0x100) == 0)
+			break;
+
+		if (speed == 10)
+			cptr |= 0x0000010;
+		else if (speed == 100)
+			cptr &= ~0x0000010;
+		break;
+	case 1:
+		/*
+		 * check if in RMII mode 
+		 */
+		if ((cptr & 0x80) == 0)
+			break;
+
+		if (speed == 10)
+			cptr |= 0x0000008;
+		else if (speed == 100)
+			cptr &= ~0x0000008;
+		break;
+	default:
+		BUG();	/* should never happen */
+		break;
+	}
+	out_be32(&immap->im_cpm.cp_cptr, cptr);
+#endif
+
+	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+	/*
+	 * adjust to duplex mode 
+	 */
+	if (duplex) {
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
+	FW(fecp, ecntrl, ~FEC_ECNTRL_ETHER_EN);
+
+	fs_cleanup_bds(dev);
+}
+
+static void pre_request_irq(struct net_device *dev, int irq)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	__u32 siel;
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
+static __u32 get_int_events(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	return FR(fecp, ievent) & FR(fecp, imask);
+}
+
+static void clear_int_events(struct net_device *dev, __u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fec_t *fecp = fep->fec.fecp;
+
+	FW(fecp, ievent, int_events);
+}
+
+static void ev_error(struct net_device *dev, __u32 int_events)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	(void)fep;
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
+	.set_promiscuous_mode	= set_promiscuous_mode,
+	.set_multicast_start	= set_multicast_start,
+	.set_multicast_one	= set_multicast_one,
+	.set_multicast_finish	= set_multicast_finish,
+	.set_mac_address	= set_mac_address,
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
+	switch (bi->id) {
+		case 0:
+			bus->fec.fecp = &((immap_t *)IMAP_ADDR)->im_cpm.cp_fec;
+			break;
+#ifdef CONFIG_DUET
+		case 1:
+			bus->fec.fecp = &((immap_t *)IMAP_ADDR)->im_cpm.cp_fec2;
+			break;
+#endif
+		default:
+			return -EINVAL;
+	}
+
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

--------------010908020602020507020705--
