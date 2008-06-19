Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5480ADE15F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 04:20:38 +1000 (EST)
Date: Thu, 19 Jun 2008 22:20:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: matvejchikov@gmail.com
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Message-ID: <20080619222042.2910e284@vitb.ru.mvista.com>
In-Reply-To: <8496f91a0806181145w62d57a7fua767c8036f2261aa@mail.gmail.com>
References: <200806181707.17739.laurentp@cse-semaphore.com>
	<8496f91a0806181145w62d57a7fua767c8036f2261aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jun 2008 22:45:57 +0400
"Matvejchikov Ilya" <matvejchikov@gmail.com> wrote:

> I'm glad that you have corrected it. Half a year ago I pointed out
> that there was such a mistake:
> http://patchwork.ozlabs.org/linuxppc/patch?id=10700
> 
You've used -embedded ML, and patch wasn't noticed... I can add your S-O-B line if that will make you fill better :) 

-Vitaly
> Thanks.
> 
> 2008/6/18 Laurent Pinchart <laurentp@cse-semaphore.com>:
> > The restart() function is called when the link state changes and resets
> > multicast and promiscous settings. This patch restores those settings at the
> > end of restart().
> >
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> > ---
> >  drivers/net/fs_enet/mac-fcc.c     |    3 +++
> >  2 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
> > index ce40cf9..1a95cf1 100644
> > --- a/drivers/net/fs_enet/mac-fcc.c
> > +++ b/drivers/net/fs_enet/mac-fcc.c
> > @@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
> >                C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
> >
> >        S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
> > +
> > +       /* Restore multicast and promiscous settings */
> > +       set_multicast_list(dev);
> >  }
> >
> >  static void stop(struct net_device *dev)
> > --
> > 1.5.0
> >
> > --
> > Laurent Pinchart
> > CSE Semaphore Belgium
> >
> > Chaussee de Bruxelles, 732A
> > B-1410 Waterloo
> > Belgium
> >
> > T +32 (2) 387 42 59
> > F +32 (2) 387 42 75
> >


-- 
Sincerely, 
Vitaly
