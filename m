Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2F4967CA1
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jul 2005 03:40:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
In-Reply-To: <20050715160115.GA22990@janus>
References: <20050715160115.GA22990@janus>
Content-Type: text/plain
Date: Sun, 17 Jul 2005 03:39:47 +1000
Message-Id: <1121535588.14393.18.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: bug in arch/ppc/kernel/misc.S: __ashrdi3?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-07-15 at 18:01 +0200, Frank van Maarseveen wrote:
> I don't really grok the code but an operand seems to be missing and the
> assembler makes something out of it I don't trust:
> 
> _GLOBAL(__ashrdi3)
> 	...
> 	rlwinm  r8,r7,0,32      # t3 = (count < 32) ? 32 : 0

This is equivalent to r8 = r7 & 32. It will definitely not do what the
comment says though. If (count < 64), however, it will do something
like r8 = (r7 < 32) ? 0 : 32. Paul, maybe we should dbl check what's
going in there ?

>    0:   54 e8 06 b4     rlwinm  r8,r7,0,26,26

This is the same.

The assembler, when provided with only one argument after the shift
count, will generate ME and MB to represent the mask whose value is
given in argument. (If you give an argument which doesn't contain a
single contiguous range of 1 bits, I suppose it will error out).

Ben.
