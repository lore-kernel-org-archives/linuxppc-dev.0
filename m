Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 234DB1A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 03:37:45 +1100 (AEDT)
Received: by mail-pa0-f47.google.com with SMTP id kx10so1092910pab.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 09:37:43 -0700 (PDT)
Date: Tue, 28 Oct 2014 09:37:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add reg_defaults for regmap to fix
 kernel dump
Message-ID: <20141028163733.GA6480@Asurada>
References: <1414202637-18929-1-git-send-email-nicoleotsuka@gmail.com>
 <20141028001904.GH18557@sirena.org.uk>
 <20141028042603.GA5548@Asurada>
 <20141028104742.GP18557@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141028104742.GP18557@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2014 at 10:47:42AM +0000, Mark Brown wrote:
> On Mon, Oct 27, 2014 at 09:26:26PM -0700, Nicolin Chen wrote:
> > On Tue, Oct 28, 2014 at 12:19:04AM +0000, Mark Brown wrote:
> 
> > > It's not a bug, it's not reasonable to default allocations to atomic and
> > > we can't really tell what context we're in.  Anything used inside a
> > > heavily locked path should either have a default provided or arrange for
> > > a prior write to set up the cache.
> 
> > I've a little trouble to understand the prior write over here. Inside my
> > probe() there's a register_init() call which has a set of regmap_write().
> > And then the first regmap_write() results the dump. Does that mean this
> > regmap_write() isn't prior write? If so, how should I do if not setting
> 
> Oh, bother.  We fixed things so that we're now always running with the
> spinlock held...  never mind.

Okay...so only one choice left.

> > default values here -- Some IPs may have default value 0 for registers.
> > And this would make reg_defaults tedious since there's nothing special
> > to assign.
> 
> Write a small script then, or a little bit of code to create the
> defaults dynamically.

It actually doesn't bother me at all. I just thought there might be
a simpler way. :)

Thank you
Nicolin
