Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E287DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 10:19:03 +1000 (EST)
In-Reply-To: <20070614164136.GB27602@iram.es>
References: <200706141739.12754.mb@bu3sch.de> <20070614164136.GB27602@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6e243cf388c34c4dd3c54ffd04dfbd4f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Date: Fri, 15 Jun 2007 02:18:52 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I believe that the hardware (PMU?) forces a power off
> when the fan speed control registers are not accessed
> for some time. This delay may depend on the temperature.

Yes, to me as well it sounds like the PMU is unhappy
because you didn't talk to it for too long while
things are hot.  Pretty hard to prove this assumption
of course -- but try Gabriel's suggestion, if that
works, it means this diagnosis is at least slightly
correct.  A real fix is something different of course.

> As a stab in the dark, you might try to force the fans at
> full speed in an __init function. This will make the machine
> noisy for some time before the loop starts regulating fan
> speed but might buy you some time.


Segher
