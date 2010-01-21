Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id AD372B6EEB
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 03:43:48 +1100 (EST)
Received: by iwn42 with SMTP id 42so150736iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 08:43:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264039999-25731-2-git-send-email-agust@denx.de>
References: <1264039999-25731-1-git-send-email-agust@denx.de>
	<1264039999-25731-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 Jan 2010 09:43:27 -0700
Message-ID: <fa686aa41001210843n64be77d9wd62631d7b36d7342@mail.gmail.com>
Subject: Re: [net-next-2.6 PATCH 1/3] fs_enet: use dev_xxx instead of printk
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 20, 2010 at 7:13 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: <linuxppc-dev@ozlabs.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> Cc: John Rigby <jcrigby@gmail.com>
> Cc: Piotr Ziecik <kosmo@semihalf.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
> =A0drivers/net/fs_enet/fs_enet-main.c | =A0 39 +++++++++++++-------------=
---------
> =A0drivers/net/fs_enet/mac-fcc.c =A0 =A0 =A0| =A0 =A05 ++-
> =A0drivers/net/fs_enet/mac-fec.c =A0 =A0 =A0| =A0 12 ++++------
> =A0drivers/net/fs_enet/mac-scc.c =A0 =A0 =A0| =A0 =A09 +++----
> =A04 files changed, 27 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_=
enet-main.c
> index ec2f503..c34a7e0 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -108,9 +108,7 @@ static int fs_enet_rx_napi(struct napi_struct *napi, =
int budget)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the last indicator should be set.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((sc & BD_ENET_RX_LAST) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MOD=
ULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s rcv is=
 not +last\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev, "rcv is =
not +last\n");
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Check for errors.
> @@ -178,9 +176,8 @@ static int fs_enet_rx_napi(struct napi_struct *napi, =
int budget)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0received++=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0netif_rece=
ive_skb(skb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0": %s Memory squeeze, dropping packet.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fe=
p->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"Memory squeeze, dropping packet.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fep->stats=
.rx_dropped++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skbn =3D s=
kb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -242,9 +239,7 @@ static int fs_enet_rx_non_napi(struct net_device *dev=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the last indicator should be set.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((sc & BD_ENET_RX_LAST) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MOD=
ULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s rcv is=
 not +last\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev, "rcv is =
not +last\n");
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Check for errors.
> @@ -313,9 +308,8 @@ static int fs_enet_rx_non_napi(struct net_device *dev=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0received++=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0netif_rx(s=
kb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0": %s Memory squeeze, dropping packet.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fe=
p->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"Memory squeeze, dropping packet.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fep->stats=
.rx_dropped++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skbn =3D s=
kb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -388,10 +382,10 @@ static void fs_enet_tx(struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fep->stats.tx_packets++;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sc & BD_ENET_TX_READY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MOD=
ULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s HEY! E=
net xmit interrupt and TX_READY.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sc & BD_ENET_TX_READY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"HEY! En=
et xmit interrupt and TX_READY.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Deferred means some collisions occurred=
 during transmit,
> @@ -511,9 +505,8 @@ void fs_init_bds(struct net_device *dev)
> =A0 =A0 =A0 =A0for (i =3D 0, bdp =3D fep->rx_bd_base; i < fep->rx_ring; i=
++, bdp++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D dev_alloc_skb(ENET_RX_FRSIZE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (skb =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MOD=
ULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s Memory=
 squeeze, unable to allocate skb\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Memory =
squeeze, unable to allocate skb\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb_align(skb, ENET_RX_ALIGN);
> @@ -610,8 +603,7 @@ static int fs_enet_start_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Ooops. =A0All transmit buffers are full=
. =A0Bail out.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * This should not happen, since the tx qu=
eue should be stopped.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s tx queue full!.\n", de=
v->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev, "tx queue full!.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NETDEV_TX_BUSY;
> =A0 =A0 =A0 =A0}
>
> @@ -788,8 +780,7 @@ static int fs_enet_open(struct net_device *dev)
> =A0 =A0 =A0 =A0r =3D request_irq(fep->interrupt, fs_enet_interrupt, IRQF_=
SHARED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fs_enet-mac", dev);
> =A0 =A0 =A0 =A0if (r !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s Could not allocate FS_=
ENET IRQ!", dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fep->dev, "Could not allocate FS_EN=
ET IRQ!");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fep->fpi->use_napi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0napi_disable(&fep->napi);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1053,7 +1044,7 @@ static int __devinit fs_enet_probe(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_bd;
>
> - =A0 =A0 =A0 printk(KERN_INFO "%s: fs_enet: %pM\n", ndev->name, ndev->de=
v_addr);
> + =A0 =A0 =A0 pr_info("%s: fs_enet: %pM\n", ndev->name, ndev->dev_addr);
>
> =A0 =A0 =A0 =A0return 0;
>
> diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.=
c
> index 22e5a84..dd78640 100644
> --- a/drivers/net/fs_enet/mac-fcc.c
> +++ b/drivers/net/fs_enet/mac-fcc.c
> @@ -476,8 +476,9 @@ static void clear_int_events(struct net_device *dev, =
u32 int_events)
>
> =A0static void ev_error(struct net_device *dev, u32 int_events)
> =A0{
> - =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s FS_ENET ERROR(s) 0x%x\n", dev->name, i=
nt_events);
> + =A0 =A0 =A0 struct fs_enet_private *fep =3D netdev_priv(dev);
> +
> + =A0 =A0 =A0 dev_warn(fep->dev, "FS_ENET ERROR(s) 0x%x\n", int_events);
> =A0}
>
> =A0static int get_regs(struct net_device *dev, void *p, int *sizep)
> diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.=
c
> index ca7bcb8..a664aa1 100644
> --- a/drivers/net/fs_enet/mac-fec.c
> +++ b/drivers/net/fs_enet/mac-fec.c
> @@ -257,8 +257,7 @@ static void restart(struct net_device *dev)
>
> =A0 =A0 =A0 =A0r =3D whack_reset(fep->fec.fecp);
> =A0 =A0 =A0 =A0if (r !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ": %s FEC R=
eset FAILED!\n", dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fep->dev, "FEC Reset FAILED!\n");
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Set station address.
> =A0 =A0 =A0 =A0 */
> @@ -355,9 +354,7 @@ static void stop(struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(1);
>
> =A0 =A0 =A0 =A0if (i =3D=3D FEC_RESET_DELAY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s FEC timeout on gracefu=
l transmit stop\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev, "FEC timeout on graceful=
 transmit stop\n");
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Disable FEC. Let only MII interrupts.
> =A0 =A0 =A0 =A0 */
> @@ -433,8 +430,9 @@ static void clear_int_events(struct net_device *dev, =
u32 int_events)
>
> =A0static void ev_error(struct net_device *dev, u32 int_events)
> =A0{
> - =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s FEC ERROR(s) 0x%x\n", dev->name, int_e=
vents);
> + =A0 =A0 =A0 struct fs_enet_private *fep =3D netdev_priv(dev);
> +
> + =A0 =A0 =A0 dev_warn(fep->dev, "FEC ERROR(s) 0x%x\n", int_events);
> =A0}
>
> =A0static int get_regs(struct net_device *dev, void *p, int *sizep)
> diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.=
c
> index 008cdd9..2d8917f 100644
> --- a/drivers/net/fs_enet/mac-scc.c
> +++ b/drivers/net/fs_enet/mac-scc.c
> @@ -367,9 +367,7 @@ static void stop(struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(1);
>
> =A0 =A0 =A0 =A0if (i =3D=3D SCC_RESET_DELAY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s SCC timeout on gracefu=
l transmit stop\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(fep->dev, "SCC timeout on graceful=
 transmit stop\n");
>
> =A0 =A0 =A0 =A0W16(sccp, scc_sccm, 0);
> =A0 =A0 =A0 =A0C32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
> @@ -429,8 +427,9 @@ static void clear_int_events(struct net_device *dev, =
u32 int_events)
>
> =A0static void ev_error(struct net_device *dev, u32 int_events)
> =A0{
> - =A0 =A0 =A0 printk(KERN_WARNING DRV_MODULE_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0": %s SCC ERROR(s) 0x%x\n", dev->name, int_e=
vents);
> + =A0 =A0 =A0 struct fs_enet_private *fep =3D netdev_priv(dev);
> +
> + =A0 =A0 =A0 dev_warn(fep->dev, "SCC ERROR(s) 0x%x\n", int_events);
> =A0}
>
> =A0static int get_regs(struct net_device *dev, void *p, int *sizep)
> --
> 1.5.6.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
