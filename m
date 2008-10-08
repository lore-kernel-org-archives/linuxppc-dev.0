Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D4C1DE361
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 07:45:27 +1100 (EST)
Subject: Re: 8600 serial support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <48ED0F30.7080103@hypersurf.com>
References: <48ED0F30.7080103@hypersurf.com>
Content-Type: text/plain
Date: Thu, 09 Oct 2008 07:45:11 +1100
Message-Id: <1223498711.8157.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 12:51 -0700, Kevin Diggs wrote:
> Hi,
> 
> 	I thought I might take a whack at fixing the 2.6 serial driver
> for my 8600. At the top of pmac_zilog.c (2.6.26) there is a todo for DMA.
> A quick glance at macserial.c (2.4.31) suggests it has dbdma support for
> receive. Anyone know of any pitfalls for adding dbdma support for
> pmac_zilog.c?

Yes, it's not totally trivial and I wouldn't recommend using the weirdo
code in macserial (it does things that I don't understand how they work
with the dbdma engine).

The best way I see is to start from scratch with two different
mechanisms:

 - For Tx, that's the easiest, the fire off DMA's for outgoing chars,
maybe queue up a few descriptors to let data accumulate.

 - For Rx, one descriptor per byte. That sucks but I think that's also
what Apple does. No need to have a huge Rx buffer anyway. That gives you
precise Rx status to the byte.

Ben.
