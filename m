Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjxR061QPzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:10:35 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Daniel Axtens' <dja@axtens.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
CC: "anton@samba.org" <anton@samba.org>
Subject: RE: [PATCH 1/4] crypto: powerpc - Factor out the core CRC vpmsum
 algorithm
Date: Wed, 15 Mar 2017 16:10:28 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFB1A81@AcuExch.aculab.com>
References: <20170315123737.20234-1-dja@axtens.net>
In-Reply-To: <20170315123737.20234-1-dja@axtens.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linuxppc-dev Daniel Axtens
> Sent: 15 March 2017 12:38
> The core nuts and bolts of the crc32c vpmsum algorithm will
> also work for a number of other CRC algorithms with different
> polynomials. Factor out the function into a new asm file.
>=20
> To handle multiple users of the function, a user simply
> provides constants, defines the name of their CRC function,
> and then #includes the core algorithm file.
...

While not part of this change, the unrolled loops look as though
they just destroy the cpu cache.
I'd like be convinced that anything does CRC over long enough buffers
to make it a gain at all.

With modern (not that modern now) superscalar cpus you can often
get the loop instructions 'for free'.
Sometimes pipelining the loop is needed to get full throughput.
Unlike the IP checksum, you don't even have to 'loop carry' the
cpu carry flag.

	David
