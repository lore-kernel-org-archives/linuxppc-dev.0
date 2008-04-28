Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CA85DE0F0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:04:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3SH4J2Y021602
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:04:19 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3SH4IV4016349
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 12:04:18 -0500 (CDT)
Date: Mon, 28 Apr 2008 12:04:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: suggestions on handling additional exception levels on ppc32
Message-ID: <20080428170418.GA11378@ld0162-tx32.am.freescale.net>
References: <DF3B8F4C-EAE1-4F44-8884-44535A855139@kernel.crashing.org>
	<20080428155928.GE9849@ld0162-tx32.am.freescale.net>
	<F8B7AFF4-85EE-4C6B-99A5-E59B416EE78B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F8B7AFF4-85EE-4C6B-99A5-E59B416EE78B@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 11:58:58AM -0500, Kumar Gala wrote:
> 
> On Apr 28, 2008, at 10:59 AM, Scott Wood wrote:
> >On Mon, Apr 28, 2008 at 10:40:56AM -0500, Kumar Gala wrote:
> >>A few possibilities:
> >>* introduce an additional function pointer as part of
> >>EXC_XFER_TEMPLATE() to specifies the type of handler (normal, crit,
> >>dbg, mcheck)
> >>* use the traps field low order bits to determine normal, crit, dbg,
> >>mcheck at run time.
> >>* duplicate the code paths for each exception level
> >>
> >>suggestions?
> >
> >You could temporarily disable all asynchronous exceptions, and use the
> >registers of the highest-priority exception type.
> 
> That doesn't work.  We have NMIs or will have them in the future.

Truly non-maskable?  Ick.  You could have a separate code path just for
the exception type that NMIs use, I guess, if there's a clear
highest-priority among the remaining interrupt types.  What sort of
exceptions are they?

-Scott
