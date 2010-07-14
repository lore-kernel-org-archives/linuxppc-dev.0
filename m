Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A2BCCB6F05
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 23:07:31 +1000 (EST)
Date: Wed, 14 Jul 2010 17:07:28 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/8] sdhci: Move real work out of an atomic context
Message-ID: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Fleming <matt@console-pimps.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Currently the sdhci driver does everything in the atomic context.
And what is worse, PIO transfers are made from the IRQ handler.

This causes huge latencies (up to 120 ms). On some P2020 SOCs,
DMA and card detection is broken, which means that kernel polls
for the card via PIO transfers every second. Needless to say
that this is quite bad.

So, this patch set reworks sdhci code to avoid atomic context,
almost completely. We only do two device memory operations
in the atomic context, and all the rest is threaded.

I noticed no throughput drop neither with PIO transfers nor
with DMA (tested on MPC8569E CPU), while latencies should be
greatly improved.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
