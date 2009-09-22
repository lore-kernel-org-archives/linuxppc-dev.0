Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 090F1B7B75
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 09:01:53 +1000 (EST)
Date: Wed, 23 Sep 2009 03:01:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
Message-ID: <20090922230150.GA27593@oksana.dev.rtsoft.ru>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
	<200908031954.50955.david-b@pacbell.net>
	<20090922141705.b5d31e24.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090922141705.b5d31e24.akpm@linux-foundation.org>
Cc: ben@fluff.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, khali@linux-fr.org, dwmw2@infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2009 at 02:17:05PM -0700, Andrew Morton wrote:
> On Mon, 3 Aug 2009 19:54:50 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > On Thursday 30 July 2009, Anton Vorontsov wrote:
> > > This patch converts the m25p80 driver so that now it uses .id_table
> > > for device matching, making it properly detect devices on OpenFirmware
> > > platforms (prior to this patch the driver misdetected non-JEDEC chips,
> > > seeing all chips as "m25p80").
> > 
> > I suspect "detect" is a misnomer there.  It only "detects" JEDEC chips.
> > All others got explicit declarations ... so if there's misbehavior for
> > other chips, it's because those declarations were poorly handled.  Maybe
> > they were not properly flagged as non-JDEC
> > 
> >  
> > > Also, now jedec_probe() only does jedec probing, nothing else. If it
> > > is not able to detect a chip, NULL is returned and the driver fall
> > > backs to the information specified by the platform (platform_data, or
> > > exact ID).
> > 
> > I'd rather keep the warning, so there's a clue about what's really
> > going on:  JEDEC chip found, but its ID is not handled.
> > 
> 
> afaik there was no response to David's review comments, so this patch
> is in the "stuck" state.

Hm? Response:

http://lkml.org/lkml/2009/8/18/363

And the two patches I sent on top:

http://lkml.org/lkml/2009/8/18/364
http://lkml.org/lkml/2009/8/18/366

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
