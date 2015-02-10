Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F4841A02E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:45:56 +1100 (AEDT)
Message-ID: <1423597534.5891.3.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Olson <olson@cumulusnetworks.com>
Date: Wed, 11 Feb 2015 06:45:34 +1100
In-Reply-To: <20150210165542.GB16682@cumulusnetworks.com>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
 <20150209234351.GC22286@cumulusnetworks.com>
 <1423527151.4924.64.camel@kernel.crashing.org>
 <20150210080002.GA23291@cumulusnetworks.com>
 <1423556040.4924.90.camel@kernel.crashing.org>
 <20150210165542.GB16682@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 08:55 -0800, Dave Olson wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Tue, 2015-02-10 at 00:00 -0800, Dave Olson wrote:
> > > 
> > > OK, now that I understand that's the case, I'll have to go back and
> > > re-do the patch to handle both cache-size and d-cache-size for the
> > > L2 cache (using whichever is present).
> > 
> > I notice that you also didn't modify all the other properties, I would
> > assume you need to also updates in that area ? Maybe you should
> > duplicate the whole structure and have the code look for both.
> 
> Since we have line_size_props, I can bump that from 2 to 4
> entries, and add "cache_line_size" and "cache_block_size",
> instead of an explict check.
> 
> I could change size_prop, and nr_sets_prop to be a structure like
> line_size_props, if you think that's cleaner than the explict
> check for "cache-size", and "cache-sets" in the functions.
> 
> These 3 seem to be the only ones at issue, and I should have checked
> futher to realize that sets and line size were missing.
> 
> What's the preference for the other 2 missing items?

Up to you, but I'm thinking at this point, isn't it worth duplicating
the whole struct and using which ever matches on the first entry ?

> > > I don't have any power Macs to use for testing, would one of you be
> > > willing and able to verify the patch on a power Mac?
> 
> Dave Olson
> olson@cumulusnetworks.com
