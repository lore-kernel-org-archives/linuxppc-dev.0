Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33C7D67A84
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 10:45:11 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050206225323.GA16821@mars.ravnborg.org>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
	<20050206225323.GA16821@mars.ravnborg.org>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 10:43:11 +1100
Message-Id: <1107733391.30303.66.camel@gaston>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-02-06 at 23:53 +0100, Sam Ravnborg wrote:

> The problem is that the images/ sub directory is visited before the
> prerequisites are finished.
> I have no good way to debug this - I can see it based on the Makefile and
> the output Olaf included.
> 
> Also the problem Olaf describe is just a cp of a half finished file.

We had a similar problem with paul recently where the build worked but
the resulting zImage contained a corrupted file as the
objcopy/gzip/whatever wasn't fully finished when the zImage file got
linked.
> 
> So the fix is to let the images/ directory depends on the rest of the
> directories.
> 
> Something like this may do the trick:

We should maybe also have an explicit dependency on vmlinux no ? Or is
this handled already for the boot dir as a whole ?

> $(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
> 	$(Q)$(MAKE) $(build)=$@
> 
> And then delete the assignment of images to subdir-y
> 
> 
> Another solution would be to get rid on the images/ drectory and place
> outputfiles where they are being built.
> 
> 	Sam
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
