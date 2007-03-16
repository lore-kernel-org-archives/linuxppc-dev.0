Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A637CDDEF8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 03:21:52 +1100 (EST)
Date: Fri, 16 Mar 2007 11:21:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316162135.GA29231@ld0162-tx32.am.freescale.net>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
	<20070316001819.GE6784@localhost.localdomain>
	<20070316004717.GB10786@mag.az.mvista.com>
	<20070316005016.GI6784@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316005016.GI6784@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 11:50:16AM +1100, David Gibson wrote:
> Sorry, I misunderstood.  That sort of firmware - and the even dumber
> sort where the start address isn't configurable at all - is exactly
> what option (1) is for.  You'll need an asm platform file which
> defines _zimage_start to a fixed offset.  In your case you could
> probably just make it a jump to the generic _zimage_start.

One problem with that is that the wrapper currently only accepts one
platform .o file -- and presumably one isn't going to want to do all of
the platform code in assembly.

If the wrapper is changed to allow two platform .o files, then the link
order can be "platform_early.o crt0.o platform.o".  If platform_early.o
isn't provided, then crt0.o goes first, and one doesn't need to provide a
platform .S for the special case of having the entry be at a known offset
from the start of the file, while still allowing a platform .S to be
provided for cases where it's really needed.

-Scott
