Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACFECB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 10:24:48 +1100 (EST)
Received: by lbbgn12 with SMTP id gn12so2956262lbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 16:24:44 -0700 (PDT)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1332107741.9397.27.camel@edumazet-glaptop>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-5-git-send-email-paul.gortmaker@windriver.com>
 <1332107741.9397.27.camel@edumazet-glaptop>
Date: Sun, 18 Mar 2012 19:24:44 -0400
Message-ID: <CAP=VYLpzpbLVAJ6=L1jdoZWcyAWPPKGMFTKBVU=7=HR+qTxwwA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] gianfar: use netif_tx_queue_stopped instead
 of __netif_subqueue_stopped
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sun, Mar 18, 2012 at 5:55 PM, Eric Dumazet <eric.dumazet@gmail.com> wrot=
e:
> On Sun, 2012-03-18 at 17:39 -0400, Paul Gortmaker wrote:
>> The __netif_subqueue_stopped() just does the following:
>>
>> =A0 =A0 =A0 =A0 struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qu=
eue_index);
>> =A0 =A0 =A0 =A0 return netif_tx_queue_stopped(txq);
>>
>> and since we already have the txq in scope, we can just call that
>> directly in this case.
>>
>> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>> =A0drivers/net/ethernet/freescale/gianfar.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethe=
rnet/freescale/gianfar.c
>> index 6e66cc3..d9428f0 100644
>> --- a/drivers/net/ethernet/freescale/gianfar.c
>> +++ b/drivers/net/ethernet/freescale/gianfar.c
>> @@ -2565,7 +2565,7 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_=
q *tx_queue)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* If we freed a buffer, we can restart transmission, if nec=
essary */
>> - =A0 =A0 if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfr=
ee)
>> + =A0 =A0 if (netif_tx_queue_stopped(txq) && tx_queue->num_txbdfree)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_wake_subqueue(dev, tqi);
>>
>> =A0 =A0 =A0 /* Update dirty indicators */
>
> Please change netif_wake_subqueue() as well ;)

I looked at this earlier when I added patch #4 but I was concerned about
the different semantics.

The netif_wake_subqueue() just returns on a netpoll_trap but the other
netif_tx_wake_queue() actually calls netif_tx_start_queue() for the same
netpoll_trap instance.  Maybe that is OK, but I didn't want to be changing
the behaviour of subtleties in stuff where I am clearly still learning.

Thanks,
Paul.

>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
