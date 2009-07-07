Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8619CB6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 06:37:15 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 16BEFDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 06:37:14 +1000 (EST)
Date: Wed, 8 Jul 2009 00:37:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Rick Jones <rick.jones2@hp.com>
Subject: Re: [PATCH] ucc_geth: Add support for skb recycling
Message-ID: <20090707203712.GA11157@oksana.dev.rtsoft.ru>
References: <20090707183842.GA8425@oksana.dev.rtsoft.ru>
	<4A53984A.4050002@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A53984A.4050002@hp.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, Li Yang <leoli@freescale.com>,
	David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@marvell.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2009 at 11:47:38AM -0700, Rick Jones wrote:
> Anton Vorontsov wrote:
> >We can reclaim transmitted skbs to use in the receive path, so-called
> >skb recycling support.
> >
> >Also reorder ucc_geth_poll() steps, so that we'll clean tx ring firstly,
> >thus maybe reclaim some skbs for rx.
> 
> Admittedly, all the world is not TCP, but a big chunk is, so are you
> likely to have reference counts go to zero on the tx queue for
> anything other than small standalone TCP ACK segments?

That's a generic question wrt skb recycling, right? Whether we can
always recycle transmitted skbs. No, sometimes (or mostly) we can't.

Initially, I was quite puzzled by this support... looking at how
gianfar driver works (it has the same support as of 0fd56bb5be6455d0),
I noticed that skb_recycle_check() always returns 0, and so we
don't recycle the skbs.

Though, things change when the kernel starts packets forwarding,
*then* skb recycling path actually triggers.

Lennert (skb recycling author) hints us that the gain is indeed
in forwarding/routing workload:

http://kerneltrap.org/mailarchive/linux-netdev/2008/9/28/3433514

Hope I understood everything correctly. :-)


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
