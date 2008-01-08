Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2AB10DDF5E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:25:23 +1100 (EST)
Date: Tue, 8 Jan 2008 13:25:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
Message-ID: <20080108192531.GB5296@loki.buserror.net>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<fa686aa40801080919y7c426007vd031bb79e8f9a03d@mail.gmail.com>
	<20080108175513.GC5188@loki.buserror.net>
	<fa686aa40801080956n20f31a54xe02328a139ac3a3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801080956n20f31a54xe02328a139ac3a3b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 10:56:41AM -0700, Grant Likely wrote:
> On 1/8/08, Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, Jan 08, 2008 at 10:19:20AM -0700, Grant Likely wrote:
> > > > +config MPC5121_ADS
> > > > +       bool "Freescale MPC5121E ADS"
> > > > +       select DEFAULT_UIMAGE
> > > > +       help
> > > > +         This option enables support for the MPC5121E ADS board.
> > >
> > > Make this depend on PPC_MULTIPLATFORM and PPC32
> >
> > I don't think PPC_MULTIPLATFORM is appropriate here... it seems to be
> > OF-specific.
> 
> 52xx is multiplatform.

"multiplatform" and "PPC_MULTIPLATFORM" are not the same.  The config option
is misnamed.

> It works well on both OF and non-OF boards.

It may work, but it pulls in code like prom_init.c that is not needed on
non-OF boards.  It's also quite confusing to have an embedded board's
checkbox only show up when you say yes to "Generic desktop/server/laptop".

-Scott
