Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 60112DDEDE
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 05:11:26 +1000 (EST)
Date: Sat, 5 May 2007 14:13:06 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Message-ID: <20070505191306.GB23524@lixom.net>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1d22829fe3f12509018791541073706@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 05, 2007 at 07:21:33PM +0200, Segher Boessenkool wrote:

> > +		PowerPC,750@0 {
> 
> Needs to be PowerPC,750CL etc.

Why _needs_? Apple never used anything else than PowerPC,G5, no matter
what generation chip.

> > +  	tsi109@c0000000 {
> > +		device_type = "tsi-bridge";
> 
> Don't put a "device_type" here, it is useless
> (and undefined).  There are more like this, but
> perhaps Linux (wrongly) probes on "device_type"
> for those, so the kernel would need updating
> first.

Josh is just using the precedence that the other platform gives, the
driver is keying off of device_type. While that should be fixed, that's
a separate issue. I'm sure they'd welcome a driver patch from you.

(Does anyone know if there's an actual firmware out there with the
tsi-bridge device_type set, and thus just changing DTS's won't help? We'd
still need to be able to boot/probe the device on those firmwares.)

> > +		bus-frequency = <0>;
> 
> 0?

Filled in by bootloader/wrapper? Other dts'es are similar. Could be nice
to have a comment next to it if that's the case.


-Olof
