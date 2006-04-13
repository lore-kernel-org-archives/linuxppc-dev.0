Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 16CC4679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:27:55 +1000 (EST)
Date: Thu, 13 Apr 2006 17:27:21 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
Message-ID: <20060413222721.GN24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<1144961515.4935.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1144961515.4935.22.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 14, 2006 at 06:51:55AM +1000, Benjamin Herrenschmidt wrote:

> an improvement with the DART thanks to virtual merging. Currently, we
> pay a cost due to our stupid invalidate mecanism that we should really
> fix by shooting the TLB directly.

What was keeping me from implementing this before was the lack of public
documentation on how to do it. Has that changed? I'd be happy to do the
implementation.

> Also have you made sure all your
> additions for handling crappy hardware are nicely wrapped in unlikely()
> statements ? :)

I would expect the dynamic predictor to work quite well on this. I'm not
worried about the overhead of the tests as much as the overhead of
having to enable the DART for smaller configs. If benchmark profiling
shows different down the road then we can add them.


-Olof
