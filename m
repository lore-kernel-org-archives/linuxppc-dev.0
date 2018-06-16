Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4177sZ213MzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 17:14:57 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so10766978oiy.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 00:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
In-Reply-To: <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 16 Jun 2018 09:14:42 +0200
Message-ID: <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: eric.dumazet@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Christophe LEROY <christophe.leroy@c-s.fr>,
 Meelis Roos <mroos@linux.ee>, schwab@linux-m68k.org, netdev@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Eric,

On Fri, Jun 15, 2018 at 9:14 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 06/15/2018 11:56 AM, Mathieu Malaterre wrote:
> > This reverts commit 88078d98d1bb085d72af8437707279e203524fa5.
> >
> > It causes regressions for people using chips driven by the sungem
> > driver. Suspicion is that the skb->csum value isn't being adjusted
> > properly.
> >
> > Symptoms as seen on G4+sungem are:
> >
> > [   34.023281] eth0: hw csum failure
> > [   34.023438] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #2
> > [   34.023618] Call Trace:
> > [   34.023707] [dffedbd0] [c069ddac] __skb_checksum_complete+0xf0/0x108 (unreliable)
> > [   34.023948] [dffedbf0] [c0777a70] tcp_v4_rcv+0x604/0xe00
> > [   34.024118] [dffedc70] [c0731624] ip_local_deliver_finish+0xa8/0x3c4
> > [   34.024315] [dffedcb0] [c0732430] ip_local_deliver+0xf0/0x154
> > [   34.024493] [dffedcf0] [c07328dc] ip_rcv+0x448/0x774
> > [   34.024653] [dffedd50] [c06aeae0] __netif_receive_skb_core+0x5e8/0x1184
> > [   34.024857] [dffedde0] [c06bba20] napi_gro_receive+0x160/0x22c
> > [   34.025044] [dffede10] [e14b2590] gem_poll+0x7fc/0x1ac0 [sungem]
> > [   34.025228] [dffedee0] [c06bacf0] net_rx_action+0x34c/0x618
> > [   34.025402] [dffedf60] [c07fd27c] __do_softirq+0x16c/0x5f0
> > [   34.025575] [dffedfd0] [c0064c7c] irq_exit+0x110/0x1a8
> > [   34.025738] [dffedff0] [c0016170] call_do_irq+0x24/0x3c
> > [   34.025903] [c0cf7e80] [c0009a84] do_IRQ+0x98/0x1a0
> > [   34.026055] [c0cf7eb0] [c001b474] ret_from_except+0x0/0x14
> > [   34.026225] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> >                    LR = arch_cpu_idle+0x30/0x78
> > [   34.026510] [c0cf7f70] [c0cf6000] 0xc0cf6000 (unreliable)
> > [   34.026682] [c0cf7f80] [c00a3868] do_idle+0xc4/0x158
> > [   34.026835] [c0cf7fb0] [c00a3ab0] cpu_startup_entry+0x20/0x28
> > [   34.027013] [c0cf7fc0] [c0998820] start_kernel+0x47c/0x490
> > [   34.027181] [c0cf7ff0] [00003444] 0x3444
> >
> > See commit 7ce5a27f2ef8 ("Revert "net: Handle CHECKSUM_COMPLETE more
> > adequately in pskb_trim_rcsum()."") for previous reference.
>
> This fix seems to hide a bug in csum functions on this architecture.

That's odd since it seems to only affect g4+sungem user. None of the
ppc64 seems to be having it. And some ppc32 users are not even seeing
it.

> Or a bug on this NIC when receiving a small packet (less than 60 bytes).
> Maybe the padding bytes are not included in NIC provided csum, and not 0.

Ok in that case the bug is located in
./drivers/net/ethernet/sun/sungem.c that seems more likely. I'll try
to understand that code, then.

Thanks

>
>
>
