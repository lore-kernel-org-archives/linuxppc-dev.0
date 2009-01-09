Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 1258B47506
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 01:54:14 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: mal_probe crash
Date: Fri, 9 Jan 2009 15:49:56 +0100
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<20090108204634.GB2337@yoda.jdub.homelinux.org>
	<1231368610.2142.27.camel@pasglop>
In-Reply-To: <1231368610.2142.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901091549.56943.matthias.fuchs@esd-electronics.com>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009 23:50, Benjamin Herrenschmidt wrote:
> On Thu, 2009-01-08 at 15:46 -0500, Josh Boyer wrote:
> > On Wed, Jan 07, 2009 at 03:44:34PM -0500, Sean MacLennan wrote:
> > >With Linus' latest git, mal_probe crashes. It calls netif_napi_add with
> > >the first parameter NULL. This was ok since the parameter, a net
> > >device, was only used if CONFIG_NETPOLL was set.
> > >
> > >Now it is always de-referenced. A quick check shows that ibm_newemac is
> > >the only driver that passed NULL as the first parameter to this call in
> > >2.6.28.
> > >
> > >I don't really follow ibm_newemac changes, so the patch may be waiting
> > >to be applied. This is really just a heads up.
> > 
> > I haven't heard of that, so I doubt there's a patch pending.  *Sigh*
> 
> There isn't that I know of. The EMAC code creates a single NAPI instance
> for all EMACs and I think used to completely disconnect things. The old
> code created a fake netdev just for NAPI, that became unnecessary with
> the new NAPI stuff.... but it looks like the way we do things now
> displeases some changes in the network stack. I'll have to dig.
> 
Could it be that simple. Probably not. It works at a first glace on
a 405EP ang GPr board. But it might cause problems when having more than 
one EMAC up at the same time.

Matthias

[PATCH] powerpc: Fix ibm_newemac driver

Since commit d565b0a1a9b6ee7d netif_napi_add must be called
if a proper net_device pointer != NULL.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
---
 drivers/net/ibm_newemac/core.c |    3 +++
 drivers/net/ibm_newemac/mal.c  |    5 +----
 drivers/net/ibm_newemac/mal.h  |    1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 87a7066..9bd4d6d 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2767,6 +2767,9 @@ static int __devinit emac_probe(struct of_device *ofdev,
 	if (dev->mdio_dev != NULL)
 		dev->mdio_instance = dev_get_drvdata(&dev->mdio_dev->dev);
 
+	netif_napi_add(ndev, &dev->mal->napi, mal_poll,
+		       CONFIG_IBM_NEW_EMAC_POLL_WEIGHT);
+
 	/* Register with MAL */
 	dev->commac.ops = &emac_commac_ops;
 	dev->commac.dev = dev;
diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index ecf9798..d5306ae 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -391,7 +391,7 @@ void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac)
 	napi_schedule(&mal->napi);
 }
 
-static int mal_poll(struct napi_struct *napi, int budget)
+int mal_poll(struct napi_struct *napi, int budget)
 {
 	struct mal_instance *mal = container_of(napi, struct mal_instance, napi);
 	struct list_head *l;
@@ -613,9 +613,6 @@ static int __devinit mal_probe(struct of_device *ofdev,
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
 
-	netif_napi_add(NULL, &mal->napi, mal_poll,
-		       CONFIG_IBM_NEW_EMAC_POLL_WEIGHT);
-
 	/* Load power-on reset defaults */
 	mal_reset(mal);
 
diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
index 2f0a873..51597bd 100644
--- a/drivers/net/ibm_newemac/mal.h
+++ b/drivers/net/ibm_newemac/mal.h
@@ -282,6 +282,7 @@ void mal_disable_rx_channel(struct mal_instance *mal, int channel);
 
 void mal_poll_disable(struct mal_instance *mal, struct mal_commac *commac);
 void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac);
+int mal_poll(struct napi_struct *napi, int budget);
 
 /* Add/remove EMAC to/from MAL polling list */
 void mal_poll_add(struct mal_instance *mal, struct mal_commac *commac);
-- 
1.5.6.3
