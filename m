Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98DA8DDEDC
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 23:28:23 +1000 (EST)
In-Reply-To: <20070515230930.GB20290@localhost.localdomain>
References: <20070515045415.5B05ADDECE@ozlabs.org>
	<1179233998.3084.28.camel@zod.rchland.ibm.com>
	<20070515230930.GB20290@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1c27b74b07962c94458f6a6eb2677cf4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] Derive ebc ranges property from EBC registers
Date: Wed, 16 May 2007 15:28:16 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Do we want a "ranges;" here as a placeholder?  I don't see where it's
>> absolutely required, but it makes me feel better for some reason...
>
> Absolutely not.  An empty ranges property indicates that the child bus
> address space is the same as the parent bus address space.

Or a subset of it, anyway; both address domains have to
use the same representation in "reg" properties, and the
mapping has to be 1-1.

A missing "ranges" property means there is no direct
mapping, which is more correct in this case, and perfectly
valid.

> If we're
> using the chip-select/offset addressing form for the EBC peripherals,
> that's manifestly not the case.

This would be a nice use case for the

	ranges = ??;

syntax when/if that gets added to DTC and the kernel
and bootwrapper parsers for DTBs.


Segher
