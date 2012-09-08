Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5CDF62C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 09:09:14 +1000 (EST)
Message-ID: <1347145741.2385.68.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sun, 09 Sep 2012 09:09:01 +1000
In-Reply-To: <1339722302.9220.175.camel@pasglop>
References: <20120614234101.GB17147@tyr.buserror.net>
 <1339722302.9220.175.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-15 at 11:05 +1000, Benjamin Herrenschmidt wrote:
> > -#define MMU_PAGE_COUNT       14
> > +#define MMU_PAGE_2M  6
> > +#define MMU_PAGE_4M  7
> > +#define MMU_PAGE_8M  8
> > +#define MMU_PAGE_16M 9
> > +#define MMU_PAGE_64M 10
> > +#define MMU_PAGE_256M        11
> > +#define MMU_PAGE_1G  12
> > +#define MMU_PAGE_16G 13
> > +#define MMU_PAGE_64G 14
> > +
> > +#define MMU_PAGE_COUNT       15 

BTW. We are getting close to 16 here which is the max since we encode
the size into a 4-bit field in the slice masks on server.

Any chance if/when you respin, to add a BUILD_BUG_ON somewhere to ensure
that we never accidentally break that limit ? (With a comment).

If we need to scavenge a size, we can always get rid of the AP one, it's
not actually useful (we'll have to find a different way to store the
encodings on server if we ever support multiple size per segment).

Cheers,
Ben.
