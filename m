Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418fks2DSszF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 04:29:24 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id k190-v6so15740622oib.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 11:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
In-Reply-To: <87o9g8geu0.fsf@igel.home>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 18 Jun 2018 20:29:10 +0200
Message-ID: <CA+7wUsxM6Leb-RHhecX5Z6JG9WEaRGt6t=7Bo3DQRnsFUyHz6Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: schwab@linux-m68k.org
Cc: eric.dumazet@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 7:54 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > Oh this is silly, please try :
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
> >  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
> >  {
> >         if (skb->ip_summed == CHECKSUM_COMPLETE) {
> > -               int delta = skb->len - len;
> > +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
> >
> > -               skb->csum = csum_sub(skb->csum,
> > -                                    skb_checksum(skb, len, delta, 0));
> > +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
> >         }
> >         return __pskb_trim(skb, len);
> >  }
>
> That doesn't help either.

seconded (setup g4+sungem):

[  100.272676] eth0: hw csum failure
[  100.272710] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #6
[  100.272716] Call Trace:
[  100.272733] [dffedbd0] [c069ddb8]
__skb_checksum_complete+0xf0/0x108 (unreliable)
[  100.272752] [dffedbf0] [c078ea28] __udp4_lib_rcv+0x238/0xf98
[  100.272767] [dffedc70] [c0731630] ip_local_deliver_finish+0xa8/0x3c4
[  100.272777] [dffedcb0] [c073243c] ip_local_deliver+0xf0/0x154
[  100.272786] [dffedcf0] [c07328e8] ip_rcv+0x448/0x774
[  100.272800] [dffedd50] [c06aeaec] __netif_receive_skb_core+0x5e8/0x1184
[  100.272811] [dffedde0] [c06bba2c] napi_gro_receive+0x160/0x22c
[  100.272828] [dffede10] [e1571590] gem_poll+0x7fc/0x1ac0 [sungem]
[  100.272837] [dffedee0] [c06bacfc] net_rx_action+0x34c/0x618
[  100.272849] [dffedf60] [c07fd28c] __do_softirq+0x16c/0x5f0
[  100.272863] [dffedfd0] [c0064c7c] irq_exit+0x110/0x1a8
[  100.272877] [dffedff0] [c0016170] call_do_irq+0x24/0x3c
[  100.272890] [c0cf7e80] [c0009a84] do_IRQ+0x98/0x1a0
[  100.272900] [c0cf7eb0] [c001b474] ret_from_except+0x0/0x14
[  100.272911] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[  100.272920] [c0cf7f70] [c0cf6000] 0xc0cf6000 (unreliable)
[  100.272935] [c0cf7f80] [c00a3868] do_idle+0xc4/0x158
[  100.272944] [c0cf7fb0] [c00a3ab4] cpu_startup_entry+0x24/0x28
[  100.272955] [c0cf7fc0] [c0998820] start_kernel+0x47c/0x490
[  100.272963] [c0cf7ff0] [00003444] 0x3444


> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
