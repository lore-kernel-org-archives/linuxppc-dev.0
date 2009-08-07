Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 77A79B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 04:43:21 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 097D6DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 04:43:21 +1000 (EST)
Date: Fri, 7 Aug 2009 22:43:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 3/4] sdhci-of: Fix high-speed cards recognition
Message-ID: <20090807184319.GA22652@oksana.dev.rtsoft.ru>
References: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
	<20090807165015.GB524@oksana.dev.rtsoft.ru>
	<4A7C5FAB.2020304@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A7C5FAB.2020304@csr.com>
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 06:08:59PM +0100, David Vrabel wrote:
> Anton Vorontsov wrote:
> > eSDHC fails to recognize some SDHS cards, throwing timeout errors:
> > 
> >   mmc0: error -110 whilst initialising SD card
> > 
> > That's because we calculate timeout value in a wrong way: on eSDHC
> > hosts the timeout clock is derivied from the SD clock, which is set
> > dynamically.
> 
> I've seen an reference design for an SDHC controller do this also.

Thanks for the information!

> > +/* Controller has dynamic timeout clock management */
> > +#define SDHCI_QUIRK_DYNAMIC_TIMEOUT_CLOCK		(1<<24)
> 
> This comment and define would be better if it matched terms used in the
> spec.  Suggest:
> 
> /* Controller uses SDCLK instead of TMCLK for data timeouts. */
> #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK  (1 << 24)

Yeah, if it's somewhat common scheme, then it makes sense to name the
quirk that way.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
