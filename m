Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02E811007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 07:14:47 +1000 (EST)
Date: Wed, 21 Jul 2010 14:13:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Message-Id: <20100721141352.d7993493.akpm@linux-foundation.org>
In-Reply-To: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 14 Jul 2010 17:07:28 +0400
Anton Vorontsov <avorontsov@mvista.com> wrote:

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
> 

The patchset looks good to me, but it'd be nice to hear from the other
people who work on this code, please?
