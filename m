Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58907DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 14:45:31 +1100 (EST)
Subject: Re: Commits pushed to powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18706.22388.866402.123514@cargo.ozlabs.ibm.com>
References: <18706.22388.866402.123514@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 14:45:16 +1100
Message-Id: <1225943116.13603.38.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-06 at 13:33 +1100, Paul Mackerras wrote:
>       powerpc: Fix domain numbers in /proc on 64-bit

This can cause problems apparently on some POWER3's which is why
I didn't include it in the previous merge window, though it's not
a huge deal. Basically, POWER3 used to have unique bus numbers and
thus didn't need domain numbers, and the old code that used buid would
basically do that.

With the patch, all pSeries will get domain numbers for all busses
except domain 0 (which is pretty arbitrary, whichever is found first in
the device-tree basically).

So that means X -might- break on some POWER3's.

Now, rather than backing that one out, I think we can fix on top of it,
though I yet have to convince myself of what the right solution here is,
and that is provided we care about those old pre-libpciaccess X servers
on POWER3.

Ben.
