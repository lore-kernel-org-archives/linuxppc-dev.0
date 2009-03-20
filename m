Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD86BDDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 07:46:17 +1100 (EST)
In-Reply-To: <20090320200740.GA32082@oksana.dev.rtsoft.ru>
References: <OF20EA88BB.017079CD-ONC125757F.006C40A2-C125757F.006C646E@transmode.se>
	<20090320200740.GA32082@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
MIME-Version: 1.0
Subject: Re: Fw: [PATCH] ucc_geth: Correct fixed_link OOPS.
Message-ID: <OF9395F5D9.8C7241AA-ONC125757F.00714908-C125757F.0072183A@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 20 Mar 2009 21:46:13 +0100
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

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 20/03/2009 21:07:40:
> 
> On Fri, Mar 20, 2009 at 08:43:56PM +0100, Joakim Tjernlund wrote:
> > hmm, this mail didn't seem to reach the lists. Resending
> > 
> >  Jocke
> > ----- Forwarded by Joakim Tjernlund/Transmode on 20/03/2009 20:42 
-----
> > 
> > From:
> > Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > To:
> > leoli@freescale.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
> > Cc:
> > Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date:
> > 20/03/2009 18:01
> > Subject:
> > [PATCH] ucc_geth: Correct fixed_link OOPS.
> > 
> > 
> > 
> > fixed_link(PHY less) mode will get you an NULL
> > deference as it does not have a phy-handle.
> > Correct by using already probed information.
> > 
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> > 
> > The below fixes the problem and seems like the right thing to do.
> > Can we have this in 2.6.29?
> > 
> >  drivers/net/ucc_geth.c |   17 +----------------
> >  1 files changed, 1 insertions(+), 16 deletions(-)

[SNIP]

> 
> This effectivly breaks boards where Gianfar is using UCC's MDIO
> bus (i.e. breaks commit b1c4a9dddf09fe99b8f88252718ac5b357363dc4,
> which is the cause of fixed-link breakage, btw). And, your patch
> is line-wrapped and tabs are substituted by white spaces...

Yes, I noticed that afterwards. It is our "great" new mailsystem
that gets in the way. I really need to find another mailsystem as
Lotus/Domino gets in my way too often :(

> 
> I would suggest something along these lines (unfortunately
> right now I can't test it on real HW, only compile-tested):

Tested here, works fine for fixed-link PHYs, thanks.
I left the 
    priv->oldlink = 0;
    priv->oldspeed = 0;
    priv->oldduplex = -1;
in though. Seemed like a good idea.

Tested By: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

 Jocke
