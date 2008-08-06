Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B28ADE421
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 10:35:24 +1000 (EST)
Subject: Re: inline assembly & r0 SOS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4898EE60.9080206@hypersurf.com>
References: <4898EE60.9080206@hypersurf.com>
Content-Type: text/plain
Date: Wed, 06 Aug 2008 10:35:07 +1000
Message-Id: <1217982907.24157.217.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-05 at 17:20 -0700, Kevin Diggs wrote:
> Hi,
> 

> thats bad right? Because the "addi 0, 0, 23" will not work as expected 
> because of the "special property" of r0. FYI:  The first three lines 
> after the "#APP" are from a similar function get_PLL_ratio().
> 
> 	Is there a way to blacklist r0?

Yes. Use "b" instead of "r" in the constraints to force the compiler
to avoid r0 when assigning a register.

Cheers,
Ben.
