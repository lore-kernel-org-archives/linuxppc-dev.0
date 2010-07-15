Return-Path: <matt@arkanian.console-pimps.org>
Received: from arkanian.console-pimps.org (arkanian.console-pimps.org
	[212.110.184.194]) by ozlabs.org (Postfix) with ESMTP id 480B1B6F0E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 16:12:43 +1000 (EST)
From: Matt Fleming <matt@console-pimps.org>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
In-Reply-To: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Date: Thu, 15 Jul 2010 07:02:55 +0100
Message-ID: <87oce9z3hs.fsf@linux-g6p1.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>, Andrew Morton <akpm@linux-foundation.org>,
	Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Jul 2010 17:07:28 +0400, Anton Vorontsov <avorontsov@mvista.com> wrote:
> Hi all,
> 
> Currently the sdhci driver does everything in the atomic context.
> And what is worse, PIO transfers are made from the IRQ handler.
> 
> This causes huge latencies (up to 120 ms). On some P2020 SOCs,
> DMA and card detection is broken, which means that kernel polls
> for the card via PIO transfers every second. Needless to say
> that this is quite bad.
> 
> So, this patch set reworks sdhci code to avoid atomic context,
> almost completely. We only do two device memory operations
> in the atomic context, and all the rest is threaded.
> 
> I noticed no throughput drop neither with PIO transfers nor
> with DMA (tested on MPC8569E CPU), while latencies should be
> greatly improved.

I haven't had time to read these patches in detail yet but they all seem
to be sensible changes. A very nice series!
