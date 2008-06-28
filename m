Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80D88DDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 09:37:35 +1000 (EST)
In-Reply-To: <fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Date: Sun, 29 Jun 2008 01:37:12 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm really don't like "fsl,sec1.0" or any of the variants as a
> compatible property either because it can easily be abused (it's not
> anchored to a specific physical part so the meaning can shift over
> time); but that is another argument and it is well documented in other
> email threads  
> (http://thread.gmane.org/gmane.linux.ports.ppc64.devel/38977/ 
> focus=39147)

Also, these made-up names make you do more work: you'll need to
write up a binding for them, explaining exactly what a 1.0 device
etc. is (or at least point to documentation for it).  If you use
a name that refers to some device that people can easily google
for documentation, you can skip this (well, you might need to
write a binding anyway; but at least you won't have to explain
what the device _is_).

Using actual model names also reduces the namespace pollution
(hopefully Freescale will not create some other MPC8272 device
ever, so "fsl,mpc8272-whatever" will never be a nice name to
use for any other device; OTOH, it's likely that Freescale will
create some other device called "SEC" (there are only so many
TLAs, after all), so "fsl,sec-n.m" isn't as future-proof.


Segher
