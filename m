Message-ID: <006d01c36db2$e13b9310$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <jan.damborsky@devcom.cz>
Cc: <brad@parker.boston.ma.us>, "Wolfgang Denk" <wd@denx.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ethernets on SCC2 and SCC3 on mpc8xx
Date: Fri, 29 Aug 2003 00:22:24 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006A_01C36DC3.9EB44350"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_006A_01C36DC3.9EB44350
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Jan

I have a version that supports multiple enet's in one driver.
It is a bit specific for our board and contains a lot more:
- run time settable MAC and MTU.
- optimized RX interrupt handling(up to 20% better throuput)
- improved handling of received faulty frames.

    I am attaching the driver. Good luck.

   Jocke
------=_NextPart_000_006A_01C36DC3.9EB44350
Content-Type: application/octet-stream;
	name="enet.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="enet.c"

/*=0A=
 * Ethernet driver for Motorola MPC8xx.=0A=
 * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)=0A=
 *=0A=
 * I copied the basic skeleton from the lance driver, because I did not=0A=
 * know how to write the Linux driver, but I did know how the LANCE =
worked.=0A=
 *=0A=
 * This version of the driver is somewhat selectable for the different=0A=
 * processor/board combinations.  It works for the boards I know about=0A=
 * now, and should be easily modified to include others.  Some of the=0A=
 * configuration information is contained in "commproc.h" and the=0A=
 * remainder is here.=0A=
 *=0A=
 * Buffer descriptors are kept in the CPM dual port RAM, and the frame=0A=
 * buffers are in the host memory.=0A=
 *=0A=
 * Right now, I am very watseful with the buffers.  I allocate memory=0A=
 * pages and then divide them into 2K frame buffers.  This way I know I=0A=
 * have buffers large enough to hold one frame within one buffer =
descriptor.=0A=
 * Once I get this working, I will use 64 or 128 byte CPM buffers, which=0A=
 * will be much more memory efficient and will easily handle lots of=0A=
 * small packets.=0A=
 *=0A=
 */=0A=
#include <linux/config.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/string.h>=0A=
#include <linux/ptrace.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/init.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/netdevice.h>=0A=
#include <linux/etherdevice.h>=0A=
#include <linux/skbuff.h>=0A=
#include <linux/spinlock.h>=0A=
=0A=
#include <asm/8xx_immap.h>=0A=
#include <asm/pgtable.h>=0A=
#include <asm/mpc8xx.h>=0A=
#include <asm/bitops.h>=0A=
#include <asm/uaccess.h>=0A=
=0A=
#include <asm/commproc.h>=0A=
=0A=
/*=0A=
 *				Theory of Operation=0A=
 *=0A=
 * The MPC8xx CPM performs the Ethernet processing on SCC1.  It can use=0A=
 * an aribtrary number of buffers on byte boundaries, but must have at=0A=
 * least two receive buffers to prevent constant overrun conditions.=0A=
 *=0A=
 * The buffer descriptors are allocated from the CPM dual port memory=0A=
 * with the data buffers allocated from host memory, just like all other=0A=
 * serial communication protocols.  The host memory buffers are allocated=0A=
 * from the free page pool, and then divided into smaller receive and=0A=
 * transmit buffers.  The size of the buffers should be a power of two,=0A=
 * since that nicely divides the page.  This creates a ring buffer=0A=
 * structure similar to the LANCE and other controllers.=0A=
 *=0A=
 * Like the LANCE driver:=0A=
 * The driver runs as two independent, single-threaded flows of control. =
 One=0A=
 * is the send-packet routine, which enforces single-threaded use by the=0A=
 * cep->tx_busy flag.  The other thread is the interrupt handler, which =
is=0A=
 * single threaded by the hardware and other software.=0A=
 *=0A=
 * The send packet thread has partial control over the Tx ring and the=0A=
 * 'cep->tx_busy' flag.  It sets the tx_busy flag whenever it's queuing =
a Tx=0A=
 * packet. If the next queue slot is empty, it clears the tx_busy flag =
when=0A=
 * finished otherwise it sets the 'lp->tx_full' flag.=0A=
 *=0A=
 * The MBX has a control register external to the MPC8xx that has some=0A=
 * control of the Ethernet interface.  Information is in the manual for=0A=
 * your board.=0A=
 *=0A=
 * The RPX boards have an external control/status register.  Consult the=0A=
 * programming documents for details unique to your board.=0A=
 *=0A=
 * For the TQM8xx(L) modules, there is no control register interface.=0A=
 * All functions are directly controlled using I/O pins.  See commproc.h.=0A=
 */=0A=
=0A=
=0A=
/* The transmitter timeout=0A=
 */=0A=
#define TX_TIMEOUT	(1*HZ)=0A=
=0A=
/* Define COPY_SMALL_FRAMES if you want to save buffer memory for small =
packets =0A=
 * at a small performance hit */=0A=
#ifdef COPY_SMALL_FRAMES=0A=
  #define RX_COPYBREAK (256-16+1) /* dev_alloc_skb() adds 16 bytes for =
internal use */=0A=
#endif=0A=
/* The number of Tx and Rx buffers.  These are allocated from the page=0A=
 * pool.  The code may assume these are power of two, so it is best=0A=
 * to keep them that size.=0A=
 * We don't need to allocate pages for the transmitter.  We just use=0A=
 * the skbuffer directly.=0A=
 */=0A=
=0A=
#ifdef CONFIG_ENET_BIG_BUFFERS=0A=
  #define RX_RING_SIZE		64=0A=
  #define TX_RING_SIZE		64	/* Must be power of two for this to work */=0A=
#else=0A=
  #define RX_RING_SIZE		16=0A=
  #define TX_RING_SIZE		16	/* Must be power of two for this to work */=0A=
#endif=0A=
#define TX_RING_MOD_MASK	(TX_RING_SIZE-1)=0A=
=0A=
#define CPM_ENET_RX_FRSIZE	1552 /* must be a multiple of cache line */=0A=
#if CPM_ENET_RX_FRSIZE % L1_CACHE_LINE_SIZE !=3D 0=0A=
    #error CPM_ENET_RX_FRSIZE must be a multiple of L1 cache size=0A=
#endif=0A=
=0A=
=0A=
/* The CPM stores dest/src/type, data, and checksum for receive packets.=0A=
 */=0A=
#define MAX_MTU 1514  /* this is data size */=0A=
#define MIN_MTU 46    /* this is data size */=0A=
#define SCC_MAX_MTU   (((CPM_ENET_RX_FRSIZE-ETH_HLEN-8)/4)*4) /* must be =
a multiple of 4 */=0A=
=0A=
#define PKT_MAXBUF_SIZE   (MAX_MTU+ETH_HLEN+4) /* allow fullsized pppoe =
packets and VLAN */=0A=
#define PKT_MINBUF_SIZE   (MIN_MTU+ETH_HLEN+4)=0A=
#define PKT_MAXBLR_SIZE	  SCC_MAX_MTU=0A=
=0A=
=0A=
/* The CPM buffer descriptors track the ring buffers.  The rx_bd_base and=0A=
 * tx_bd_base always point to the base of the buffer descriptors.  The=0A=
 * cur_rx and cur_tx point to the currently available buffer.=0A=
 * The dirty_tx tracks the current buffer that is being sent by the=0A=
 * controller.  The cur_tx and dirty_tx are equal under both completely=0A=
 * empty and completely full conditions.  The empty/ready indicator in=0A=
 * the buffer descriptor determines the actual condition.=0A=
 */=0A=
struct scc_enet_private {=0A=
	/* The saved address of a sent-in-place packet/buffer, for skfree(). */=0A=
	struct	sk_buff* tx_skbuff[TX_RING_SIZE];=0A=
	ushort	skb_cur;=0A=
	ushort	skb_dirty;=0A=
=0A=
	/* CPM dual port RAM relative addresses.=0A=
	*/=0A=
	cbd_t	*rx_bd_base;		/* Address of Rx and Tx buffers. */=0A=
	cbd_t	*tx_bd_base;=0A=
	cbd_t	*cur_rx, *cur_tx;		/* The next free ring entry */=0A=
	cbd_t	*dirty_tx;	/* The ring entries to be free()ed. */=0A=
	scc_t	*sccp;=0A=
=0A=
	/* Virtual addresses for the receive buffers because we can't=0A=
	 * do a __va() on them anymore.=0A=
	 */=0A=
	void    *rx_vaddr[RX_RING_SIZE];=0A=
	struct	net_device_stats stats;=0A=
	uint	tx_full;=0A=
        spinlock_t lock;=0A=
        char    scc_num;=0A=
        int     cpm_cr_ch;=0A=
};=0A=
=0A=
int __init scc_enet_init_params(int scc_num, int cpmvec, int proff, int =
cpm_cr_ch);=0A=
int __init cpm_enet_init_scc_pins(int scc_num);=0A=
int __init cpm_enet_init_scc_clock(int scc_num);=0A=
=0A=
static int scc_enet_open(struct net_device *dev);=0A=
static int scc_enet_start_xmit(struct sk_buff *skb, struct net_device =
*dev);=0A=
static int scc_enet_rx(struct net_device *dev);=0A=
static void scc_enet_interrupt(void *dev_id, struct pt_regs *regs);=0A=
static int scc_enet_close(struct net_device *dev);=0A=
static struct net_device_stats *scc_enet_get_stats(struct net_device =
*dev);=0A=
static void set_multicast_list(struct net_device *dev);=0A=
static void cpm_enet_enable_xmit(int);=0A=
=0A=
/*=0A=
 * Called from net/core/dev.c: int dev_open(struct net_device *dev)=0A=
 *=0A=
 * If CONFIG_LUMENTISCP defined: it will be called twice, once for=0A=
 * 'eth0' and once for 'eth1'.=0A=
 *=0A=
 * If CONFIG_LUMENTISUP defined: it will be called just once.=0A=
 * I.e. for'eth0'.=0A=
 */=0A=
=0A=
static int=0A=
scc_enet_open(struct net_device *dev)=0A=
{=0A=
	struct	scc_enet_private *cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	/* I should reset the ring buffers here, but I don't yet know=0A=
	 * a simple way to do that.=0A=
	 */=0A=
	netif_start_queue(dev);=0A=
=0A=
	/* enable the transmit and receive processing.=0A=
	*/=0A=
	cep->sccp->scc_gsmrl |=3D (SCC_GSMRL_ENR | SCC_GSMRL_ENT);=0A=
=0A=
	return 0;					/* Always succeed */=0A=
}=0A=
=0A=
static int=0A=
scc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)=0A=
{=0A=
	struct scc_enet_private *cep =3D (struct scc_enet_private *)dev->priv;=0A=
	volatile cbd_t	*bdp;=0A=
	volatile  scc_enet_t *ep =3D (scc_enet_t *)dev->base_addr;=0A=
	/* Fill in a Tx ring entry */=0A=
	bdp =3D cep->cur_tx;=0A=
=0A=
	if (skb->len > (ep->sen_maxflr - 4)){=0A=
		printk("eth: TX frame is too long");=0A=
	}=0A=
=0A=
	/* Clear all of the status flags.=0A=
	 */=0A=
	bdp->cbd_sc &=3D ~BD_ENET_TX_STATS;=0A=
=0A=
	/* If the frame is short, tell CPM to pad it.=0A=
	if (skb->len <=3D ETH_ZLEN)=0A=
		bdp->cbd_sc |=3D BD_ENET_TX_PAD;=0A=
	else=0A=
		bdp->cbd_sc &=3D ~BD_ENET_TX_PAD;=0A=
	*/=0A=
=0A=
	/* Set buffer length and buffer pointer.=0A=
	*/=0A=
	bdp->cbd_datlen =3D skb->len;=0A=
	bdp->cbd_bufaddr =3D __pa(skb->data);=0A=
=0A=
	/* Save skb pointer.=0A=
	*/=0A=
	cep->tx_skbuff[cep->skb_cur] =3D skb;=0A=
=0A=
	cep->stats.tx_bytes +=3D skb->len;=0A=
	cep->skb_cur =3D (cep->skb_cur+1) & TX_RING_MOD_MASK;=0A=
	=0A=
	/* Push the data cache so the CPM does not get stale memory=0A=
	 * data.=0A=
	 */=0A=
	flush_dcache_range((unsigned long)(skb->data),=0A=
					(unsigned long)(skb->data + skb->len));=0A=
=0A=
	spin_lock_irq(&cep->lock);=0A=
=0A=
	/* Send it on its way.  Tell CPM its ready, interrupt when done,=0A=
	 * its the last BD of the frame, and to put the CRC on the end.=0A=
	 */=0A=
	bdp->cbd_sc |=3D (BD_ENET_TX_READY | BD_ENET_TX_INTR | BD_ENET_TX_LAST =
| BD_ENET_TX_TC | BD_ENET_TX_PAD);=0A=
=0A=
	dev->trans_start =3D jiffies;=0A=
=0A=
	/* If this was the last BD in the ring, start at the beginning again.=0A=
	*/=0A=
	if (bdp->cbd_sc & BD_ENET_TX_WRAP)=0A=
		bdp =3D cep->tx_bd_base;=0A=
	else=0A=
		bdp++;=0A=
=0A=
	if (bdp->cbd_sc & BD_ENET_TX_READY) {=0A=
		netif_stop_queue(dev);=0A=
		cep->tx_full =3D 1;=0A=
	}=0A=
=0A=
	cep->cur_tx =3D (cbd_t *)bdp;=0A=
=0A=
	spin_unlock_irq(&cep->lock);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void=0A=
scc_enet_timeout(struct net_device *dev)=0A=
{=0A=
	struct scc_enet_private *cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	printk("%s: transmit timed out.\n", dev->name);=0A=
	cep->stats.tx_errors++;=0A=
#ifndef final_version=0A=
	{=0A=
		int	i;=0A=
		cbd_t	*bdp;=0A=
		printk(" Ring data dump: cur_tx %p%s cur_rx %p.\n",=0A=
		       cep->cur_tx, cep->tx_full ? " (full)" : "",=0A=
		       cep->cur_rx);=0A=
		bdp =3D cep->tx_bd_base;=0A=
		for (i =3D 0 ; i < TX_RING_SIZE; i++, bdp++)=0A=
			printk("%04x %04x %08x\n",=0A=
			       bdp->cbd_sc,=0A=
			       bdp->cbd_datlen,=0A=
			       bdp->cbd_bufaddr);=0A=
		bdp =3D cep->rx_bd_base;=0A=
		for (i =3D 0 ; i < RX_RING_SIZE; i++, bdp++)=0A=
			printk("%04x %04x %08x\n",=0A=
			       bdp->cbd_sc,=0A=
			       bdp->cbd_datlen,=0A=
			       bdp->cbd_bufaddr);=0A=
	}=0A=
#endif=0A=
	if (!cep->tx_full)=0A=
		netif_wake_queue(dev);=0A=
}=0A=
=0A=
/* The interrupt handler.=0A=
 * This is called from the CPM handler, not the MPC core interrupt.=0A=
 */=0A=
static void=0A=
scc_enet_interrupt(void *dev_id,  struct pt_regs *regs)=0A=
{=0A=
	struct	net_device *dev =3D dev_id;=0A=
	volatile struct	scc_enet_private *cep;=0A=
	volatile cbd_t	*bdp;=0A=
	ushort	int_events;=0A=
	int	must_restart;=0A=
=0A=
	cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	/* Get the interrupt events that caused us to be here.=0A=
	*/=0A=
	int_events =3D cep->sccp->scc_scce;=0A=
	cep->sccp->scc_scce =3D int_events;=0A=
	must_restart =3D 0;=0A=
=0A=
	/* Handle receive event in its own function.=0A=
	*/=0A=
	if (int_events & SCCE_ENET_RXF)=0A=
		scc_enet_rx(dev_id);=0A=
=0A=
	/* Check for a transmit error.  The manual is a little unclear=0A=
	 * about this, so the debug code until I get it figured out.  It=0A=
	 * appears that if TXE is set, then TXB is not set.  However,=0A=
	 * if carrier sense is lost during frame transmission, the TXE=0A=
	 * bit is set, "and continues the buffer transmission normally."=0A=
	 * I don't know if "normally" implies TXB is set when the buffer=0A=
	 * descriptor is closed.....trial and error :-).=0A=
	 */=0A=
=0A=
	/* Transmit OK, or non-fatal error.  Update the buffer descriptors.=0A=
	*/=0A=
	if (int_events & (SCCE_ENET_TXE | SCCE_ENET_TXB)) {=0A=
	    spin_lock(&cep->lock);=0A=
	    bdp =3D cep->dirty_tx;=0A=
	    while ((bdp->cbd_sc&BD_ENET_TX_READY)=3D=3D0) {=0A=
		if ((bdp=3D=3Dcep->cur_tx) && (cep->tx_full =3D=3D 0))=0A=
		    break;=0A=
		if (bdp->cbd_sc & (BD_ENET_TX_HB | BD_ENET_TX_LC | BD_ENET_TX_RL | =
BD_ENET_TX_UN | BD_ENET_TX_CSL | BD_ENET_TX_RCMASK)) {=0A=
			if (bdp->cbd_sc & BD_ENET_TX_HB)	/* No heartbeat */=0A=
				cep->stats.tx_heartbeat_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_TX_LC)	/* Late collision */=0A=
				cep->stats.tx_window_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_TX_RL)	/* Retrans limit */=0A=
				cep->stats.tx_aborted_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_TX_UN)	/* Underrun */=0A=
				cep->stats.tx_fifo_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_TX_CSL)	/* Carrier lost */=0A=
				cep->stats.tx_carrier_errors++;=0A=
			=0A=
			/* Check retry counter, i.e. collision counter */=0A=
			if (bdp->cbd_sc & BD_ENET_TX_RCMASK){=0A=
				/* Note that counter cannot go higher than 15 */=0A=
				cep->stats.collisions+=3D(bdp->cbd_sc & BD_ENET_TX_RCMASK)>>2;=0A=
			}=0A=
			=0A=
			/* No heartbeat or Lost carrier are not really bad errors.=0A=
			 * The others require a restart transmit command.=0A=
			 */=0A=
			if (bdp->cbd_sc &=0A=
			    (BD_ENET_TX_LC | BD_ENET_TX_RL | BD_ENET_TX_UN)) {=0A=
				must_restart =3D 1;=0A=
				cep->stats.tx_errors++;=0A=
			}=0A=
		}=0A=
=0A=
		cep->stats.tx_packets++;=0A=
=0A=
		/* Free the sk buffer associated with this last transmit.=0A=
		*/=0A=
		dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);=0A=
		cep->skb_dirty =3D (cep->skb_dirty + 1) & TX_RING_MOD_MASK;=0A=
=0A=
		/* Update pointer to next buffer descriptor to be transmitted.=0A=
		*/=0A=
		if (bdp->cbd_sc & BD_ENET_TX_WRAP)=0A=
			bdp =3D cep->tx_bd_base;=0A=
		else=0A=
			bdp++;=0A=
=0A=
		/* I don't know if we can be held off from processing these=0A=
		 * interrupts for more than one frame time.  I really hope=0A=
		 * not.  In such a case, we would now want to check the=0A=
		 * currently available BD (cur_tx) and determine if any=0A=
		 * buffers between the dirty_tx and cur_tx have also been=0A=
		 * sent.  We would want to process anything in between that=0A=
		 * does not have BD_ENET_TX_READY set.=0A=
		 */=0A=
=0A=
		/* Since we have freed up a buffer, the ring is no longer=0A=
		 * full.=0A=
		 */=0A=
		if (cep->tx_full) {=0A=
			cep->tx_full =3D 0;=0A=
			if (netif_queue_stopped(dev))=0A=
				netif_wake_queue(dev);=0A=
		}=0A=
=0A=
		cep->dirty_tx =3D (cbd_t *)bdp;=0A=
	    }=0A=
=0A=
	    if (must_restart) {=0A=
		volatile cpm8xx_t *cp;=0A=
=0A=
		/* Some transmit errors cause the transmitter to shut=0A=
		 * down.  We now issue a restart transmit.  Since the=0A=
		 * errors close the BD and update the pointers, the restart=0A=
		 * _should_ pick up without having to reset any of our=0A=
		 * pointers either.=0A=
		 */=0A=
		cp =3D cpmp;=0A=
		cp->cp_cpcr =3D=0A=
                    mk_cr_cmd(cep->cpm_cr_ch, CPM_CR_RESTART_TX) | =
CPM_CR_FLG;=0A=
		while (cp->cp_cpcr & CPM_CR_FLG);=0A=
	    }=0A=
	    spin_unlock(&cep->lock);=0A=
	}=0A=
=0A=
	/* Check for receive busy, i.e. packets coming but no place to=0A=
	 * put them.  This "can't happen" because the receive interrupt=0A=
	 * is tossing previous frames.=0A=
	 */=0A=
	if (int_events & SCCE_ENET_BSY) {=0A=
		cep->stats.rx_dropped++;=0A=
		printk("CPM ENET ethernet: BSY can't happen.\n");=0A=
	}=0A=
=0A=
	return;=0A=
}=0A=
=0A=
/* During a receive, the cur_rx points to the current incoming buffer.=0A=
 * When we update through the ring, if the next incoming buffer has=0A=
 * not been given to the system, we just set the empty indicator,=0A=
 * effectively tossing the packet.=0A=
 */=0A=
static int=0A=
scc_enet_rx(struct net_device *dev)=0A=
{=0A=
	struct	scc_enet_private *cep;=0A=
	volatile cbd_t	*bdp;=0A=
	struct	sk_buff *skb, *skb_tmp;=0A=
	ushort	pkt_len;=0A=
=0A=
	cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	/* First, grab all of the stats for the incoming packet.=0A=
	 * These get messed up if we get called due to a busy condition.=0A=
	 */=0A=
	bdp =3D cep->cur_rx;=0A=
=0A=
	for (;;) {=0A=
		if (bdp->cbd_sc & BD_ENET_RX_EMPTY)=0A=
			break;=0A=
#define RX_BD_ERRORS (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO | =
BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_CL)=0A=
		if(bdp->cbd_sc & RX_BD_ERRORS){ /* Receive errors ? */=0A=
			cep->stats.rx_errors++;=0A=
			if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH)) /* Frame too long =
or too short. */=0A=
				cep->stats.rx_length_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */=0A=
				cep->stats.rx_frame_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */=0A=
				cep->stats.rx_crc_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */=0A=
				cep->stats.rx_fifo_errors++;=0A=
			if (bdp->cbd_sc & BD_ENET_RX_CL)        /* Late collision */=0A=
				cep->stats.collisions++;=0A=
		} else {=0A=
			=0A=
			/* Process the incoming frame.=0A=
			 */=0A=
			cep->stats.rx_packets++;=0A=
			pkt_len =3D bdp->cbd_datlen;=0A=
			cep->stats.rx_bytes +=3D pkt_len;=0A=
			pkt_len -=3D 4; /* The packet length includes FCS, but we don't want =
to=0A=
				       * include that when passing upstream as it messes up=0A=
				       * bridging applications. */=0A=
#ifdef COPY_SMALL_FRAMES =0A=
			/* Allocate the next buffer now so we are sure to have one when needed=0A=
			 * This does 16 byte alignment, exactly what we need(L1_CACHE =
aligned). */=0A=
			if(pkt_len < RX_COPYBREAK){=0A=
				skb_tmp =3D __dev_alloc_skb(pkt_len + 2, GFP_ATOMIC | GFP_DMA);=0A=
				skb_reserve(skb_tmp, 2); /* make the IP header L1 cache aligned */=0A=
			} else=0A=
#endif=0A=
				skb_tmp =3D __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | =
GFP_DMA);=0A=
			=0A=
			if (skb_tmp =3D=3D NULL) {=0A=
				printk("%s: Memory squeeze, dropping packet.\n", dev->name);=0A=
				cep->stats.rx_dropped++;=0A=
=0A=
			} else {=0A=
				skb =3D cep->rx_vaddr[bdp - cep->rx_bd_base];=0A=
#ifdef COPY_SMALL_FRAMES =0A=
				if(pkt_len < RX_COPYBREAK) {=0A=
					typeof(skb) skb_swap =3D skb;=0A=
					memcpy(skb_put(skb_tmp, pkt_len), skb->data, pkt_len);=0A=
					/* swap the skb and skb_tmp */=0A=
					skb =3D skb_tmp;=0A=
					skb_tmp =3D skb_swap;=0A=
				} =0A=
				else =0A=
#endif=0A=
				{=0A=
					skb_put(skb, pkt_len);  /* Make room */=0A=
					bdp->cbd_bufaddr =3D __pa(skb_tmp->data);=0A=
					cep->rx_vaddr[bdp - cep->rx_bd_base] =3D skb_tmp;=0A=
				}=0A=
				invalidate_dcache_range((unsigned long) skb_tmp->data,=0A=
							(unsigned long) skb_tmp->data + CPM_ENET_RX_FRSIZE);=0A=
				skb->dev =3D dev;=0A=
				skb->protocol=3Deth_type_trans(skb, dev);=0A=
				netif_rx(skb);=0A=
			}=0A=
		}=0A=
		=0A=
		/* Clear the status flags for this buffer.=0A=
		 */=0A=
		bdp->cbd_sc &=3D ~BD_ENET_RX_STATS;=0A=
		=0A=
		/* Mark the buffer empty.=0A=
		 */=0A=
		bdp->cbd_sc |=3D BD_ENET_RX_EMPTY;=0A=
		=0A=
		/* Update BD pointer to next entry.=0A=
		 */=0A=
		if (bdp->cbd_sc & BD_ENET_RX_WRAP)=0A=
			bdp =3D cep->rx_bd_base;=0A=
		else=0A=
			bdp++;=0A=
		=0A=
	}=0A=
	cep->cur_rx =3D (cbd_t *)bdp;=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static int=0A=
scc_enet_close(struct net_device *dev)=0A=
{=0A=
	struct	scc_enet_private *cep =3D (struct scc_enet_private *)dev->priv;=0A=
	/* Don't know what to do yet.=0A=
	*/=0A=
	cep->sccp->scc_gsmrl &=3D ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);=0A=
	netif_stop_queue(dev);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static struct net_device_stats *scc_enet_get_stats(struct net_device =
*dev)=0A=
{=0A=
	struct scc_enet_private *cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	return &cep->stats;=0A=
}=0A=
=0A=
static int change_mtu(struct net_device *dev, int new_mtu)=0A=
{=0A=
	volatile scc_enet_t *ep;=0A=
=0A=
	if ((new_mtu < MIN_MTU ) || (new_mtu >  MAX_MTU))=0A=
	       return -EINVAL;=0A=
	ep =3D (scc_enet_t *)dev->base_addr;=0A=
	=0A=
	ep->sen_maxflr =3D new_mtu + ETH_HLEN + 4;   /* maximum frame length =
register */=0A=
	dev->mtu =3D new_mtu;=0A=
	printk("ENET: change_mtu: %d\n",new_mtu);=0A=
	return 0;=0A=
}=0A=
=0A=
static int set_mac_address(struct net_device *dev, void *addr)=0A=
{=0A=
	volatile scc_enet_t *ep;=0A=
	unsigned char	    *eap;=0A=
	struct sockaddr     *mac =3D addr;=0A=
	int	i;=0A=
=0A=
	if(netif_running(dev))=0A=
	       return -EBUSY;=0A=
	=0A=
	/* Get pointer to SCC area in parameter RAM. */=0A=
	ep =3D (scc_enet_t *)dev->base_addr;=0A=
	eap =3D (unsigned char *)&(ep->sen_paddrh);=0A=
	/* cli();  */=0A=
	for (i=3D5; i>=3D0; i--)=0A=
		*eap++ =3D dev->dev_addr[i] =3D mac->sa_data[i];=0A=
	/* sti(); */=0A=
	return 0;=0A=
}=0A=
=0A=
/* Set or clear the multicast filter for this adaptor.=0A=
 * Skeleton taken from sunlance driver.=0A=
 * The CPM Ethernet implementation allows Multicast as well as individual=0A=
 * MAC address filtering.  Some of the drivers check to make sure it is=0A=
 * a group multicast address, and discard those that are not.  I guess I=0A=
 * will do the same for now, but just remove the test if you want=0A=
 * individual filtering as well (do the upper net layers want or support=0A=
 * this kind of feature?).=0A=
 */=0A=
=0A=
static void set_multicast_list(struct net_device *dev)=0A=
{=0A=
	struct	scc_enet_private *cep;=0A=
	struct	dev_mc_list *dmi;=0A=
	u_char	*mcptr, *tdptr;=0A=
	volatile scc_enet_t *ep;=0A=
	int	i, j;=0A=
	cep =3D (struct scc_enet_private *)dev->priv;=0A=
=0A=
	/* Get pointer to SCC area in parameter RAM.=0A=
	*/=0A=
	ep =3D (scc_enet_t *)dev->base_addr;=0A=
=0A=
	if (dev->flags&IFF_PROMISC) {=0A=
		cep->sccp->scc_pmsr |=3D SCC_PMSR_PRO;=0A=
	} else {=0A=
=0A=
		cep->sccp->scc_pmsr &=3D ~SCC_PMSR_PRO;=0A=
=0A=
		if (dev->flags & IFF_ALLMULTI) {=0A=
			/* Catch all multicast addresses, so set the=0A=
			 * filter to all 1's.=0A=
			 */=0A=
			ep->sen_gaddr1 =3D 0xffff;=0A=
			ep->sen_gaddr2 =3D 0xffff;=0A=
			ep->sen_gaddr3 =3D 0xffff;=0A=
			ep->sen_gaddr4 =3D 0xffff;=0A=
		}=0A=
		else {=0A=
			/* Clear filter and add the addresses in the list.=0A=
			*/=0A=
			ep->sen_gaddr1 =3D 0;=0A=
			ep->sen_gaddr2 =3D 0;=0A=
			ep->sen_gaddr3 =3D 0;=0A=
			ep->sen_gaddr4 =3D 0;=0A=
=0A=
			dmi =3D dev->mc_list;=0A=
=0A=
			for (i=3D0; i<dev->mc_count; i++, dmi =3D dmi->next) {=0A=
				=0A=
				/* Only support group multicast for now.=0A=
				*/=0A=
				if (!(dmi->dmi_addr[0] & 1))=0A=
					continue;=0A=
=0A=
				/* The address in dmi_addr is LSB first,=0A=
				 * and taddr is MSB first.  We have to=0A=
				 * copy bytes MSB first from dmi_addr.=0A=
				 */=0A=
				mcptr =3D (u_char *)dmi->dmi_addr + 5;=0A=
				tdptr =3D (u_char *)&ep->sen_taddrh;=0A=
				for (j=3D0; j<6; j++)=0A=
					*tdptr++ =3D *mcptr--;=0A=
=0A=
				/* Ask CPM to run CRC and set bit in=0A=
				 * filter mask.=0A=
				 */=0A=
                                cpmp->cp_cpcr =3D =
mk_cr_cmd(cep->cpm_cr_ch, CPM_CR_SET_GADDR) | CPM_CR_FLG;=0A=
				/* this delay is necessary here -- Cort */=0A=
				udelay(10);=0A=
				while (cpmp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
int __init scc_enet_init(void)=0A=
{=0A=
	bd_t *bd =3D (bd_t *)__res;=0A=
	/*=0A=
	 * Always initialize eth0 on SCC1.=0A=
	 */=0A=
	scc_enet_init_params(0, CPMVEC_SCC1, PROFF_SCC1, CPM_CR_CH_SCC1);=0A=
	=0A=
	if(bd->board_type =3D=3D  CU_BOARDTYPE || bd->board_type =3D=3D  =
CU2_BOARDTYPE){=0A=
		/*=0A=
		 * On a CP board initialize eth1 on SCC2.=0A=
		 */=0A=
		scc_enet_init_params(1, CPMVEC_SCC2, PROFF_SCC2, CPM_CR_CH_SCC2);=0A=
		if(bd->board_type =3D=3D  CU2_BOARDTYPE){=0A=
			scc_enet_init_params(3, CPMVEC_SCC4, PROFF_SCC4, CPM_CR_CH_SCC4);=0A=
		}=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=
/* Initialize the CPM Ethernet on SCC.  If EPPC-Bug loaded us, or =
performed=0A=
 * some other network I/O, a whole bunch of this has already been set up.=0A=
 * It is no big deal if we do it again, we just have to disable the=0A=
 * transmit and receive to make sure we don't catch the CPM with some=0A=
 * inconsistent control information.=0A=
 */=0A=
int __init scc_enet_init_params(int scc_num, int cpmvec, int proff, int =
cpm_cr_ch)=0A=
{=0A=
	struct net_device *dev;=0A=
	struct scc_enet_private *cep;=0A=
	int i, j, k;=0A=
	unsigned char	*eap;=0A=
	bd_t		*bd;=0A=
	volatile	cbd_t		*bdp;=0A=
	volatile	cpm8xx_t	*cp;=0A=
	volatile	scc_t		*sccp;=0A=
	volatile	scc_enet_t	*ep;=0A=
	volatile	immap_t		*immap;=0A=
=0A=
	cp =3D cpmp;	/* Get pointer to Communication Processor */=0A=
=0A=
	immap =3D (immap_t *)(mfspr(IMMR) & 0xFFFF0000);	/* and to internal =
registers */=0A=
=0A=
	bd =3D (bd_t *)__res;=0A=
=0A=
	/* Allocate some private information.=0A=
	*/=0A=
	cep =3D (struct scc_enet_private *)kmalloc(sizeof(*cep), GFP_KERNEL);=0A=
	if (cep =3D=3D NULL)=0A=
		return -ENOMEM;=0A=
=0A=
	__clear_user(cep,sizeof(*cep));=0A=
	spin_lock_init(&cep->lock);=0A=
=0A=
	/* Create an Ethernet device instance.=0A=
	*/=0A=
	dev =3D init_etherdev(0, 0);=0A=
=0A=
	/* Get pointer to SCC area in parameter RAM.=0A=
	*/=0A=
        ep =3D (scc_enet_t *)(&cp->cp_dparam[proff]);=0A=
=0A=
	/* And another to the SCC register area.=0A=
	*/=0A=
        sccp =3D (volatile scc_t *)(&cp->cp_scc[scc_num]);=0A=
	cep->sccp =3D (scc_t *)sccp;		/* Keep the pointer handy */=0A=
        cep->scc_num =3D scc_num;=0A=
        cep->cpm_cr_ch =3D cpm_cr_ch;=0A=
=0A=
	/* Disable receive and transmit in case EPPC-Bug started it.=0A=
	*/=0A=
	sccp->scc_gsmrl &=3D ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);=0A=
=0A=
	/* Init physical pins=0A=
	 */=0A=
	cpm_enet_init_scc_pins(scc_num);=0A=
=0A=
	/* Configure Serial Interface clock routing.=0A=
	 */=0A=
	cpm_enet_init_scc_clock(scc_num);=0A=
=0A=
=0A=
	/* Manual says set SDDR, but I can't find anything with that=0A=
	 * name.  I think it is a misprint, and should be SDCR.  This=0A=
	 * has already been set by the communication processor initialization.=0A=
	 */=0A=
=0A=
	/* Allocate space for the buffer descriptors in the DP ram.=0A=
	 * These are relative offsets in the DP ram address space.=0A=
	 * Initialize base addresses for the buffer descriptors.=0A=
	 */=0A=
	i =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * RX_RING_SIZE);=0A=
	ep->sen_genscc.scc_rbase =3D i;=0A=
	cep->rx_bd_base =3D (cbd_t *)&cp->cp_dpmem[i];=0A=
=0A=
	i =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * TX_RING_SIZE);=0A=
	ep->sen_genscc.scc_tbase =3D i;=0A=
	cep->tx_bd_base =3D (cbd_t *)&cp->cp_dpmem[i];=0A=
=0A=
	cep->dirty_tx =3D cep->cur_tx =3D cep->tx_bd_base;=0A=
	cep->cur_rx =3D cep->rx_bd_base;=0A=
=0A=
	/* Issue init Rx BD command for SCC.=0A=
	 * Manual says to perform an Init Rx parameters here.  We have=0A=
	 * to perform both Rx and Tx because the SCC may have been=0A=
	 * already running.=0A=
	 * In addition, we have to do it later because we don't yet have=0A=
	 * all of the BD control/status set properly.=0A=
	 */=0A=
=0A=
	/* Initialize function code registers for big-endian.=0A=
	*/=0A=
	ep->sen_genscc.scc_rfcr =3D SCC_EB;=0A=
	ep->sen_genscc.scc_tfcr =3D SCC_EB;=0A=
=0A=
	/* Set maximum bytes per receive buffer.=0A=
	 * This appears to be an Ethernet frame size, not the buffer=0A=
	 * fragment size.  It must be a multiple of four.=0A=
	 */=0A=
	ep->sen_genscc.scc_mrblr =3D PKT_MAXBLR_SIZE;=0A=
=0A=
	/* Set CRC preset and mask.=0A=
	*/=0A=
	ep->sen_cpres =3D 0xffffffff;=0A=
	ep->sen_cmask =3D 0xdebb20e3;=0A=
=0A=
	ep->sen_crcec =3D 0;	/* CRC Error counter */=0A=
	ep->sen_alec =3D 0;	/* alignment error counter */=0A=
	ep->sen_disfc =3D 0;	/* discard frame counter */=0A=
=0A=
	ep->sen_pads =3D 0x8888;	/* Tx short frame pad character */=0A=
	ep->sen_retlim =3D 15;	/* Retry limit threshold */=0A=
=0A=
	ep->sen_maxflr =3D PKT_MAXBUF_SIZE;   /* maximum frame length register =
*/=0A=
	ep->sen_minflr =3D PKT_MINBUF_SIZE;  /* minimum frame length register */=0A=
=0A=
	ep->sen_maxd1 =3D PKT_MAXBLR_SIZE;	/* maximum DMA1 length */=0A=
	ep->sen_maxd2 =3D PKT_MAXBLR_SIZE;	/* maximum DMA2 length */=0A=
=0A=
	/* Clear hash tables.=0A=
	*/=0A=
	ep->sen_gaddr1 =3D 0;=0A=
	ep->sen_gaddr2 =3D 0;=0A=
	ep->sen_gaddr3 =3D 0;=0A=
	ep->sen_gaddr4 =3D 0;=0A=
	ep->sen_iaddr1 =3D 0;=0A=
	ep->sen_iaddr2 =3D 0;=0A=
	ep->sen_iaddr3 =3D 0;=0A=
	ep->sen_iaddr4 =3D 0;=0A=
	/* Set Ethernet station address.=0A=
	 *=0A=
	 * If we performed a MBX diskless boot, the Ethernet controller=0A=
	 * has been initialized and we copy the address out into our=0A=
	 * own structure.=0A=
	 *=0A=
	 * All other types of boards supply the address in the board=0A=
	 * information structure, so we copy that into the controller.=0A=
	 */=0A=
	eap =3D (unsigned char *)&(ep->sen_paddrh);=0A=
	for (i=3D5; i>=3D0; i--)=0A=
		*eap++ =3D dev->dev_addr[i] =3D bd->bi_enetaddr[i];=0A=
=0A=
	ep->sen_pper =3D 0;	/* 'cause the book says so */=0A=
	ep->sen_taddrl =3D 0;	/* temp address (LSB) */=0A=
	ep->sen_taddrm =3D 0;=0A=
	ep->sen_taddrh =3D 0;	/* temp address (MSB) */=0A=
=0A=
	/* Now allocate the host memory pages and initialize the=0A=
	 * buffer descriptors.=0A=
	 */=0A=
	bdp =3D cep->tx_bd_base;=0A=
	for (i=3D0; i<TX_RING_SIZE; i++) {=0A=
=0A=
		/* Initialize the BD for every fragment in the page.=0A=
		*/=0A=
		bdp->cbd_sc =3D 0;=0A=
		bdp->cbd_bufaddr =3D 0;=0A=
		bdp++;=0A=
	}=0A=
=0A=
	/* Set the last buffer to wrap.=0A=
	*/=0A=
	bdp--;=0A=
	bdp->cbd_sc |=3D BD_SC_WRAP;=0A=
=0A=
	bdp =3D cep->rx_bd_base;=0A=
	k =3D 0;=0A=
	/* Initialize the BDs. */=0A=
	for (j=3D0; j < RX_RING_SIZE; j++) {=0A=
		struct	sk_buff * skb =3D __dev_alloc_skb(CPM_ENET_RX_FRSIZE, =
GFP_ATOMIC|GFP_DMA);=0A=
=0A=
		invalidate_dcache_range((unsigned long) skb->data,=0A=
					(unsigned long) skb->data + CPM_ENET_RX_FRSIZE);=0A=
		bdp->cbd_sc =3D BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;=0A=
		bdp->cbd_bufaddr =3D __pa(skb->data);=0A=
		cep->rx_vaddr[k++] =3D skb;=0A=
		bdp++;=0A=
	}=0A=
	/* Set the last buffer to wrap.=0A=
	*/=0A=
	bdp--;=0A=
	bdp->cbd_sc |=3D BD_SC_WRAP;=0A=
=0A=
	/* Let's re-initialize the channel now.  We have to do it later=0A=
	 * than the manual describes because we have just now finished=0A=
	 * the BD initialization.=0A=
	 */=0A=
        cp->cp_cpcr =3D mk_cr_cmd(cep->cpm_cr_ch, CPM_CR_INIT_TRX) | =
CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	cep->skb_cur =3D cep->skb_dirty =3D 0;=0A=
=0A=
	sccp->scc_scce =3D 0xffff;	/* Clear any pending events */=0A=
=0A=
	/* Enable interrupts for transmit error, complete frame=0A=
	 * received, and any transmit buffer we have also set the=0A=
	 * interrupt flag.=0A=
	 */=0A=
	sccp->scc_sccm =3D (SCCE_ENET_TXE | SCCE_ENET_RXF | SCCE_ENET_TXB);=0A=
=0A=
	/* Install our interrupt handler.=0A=
	*/=0A=
        cpm_install_handler(cpmvec, scc_enet_interrupt, dev);=0A=
=0A=
	/* Set GSMR_H to enable all normal operating modes.=0A=
	 * Set GSMR_L to enable Ethernet to MC68160.=0A=
	 */=0A=
	sccp->scc_gsmrh =3D 0;=0A=
	sccp->scc_gsmrl =3D (SCC_GSMRL_TCI | SCC_GSMRL_TPL_48 | =
SCC_GSMRL_TPP_10 | SCC_GSMRL_MODE_ENET);=0A=
=0A=
	/* Set sync/delimiters.=0A=
	*/=0A=
	sccp->scc_dsr =3D 0xd555;=0A=
=0A=
	/* Set processing mode.  Use Ethernet CRC, catch broadcast, and=0A=
	 * start frame search 22 bit times after RENA.=0A=
	 */=0A=
	sccp->scc_pmsr =3D (SCC_PMSR_ENCRC | SCC_PMSR_NIB22);=0A=
#ifdef CONFIG_SCC_ENET_FULL_DUPLEX =0A=
	sccp->scc_pmsr |=3D SCC_PMSR_LPB | SCC_PMSR_FDE;=0A=
	printk("Enet %d: Full duplex enabled\n", scc_num);=0A=
#endif=0A=
	/* It is now OK to enable the Ethernet transmitter.=0A=
	 * Unfortunately, there are board implementation differences here.=0A=
	 */=0A=
        cpm_enet_enable_xmit(scc_num);=0A=
=0A=
=0A=
#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)=0A=
	/* And while we are here, set the configuration to enable ethernet.=0A=
	*/=0A=
	*((volatile uint *)RPX_CSR_ADDR) &=3D ~BCSR0_ETHLPBK;=0A=
	*((volatile uint *)RPX_CSR_ADDR) |=3D=0A=
			(BCSR0_ETHEN | BCSR0_COLTESTDIS | BCSR0_FULLDPLXDIS);=0A=
=0A=
#endif=0A=
=0A=
=0A=
	dev->base_addr =3D (unsigned long)ep;=0A=
	dev->priv =3D cep;=0A=
#if 0=0A=
	dev->name =3D "CPM_ENET";=0A=
#endif=0A=
=0A=
	/* The CPM Ethernet specific entries in the device structure. */=0A=
	dev->open =3D scc_enet_open;=0A=
	dev->hard_start_xmit =3D scc_enet_start_xmit;=0A=
	dev->tx_timeout =3D scc_enet_timeout;=0A=
	dev->watchdog_timeo =3D TX_TIMEOUT;=0A=
	dev->stop =3D scc_enet_close;=0A=
	dev->get_stats =3D scc_enet_get_stats;=0A=
	dev->set_multicast_list =3D set_multicast_list;=0A=
	dev->set_mac_address =3D set_mac_address;=0A=
	dev->change_mtu =3D change_mtu;=0A=
=0A=
	printk("%s: CPM ENET Version 0.3, ", dev->name);=0A=
	for (i=3D0; i<5; i++)=0A=
		printk("%02x:", dev->dev_addr[i]);=0A=
	printk("%02x\n", dev->dev_addr[5]);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/* Cookbook style from the MPC860 manual.....=0A=
 * Not all of this is necessary if EPPC-Bug has initialized=0A=
 * the network.=0A=
 * So far we are lucky, all board configurations use the same=0A=
 * pins, or at least the same I/O Port for these functions.....=0A=
 * It can't last though......=0A=
 */=0A=
=0A=
int __init cpm_enet_init_scc_pins(int scc_num)=0A=
{=0A=
    volatile immap_t *immap =3D (immap_t *)IMAP_ADDR;=0A=
=0A=
    switch (scc_num) {=0A=
    case 0: /* SCC1 */=0A=
        /* Configure port A pins for Txd and Rxd.=0A=
         */=0A=
        immap->im_ioport.iop_papar |=3D (PA1_ENET_RXD | PA1_ENET_TXD);=0A=
        immap->im_ioport.iop_padir &=3D ~(PA1_ENET_RXD | PA1_ENET_TXD);=0A=
        immap->im_ioport.iop_paodr &=3D ~PA1_ENET_TXD;=0A=
=0A=
        /* Configure port C pins to enable CLSN and RENA.=0A=
         */=0A=
        immap->im_ioport.iop_pcpar &=3D ~(PC1_ENET_CLSN | PC1_ENET_RENA);=0A=
        immap->im_ioport.iop_pcdir &=3D ~(PC1_ENET_CLSN | PC1_ENET_RENA);=0A=
        immap->im_ioport.iop_pcso |=3D (PC1_ENET_CLSN | PC1_ENET_RENA);=0A=
=0A=
        /* Configure port A for TCLK and RCLK.=0A=
         */=0A=
        immap->im_ioport.iop_papar |=3D (PA1_ENET_TCLK | PA1_ENET_RCLK);=0A=
        immap->im_ioport.iop_padir &=3D ~(PA1_ENET_TCLK | PA1_ENET_RCLK);=0A=
        break;=0A=
=0A=
    case 1: /* SCC2 */=0A=
        /* Configure port A pins for Txd and Rxd.=0A=
         */=0A=
        immap->im_ioport.iop_papar |=3D (PA2_ENET_RXD | PA2_ENET_TXD);=0A=
        immap->im_ioport.iop_padir &=3D ~(PA2_ENET_RXD | PA2_ENET_TXD);=0A=
        immap->im_ioport.iop_paodr &=3D ~PA2_ENET_TXD;=0A=
=0A=
        /* Configure port C pins to enable CLSN and RENA.=0A=
         */=0A=
        immap->im_ioport.iop_pcpar &=3D ~(PC2_ENET_CLSN | PC2_ENET_RENA);=0A=
        immap->im_ioport.iop_pcdir &=3D ~(PC2_ENET_CLSN | PC2_ENET_RENA);=0A=
        immap->im_ioport.iop_pcso |=3D (PC2_ENET_CLSN | PC2_ENET_RENA);=0A=
=0A=
        /* Configure port A for TCLK and RCLK.=0A=
         * eth1 on CP board: TCLK: CLK3    0x0400=0A=
         *                   RCLK: CLK4    0x0800=0A=
         */=0A=
        immap->im_ioport.iop_papar |=3D (PA2_ENET_TCLK | PA2_ENET_RCLK);=0A=
        immap->im_ioport.iop_padir &=3D ~(PA2_ENET_TCLK | PA2_ENET_RCLK);=0A=
        break;=0A=
=0A=
    case 3: /* SCC4 */=0A=
        /* Configure port D pins for Txd and Rxd.=0A=
         */=0A=
        immap->im_ioport.iop_pdpar |=3D (PD4_ENET_RXD | PD4_ENET_TXD);=0A=
	/* Make sure PDDIR is zero otherwise RXD and TXD wont work on PD pins! =
*/=0A=
        immap->im_ioport.iop_pddir &=3D ~(PD4_ENET_RXD | PD4_ENET_TXD);=0A=
=0A=
        /* Configure port C pins to enable CLSN and RENA.=0A=
         */=0A=
        immap->im_ioport.iop_pcpar &=3D ~(PC4_ENET_CLSN | PC4_ENET_RENA);=0A=
        immap->im_ioport.iop_pcdir &=3D ~(PC4_ENET_CLSN | PC4_ENET_RENA);=0A=
        immap->im_ioport.iop_pcso |=3D (PC4_ENET_CLSN | PC4_ENET_RENA);=0A=
=0A=
        /* Configure port A for TCLK and RCLK.=0A=
         * eth2 on CP board: TCLK: CLK7    0x8000=0A=
         *                   RCLK: CLK8    0x4000=0A=
         */=0A=
        immap->im_ioport.iop_papar |=3D (PA4_ENET_TCLK | PA4_ENET_RCLK);=0A=
        immap->im_ioport.iop_padir &=3D ~(PA4_ENET_TCLK | PA4_ENET_RCLK);=0A=
        break;=0A=
    default:=0A=
        break;=0A=
    }=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
int __init cpm_enet_init_scc_clock(int scc_num)=0A=
{=0A=
    volatile cpm8xx_t *cp =3D cpmp;=0A=
=0A=
    /* First, clear all SCC bits to zero, then set the ones we want.=0A=
     */=0A=
    switch (scc_num) {=0A=
    case 0:=0A=
        cp->cp_sicr &=3D ~SICR_ENET_MASK_1;=0A=
        /*=0A=
         * 'First ethernet, eth0:=0A=
         * TCLK: CLK1    RCLK: CLK2=0A=
         */=0A=
        cp->cp_sicr |=3D SICR_ENET_CLKRT_1;  /* 0x0000002C */=0A=
        break;=0A=
    case 1:=0A=
        /*=0A=
         * 'Second ethernet, eth1:=0A=
         * TCLK: CLK3    RCLK: CLK4=0A=
         */=0A=
        cp->cp_sicr &=3D ~SICR_ENET_MASK_2; /* 0x0000ff00 */=0A=
        cp->cp_sicr |=3D SICR_ENET_CLKRT_2; /* 0x00003E00 */=0A=
        break;=0A=
    case 3:=0A=
        /*=0A=
         * eth2:=0A=
         * TCLK: CLK7    RCLK: CLK8=0A=
         */=0A=
        cp->cp_sicr &=3D ~SICR_ENET_MASK_4; /* 0xff000000 */=0A=
        cp->cp_sicr |=3D SICR_ENET_CLKRT_4; /* 0x3E000000 */=0A=
        break;=0A=
    default:=0A=
        break;=0A=
    }=0A=
    return 0;=0A=
}=0A=
=0A=
static void cpm_enet_enable_xmit(int scc_num)=0A=
{=0A=
    volatile immap_t *immap =3D (immap_t *)IMAP_ADDR;=0A=
    volatile cpm8xx_t *cp =3D cpmp;=0A=
=0A=
    switch (scc_num) {=0A=
    case 0: /* SCC1 */=0A=
	cp->cp_pbpar |=3D PB1_ENET_TENA;=0A=
	cp->cp_pbdir |=3D PB1_ENET_TENA;=0A=
        break;=0A=
    case 1: /* SCC2 */=0A=
	cp->cp_pbpar |=3D PB2_ENET_TENA;=0A=
	cp->cp_pbdir |=3D PB2_ENET_TENA;=0A=
        break;=0A=
    case 3: /* SCC4 */=0A=
        immap->im_ioport.iop_pdpar |=3D PD4_ENET_TENA;=0A=
	/* Make sure PDDIR is zero otherwise TENA wont work on PD pins! */=0A=
        immap->im_ioport.iop_pddir &=3D ~PD4_ENET_TENA;=0A=
        break;=0A=
    default:=0A=
        break;=0A=
    }=0A=
}=0A=
=0A=

------=_NextPart_000_006A_01C36DC3.9EB44350--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
