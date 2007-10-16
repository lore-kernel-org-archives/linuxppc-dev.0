Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDCA2DDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 05:28:50 +1000 (EST)
Message-ID: <4714E505.3080801@freescale.com>
Date: Tue, 16 Oct 2007 11:21:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pasemi: process i2c device tree entries at boot
References: <20071015015232.GA4641@lixom.net>
	<20071015224932.GA23875@lixom.net> <4713EFBB.3070203@freescale.com>
	<20071016001701.GA25444@lixom.net>
In-Reply-To: <20071016001701.GA25444@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Mon, Oct 15, 2007 at 05:54:51PM -0500, Scott Wood wrote:
>> Olof Johansson wrote:
>>> Setup i2c_board_info based on device tree contents. This has to be
>>> a device_initcall since we need PCI to be probed by the time we
>>> run it, but before the actual driver is initialized.
>> Can we factor at least some of this stuff out into common code?
> 
> I didn't really feel strong motivations to do so, given that the amount
> of shared code is quite small, and the official bindings are not yet
> determined.

Enh...  I'm just irked because I originally did it in a generic manner, 
and whoever it was that did further work on my patch shoved in into 
fsl_soc. :-P

> Chances are whenever the bindings are done they might be incompatible
> with what we already have in our firmware, so the code would need to be
> separated out again.

Well, then it'd be better to just have one bit of code to fix, right? :-)

It'd suck to see different i2c controllers end up implementing the 
binding differently due to the forking, though.  Already with this 
patch, we have a different set of i2c devices that will be recognized 
depending on the adapter.

-Scott
