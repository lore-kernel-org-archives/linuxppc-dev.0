Message-ID: <37DE6AC5.EAF9A6DD@kieray1.p.y.ki.era.ericsson.se>
Date: Tue, 14 Sep 1999 17:33:25 +0200
From: Marcus Sundberg <erammsu@kieray1.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC: porting to new platforms
References: <37DC6656.2A40D04D@ctam.com.au> <37DC7E94.946FBA49@jlc.net>
Content-Type: multipart/mixed; boundary="------------C72CF2C94313E0D8339BB43C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------C72CF2C94313E0D8339BB43C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Malek wrote:
> Send them to me and I will merge them with the many other I get.
> When it all fits together I'll check it into CVS.

Ok, here comes a mixture of updates/suggestions for the embedded
port:

* in arch/ppc/config.in this code breaks 8xx configuration:
  if [ "$CONFIG_PPC64" != "y" ];then
    define_bool CONFIG_6xx y
  fi

* Move "commproc.h" ==> <asm/8xx_cpm.h> so external modules can
  access it in a clean way. (I can send a diff if you want)

* Do EXPORT_SYMBOL(cpm_install_handler) so modules can use this
  function.

* As at least the 860 is quite crowded with bugs it's nice to have
  a nice way to handle bug workarounds. The attached mpc8xx_bug.h
  is what we use to compile kernels for different hardware revisions.

* The workaround we had for the CPU6 bug (don't know if Magnus Damm
  received it from you or someone else) failed to fix pgtable.h.
  Here's the diff for that:
RCS file: /cvs_repository/linux/include/asm-ppc/mpc8xx.h,v
diff -u
--- mpc8xx.h    1999/07/16 17:00:08     1.4
+++ mpc8xx.h    1999/07/21 17:50:25     1.5
@@ -9,6 +9,7 @@
 #define __CONFIG_8xx_DEFS
 
 #include <asm/ptrace.h> /* For struct pt_regs */
+#include <asm/mpc8xx_bug.h>
 
 #ifdef CONFIG_MBX
 #include <asm/mbx.h>
RCS file: /cvs_repository/linux/include/asm-ppc/pgtable.h,v
diff -u
--- pgtable.h   1999/08/27 08:57:38     1.1.1.2
+++ pgtable.h   1999/08/27 09:38:56     1.3
@@ -8,6 +8,9 @@
 #include <asm/processor.h>             /* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+#ifdef CONFIG_8xx
+#include <asm/mpc8xx.h>                        /* For set_m_twb() */
+#endif
 
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
@@ -230,7 +233,7 @@
  do { \
        unsigned long __pgdir = (unsigned long)pgdir; \
        ((tsk)->tss.pg_tables = (unsigned long *)(__pgdir)); \
-       asm("mtspr %0,%1 \n\t" : : "i"(M_TWB), "r"(__pa(__pgdir))); \
+       set_m_twb(__pa(__pgdir)); \
  } while (0)
 #endif /* CONFIG_8xx */
   
* In the FEC driver around line 318:
	    bdp = fep->dirty_tx;
	    while ((bdp->cbd_sc&BD_ENET_TX_READY)==0) {
#if 1
		if (bdp==fep->cur_tx)
		    break;
#endif
  the if statement will be true not only when the transmit ring is
  empty, but also when it is completely full! This is what caused
  the ringdumps and subsequent FEC lockups I belive Magnus mentioned
  to you. I'm attaching the FEC driver we have been using here for
  the last two months. I've also tried to clean up the init code and
  add working open/close functions. We are using it with 2.2.12,
  but the changes between embedded-2.2.5 and mpc8xx-2.3.10 seemed
  minor. (CONFIG_IPI is what we use for our custom board).
  
//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se
--------------C72CF2C94313E0D8339BB43C
Content-Type: text/plain; charset=us-ascii; name="mpc8xx_bug.h"
Content-Disposition: inline; filename="mpc8xx_bug.h"
Content-Transfer-Encoding: 7bit

/* MPC860 family bug workarounds
*/

#ifndef _ASM_MPC860_BUG_H
#define _ASM_MPC860_BUG_H

#if defined(CONFIG_MPC860T)

#if defined(CONFIG_MPC860T_NOBUGS)
/* Nothing to do */
#elif defined(CONFIG_MPC860T_B5)
#define MPC8xxBUG_FEC1	1
#define MPC8xxBUG_FEC2	1
#define MPC8xxBUG_FEC3	1
#define MPC8xxBUG_FEC5	1
#define MPC8xxBUG_FEC6	1
#define MPC8xxBUG_FEC7	1
#define MPC8xxBUG_FEC11	1
#define MPC8xxBUG_FEC12	1
#define MPC8xxBUG_FEC13	1
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10	1
#elif defined(CONFIG_MPC860T_B3)
#define MPC8xxBUG_FEC1	1
#define MPC8xxBUG_FEC2	1
#define MPC8xxBUG_FEC3	1
#define MPC8xxBUG_FEC5	1
#define MPC8xxBUG_FEC6	1
#define MPC8xxBUG_FEC7	1
#define MPC8xxBUG_FEC11	1
#define MPC8xxBUG_FEC12	1
#define MPC8xxBUG_FEC13	1
#define MPC8xxBUG_FEC14	1
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10	1
#elif defined(CONFIG_MPC860T_B2)
#define MPC8xxBUG_FEC1	1
#define MPC8xxBUG_FEC2	1
#define MPC8xxBUG_FEC3	1
#define MPC8xxBUG_FEC4	1
#define MPC8xxBUG_FEC5	1
#define MPC8xxBUG_FEC6	1
#define MPC8xxBUG_FEC7	1
#define MPC8xxBUG_FEC8	1
#define MPC8xxBUG_FEC9	1
#define MPC8xxBUG_FEC10	1
#define MPC8xxBUG_FEC11	1
#define MPC8xxBUG_FEC12	1
#define MPC8xxBUG_FEC13	1
#define MPC8xxBUG_FEC14	1
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10	1
#else
#error Either define CPU revision or define CONFIG_MPC860T_NOBUGS
#endif

#elif defined(CONFIG_MPC860) /* ! CONFIG_MPC860T */

#if defined(CONFIG_MPC860_NOBUGS)
/* Nothing to do */
#elif defined(CONFIG_MPC860_C1)
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU9	1
#define MPC8xxBUG_CPU10	1
#elif defined(CONFIG_MPC860_C0)
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10	1
#elif defined(CONFIG_MPC860_B1)
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10 1
#elif defined(CONFIG_MPC860_A3)
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU3	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10 1
#elif defined(CONFIG_MPC860_A2)
#define MPC8xxBUG_CPU1	1
#define MPC8xxBUG_CPU2	1
#define MPC8xxBUG_CPU3	1
#define MPC8xxBUG_CPU4	1
#define MPC8xxBUG_CPU5	1
#define MPC8xxBUG_CPU6	1
#define MPC8xxBUG_CPU7	1
#define MPC8xxBUG_CPU8	1
#define MPC8xxBUG_CPU10 1
#else
#error Either define CPU revision or define CONFIG_MPC860T_NOBUGS
#endif

#else /* ! CONFIG_MPC860 */

#warning No bug workarounds implemented for this 8xx CPU

#endif /* CONFIG_MPC860T */

/*
  MPC860* CPU6 workaround defines
*/
#define IMMR_ADDR	0x3d30
#define IC_CST_ADDR	0x2110
#define IC_ADR_ADDR	0x2310
#define IC_DAT_ADDR	0x2510
#define DC_CST_ADDR	0x3110
#define DC_ADR_ADDR	0x3310
#define DC_DAT_ADDR	0x3510
#define MI_CTR_ADDR	0x2180
#define MI_AP_ADDR	0x2580
#define MI_EPN_ADDR	0x2780
#define MI_TWC_ADDR	0x2b80
#define MI_RPN_ADDR	0x2d80
#define MI_DBCAM_ADDR	0x2190
#define MI_DBRAM0_ADDR	0x2390
#define MI_DBRAM1_ADDR	0x2590
#define MD_CTR_ADDR	0x3180
#define M_CASID_ADDR	0x3380
#define MD_AP_ADDR	0x3580
#define MD_EPN_ADDR	0x3780
#define M_TWB_ADDR	0x3980
#define MD_TWC_ADDR	0x3b80
#define MD_RPN_ADDR	0x3d80
#define M_TW_ADDR	0x3f80
#define MD_DBCAM_ADDR	0x3190
#define MD_DBRAM0_ADDR	0x3390
#define MD_DBRAM1_ADDR	0x3590
#define DEC_ADDR	0x2c00
#define TB_ADDR		0x3880
#define TBU_ADDR	0x3a80
#define DPDR_ADDR	0x2d30

#ifndef __ASSEMBLY__
#ifndef MPC8xxBUG_CPU6
#define set_m_twb(val)	asm("mtspr %0,%1 \n\t" : : "i"(M_TWB), "r"((val)))
#else
#define set_m_twb(val) \
do {	unsigned long dummy_var; \
	register unsigned long reg5 __asm__ ("r5") = M_TWB_ADDR; \
	register unsigned long reg4 __asm__ ("r4") = (unsigned long) &dummy_var; \
	asm volatile ( \
		"stw   %3,0(%2)\n\t" \
		"lwz   %3,0(%2)\n\t" \
		"mtspr %0,%1 \n\t" \
	    : : "i"(M_TWB), "r"((val)), "r"(reg4), "r"(reg5) \
		       : "r4", "r5", "memory"); }while(0)
#endif
#endif /* __ASSEMBLY__ */

/*
  MPC860* CPU8 workaround defines
*/
#define ICTRL				158
#  define ISCT_SER_MASK			0x07
#  define ISCT_SER_SHOW_ALL		0x00
#  define ISCT_SER_SHOW_CHANGES		0x01
#  define ISCT_SER_SHOW_ICHANGES	0x02
#  define ISCT_SER_NOSHOW		0x03
/* Illegal 				0x04 */
#  define ISCT_SER_NORM_SHOW_CHANGES	0x05
#  define ISCT_SER_NORM_SHOW_ICHANGES	0x06
#  define ISCT_SER_NORM_NOSHOW		0x07

#endif /* _ASM_MPC860_BUG_H */

--------------C72CF2C94313E0D8339BB43C
Content-Type: text/plain; charset=us-ascii; name="fec.c"
Content-Disposition: inline; filename="fec.c"
Content-Transfer-Encoding: 7bit

/*
 * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
 * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
 *
 * This version of the driver is specific to the FADS implementation,
 * since the board contains control registers external to the processor
 * for the control of the LevelOne LXT970 transceiver.  The MPC860T manual
 * describes connections using the internal parallel port I/O, which
 * is basically all of Port D.
 *
 * Right now, I am very wasteful with the buffers.  I allocate memory
 * pages and then divide them into 2K frame buffers.  This way I know I
 * have buffers large enough to hold one frame within one buffer descriptor.
 * Once I get this working, I will use 64 or 128 byte CPM buffers, which
 * will be much more memory efficient and will easily handle lots of
 * small packets.
 *
 */
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/ptrace.h>
#include <linux/errno.h>
#include <linux/ioport.h>
#include <linux/malloc.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>

#include <asm/8xx_immap.h>
#include <asm/pgtable.h>
#include <asm/mpc8xx.h>
#include <asm/irq.h>
#include <asm/bitops.h>
#include <asm/uaccess.h>
#include <asm/8xx_cpm.h>

/* The maximum time waited (in jiffies) before assuming a Tx failed. (20ms) */
#define TX_TIMEOUT (20*HZ/1000)

/* The number of Tx and Rx buffers.  These are allocated from the page
 * pool.  The code may assume these are power of two, so it it best
 * to keep them that size.
 * We don't need to allocate pages for the transmitter.  We just use
 * the skbuffer directly.
 */
#if 1
#define FEC_ENET_RX_PAGES	4
#define FEC_ENET_RX_FRSIZE	2048
#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
#define TX_RING_SIZE		8	/* Must be power of two */
#define TX_RING_MOD_MASK	7	/*   for this to work */
#else
#define FEC_ENET_RX_PAGES	16
#define FEC_ENET_RX_FRSIZE	2048
#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
#define TX_RING_SIZE		16	/* Must be power of two */
#define TX_RING_MOD_MASK	15	/*   for this to work */
#endif

/* Interrupt events/masks.
*/
#define FEC_ENET_HBERR	((uint)0x80000000)	/* Heartbeat error */
#define FEC_ENET_BABR	((uint)0x40000000)	/* Babbling receiver */
#define FEC_ENET_BABT	((uint)0x20000000)	/* Babbling transmitter */
#define FEC_ENET_GRA	((uint)0x10000000)	/* Graceful stop complete */
#define FEC_ENET_TXF	((uint)0x08000000)	/* Full frame transmitted */
#define FEC_ENET_TXB	((uint)0x04000000)	/* A buffer was transmitted */
#define FEC_ENET_RXF	((uint)0x02000000)	/* Full frame received */
#define FEC_ENET_RXB	((uint)0x01000000)	/* A buffer was received */
#define FEC_ENET_MII	((uint)0x00800000)	/* MII interrupt */
#define FEC_ENET_EBERR	((uint)0x00400000)	/* SDMA bus error */

/* The FEC stores dest/src/type, data, and checksum for receive packets.
 */
#define PKT_MAXBUF_SIZE		1518
#define PKT_MINBUF_SIZE		64
#define PKT_MAXBLR_SIZE		1520


/* Ethernet address of device */
static	ushort	my_enet_addr[] = { 0x0800, 0x3e26, 0x1559 };


/* The FEC buffer descriptors track the ring buffers.  The rx_bd_base and
 * tx_bd_base always point to the base of the buffer descriptors.  The
 * cur_rx and cur_tx point to the currently available buffer.
 * The dirty_tx tracks the current buffer that is being sent by the
 * controller.  The cur_tx and dirty_tx are equal under both completely
 * empty and completely full conditions.  The empty/ready indicator in
 * the buffer descriptor determines the actual condition.
 */
struct fec_enet_private {
	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
	struct	sk_buff* tx_skbuff[TX_RING_SIZE];
	ushort	skb_cur;
	ushort	skb_dirty;

	/* CPM dual port RAM relative addresses.
	*/
	cbd_t	*rx_bd_base;		/* Address of Rx and Tx buffers. */
	cbd_t	*tx_bd_base;
	cbd_t	*cur_rx, *cur_tx;		/* The next free ring entry */
	cbd_t	*dirty_tx;	/* The ring entries to be free()ed. */
	scc_t	*sccp;
	struct	net_device_stats stats;
	char	tx_full;
	unsigned long lock;
	unsigned int  tx_queued;/* Number of packets in the Tx queue */
	unsigned long rx_bd_pa;	/* Physical address of Rx ring start. */
	unsigned long tx_bd_pa;	/* Physical address of Tx ring start. */
};

static int  fec_enet_open(struct device *dev);
static int  fec_enet_close(struct device *dev);
static struct net_device_stats *fec_enet_get_stats(struct device *dev);
static void set_multicast_list(struct device *dev);
static int  fec_enet_start_xmit(struct sk_buff *skb, struct device *dev);
/* Interrupt handler */
static void fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs);
/* Interrupt helpers */
static int  fec_enet_tx(struct device *dev);
static int  fec_enet_rx(struct device *dev);
static void fec_enet_mii(struct device *dev);

/* Reset/Init functions */
static void FEC_reset(struct device *dev);
static void FEC_init(struct device *dev);

/* MII processing.  We keep this as simple as possible.  Requests are
 * placed on the list (if there is room).  When the request is finished
 * by the MII, an optional function may be called.
 */
typedef struct mii_list {
	uint	mii_regval;
	void	(*mii_func)(uint val);
	struct	mii_list *mii_next;
} mii_list_t;

#define		NMII	10
static mii_list_t	mii_cmds[NMII];
static mii_list_t	*mii_free;
static mii_list_t	*mii_head;
static mii_list_t	*mii_tail;

static int mii_queue(volatile fec_t *fecp, int request, void (*func)(uint));

/* Make MII read/write commands for the FEC.
*/
#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | \
						(VAL & 0xffff))

#ifndef final_version
static void ringdump(struct device *dev)
{
	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
	int	i;
	cbd_t	*bdp;

	printk("Ring data dump: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
	       (unsigned long)fep->cur_tx, fep->tx_full ? " (full)" : "",
	       (unsigned long)fep->dirty_tx,
	       (unsigned long)fep->cur_rx);
  
	bdp = fep->tx_bd_base;
	printk(" tx: %u buffers\n",  TX_RING_SIZE);
	for (i = 0 ; i < TX_RING_SIZE; i++) {
		printk("  %08x: %04x %04x %08x\n", 
		       (uint) bdp,
		       bdp->cbd_sc,
		       bdp->cbd_datlen,
		       bdp->cbd_bufaddr);
		bdp++;
	}

	bdp = fep->rx_bd_base;
	printk(" rx: %lu buffers\n",  RX_RING_SIZE);
	for (i = 0 ; i < RX_RING_SIZE; i++) {
		printk("  %08x: %04x %04x %08x\n",
		       (uint) bdp,
		       bdp->cbd_sc,
		       bdp->cbd_datlen,
		       bdp->cbd_bufaddr);
		bdp++;
	}
}
#endif


static int
fec_enet_start_xmit(struct sk_buff *skb, struct device *dev)
{
	struct fec_enet_private *fep;
	volatile fec_t	*fecp;
	volatile cbd_t	*bdp;
	unsigned long flags;

	fep = dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;

	/* Transmitter timeout, serious problems. */
	if (dev->tbusy) {
		int tickssofar = jiffies - dev->trans_start;

		if (tickssofar < TX_TIMEOUT) return 1;

		fep->stats.tx_errors++;
		printk("%s: transmit timed out.\n", dev->name);
#ifndef final_version
		ringdump(dev);
#endif
		FEC_reset(dev);
		FEC_init(dev);
	}

	/* Block a timer-based transmit from overlapping.  This could better be
	   done with atomic_swap(1, dev->tbusy), but set_bit() works as well.*/
	if (test_and_set_bit(0, (void*)&dev->tbusy) != 0) {
		printk("%s: Transmitter access conflict.\n", dev->name);
		return 1;
	}

	if (test_and_set_bit(0, (void*)&fep->lock) != 0) {
		printk("%s: tx queue lock!.\n", dev->name);
		/* don't clear dev->tbusy flag. */
		return 1;
	}

	/* Fill in a Tx ring entry */
	bdp = fep->cur_tx;

#if !defined(final_version)
	if (bdp->cbd_sc & BD_ENET_TX_READY) {
		/* Ooops.  All transmit buffers are full.  Bail out.
		 * This should not happen, since dev->tbusy should be set.
		 */
		printk("%s: tx queue full!.\n", dev->name);
		fep->lock = 0;
		return 1;
	}
#endif

	/* Clear all of the status flags.
	 */
	bdp->cbd_sc &= ~BD_ENET_TX_STATS;

	/* Set buffer length and buffer pointer.
	*/
	bdp->cbd_bufaddr = __pa(skb->data);
	bdp->cbd_datlen = skb->len;

	/* Save skb pointer.
	*/
	fep->tx_skbuff[fep->skb_cur] = skb;

	fep->stats.tx_bytes += skb->len;
	fep->skb_cur = (fep->skb_cur+1) & TX_RING_MOD_MASK;
	
	/* Push the data cache so the CPM does not get stale memory
	 * data.
	 */
	flush_dcache_range((unsigned long)skb->data,
			   (unsigned long)skb->data + skb->len);

	save_flags(flags);
	cli();

	/* Send it on its way.  Tell CPM its ready,
	   its the last BD of the frame, and to put the CRC on the end.
	 */
	bdp->cbd_sc |= (BD_ENET_TX_READY | BD_ENET_TX_LAST | BD_ENET_TX_TC);

	dev->trans_start = jiffies;

	/* If this was the last BD in the ring, start at the beginning again.
	*/
	if ((bdp->cbd_sc & BD_ENET_TX_WRAP)) {
		bdp = fep->tx_bd_base;
	} else {
		bdp++;
	}

	/* Trigger transmission start */
	fecp->fec_x_des_active = 0x01000000;

	if (bdp->cbd_sc & BD_ENET_TX_READY) {
#if 0
		printk("fec: txbuf %08x full - sc = 0x%08x\n", (uint) bdp, bdp->cbd_sc);
#endif
		fep->tx_full = 1;
		dev->tbusy = 1;
	} else {
		fep->tx_full = 0;
		dev->tbusy = 0;
	}

	fep->cur_tx = (cbd_t *)bdp;
	fep->tx_queued++;
		
	restore_flags(flags);

	fep->lock = 0;

	return 0;
}


/* The interrupt handler.
 * This is called from the MPC core interrupt.
 */
static void
fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
{
	struct	device *dev = dev_id;
	struct	fec_enet_private *fep = dev->priv;
	volatile fec_t	*fecp;
	uint	int_events;

	fecp = (volatile fec_t*)dev->base_addr;

	if (dev->interrupt) {
		printk("%s: Re-entering the interrupt handler.\n", dev->name);
	}
	dev->interrupt = 1;

	/* Get the interrupt events that caused us to be here.
	*/
	while ((int_events = fecp->fec_ievent) != 0) {
		fecp->fec_ievent = int_events;

		if ((int_events &
		     (FEC_ENET_HBERR | FEC_ENET_BABR |
		      FEC_ENET_BABT | FEC_ENET_EBERR)) != 0) {
			printk("FEC ERROR %x\n", int_events);
		}

		/* Handle receive event in its own function.
		 */
		if ((int_events & (FEC_ENET_RXF | FEC_ENET_RXB))) {
#if 0
			uint ev = int_events & (FEC_ENET_RXF | FEC_ENET_RXB);
			if (ev == FEC_ENET_RXF) printk("RX F\n");
			else if (ev == FEC_ENET_RXB) printk("RX B\n");
			else printk("RX both\n");
#endif
			fec_enet_rx(dev);
		}

		/* Transmit OK, or non-fatal error.  Update the buffer
		   descriptors.
		   FEC handles all errors, we just discover them as part of the
		   transmit process.
		*/
		if ((int_events & (FEC_ENET_TXF | FEC_ENET_TXB)) || 1) {
#if 0
			uint ev = int_events & (FEC_ENET_TXF | FEC_ENET_TXB);
			if (ev == FEC_ENET_TXF) printk("TX F\n");
			else if (ev == FEC_ENET_TXB) printk("TX B\n");
			else printk("TX both\n");
#endif
			fec_enet_tx(dev);
		}

		if (int_events & FEC_ENET_MII) {
			fec_enet_mii(dev_id);
		}
	} /* while any events */

	dev->interrupt = 0;
}


static int
fec_enet_tx(struct device *dev)
{
	struct	fec_enet_private *fep;
	volatile cbd_t	*bdp;
	struct	sk_buff	*skb;

	fep = (struct fec_enet_private *)dev->priv;
	bdp = fep->dirty_tx;

	while ((bdp->cbd_sc & BD_ENET_TX_READY) == 0 && fep->tx_queued > 0) {
		skb = fep->tx_skbuff[fep->skb_dirty];
		/* Check for errors. */
		if (bdp->cbd_sc & BD_ENET_TX_ERR) {
			fep->stats.tx_errors++;			
			if (bdp->cbd_sc & BD_ENET_TX_HB)  /* No heartbeat */
				fep->stats.tx_heartbeat_errors++;
			if (bdp->cbd_sc & BD_ENET_TX_LC)  /* Late collision */
				fep->stats.tx_window_errors++;
			if (bdp->cbd_sc & BD_ENET_TX_RL)  /* Retrans limit */
				fep->stats.tx_aborted_errors++;
			if (bdp->cbd_sc & BD_ENET_TX_UN)  /* Underrun */
				fep->stats.tx_fifo_errors++;
			if (bdp->cbd_sc & BD_ENET_TX_CSL) /* Carrier lost */
				fep->stats.tx_carrier_errors++;
		} else {
			fep->stats.tx_packets++;
		}

		/* Deferred means some collisions occurred during transmit,
		 * but we eventually sent the packet OK.
		 */
		if (bdp->cbd_sc & BD_ENET_TX_DEF) {
			fep->stats.collisions++;
		}
	    
		/* Free the sk buffer associated with this last transmit.
		 */
		dev_kfree_skb(skb/*, FREE_WRITE*/);
		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;

		/* Update pointer to next buffer descriptor to be transmitted.
		 */
		if (bdp->cbd_sc & BD_ENET_TX_WRAP) {
			bdp = fep->tx_bd_base;
		} else {
			bdp++;
		}

		fep->tx_queued--;

		/* Since we have freed up a buffer, the ring is no longer
		 * full.
		 */
		if (fep->tx_full && dev->tbusy) {
			fep->tx_full = 0;
			dev->tbusy = 0;
			mark_bh(NET_BH);
		}
	}

	fep->dirty_tx = (cbd_t *)bdp;

	return 0;
}
	

/* During a receive, the cur_rx points to the current incoming buffer.
 * When we update through the ring, if the next incoming buffer has
 * not been given to the system, we just set the empty indicator,
 * effectively tossing the packet.
 */
static int
fec_enet_rx(struct device *dev)
{
	struct	fec_enet_private *fep;
	volatile cbd_t *bdp;
	struct	sk_buff	*skb;
	ushort	pkt_len;
	volatile fec_t	*fecp;

	fep = dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;

	/* First, grab all of the stats for the incoming packet.
	 * These get messed up if we get called due to a busy condition.
	 */
	bdp = fep->cur_rx;

while (!(bdp->cbd_sc & BD_ENET_RX_EMPTY)) {

#ifndef final_version
	/* Since we have allocated space to hold a complete frame,
	 * the last indicator should be set.
	 */
	if ((bdp->cbd_sc & BD_ENET_RX_LAST) == 0)
		printk("FEC ENET: rcv is not +last\n");
#endif

	/* Check for errors. */
	if (bdp->cbd_sc & BD_ENET_RX_ERR) {
		fep->stats.rx_errors++;
		if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
			/* Frame too long or too short. */
			fep->stats.rx_length_errors++;
		}
		if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
			fep->stats.rx_frame_errors++;
		if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
			fep->stats.rx_crc_errors++;
		if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
			fep->stats.rx_crc_errors++;
	}

	/* Report late collisions as a frame error.
	 * On this error, the BD is closed, but we don't know what we
	 * have in the buffer.  So, just drop this frame on the floor.
	 */
	if (bdp->cbd_sc & BD_ENET_RX_CL) {
		fep->stats.rx_errors++;
		fep->stats.rx_frame_errors++;
		goto rx_processing_done;
	}

	/* Process the incoming frame.
	 */
	fep->stats.rx_packets++;
	pkt_len = bdp->cbd_datlen;
	fep->stats.rx_bytes += pkt_len;

	/* This does 16 byte alignment, exactly what we need.
	 */
	skb = dev_alloc_skb(pkt_len);

	if (skb == NULL) {
		printk("%s: Memory squeeze, dropping packet.\n",
		       dev->name);
		fep->stats.rx_dropped++;
	} else {
		skb->dev = dev;
		skb_put(skb,pkt_len);	/* Make room */
		eth_copy_and_sum(skb, (unsigned char *)__va(bdp->cbd_bufaddr),
				 pkt_len, 0);
		skb->protocol = eth_type_trans(skb,dev);
		netif_rx(skb);
	}
 rx_processing_done:

	/* Clear the status flags for this buffer.
	*/
	bdp->cbd_sc &= ~BD_ENET_RX_STATS;

	/* Mark the buffer empty.
	*/
	bdp->cbd_sc |= BD_ENET_RX_EMPTY;

	/* Update BD pointer to next entry.
	*/
	if (bdp->cbd_sc & BD_ENET_RX_WRAP) {
		bdp = fep->rx_bd_base;
	} else {
		bdp++;
	}

#if 1
	/* Doing this here will keep the FEC running while we process
	 * incoming frames.  On a heavily loaded network, we should be
	 * able to keep up at the expense of system resources.
	 */
	fecp->fec_r_des_active = 0x01000000;
#endif
} /* while (bdp->cbd_sc & BD_ENET_RX_EMPTY) */
	fep->cur_rx = (cbd_t *)bdp;

#if 0
	/* Doing this here will allow us to process all frames in the
	 * ring before the FEC is allowed to put more there.  On a heavily
	 * loaded network, some frames may be lost.  Unfortunately, this
	 * increases the interrupt overhead since we can potentially work
	 * our way back to the interrupt return only to come right back
	 * here.
	 */
	fecp->fec_r_des_active = 0x01000000;
#endif

	return 0;
}

static void
fec_enet_mii(struct device *dev)
{
	struct	fec_enet_private *fep;
	volatile fec_t	*fecp;
	mii_list_t	*mip;
	uint		mii_reg;

	fep = dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;

	mii_reg = fecp->fec_mii_data;
	
	if ((mip = mii_head) == NULL) {
		printk("MII and no head!\n");
		return;
	}

	if (mip->mii_func != NULL) (*(mip->mii_func))(mii_reg);

	mii_head = mip->mii_next;
	mip->mii_next = mii_free;
	mii_free = mip;

	if ((mip = mii_head) != NULL) fecp->fec_mii_data = mip->mii_regval;
}

static int
mii_queue(volatile fec_t  *fecp, int regval, void (*func)(uint))
{
	unsigned long	flags;
	mii_list_t	*mip;
	int		retval;

	retval = 0;

	save_flags(flags);
	cli();

	if ((mip = mii_free) != NULL) {
		mii_free = mip->mii_next;
		mip->mii_regval = regval;
		mip->mii_func = func;
		mip->mii_next = NULL;
		if (mii_head) {
			mii_tail->mii_next = mip;
			mii_tail = mip;
		} else {
			mii_head = mii_tail = mip;
			fecp->fec_mii_data = regval;
		}
	} else {
		retval = 1;
	}

	restore_flags(flags);

	return retval;
}

static void
mii_status(uint mii_reg)
{
	if (((mii_reg >> 18) & 0x1f) == 1) {
		/* status register.
		*/
		printk("fec: ");
		if (mii_reg & 0x0004) {
			printk("link up");
		} else {
			printk("link down");
		}

		if (mii_reg & 0x0010) {
			printk(",remote fault");
		}
		if (mii_reg & 0x0020) {
			printk(",auto complete");
		}
		printk("\n");
	}
	if (((mii_reg >> 18) & 0x1f) == 0x14) {
		/* Extended chip status register.
		*/
		printk("fec: ");
		if (mii_reg & 0x0800) {
			printk("100 Mbps");
		} else {
			printk("10 Mbps");
		}

		if (mii_reg & 0x1000) {
			printk(", Full-Duplex\n");
		} else {
			printk(", Half-Duplex\n");
		}
	}
	if (((mii_reg >> 18) & 0x1f) == 0x1f) {
		printk("fec: %x\n", mii_reg);
	}
}

static	void
mii_startup_cmds(volatile fec_t	*fecp)
{
	/* Read status registers to clear any pending interrupt.
	*/
	mii_queue(fecp, mk_mii_read(1), mii_status);
#ifdef CONFIG_IPI
	mii_queue(fecp, mk_mii_read(18), mii_status);

	/* Read extended chip status register.
	*/
	mii_queue(fecp, mk_mii_read(0x14), mii_status);

	/* Enable Link status change interrupts.
	*/
	mii_queue(fecp, mk_mii_write(0x11, 0x0002), NULL);

#ifdef CONFIG_FADS
	/* FADS uses the TRSTE in the BCSR, which is kind of weird.
	 * This really controls the startup default configuration.
	 * Changing the state of TRSTE once powered up doesn't do
	 * anything, you have to whack the control register.
	 * This of course screws up any autoconfig that was done.......
	*/
	mii_queue(fecp, mk_mii_write(0, 0x1000), NULL);
#endif
#else
	mii_queue(fecp, mk_mii_read(31), mii_status);
#endif
}

/* This supports the mii_link interrupt below.
 * We should get called three times.  Once for register 1, once for
 * register 18, and once for register 20.
 */

static void
mii_relink(uint mii_reg)
{
	static	uint mii_saved_reg1;

	if (((mii_reg >> 18) & 0x1f) == 1) {
		/* Just save the status register and get out.
		*/
		mii_saved_reg1 = mii_reg;
		return;
	}
	if (((mii_reg >> 18) & 0x1f) == 18) {
		/* Not much here, but has to be read to clear the
		 * interrupt condition.
		 */
		if ((mii_reg & 0x8000) == 0)
			printk("fec: re-link and no IRQ?\n");
		if ((mii_reg & 0x4000) == 0)
			printk("fec: no PHY power?\n");
	}
	if (((mii_reg >> 18) & 0x1f) == 20) {
		/* Extended chip status register.
		 * OK, now we have it all, so figure out what is going on.
		 */
		printk("fec: ");
		if (mii_saved_reg1 & 0x0004)
			printk("link up");
		else
			printk("link down");

		if (mii_saved_reg1 & 0x0010)
			printk(", remote fault");
		if (mii_saved_reg1 & 0x0020)
			printk(", auto complete");

		if (mii_reg & 0x0800)
			printk(", 100 Mbps");
		else
			printk(", 10 Mbps");

		if (mii_reg & 0x1000)
			printk(", Full-Duplex\n");
		else
			printk(", Half-Duplex\n");
	}
}

/* This interrupt occurs when the LTX970 detects a link change.
*/
static	void
mii_link_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct	device *dev = dev_id;
	struct	fec_enet_private *fep;
	volatile fec_t	*fecp;

	fep = (struct fec_enet_private *)dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;

	/* We need to sequentially read registers 1 and 18 to clear
	 * the interrupt.  We don't need to do that here because this
	 * is an edge triggered interrupt that has already been acknowledged
	 * by the top level handler.  We also read the extended status
	 * register 20.  We just queue the commands and let them happen
	 * as part of the "normal" processing.
	 */
	mii_queue(fecp, mk_mii_read(1), mii_relink);
#ifdef CONFIG_IPI
	mii_queue(fecp, mk_mii_read(18), mii_relink);
	mii_queue(fecp, mk_mii_read(20), mii_relink);
	mii_queue(fecp, mk_mii_write(0x11, 0x0002), NULL);
#else
	mii_queue(fecp, mk_mii_read(6), mii_relink);
	mii_queue(fecp, mk_mii_read(31), mii_relink);
#endif
}


static struct net_device_stats *fec_enet_get_stats(struct device *dev)
{
	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;

	return &fep->stats;
}

/* Set or clear the multicast filter for this adaptor.
 * Skeleton taken from sunlance driver.
 * The CPM Ethernet implementation allows Multicast as well as individual
 * MAC address filtering.  Some of the drivers check to make sure it is
 * a group multicast address, and discard those that are not.  I guess I
 * will do the same for now, but just remove the test if you want
 * individual filtering as well (do the upper net layers want or support
 * this kind of feature?).
 */

static void set_multicast_list(struct device *dev)
{
	struct	fec_enet_private *fep;
	volatile fec_t *fecp;
#if 0
	struct	dev_mc_list *dmi;
	u_char	*mcptr, *tdptr;
	int	i, j;
#endif

	fep = dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;

	if (dev->flags&IFF_PROMISC) {
		fecp->fec_r_cntrl |= 0x0008;
	} else {
		fecp->fec_r_cntrl &= ~0x0008;

		if (dev->flags & IFF_ALLMULTI) {
			/* Catch all multicast addresses, so set the
			 * filter to all 1's.
			 */
			fecp->fec_hash_table_high = 0xffffffff;
			fecp->fec_hash_table_low = 0xffffffff;
		}
#if 0
		else {
			/* Clear filter and add the addresses in the list.
			*/
			fecp->sen_gaddr1 = 0;
			fecp->sen_gaddr2 = 0;
			fecp->sen_gaddr3 = 0;
			fecp->sen_gaddr4 = 0;

			dmi = dev->mc_list;

			for (i=0; i<dev->mc_count; i++) {
				
				/* Only support group multicast for now.
				*/
				if (!(dmi->dmi_addr[0] & 1))
					continue;

				/* The address in dmi_addr is LSB first,
				 * and taddr is MSB first.  We have to
				 * copy bytes MSB first from dmi_addr.
				 */
				mcptr = (u_char *)dmi->dmi_addr + 5;
				tdptr = (u_char *)&fecp->sen_taddrh;
				for (j=0; j<6; j++)
					*tdptr++ = *mcptr--;

				/* Ask CPM to run CRC and set bit in
				 * filter mask.
				 */
				cpmp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SCC1, CPM_CR_SET_GADDR) | CPM_CR_FLG;
				/* this delay is necessary here -- Cort */
				udelay(10);
				while (cpmp->cp_cpcr & CPM_CR_FLG);
			}
		}
#endif
	}
}


static int
fec_enet_open(struct device *dev)
{
	/* Install our interrupt handlers.  The 860T boards use
	   IRQ2 for the MII interrupt.
	*/
	if (request_irq(dev->irq, fec_enet_interrupt, 0, "fec", dev) != 0) {
		return -EAGAIN;
	}

	if (request_irq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0) {
		free_irq(dev->irq, dev);
		return -EAGAIN;
	}

	FEC_init(dev);

	dev->interrupt = 0;
	dev->tbusy = 0;
	dev->start = 1;

	return 0;					/* Always succeed */
}


static int
fec_enet_close(struct device *dev)
{
	volatile fec_t *fecp = (volatile fec_t*)dev->base_addr;

	dev->tbusy = 1;
	dev->start = 0;

	/* Shut down hardware nicely. */
	fecp->fec_ecntrl = 0;

	/* Due to a hardware BUG we must also perform a reset, but first we
	   wait for transmission of bad CRC to finish. */
	udelay(20);
	FEC_reset(dev);

	free_irq(SIU_IRQ2, dev);
	free_irq(dev->irq, dev);

	return 0;
}


static void
FEC_reset(struct device *dev)
{
	volatile fec_t *fecp = (volatile fec_t*)dev->base_addr;

	/* Whack a reset.  We should wait for this.
	 */
	fecp->fec_ecntrl = 1;
	udelay(10);
}


static void
FEC_init(struct device *dev)
{
	volatile	cbd_t	*bdp;
	volatile	fec_t	*fecp;
	volatile	immap_t	*immap;
	struct fec_enet_private *fep;
	int i;

	fep = dev->priv;
	fecp = (volatile fec_t*)dev->base_addr;
	immap = (immap_t*)IMAP_ADDR;	/* Pointer to internal registers */

	/* Clear flags. */
	fep->tx_full = 0;
	fep->lock = 0;

	/* Reset ring buffers. */
	fep->dirty_tx = fep->cur_tx = fep->tx_bd_base;
	fep->cur_rx = fep->rx_bd_base;
	fep->skb_cur = fep->skb_dirty = 0;
	fep->tx_queued = 0;

	/* Initialize the receive buffer descriptors.
	 */
	bdp = fep->rx_bd_base;
	for (i=0; i<RX_RING_SIZE; i++, bdp++) {
		bdp->cbd_sc = BD_ENET_RX_EMPTY;
	}
	/* Set the last buffer to wrap. */
	bdp--;
	bdp->cbd_sc |= BD_SC_WRAP;

	/* ...and the same for transmmit.
	 */
	bdp = fep->tx_bd_base;
	for (i=0; i < TX_RING_SIZE; i++) {
		/* Initialize the BD for all fragments. */
		bdp->cbd_sc = 0;
		bdp->cbd_bufaddr = 0;
		bdp++;
	}
	/* Set the last buffer to wrap. */
	bdp--;
	bdp->cbd_sc |= BD_SC_WRAP;


	/* Enable interrupts we wish to service.
	 */
#ifdef FEC_INT_ENABLE_BUFFER
	fecp->fec_imask = (FEC_ENET_TXF | FEC_ENET_TXB |
			   FEC_ENET_RXF | FEC_ENET_RXB | FEC_ENET_MII);
#else
	fecp->fec_imask = (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII);
#endif

	/* Clear any outstanding interrupt.
	 */
	fecp->fec_ievent = 0xffc0;

	fecp->fec_ivec = (dev->irq/2) << 29;

	/* Set station address. */
	fecp->fec_addr_low = (my_enet_addr[0] << 16) | my_enet_addr[1];
	fecp->fec_addr_high = my_enet_addr[2];

	/* Reset all multicast. */
	fecp->fec_hash_table_high = 0;
	fecp->fec_hash_table_low = 0;

	/* Set maximum receive buffer size. */
	fecp->fec_r_buff_size = PKT_MAXBLR_SIZE;
	fecp->fec_r_hash = PKT_MAXBUF_SIZE;

	/* Set start of ring buffers. */
	fecp->fec_r_des_start = fep->rx_bd_pa;
	fecp->fec_x_des_start = fep->tx_bd_pa;

	/* Enable MII mode, half-duplex until we know better... */
	fecp->fec_r_cntrl = 0x0c;
	fecp->fec_x_cntrl = 0x00;

	/* Enable big endian and don't care about SDMA FC. */
	fecp->fec_fun_code = 0x78000000;

	/* Set MII speed (50 MHz core). */
	fecp->fec_mii_speed = 0x14;

	/* Configure all of port D for MII. */
	immap->im_ioport.iop_pdpar = 0x1fff;
	immap->im_ioport.iop_pddir = 0x1c58;

	/* And last, enable the transmit and receive processing.
	*/
	fecp->fec_ecntrl = 2;
	fecp->fec_r_des_active = 0x01000000;

	for (i=0; i<NMII-1; i++) {
		mii_cmds[i].mii_next = &mii_cmds[i+1];
	}

	mii_free = mii_cmds;

#ifndef NO_DAMMHACK
	mii_queue(fecp, mk_mii_write(0x11, 0x0002), NULL);

	//	udelay(200);
#endif

	mii_startup_cmds(fecp);
}


/* Initialize the FEC Ethernet on 860T.
 */
__initfunc(int fec_enet_init(void))
{
	struct device *dev;
	struct fec_enet_private *fep;
	int i, j;
	unsigned char	*eap;
	unsigned long	mem_addr;
	pte_t		*pte;
	volatile	cbd_t	*bdp;
	cbd_t		*cbd_base;
#ifdef CONFIG_RPXCLASSIC
	unsigned char	*iap;
	bd_t		*bd;

	bd = (bd_t *)res;
#endif

	/* Allocate some private information.
	*/
	fep = (struct fec_enet_private *)kmalloc(sizeof(*fep), GFP_KERNEL);
	if (fep == NULL) {
		panic("Unable to allocate FEC private structure\n");
	}
	memset(fep, 0, sizeof(*fep));

	/* Create an Ethernet device instance.
	*/
	dev = init_etherdev(0, 0);

	dev->irq = FEC_INTERRUPT;
	dev->base_addr = (unsigned long)&(((immap_t*)IMAP_ADDR)->im_cpm.cp_fec);
	dev->priv = fep;
	dev->name = "fec";

	/* The FEC Ethernet specific entries in the device structure. */
	dev->open = fec_enet_open;
	dev->hard_start_xmit = fec_enet_start_xmit;
	dev->stop = fec_enet_close;
	dev->get_stats = fec_enet_get_stats;
	dev->set_multicast_list = set_multicast_list;

	eap = (unsigned char *)&my_enet_addr[0];
#ifdef CONFIG_RPXCLASSIC
	iap = bd->bi_enetaddr;
	for (i=0; i<6; i++) dev->dev_addr[i] = *eap++ = *iap++;
#else
	for (i=0; i<6; i++) dev->dev_addr[i] = *eap++;
#endif

	/* Allocate memory for buffer descriptors.
	*/
	if (((RX_RING_SIZE + TX_RING_SIZE) * sizeof(cbd_t)) > PAGE_SIZE) {
		panic("FEC init error.  Need more space.\n");
	}
	mem_addr = __get_free_page(GFP_KERNEL);
	cbd_base = (cbd_t *)mem_addr;

	/* Make it uncached.
	*/
	pte = va_to_pte(&init_task, (int)mem_addr);
	pte_val(*pte) |= _PAGE_NO_CACHE;
	flush_tlb_page(current->mm->mmap, mem_addr);

	/* Set receive and transmit descriptor base.
	*/
	fep->rx_bd_base = cbd_base;
	fep->tx_bd_base = cbd_base + RX_RING_SIZE;
	fep->rx_bd_pa = __pa((unsigned long)fep->rx_bd_base);
	fep->tx_bd_pa = __pa((unsigned long)fep->tx_bd_base);

	/* Allocate the receive buffer descriptors.
	 */
	bdp = fep->rx_bd_base;
	for (i=0; i<FEC_ENET_RX_PAGES; i++) {
		/* Allocate a page. */
		mem_addr = __get_free_page(GFP_KERNEL);

		/* Make it uncached. */
		pte = va_to_pte(&init_task, mem_addr);
		pte_val(*pte) |= _PAGE_NO_CACHE;
		flush_tlb_page(current->mm->mmap, mem_addr);

		/* Initialize the BD for every fragment in the page. */
		for (j=0; j < FEC_ENET_RX_FRPPG; j++) {
			bdp->cbd_bufaddr = __pa(mem_addr);
			mem_addr += FEC_ENET_RX_FRSIZE;
			bdp++;
		}
	}

	/* Now perform a hardware reset */
	FEC_reset(dev);

	printk("FEC ENET Version 0.1, ");
	for (i=0; i<5; i++) {
		printk("%02x:", dev->dev_addr[i]);
	}
	printk("%02x\n", dev->dev_addr[5]);

	return 0;
}

--------------C72CF2C94313E0D8339BB43C--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
