Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78275679F5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:38:48 +1000 (EST)
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060413222721.GN24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<1144961515.4935.22.camel@localhost.localdomain>
	<20060413222721.GN24769@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 08:38:31 +1000
Message-Id: <1144967911.4935.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-13 at 17:27 -0500, Olof Johansson wrote:
> On Fri, Apr 14, 2006 at 06:51:55AM +1000, Benjamin Herrenschmidt wrote:
> 
> > an improvement with the DART thanks to virtual merging. Currently, we
> > pay a cost due to our stupid invalidate mecanism that we should really
> > fix by shooting the TLB directly.
> 
> What was keeping me from implementing this before was the lack of public
> documentation on how to do it. Has that changed? I'd be happy to do the
> implementation.

Darwin has the macros to access the TLB though it doesn't use them... I
suppose I can get the necessary doco bit from the microelectronics folks
for the CPC925, that should apply to U3 as well, though U4 has a
different format afaik. I'll dig and will come back to you.

> > Also have you made sure all your
> > additions for handling crappy hardware are nicely wrapped in unlikely()
> > statements ? :)
> 
> I would expect the dynamic predictor to work quite well on this. I'm not
> worried about the overhead of the tests as much as the overhead of
> having to enable the DART for smaller configs. If benchmark profiling
> shows different down the road then we can add them.

Ok.

Ben.
