From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Mon, 28 Oct 2002 16:17:07 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJCEHFCKAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <200210241423.g9OENV4d024137@blooper.utfors.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jocke,

I just had a look at the code. So far it is running fine. on my board. :)
Following question:
In scc-enet_rx you use invalidate_dcache_range() for the skb data area.
Why don't you do the same in scc_enet_init() for the first set of skb's?
Isn't it required too at this place.

Thanks, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joakim
> Tjernlund
> Sent: Donnerstag, 24. Oktober 2002 16:24
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: scop@digitel.com.br; thomas@corelatus.com
> Subject: [PATCH] arch/ppc/8xx_io/enet.c, version 2
>
>
>
> Hi
>
> This is the second version of my patch that removes the expensive
> memcpy of
> received
> ethernet frames in interrupt context.
>
> I have 1 report(from Ricardo Scop) of 20% increase in
> packets/second, packet
> size 1500 when
> applied to 8260 FEC(needs to be applied manually). But min packet size
> decreased with 10 %.
> This version should fix the 10% decrease case.
>
> This patch could be adapted 8xx_io/fec.c and 8260_io/enet.c and
> 8260/fcc_enet.c with little effort.
>
> Better fix a bug in set_multicast_list(), move the dmi list forward when
>     walking it(dmi = dmi->next;)
>
> New stuff:
>    - Configrable: copy small packets or pass them directly, see
> COPY_SMALL_FRAMES in code.
>    - Collision reporting fix form Thomas Lange.
>    - Don't pass receive frames which has error upwards.
>    - Report RX_OV errors as fifo errors, not crc errors.
>
> Please test and report any problems and performace improvements.
>
>         Jocke
>
> --- arch/ppc/8xx_io/enet.c.org	Mon Oct 21 14:35:59 2002
> +++ arch/ppc/8xx_io/enet.c	Thu Oct 24 15:48:25 2002
> @@ -34,7 +34,6 @@
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> -#include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/netdevice.h>
> @@ -86,6 +85,14 @@
>   * All functions are directly controlled using I/O pins.  See
> <asm/commproc.h>.
>   */
>
> +/* Define COPY_SMALL_FRAMES if you want to save buffer memory for small
> packets
> + * at a small performance hit. Note performance testing needed */
> +#define COPY_SMALL_FRAMES 1
> +
> +#ifdef COPY_SMALL_FRAMES
> +  #define RX_COPYBREAK (256-16) /* dev_alloc_skb() adds 16 bytes for
> internal use */
> +#endif
> +
>  /* The transmitter timeout
>   */
>  #define TX_TIMEOUT	(2*HZ)
> @@ -97,19 +104,17 @@
>   * the skbuffer directly.
>   */
>  #ifdef CONFIG_ENET_BIG_BUFFERS
> -#define CPM_ENET_RX_PAGES	32
> -#define CPM_ENET_RX_FRSIZE	2048
> -#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
> -#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
> -#define TX_RING_SIZE		64	/* Must be power of two */
> -#define TX_RING_MOD_MASK	63	/*   for this to work */
> +  #define RX_RING_SIZE		64
> +  #define TX_RING_SIZE		64	/* Must be power of
> two for this to work */
>  #else
> -#define CPM_ENET_RX_PAGES	4
> -#define CPM_ENET_RX_FRSIZE	2048
> -#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
> -#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
> -#define TX_RING_SIZE		8	/* Must be power of two */
> -#define TX_RING_MOD_MASK	7	/*   for this to work */
> +  #define RX_RING_SIZE		8
> +  #define TX_RING_SIZE		8	/* Must be power of
> two for this to work */
> +#endif
> +#define TX_RING_MOD_MASK	(TX_RING_SIZE-1)
> +
> +#define CPM_ENET_RX_FRSIZE	1600 /* must be a multiple of cache line */
> +#if CPM_ENET_RX_FRSIZE % L1_CACHE_LINE_SIZE != 0
> +    #error CPM_ENET_RX_FRSIZE must be a multiple of L1 cache size
>  #endif
>
>  /* The CPM stores dest/src/type, data, and checksum for receive packets.
> @@ -143,7 +148,7 @@
>  	/* Virtual addresses for the receive buffers because we can't
>  	 * do a __va() on them anymore.
>  	 */
> -	unsigned char *rx_vaddr[RX_RING_SIZE];
> +	void    *rx_vaddr[RX_RING_SIZE];
>  	struct	net_device_stats stats;
>  	uint	tx_full;
>  	spinlock_t lock;
> @@ -370,11 +375,11 @@
>
>  		cep->stats.tx_packets++;
>
> -		/* Deferred means some collisions occurred during transmit,
> -		 * but we eventually sent the packet OK.
> -		 */
> -		if (bdp->cbd_sc & BD_ENET_TX_DEF)
> -			cep->stats.collisions++;
> +		/* Check retry counter, i.e. collision counter */
> +		if (bdp->cbd_sc & BD_ENET_TX_RCMASK){
> +			/* Note that counter cannot go higher than 15 */
> +			cep->stats.collisions+=(bdp->cbd_sc &
> BD_ENET_TX_RCMASK)>>2;
> +		}
>
>  		/* Free the sk buffer associated with this last transmit.
>  		*/
> @@ -449,6 +454,7 @@
>  	struct	scc_enet_private *cep;
>  	volatile cbd_t	*bdp;
>  	struct	sk_buff *skb;
> +	struct	sk_buff *skb_tmp;
>  	ushort	pkt_len;
>
>  	cep = (struct scc_enet_private *)dev->priv;
> @@ -461,7 +467,8 @@
>  for (;;) {
>  	if (bdp->cbd_sc & BD_ENET_RX_EMPTY)
>  		break;
> -
> +
> +#define RX_BD_ERRORS (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_CL)
>  #ifndef final_version
>  	/* Since we have allocated space to hold a complete frame, both
>  	 * the first and last indicators should be set.
> @@ -470,51 +477,62 @@
>  		(BD_ENET_RX_FIRST | BD_ENET_RX_LAST))
>  			printk("CPM ENET: rcv is not first+last\n");
>  #endif
> -
> -	/* Frame too long or too short.
> -	*/
> -	if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
> -		cep->stats.rx_length_errors++;
> -	if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
> -		cep->stats.rx_frame_errors++;
> -	if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
> -		cep->stats.rx_crc_errors++;
> -	if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
> -		cep->stats.rx_crc_errors++;
> -
> -	/* Report late collisions as a frame error.
> -	 * On this error, the BD is closed, but we don't know what we
> -	 * have in the buffer.  So, just drop this frame on the floor.
> -	 */
> -	if (bdp->cbd_sc & BD_ENET_RX_CL) {
> -		cep->stats.rx_frame_errors++;
> -	}
> -	else {
> -
> +	if(bdp->cbd_sc & RX_BD_ERRORS){ /* Receive errors ? */
> +		cep->stats.rx_errors++;
> +		if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
> /* Frame too long or
> too short. */
> +			cep->stats.rx_length_errors++;
> +		if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame
> alignment */
> +			cep->stats.rx_frame_errors++;
> +		if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
> +			cep->stats.rx_crc_errors++;
> +		if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
> +			cep->stats.rx_fifo_errors++;
> +		if (bdp->cbd_sc & BD_ENET_RX_CL)        /* Late collision */
> +			cep->stats.collisions++;
> +	} else {
>  		/* Process the incoming frame.
>  		*/
>  		cep->stats.rx_packets++;
>  		pkt_len = bdp->cbd_datlen;
>  		cep->stats.rx_bytes += pkt_len;
> -
> -		/* This does 16 byte alignment, much more than we need.
> -		 * The packet length includes FCS, but we don't want to
> -		 * include that when passing upstream as it messes up
> -		 * bridging applications.
> -		 */
> -		skb = dev_alloc_skb(pkt_len-4);
> -
> -		if (skb == NULL) {
> +		pkt_len -= 4; /* The packet length includes FCS,
> but we don't want to
> +			       * include that when passing upstream
> as it messes up
> +			       * bridging applications. Is this
> still true ???? */
> +#ifdef COPY_SMALL_FRAMES
> +		/* Allocate the next buffer now so we are sure to
> have one when needed
> +		 * This does 16 byte alignment, exactly what we
> need(L1_CACHE aligned). */
> +		if(pkt_len < RX_COPYBREAK)
> +			skb_tmp = __dev_alloc_skb(pkt_len,
> GFP_ATOMIC|GFP_DMA);
> +		else
> +#endif
> +			skb_tmp =
> __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC|GFP_DMA);
> +
> +		if (skb_tmp == NULL) {
>  			printk("%s: Memory squeeze, dropping
> packet.\n", dev->name);
>  			cep->stats.rx_dropped++;
> -		}
> -		else {
> +
> +		} else {
> +			skb = cep->rx_vaddr[bdp - cep->rx_bd_base];
> +			invalidate_dcache_range((unsigned long) skb->data,
> +						(unsigned long)
> skb->data + pkt_len);
> +
> +#ifdef COPY_SMALL_FRAMES
> +			if(pkt_len < RX_COPYBREAK) {
> +				typeof(skb) skb_swap = skb;
> +				memcpy(skb_put(skb_tmp, pkt_len),
> skb->data, pkt_len);
> +				/* swap the skb and skb_tmp */
> +				skb = skb_tmp;
> +				skb_tmp = skb_swap;
> +			}
> +			else
> +#endif
> +			{
> +				skb_put(skb, pkt_len);  /* Make room */
> +				bdp->cbd_bufaddr = __pa(skb_tmp->data);
> +				cep->rx_vaddr[bdp -
> cep->rx_bd_base] = skb_tmp;
> +			}
>  			skb->dev = dev;
> -			skb_put(skb,pkt_len-4);	/* Make room */
> -			eth_copy_and_sum(skb,
> -				cep->rx_vaddr[bdp - cep->rx_bd_base],
> -				pkt_len-4, 0);
> -			skb->protocol=eth_type_trans(skb,dev);
> +			skb->protocol=eth_type_trans(skb, dev);
>  			netif_rx(skb);
>  		}
>  	}
> @@ -608,7 +626,7 @@
>
>  			dmi = dev->mc_list;
>
> -			for (i=0; i<dev->mc_count; i++) {
> +			for (i=0; i<dev->mc_count; i++, dmi = dmi->next) {
>
>  				/* Only support group multicast for now.
>  				*/
> @@ -647,8 +665,7 @@
>  	struct net_device *dev;
>  	struct scc_enet_private *cep;
>  	int i, j, k;
> -	unsigned char	*eap, *ba;
> -	dma_addr_t	mem_addr;
> +	unsigned char	*eap;
>  	bd_t		*bd;
>  	volatile	cbd_t		*bdp;
>  	volatile	cpm8xx_t	*cp;
> @@ -839,22 +856,13 @@
>
>  	bdp = cep->rx_bd_base;
>  	k = 0;
> -	for (i=0; i<CPM_ENET_RX_PAGES; i++) {
> -
> -		/* Allocate a page.
> -		*/
> -		ba = (unsigned char *)consistent_alloc(GFP_KERNEL,
> PAGE_SIZE, &mem_addr);
> -
> -		/* Initialize the BD for every fragment in the page.
> -		*/
> -		for (j=0; j<CPM_ENET_RX_FRPPG; j++) {
> -			bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
> -			bdp->cbd_bufaddr = mem_addr;
> -			cep->rx_vaddr[k++] = ba;
> -			mem_addr += CPM_ENET_RX_FRSIZE;
> -			ba += CPM_ENET_RX_FRSIZE;
> -			bdp++;
> -		}
> +	/* Initialize the BDs. */
> +	for (j=0; j < RX_RING_SIZE; j++) {
> +		struct	sk_buff * skb = __dev_alloc_skb(CPM_ENET_RX_FRSIZE,
> GFP_ATOMIC|GFP_DMA);
> +		bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
> +		bdp->cbd_bufaddr = __pa(skb->data);
> +		cep->rx_vaddr[k++] = skb;
> +		bdp++;
>  	}
>
>  	/* Set the last buffer to wrap.
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
