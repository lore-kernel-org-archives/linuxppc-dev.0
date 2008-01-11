Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 19728DE074
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:01:29 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id EFDBFF49197
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 17:01:27 +0100 (CET)
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: hs@denx.de
In-Reply-To: <478666C6.2030104@denx.de>
References: <1199875566.3408.11.camel@p60365-ste> <4784C509.5030507@denx.de>
	<20080109182038.GA4337@loki.buserror.net> <4785D3D8.7080300@denx.de>
	<4785E014.4040709@denx.de> <4786556C.8040108@freescale.com>
	<478666C6.2030104@denx.de>
Date: Fri, 11 Jan 2008 17:01:27 +0100
Message-Id: <1200067287.31060.0.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Donnerstag, den 10.01.2008, 19:41 +0100 schrieb Heiko Schocher:
> Hello Scott,
> 
> Scott Wood wrote:
> > Heiko Schocher wrote:
> >> diff --git a/drivers/net/fs_enet/fs_enet-main.c
> >> b/drivers/net/fs_enet/fs_enet-main.c
> >> index f2a4d39..f432a18 100644
> >> --- a/drivers/net/fs_enet/fs_enet-main.c
> >> +++ b/drivers/net/fs_enet/fs_enet-main.c
> >> @@ -810,6 +810,10 @@ static int fs_enet_open(struct net_device *dev)
> >>      if (fep->fpi->use_napi)
> >>          napi_enable(&fep->napi);
> >>
> >> +    /* to initialize the fep->cur_rx,... */
> >> +    /* not doing this, will cause a crash in fs_enet_rx_napi */
> >> +    fs_init_bds(fep->ndev);
> > 
> > We should do this just before napi_enable() rather than just after, to
> > eliminate any chance of a race window.
> 
> Yes, you are right.
> Here is the new patch:
> 
It works fine.

Sergej.
