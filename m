Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10717B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 22:58:27 +1000 (EST)
In-Reply-To: <20100708150904.79feffdd@schlenkerla.am.freescale.net>
References: <1278614421.1801.0@antares>
	<DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
	<20100708150904.79feffdd@schlenkerla.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E0D806F7-A109-4AAF-9899-429659E2C3D9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Date: Fri, 9 Jul 2010 14:59:09 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Actually, this is something which might need closer attention -
>>> and maybe some support in the device tree indicating which read or
>>> write width a device can accept?
>>
>> There already is "device-width"; the drivers never should use any
>> other access width unless they *know* that will work.
>
> Wouldn't you want to use "bank-width" instead?

We were talking about single devices.  But, sure, when you have
multiple devices in parallel the driver needs to know about that.

> It would be nice to have a device tree property that can specify that
> all access widths supported by the CPU will work, though.

Oh please no.  A device binding should not depend on what CPU there
is in the system.  There could be multiple CPUs of different
architectures, even.

To figure out how to access a device, the driver looks at the device's
node, and all its parent nodes (or asks generic code to do that, or
platform code).


Segher
