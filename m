Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D3711B7D00
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:56:09 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 69BD9DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:56:09 +1000 (EST)
Date: Wed, 19 Aug 2009 02:56:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] qe_lib: Set gpio data before changing the direction
	to output
Message-ID: <20090818225607.GA29960@oksana.dev.rtsoft.ru>
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
	<4A8B1B2C.5090606@ruggedcom.com>
	<20090818213355.GA20966@oksana.dev.rtsoft.ru>
	<4A8B2C1C.3060403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A8B2C1C.3060403@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Michael Barkowski <michaelbarkowski@ruggedcom.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 05:33:00PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> > On Tue, Aug 18, 2009 at 05:20:44PM -0400, Michael Barkowski wrote:
> >> This avoids having a short glitch if the desired initial value is not
> >> the same as what was previously in the data register.
> >>
> >> Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
> > 
> > Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> I don't have the time to test this patch, so I abstain from acking. :-)
> If Anton likes it, that's good enough for me.

You made me doubt for a moment. :-) Thanks for the suspiciousness.

What happens if a pin was previously configured as input? Does our
write to the data register survive? For MPC8xxx GPIO controllers
it does. And randomly taken QE spec says:

  A write to CPDAT is latched, and if the corresponding CPDIR
  bits have configured the port pin as an output, the latched
  value is driven onto the respective pin. However, if the
  corresponding CPDIR bits have configured the port pin as an
  input, the latched value is prevented from reaching the pin.

I guess we're safe, but Michael, could you actually test it
(if not already)?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
