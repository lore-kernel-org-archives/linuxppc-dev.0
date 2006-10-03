Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 349F267C78
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 08:19:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/4]: Spidernet stop queue when queue is full
Date: Wed, 4 Oct 2006 00:19:42 +0200
References: <20061003205240.GE4381@austin.ibm.com>
	<20061003205729.GF4381@austin.ibm.com>
In-Reply-To: <20061003205729.GF4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610040019.43028.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 October 2006 22:57, Linas Vepstas wrote:
> +=A0=A0=A0=A0=A0=A0=A0if ((chain->head->next =3D=3D chain->tail->prev) ||
> +=A0=A0=A0=A0=A0=A0=A0 =A0 (spider_net_get_descr_status(descr) !=3D SPIDE=
R_NET_DESCR_NOT_IN_USE)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0result =3D NETDEV_TX_LOCK=
ED;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> =A0=A0=A0=A0=A0=A0=A0=A0}

=2E..

> =A0out:
> -=A0=A0=A0=A0=A0=A0=A0netif_wake_queue(netdev);
> +=A0=A0=A0=A0=A0=A0=A0card->netdev_stats.tx_dropped++;
> +=A0=A0=A0=A0=A0=A0=A0netif_stop_queue(netdev);
> =A0=A0=A0=A0=A0=A0=A0=A0return result;
> =A0}

Hmm, this looks a little strange to me. I would assume that we should not
stop the queue when the device is locked, but only when it is busy.

I would assume though that the fix is to return NETDEV_TX_BUSY instead
of NETDEV_TX_LOCKED in the case above, while the netif_stop_queue()
is correct here.

	Arnd <><
