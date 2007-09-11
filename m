Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A8004DDF27
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:14:27 +1000 (EST)
Date: Tue, 11 Sep 2007 12:15:21 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070911171521.GB10743@lixom.net>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
	<20070911141821.GA32545@lixom.net>
	<230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>
	<20070911155558.GA10743@lixom.net>
	<11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 11:00:28AM -0500, Kumar Gala wrote:
> 
> On Sep 11, 2007, at 10:55 AM, Olof Johansson wrote:
> 
> > On Tue, Sep 11, 2007 at 10:50:18AM -0500, Kumar Gala wrote:

> >>> How different are these boards really? Could you just detect  
> >>> MPC85xxDS
> >>> and have a generic platform for them, or are they different  
> >>> enough that
> >>> you need individual ones for it?
> >>
> >> I wanted a different probe.  I figured having a different struct  
> >> was a
> >> simple solution.
> >
> > Seems like the only reason to need that is the setting of
> > primary_phb_addr.  Can't that information be derived out of the device
> > tree instead? That'd avoid alot of code duplication (code that  
> > includes
> > ifdefs, FWIW :-)
> 
> well the ifdefs are orthogonal.  We don't have a way of knowing  
> primary from the device tree today.

How about something like "fsl,primary-phb" in the bus device node? I don't
know, maybe it's already been discussed and turned down for some reason.

Or would it be sufficient to check children of that device node to see
if the ULi is on that bus?

> > It just seems like a slippery slope. I'm not objecting directly to  
> > this
> > patch, but I think it should be fixed for the longer term.
> 
> Once we have a clean way of knowing primary PHB than I'm happy to fixup.


-Olof
