Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 2BF6D2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 04:34:07 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 15 Nov 2004 10:34:02 -0700
To: roger blofeld <blofeldus@yahoo.com>,
	linuxppc-embedded@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
Message-ID: <20041115173402.GA22661@xyzzy>
References: <20041115163244.57008.qmail@web53505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041115163244.57008.qmail@web53505.mail.yahoo.com>
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2004 at 04:32:43PM +0000, roger blofeld wrote:
> I'm trying to get a simple app running on a Lite5200 and am having a
> TCP/IP problem. Using tcpdump/ethereal I have learned that the Lite5200
> ethernet works fine until the client sends a TCP retransmission
> request. Then the Lite5200 replies with packets having incorrect
> checksums. Each successive Lite5200 packet appears to also lose two
> bytes of data (i.e., the packet size is correct, but the data is not
> the same for each retransmission because two bytes have been dropped
> from the start of the payload).
> 
> Could this be a problem with the FEC driver? Bestcomm? How can I figure
> out what is broken here? Any help gladly accepted!
>  
> I started with Sylvain Munaut's kernel at
> http://www.246tnt.com/mpc52xx/ and have also tried starting with the
> linux-2.5 tree and pulling Sylvain's tree into it to see if newer
> kernels worked better. I also tried using the recently updated bestcomm
> interface from denx.de with these kernels with the same result.

Try the following patch on top of Sylvain's tree.  I sent it (and others)
to Sylvain a while back, but he must be busy with other things.

-Dale

--- linux-2.5-mpc52xx-devel/drivers/net/fec_mpc52xx/fec.c	2004-10-12 11:26:55.000000000 -0700
+++ linux-2.5-mpc52xx-devel-df/drivers/net/fec_mpc52xx/fec.c	2004-11-12 10:20:18.000000000 -0700
@@ -202,6 +202,41 @@
 	return -EAGAIN;
 }
 
+/* The BestComm hardware requires data to be 32-bit aligned.
+ * We also pad to minimum ethernet packet length, ETH_ZLEN.
+ */
+static inline struct sk_buff *fec_skb_align_and_pad(struct sk_buff *skb)
+{
+	void *data = skb->data;
+	int len = skb->len;
+	int pad = (int)data & 0x3;
+	struct sk_buff *nskb;
+	int nlen;
+
+	if (pad == 0)
+		return skb;
+
+	if (!skb_cloned(skb)) {
+		skb_push(skb, pad);
+		memmove(skb->data, data, len);
+		skb_trim(skb, len);
+		skb = skb_padto(skb, ETH_ZLEN);
+		return skb;
+	}
+
+	/* ensure skb_padto doesn't have to reallocate */
+	nlen = (len >= ETH_ZLEN) ? len : ETH_ZLEN;
+
+	nskb = alloc_skb(nlen, GFP_ATOMIC);
+	if (nskb) {
+		skb_put(nskb, len);
+		memcpy(nskb->data, data, len);
+		nskb = skb_padto(nskb, ETH_ZLEN);
+	}
+	kfree_skb(skb);
+	return nskb;
+}
+
 /* This will only be invoked if your driver is _not_ in XOFF state.
  * What this means is that you need not check it, and that this
  * invariant will hold if you make sure that the netif_*_queue()
@@ -210,30 +245,16 @@
 static int fec_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fec_priv *priv = (struct fec_priv *)dev->priv;
-	int pad;
 	void *data;
-	short length;
 
 	if (sdma_queue_full(priv->tx_sdma))
 		panic("MPC52xx transmit queue overrun\n");
 
-	/* the BestComm hardware requires data to be 32-bit aligned */
-	pad = (int)skb->data & 0x3;
-	if (pad) {
-		void *old_data = skb->data;
-		length = skb->len;
-
-		skb_push(skb, pad);
-		memcpy(skb->data, old_data, length);
-		skb_trim(skb, length);
-	}
-
-	/* Zero out up to the minimum length ethernet packet size,
-	 * so we don't inadvertently expose sensitive data
-	 */
-	skb = skb_padto(skb, ETH_ZLEN);
-	if (skb == 0)
+	skb = fec_skb_align_and_pad(skb);
+	if (!skb) {
+		priv->stats.tx_dropped++;
 		return 0;
+	}
 
 	spin_lock_irq(&priv->lock);
 	dev->trans_start = jiffies;
@@ -294,7 +315,8 @@
 			break;
 
 		rskb = sdma_retrieve_buffer(priv->rx_sdma, &length);
-		skb_trim(rskb, length);
+		/* length included sizeof CRC32 */
+		skb_trim(rskb, length - sizeof(u32));
 
 		/* allocate replacement skb */
 		skb = dev_alloc_skb(FEC_RX_BUFFER_SIZE);
@@ -309,6 +331,7 @@
 			priv->stats.rx_dropped++;
 
 			skb_trim(rskb, 0);
+			skb = rskb;
 		}
 
 		skb->dev = dev;
