Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A7FFCB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 23:32:30 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 38E27DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 23:32:29 +1000 (EST)
Date: Wed, 19 Aug 2009 17:32:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: [PATCH v2] qe_lib: Set gpio data before changing the direction
	to output
Message-ID: <20090819133227.GA29934@oksana.dev.rtsoft.ru>
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
	<4A8B1B2C.5090606@ruggedcom.com>
	<20090818213355.GA20966@oksana.dev.rtsoft.ru>
	<4A8B2C1C.3060403@freescale.com>
	<20090818225607.GA29960@oksana.dev.rtsoft.ru>
	<4A8BFE6C.9030604@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A8BFE6C.9030604@ruggedcom.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 09:30:20AM -0400, Michael Barkowski wrote:
> Anton Vorontsov wrote:
> > On Tue, Aug 18, 2009 at 05:33:00PM -0500, Timur Tabi wrote:
> >> Anton Vorontsov wrote:
> >>> On Tue, Aug 18, 2009 at 05:20:44PM -0400, Michael Barkowski wrote:
> >>>> This avoids having a short glitch if the desired initial value is not
> >>>> the same as what was previously in the data register.
> >>>>
> >>>> Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
> >>> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >> I don't have the time to test this patch, so I abstain from acking. :-)
> >> If Anton likes it, that's good enough for me.
> > 
> > You made me doubt for a moment. :-) Thanks for the suspiciousness.
> > 
> > What happens if a pin was previously configured as input? Does our
> > write to the data register survive? For MPC8xxx GPIO controllers
> > it does. And randomly taken QE spec says:
> > 
> >   A write to CPDAT is latched, and if the corresponding CPDIR
> >   bits have configured the port pin as an output, the latched
> >   value is driven onto the respective pin. However, if the
> >   corresponding CPDIR bits have configured the port pin as an
> >   input, the latched value is prevented from reaching the pin.
> > 
> > I guess we're safe, but Michael, could you actually test it
> > (if not already)?
> > 
> 
> I had tested it before with the pin initially configured as "disabled".
> 
> I have now also tested it with the pin initially configured as "input".
> 
> The value written to CPDAT seems to survive and is driven onto the pin
> once CPDIR is changed to 1, just as noted in the spec.
> 
> Tested on 8360, by probing with a logic analyzer.

Great, thanks a lot! I think the patch is perfect.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
