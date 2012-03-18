Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32E20B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 10:53:16 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so1022206pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 16:53:14 -0700 (PDT)
Message-ID: <1332114791.3597.6.camel@edumazet-laptop>
Subject: Re: [PATCH net-next 4/4] gianfar: use netif_tx_queue_stopped
 instead of __netif_subqueue_stopped
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 18 Mar 2012 16:53:11 -0700
In-Reply-To: <CAP=VYLpzpbLVAJ6=L1jdoZWcyAWPPKGMFTKBVU=7=HR+qTxwwA@mail.gmail.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-5-git-send-email-paul.gortmaker@windriver.com>
 <1332107741.9397.27.camel@edumazet-glaptop>
 <CAP=VYLpzpbLVAJ6=L1jdoZWcyAWPPKGMFTKBVU=7=HR+qTxwwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le dimanche 18 mars 2012 à 19:24 -0400, Paul Gortmaker a écrit :
> On Sun, Mar 18, 2012 at 5:55 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > On Sun, 2012-03-18 at 17:39 -0400, Paul Gortmaker wrote:
> >> The __netif_subqueue_stopped() just does the following:
> >>
> >>         struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_index);
> >>         return netif_tx_queue_stopped(txq);
> >>
> >> and since we already have the txq in scope, we can just call that
> >> directly in this case.
> >>
> >> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
> >> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >> ---
> >>  drivers/net/ethernet/freescale/gianfar.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> >> index 6e66cc3..d9428f0 100644
> >> --- a/drivers/net/ethernet/freescale/gianfar.c
> >> +++ b/drivers/net/ethernet/freescale/gianfar.c
> >> @@ -2565,7 +2565,7 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
> >>       }
> >>
> >>       /* If we freed a buffer, we can restart transmission, if necessary */
> >> -     if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfree)
> >> +     if (netif_tx_queue_stopped(txq) && tx_queue->num_txbdfree)
> >>               netif_wake_subqueue(dev, tqi);
> >>
> >>       /* Update dirty indicators */
> >
> > Please change netif_wake_subqueue() as well ;)
> 
> I looked at this earlier when I added patch #4 but I was concerned about
> the different semantics.
> 
> The netif_wake_subqueue() just returns on a netpoll_trap but the other
> netif_tx_wake_queue() actually calls netif_tx_start_queue() for the same
> netpoll_trap instance.  Maybe that is OK, but I didn't want to be changing
> the behaviour of subtleties in stuff where I am clearly still learning.
> 

I see... commit 7b3d3e4fc68 added a small difference here...
