Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06A5467B3D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:57:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4254771B.2070802@nortel.com>
References: <425429BF.1050706@nortel.com> <1112829596.9518.210.camel@gaston>
	<42547112.9000302@nortel.com> <1112831363.9518.215.camel@gaston>
	<4254771B.2070802@nortel.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:57:03 +1000
Message-Id: <1112831823.9568.219.camel@gaston>
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

On Wed, 2005-04-06 at 17:56 -0600, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> 
> > But the kernel code always runs in 64 bits mode...
> 
> The ppc kernel (not ppc64) runs in 64-bit mode?  An unsigned long long 
> fits in a single register in C code?

Ah no, it doesn't, but then, be careful to have interrupts off when you
do that are the interrupt handler won't save the high half of the
registers between the mtmsrd and your "splitting" of it.

> Yeah, the optimisations really don't matter much...the ugly resulting 
> code just bothered me.
> 
> Chris
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
