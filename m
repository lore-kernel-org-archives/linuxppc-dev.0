Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87DFC1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 17:54:56 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA0AC1401F6
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 17:54:55 +1000 (EST)
Message-ID: <1409817275.4246.40.camel@pasglop>
Subject: Re: TTM placement & caching issue/questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 04 Sep 2014 17:54:35 +1000
In-Reply-To: <54081282.3040005@daenzer.net>
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
 <1409797523.25089.8.camel@pasglop> <20140904023117.GD4835@gmail.com>
 <20140904023656.GF4835@gmail.com> <54081282.3040005@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jerome Glisse <j.glisse@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 16:19 +0900, Michel Dänzer wrote:
> > +#else /* CONFIG_X86 */
> > +int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t
> *placement)
> > +{
> > +     if (*placement & (TTM_PL_TT | TTM_PL_FLAG_SYSTEM)) {
> > +             ttm->caching_state = tt_cached;
> > +             *placement &= ~TTM_PL_MASK_CACHING;
> > +             *placement |= TTM_PL_FLAG_CACHED;
> 
> NAK, this will break AGP on PowerMacs.

 ... which doesn't work reliably anyway with DRI2 :-)

The problem is ... with DRI1 I think we had tricks to take out the
AGP from the linear mapping but that want away, didn't we ?

In any case, we are playing with fire on these by allowing the
cache paradox. It just happens that those old CPUs aren't *that*
aggressive at speculative prefetch and we probably rarely hit the
lockups that they would cause...

Michel, what do you recommend we do then ? The patch I sent to
double check in ttm_io_prot() has a specific hack to avoid warning
on PowerMac for the above reason, but we need to fix Jerome if we
want to keep that broken-by-design Mac AGP functionality going :-)

Maybe we could add a similar ifdef in the above ?

Cheers,
Ben.
