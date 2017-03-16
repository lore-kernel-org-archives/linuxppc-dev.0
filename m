Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQng4PBVzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:13:27 +1100 (AEDT)
Date: Thu, 16 Mar 2017 22:13:07 +1100
From: Anton Blanchard <anton@samba.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Daniel Axtens' <dja@axtens.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/4] crypto: powerpc - Factor out the core CRC vpmsum
 algorithm
Message-ID: <20170316221307.52d14611@kryten>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFB1A81@AcuExch.aculab.com>
References: <20170315123737.20234-1-dja@axtens.net>
 <063D6719AE5E284EB5DD2968C1650D6DCFFB1A81@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> While not part of this change, the unrolled loops look as though
> they just destroy the cpu cache.
> I'd like be convinced that anything does CRC over long enough buffers
> to make it a gain at all.

btrfs data checksumming is one area.

> With modern (not that modern now) superscalar cpus you can often
> get the loop instructions 'for free'.

A branch on POWER8 is a three cycle redirect. The vpmsum instructions
are 6 cycles.

> Sometimes pipelining the loop is needed to get full throughput.
> Unlike the IP checksum, you don't even have to 'loop carry' the
> cpu carry flag.

It went through quite a lot of simulation to reach peak performance.
The loop is quite delicate, we have to pace it just right to avoid
some pipeline reject conditions.

Note also that we already modulo schedule the loop across three
iterations, required to hide the latency of the vpmsum instructions.

Anton
