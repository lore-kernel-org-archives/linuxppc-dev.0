Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C235C67B3D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:50:14 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <42547112.9000302@nortel.com>
References: <425429BF.1050706@nortel.com> <1112829596.9518.210.camel@gaston>
	<42547112.9000302@nortel.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:49:23 +1000
Message-Id: <1112831363.9518.215.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 17:30 -0600, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2005-04-06 at 12:26 -0600, Chris Friesen wrote:
> > 
> >>I want to retrieve the msr (which is 64-bits) on a 970 when running in 
> >>32-bit mode.
> 
> > Is this in kernel mode ? Why are you doing that ? 
> 
> Yes it is.
> 
> We wanted to manipulate the high word of the msr on the 970, from C 
> code, while running in 32-bit mode.  I'll be doing something similar to 
> get at the high word of HID1 (to enable the en_icbi bit).
> 
> Is there some other way to do this?

But the kernel code always runs in 64 bits mode... or are you trying to
pass that down to userland ? In the later case, your optimisations are
pretty much nothing compared to the cost of a syscall

Ben.
