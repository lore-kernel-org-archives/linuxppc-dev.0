Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11A44DDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 04:39:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3LIdFWU007966
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 11:39:16 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3LIdFe6019809
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 13:39:15 -0500 (CDT)
Date: Mon, 21 Apr 2008 13:39:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080421183914.GA6213@ld0162-tx32.am.freescale.net>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190908.GA4407@polina.dev.rtsoft.ru>
	<fa686aa40804210703iaa8251ctc125313a8e52f4ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804210703iaa8251ctc125313a8e52f4ef@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 08:03:31AM -0600, Grant Likely wrote:
> >  +    r) Freescale General-purpose Timers Module
> >  +
> >  +    Required properties:
> >  +      - compatible : should be "fsl,gtm" ("fsl,qe-gtm" in addition for QE
> >  +                     GTMs or "fsl,cpm2-gtm" for CPM2 GTMs).
> 
> I don't think this is specific enough.  It is a very real possibility
> for Freescale to produce another part with a "general purpose timers
> module" that isn't register level compatible (and fsl,i2c is an
> example of what not to do).

If that happens, we'll make up "fsl,gtm2". :-)

>  The compatible string should include the
> exact chip version.  Newer parts can also claim compatibility with
> older ones.
> 
> Defining a 'generic' compatible value is also known as "making stuff up".  :-)

Nothing wrong with making stuff up as long as we do it sanely.

How about something like fsl,gtm-1.0?

> >  +/**
> >  + * gtm_ack_timer16 - acknowledge timer event (free-run timers only)
> >  + * @tmr:       pointer to the gtm_timer structure obtained from gtm_get_timer
> >  + * @events:    events mask to ack
> >  + *
> >  + * Thus function used to acknowledge timer interrupt event, use it inside the
> >  + * interrupt handler.
> >  + */
> >  +static inline void gtm_ack_timer16(struct gtm_timer *tmr, u16 events)
> >  +{
> >  +       out_be16(tmr->gtevr, events);
> >  +}
> 
> Drop 'inline' and expect gcc to do the right thing.

Not in a header...

-Scott
