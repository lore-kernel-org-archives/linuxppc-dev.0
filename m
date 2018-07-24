Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-211.mimecast.com
 (eu-smtp-delivery-211.mimecast.com [207.82.80.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZhW94dQkzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 01:05:40 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Krzysztof Kozlowski' <krzk@kernel.org>, Pantelis Antoniou
 <pantelis.antoniou@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Date: Tue, 24 Jul 2018 11:05:59 +0000
Message-ID: <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org>
In-Reply-To: <20180723162020.6221-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Krzysztof Kozlowski
> Sent: 23 July 2018 17:20
> Use generic kernel CRC32 implementation because it:
> 1. Should be faster (uses lookup tables),

Are you sure?
The lookup tables are unlikely to be in the data cache and
the 6 cache misses kill performance.
(Not that it particularly matters when setting up multicast hash tables).

> 2. Removes duplicated CRC generation code,
> 3. Uses well-proven algorithm instead of coding it one more time.
...
>=20
> Not tested on hardware.

Have you verified that the old and new functions give the
same result for a few mac addresses?
It is very easy to use the wrong bits in crc calculations
or generate the output in the wrong bit order.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)
