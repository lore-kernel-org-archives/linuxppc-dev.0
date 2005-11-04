Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03A6668593
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 18:19:48 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0511032313i426db0c8o7254009240f6988a@mail.gmail.com>
References: <1130999620.4680.28.camel@gaston>
	<60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
	<1131052876.4680.78.camel@gaston>
	<60381eeb0511032313i426db0c8o7254009240f6988a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 18:18:50 +1100
Message-Id: <1131088730.4680.251.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Heh, in _theory_ :) The first aim of the patch is to remove the crash on
> > sleep/wakeup in 2.6.14. If it doesn't blow up, that's already a good
> 
> Well, I couldn't get to that point (getting back from sleep) :-D
> 
> > first step :) Wether suspend with your USB stick works is a different
> > matter, mostly due to the USB stack itself.
> 
> The kernel oopsed when it was supposed to go to sleep:

I would say your first mistake is to use PREEMPT :) There are various
issues with PREEMPT on ppc32 that have not really been addressed so far,
and the USB code has some "holes" that I wouldn't trust in a PREEMPT
environment.

Anyway, I'll try to come up with a better patch this week-end. Please,
continue giving me feedback with oops backtraces etc...

Ben.
