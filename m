Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 268391A0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 15:26:35 +1100 (AEDT)
Received: by mail-pa0-f52.google.com with SMTP id fa1so5202933pad.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 21:26:33 -0700 (PDT)
Date: Mon, 27 Oct 2014 21:26:26 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add reg_defaults for regmap to fix
 kernel dump
Message-ID: <20141028042603.GA5548@Asurada>
References: <1414202637-18929-1-git-send-email-nicoleotsuka@gmail.com>
 <20141028001904.GH18557@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141028001904.GH18557@sirena.org.uk>
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

On Tue, Oct 28, 2014 at 12:19:04AM +0000, Mark Brown wrote:
> On Fri, Oct 24, 2014 at 07:03:57PM -0700, Nicolin Chen wrote:
> > Kernel dump (WARN_ON) ocurred during system boot-up inside regmap_write():
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 47 at kernel/locking/lockdep.c:2744 lockdep_trace_alloc+0xe8/0x108()

> > Even though this may be a bug that should be fixed, I still try to send this
> > patch as a quick fix (work around) since it does no harm to assign default
> > values of every registers when using regcache.
> 
> It's not a bug, it's not reasonable to default allocations to atomic and
> we can't really tell what context we're in.  Anything used inside a
> heavily locked path should either have a default provided or arrange for
> a prior write to set up the cache.

I've a little trouble to understand the prior write over here. Inside my
probe() there's a register_init() call which has a set of regmap_write().
And then the first regmap_write() results the dump. Does that mean this
regmap_write() isn't prior write? If so, how should I do if not setting
default values here -- Some IPs may have default value 0 for registers.
And this would make reg_defaults tedious since there's nothing special
to assign.

And actually I remember I haven't seen any dump when I sent the initial
patch for the whole ASRC driver but it manifested last month. I thought
it might be a partially-merging issue and it would be fixed after merge
window's done.....

Thank you
Nicolin
