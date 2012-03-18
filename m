Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE596B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:04:08 +1100 (EST)
Received: by lbbgn12 with SMTP id gn12so2921705lbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 14:04:05 -0700 (PDT)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1332102032.3722.53.camel@edumazet-laptop>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332089787-24086-2-git-send-email-paul.gortmaker@windriver.com>
 <1332102032.3722.53.camel@edumazet-laptop>
Date: Sun, 18 Mar 2012 17:04:04 -0400
Message-ID: <CAP=VYLpNhJGZ0MS6Y6gWvbzn3vg-jHP0_kSBd6_Xxq_6hRyo8g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] gianfar: Add support for byte queue limits.
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

On Sun, Mar 18, 2012 at 4:20 PM, Eric Dumazet <eric.dumazet@gmail.com> wrot=
e:
> Le dimanche 18 mars 2012 =E0 12:56 -0400, Paul Gortmaker a =E9crit :
>
> ...
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we add this skb back into the pool, if =
it's the right size
>> @@ -2557,13 +2568,15 @@ static int gfar_clean_tx_ring(struct gfar_priv_t=
x_q *tx_queue)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* If we freed a buffer, we can restart transmission, if nec=
essary */
>> - =A0 =A0 if (__netif_subqueue_stopped(dev, tx_queue->qindex) && tx_queu=
e->num_txbdfree)
>> - =A0 =A0 =A0 =A0 =A0 =A0 netif_wake_subqueue(dev, tx_queue->qindex);
>> + =A0 =A0 if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfr=
ee)
>> + =A0 =A0 =A0 =A0 =A0 =A0 netif_wake_subqueue(dev, tqi);
>>
>
> You can use netif_tx_queue_stopped(txq) here instead of
> __netif_subqueue_stopped(dev, tqi)

Yes, and it looks better too.  I will do it as a patch #4 since I think
there is some small value in leaving the above patch chunk alone,
since it makes it clear that it was just the introduction of a local
variable and the code was otherwise unchanged here.

Will resend shortly....

Thanks,
Paul.
---

>
>> =A0 =A0 =A0 /* Update dirty indicators */
>> =A0 =A0 =A0 tx_queue->skb_dirtytx =3D skb_dirtytx;
>> =A0 =A0 =A0 tx_queue->dirty_tx =3D bdp;
>>
>> + =A0 =A0 netdev_tx_completed_queue(txq, howmany, bytes_sent);
>> +
>> =A0 =A0 =A0 return howmany;
>> =A0}
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
