Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B95CA1A0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 12:25:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D58C41401F1
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 12:25:43 +1000 (EST)
Message-ID: <1409797523.25089.8.camel@pasglop>
Subject: Re: TTM placement & caching issue/questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
Date: Thu, 04 Sep 2014 12:25:23 +1000
In-Reply-To: <20140904020742.GC4835@gmail.com>
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@ozlabs.org,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-03 at 22:07 -0400, Jerome Glisse wrote:

> So in the meantime the attached patch should work, it just silently ignore
> the caching attribute request on non x86 instead of pretending that things
> are setup as expected and then latter the radeon ou nouveau hw unsetting
> the snoop bit.
> 
> It's not tested but i think it should work.

I'm still getting placements with !CACHED going from bo_memcpy in
ttm_io_prot() though ... I'm looking at filtering the placement
attributes instead.

Ben.

> > 
> > Cheers,
> > Jérôme
> > 
> > > 
> > > Cheers,
> > > Ben.
> > > 
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > http://lists.freedesktop.org/mailman/listinfo/dri-devel
