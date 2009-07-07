Return-Path: <rick.jones2@hp.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5DEBB708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 06:47:02 +1000 (EST)
Received: from g5t0007.atlanta.hp.com (g5t0007.atlanta.hp.com [15.192.0.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97447DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 06:47:01 +1000 (EST)
Message-ID: <4A53B43E.4010905@hp.com>
Date: Tue, 07 Jul 2009 13:46:54 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Add support for skb recycling
References: <20090707183842.GA8425@oksana.dev.rtsoft.ru>	<4A53984A.4050002@hp.com>
	<20090707203712.GA11157@oksana.dev.rtsoft.ru>
In-Reply-To: <20090707203712.GA11157@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, Li Yang <leoli@freescale.com>,
	David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@marvell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Jul 07, 2009 at 11:47:38AM -0700, Rick Jones wrote:
>>Admittedly, all the world is not TCP, but a big chunk is, so are you
>>likely to have reference counts go to zero on the tx queue for
>>anything other than small standalone TCP ACK segments?
> 
> 
> That's a generic question wrt skb recycling, right? Whether we can
> always recycle transmitted skbs. No, sometimes (or mostly) we can't.
> 
> Initially, I was quite puzzled by this support... looking at how
> gianfar driver works (it has the same support as of 0fd56bb5be6455d0),
> I noticed that skb_recycle_check() always returns 0, and so we
> don't recycle the skbs.
> 
> Though, things change when the kernel starts packets forwarding,
> *then* skb recycling path actually triggers.
> 
> Lennert (skb recycling author) hints us that the gain is indeed
> in forwarding/routing workload:
> 
> http://kerneltrap.org/mailarchive/linux-netdev/2008/9/28/3433514
 >
> 
> Hope I understood everything correctly. :-)

Given the text reads:

  This gives a nice increase in the maximum loss-free packet forwarding
  rate in routing workloads.

Your understanding is probably correct.  Might have been "nice" :) to get a 
definition of a "nice increase" though :)

rick jones
