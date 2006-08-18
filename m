Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8C6B067B68
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:03:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6]: powerpc/cell spidernet bottom half
Date: Sat, 19 Aug 2006 01:03:04 +0200
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222657.GL26889@austin.ibm.com>
In-Reply-To: <20060818222657.GL26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608190103.05649.arnd@arndb.de>
Cc: akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 19 August 2006 00:26, Linas Vepstas wrote:
> The recent set of low-waterark patches for the spider result in a
> significant amount of computing being done in an interrupt context.
> This patch moves this to a "bottom half" aka work queue, so that
> the code runs in a normal kernel context. Curiously, this seems to 
> result in a performance boost of about 5% for large packets.

I guess this one still needs some work. We already have a bottom
half mechanism in the network layer, using the NAPI poll function
that is strongly serialized.

Linas, you wrote that you have tried doing the TX descriptor cleanup
in dev->poll(), but I think you missed the point that this function
needs should then be scheduled whenever necessary.

This seems a little strange, but I think what we need to do is in the
low-watermark interrupt call netif_rx_schedule(netdev) in order to
arrange for the ->poll function to be called in the next softirq.

Someone should probably document that in 
Documentation/networking/NAPI_HOWTO.txt, I might end up doing that
once we get it right for spidernet.

	Arnd <><
