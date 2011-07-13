Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C4F1B6F77
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 17:39:01 +1000 (EST)
Received: by wwf10 with SMTP id 10so4879124wwf.21
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 00:38:58 -0700 (PDT)
Subject: Re: softirqs are invoked while bottom halves are masked
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
In-Reply-To: <CAAXf6LXddZUHEz738DDTi-XqENRYT7dTODw+1C4RTYsCdyro7g@mail.gmail.com>
References: <1310465411.3314.6.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<CAMJ=MEeC1hoqufs7AfFRn3yJoC8mdw7v+14N+7e=wQuJefm4_w@mail.gmail.com>
	<20110712.050817.1253941735409335652.davem@davemloft.net>
	<20110712.051316.1963034055315982365.davem@davemloft.net>
	<CAAXf6LXddZUHEz738DDTi-XqENRYT7dTODw+1C4RTYsCdyro7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jul 2011 09:38:53 +0200
Message-ID: <1310542733.2634.17.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	David Miller <davem@davemloft.net>, ronny.meeus@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mercredi 13 juillet 2011 à 09:20 +0200, Thomas De Schampheleire a
écrit :

> I just want to mention that, although you seem to think that we
> shouldn't have created this thread in the first place, your and Eric's
> remarks have actually helped us in identifying the problem and
> increasing our understanding.
> 

Thread was fine IMHO, but should have mentioned the context of "non
standard linux-2.6 or net-next-2.6 trees"

I would like to mention NETIF_F_LLTX existence.

While being marked deprecated, it allows a lockless tx path :

The device transmit handler can then perform custom actions, including
its own locking if needed.

If the user wants a specific Qdisc setup (instead of a no qdisc one), it
still can.

veth, loopback, dummy, macvlan & bond devices use NETIF_F_LLTX for
example.

But ndo_start_xmit() must always be called with BH disabled.
