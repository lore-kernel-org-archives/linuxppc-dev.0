Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA4D0B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 03:21:09 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oBAGL3jg002643
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 17:21:04 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Fri, 10 Dec 2010 17:21:03 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012081652.13209.dargaud@lpsc.in2p3.fr>
	<1291854156.14490.32.camel@concordia>
In-Reply-To: <1291854156.14490.32.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012101721.03689.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

> Are you sure that you want to have the chrdev registration here (the
> following code)?

It was commented out in my lastest attempts after reading Michael's 
explainations.

> Such stuff typically goes into the probe() function. The modules's
> init() just registers the driver. Furthermore your global variables
> prohibit having more than one device instance using the driver.

Only one such device will ever be build, so don't expect a mainline kernel 
patch from me anytime soon !   C;-)

> Also turn on CONFIG_DEBUG_DRIVER and see if that gives you anything
> interesting.

I see an unset CONFIG_DEBUG_KERNEL but no CONFIG_DEBUG_DRIVER in the .config of 
my current kernel. 
Does it need to be changed in the .config with a full kernel recompilation, or 
can I still benefit from it in my module only by doing a #define at the begining 
of my code ? Some #defines like DEBUG seem to work locally on things like 
dev_dbg but I doubt the CONFIG_* work the same...

> Er. Not sure sorry. I can't see anything obviously wrong. Maybe post
> your driver code again.

Err... I ran it again this morning and it worked farther. I now get into the 
probe function and can now register my interrupt, yeah!, but I don't see the 
ISR being called. I'm currently checking if it can be a hardware problem 
before coming back here for more questions !

BTW, is errno/strerror used within the kernel ?

Thanks all.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
