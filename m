Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D82F8DE289
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 09:14:51 +1000 (EST)
In-Reply-To: <48382710.9030700@scram.de>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>	<20080523182842.GB469@polina.dev.rtsoft.ru>
	<fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
	<48382710.9030700@scram.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be6dcc7a8a3132a40af7dfed9a430876@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Date: Sun, 25 May 2008 01:14:28 +0200
To: Jochen Friedrich <jochen@scram.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The real problem is we don't yet have good method (or place) to apply
>> a translation table from compatible values to modaliases.  Ideally,
>> the translations should be part of the drivers themselves, but that
>> causes a chicken and egg problem of needing to load the driver to get
>> access to the table to know if it is the correct driver... Of course,
>> I'm really not very familiar with the whole module autoloading
>> mechanism.  Regardless; binding should be based on compatible, not on
>> a hacky and bogus linux,modalias property.
>
> i2c exactly has the same problem. Here the compatible entry is used
> in drivers/of/of_i2c.c and mangled into a name to be used as modalias.
> It's still sort of hackish, but it seems to be a compromise acceptable
> by both OF and i2c folks.

It's perfectly acceptable.  The sole purpose of "compatible" is for
a client (i.e., the kernel) to decide what to do with this device;
most often, to decide what driver to use.

It would be nice to have a completely generic thing that matches device
tree nodes to drivers, and it sounds perfectly reasonable to me to go
via modalias for that (i.e., just translate from device tree namespace
to the kernel driver namespace).

As a bonus, it would make driver matching more correct in some places:
currently, whatever driver matches first wins (i.e., which "compatible"
value is tried first), but the ordering of different values in 
"compatible"
is supposed to be significant (whatever is mentioned there first should
win).


Segher
