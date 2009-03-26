Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A52ADDDB2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 03:43:30 +1100 (EST)
In-Reply-To: <20090326133918.GA27085@oksana.dev.rtsoft.ru>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1238072077-27044-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<20090326133918.GA27085@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ucc_geth: Rework the TX logic.
Message-ID: <OF5FC70952.28684E98-ONC1257585.005ADBF9-C1257585.005BDD35@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Thu, 26 Mar 2009 17:43:25 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 26/03/2009 14:39:18:
> 
> Hi Joakim,

Hi Anton

> 
> On Thu, Mar 26, 2009 at 01:54:37PM +0100, Joakim Tjernlund wrote:
> > The line:
> >  if ((bd == ugeth->txBd[txQ]) && (netif_queue_stopped(dev) == 0))
> >        break;
> > in ucc_geth_tx() didn not make sense to me. Rework & cleanup
> > this logic to something understandable.
> > 
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  drivers/net/ucc_geth.c |   40 
++++++++++++++++++++--------------------
> >  1 files changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> > index 7fc91aa..b6ebefd 100644
> > --- a/drivers/net/ucc_geth.c
> > +++ b/drivers/net/ucc_geth.c
> > @@ -3048,6 +3048,7 @@ static int ucc_geth_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
> >     u8 __iomem *bd;         /* BD pointer */
> >     u32 bd_status;
> >     u8 txQ = 0;
> > +   int txInd;
> 
> camelCase should not be used in Linux.
> 
> Surely, the driver is full of camelCases... though, it should be
> fixed, not encouraged further.

OK, I will rename to tx_ind instead.

> 
> And btw, there is even Hungarian notation in the driver. :-(

Hopefully that will go away in time.

> 
> [...]
> >     /* If the next BD still needs to be cleaned up, then the bds
> >        are full.  We need to tell the kernel to stop sending us stuff. 
*/
> > -   if (bd == ugeth->confBd[txQ]) {
> > -      if (!netif_queue_stopped(dev))
> > -         netif_stop_queue(dev);
> > +   if (!in_be32((u32 __iomem *)(bd+4))) {
> 
> bd == ugeth->confBd[txQ]
> and
> !in_be32((u32 __iomem *)(bd+4))
> 
> Are not equivalent wrt. speed. MMIO accessors should be rather
> slow comparing to normal memory.

Yes, I know. I did it this way because I something broke under stress
when ugeth->confBd[txQ] instead. The ucc_geth_tx() and 
ucc_geth_start_xmit()
gets out of sync somehow.

> 
> We should really do some performance tests (using gbit links).
> I'll try to help you with the tests, but it might take some time.

Good, because I don't have GBE links :(

> 
> [...]
> > +      if (!in_be32((u32 __iomem *)(bd+4)))
> [...]
> > +      out_be32((u32 __iomem *)(bd+4), (int)NULL); /* Mark it free */
> 
> How about some inline function that will self-document the bd + 4
> stuff? Plus that way we'll get rid of the casts.

Good idea, will look at that.

> 
> Note that "bd+4" should be "bd + 4". And (int)NULL makes
> little sense, just 0 will work.

Sure, done.
