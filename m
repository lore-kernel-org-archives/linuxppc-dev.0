Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 87A69B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 07:57:57 +1000 (EST)
Received: by ewy2 with SMTP id 2so561552ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Sep 2010 14:57:55 -0700 (PDT)
Date: Thu, 9 Sep 2010 01:57:50 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Message-ID: <20100908215750.GA17232@oksana.dev.rtsoft.ru>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
	<20100907153813.936db0c6.akpm@linux-foundation.org>
	<20100908213740.GA7550@void.printf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100908213740.GA7550@void.printf.net>
Cc: Matt Fleming <matt@console-pimps.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 08, 2010 at 10:37:41PM +0100, Chris Ball wrote:
> Hi Andrew,
> 
> On Tue, Sep 07, 2010 at 03:38:13PM -0700, Andrew Morton wrote:
> > > I noticed no throughput drop neither with PIO transfers nor
> > > with DMA (tested on MPC8569E CPU), while latencies should be
> > > greatly improved.
> > 
> > This patchset isn't causing any problems yet, but may do so in the
> > future and will impact the validity of any testing.  It seems to be
> > kind of stuck.  Should I drop it all?
> 
> I suggest keeping it -- I'll find time to test it out here soon, and
> will keep it in mind as a possible regression cause.

Thanks!

Would be also great if you could point out which patch causes
most of the performance drop (if any)?

Albert, if you could find time, can you also "bisect" the
patchset? I wouldn't want to buy Nintendo WII just to debug the
perf regression. ;-) FWIW, I tried to disable multiblock
read/writes and test with SD cards, and still didn't notice
any performance drops.

Maybe it's SDIO IRQs that cause the performance drop for the
WII case, as we delay them a little bit? Or it could be the
patch that introduces threaded IRQ handler in whole causes
it. If so, I guess we'd need to move some of the processing to
the real IRQ context, keeping the handler lockless (if
possible) or introducing a very fine grained locking.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
