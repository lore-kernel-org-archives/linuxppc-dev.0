Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15052DE020
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:41:23 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0805211238440.5706@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
	<Pine.LNX.4.64.0805201425250.7453@t2.domain.actdsltmp>
	<1211378410.8297.192.camel@pasglop>
	<Pine.LNX.4.64.0805211238440.5706@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:41:12 -0400
Message-Id: <1211402472.8297.244.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 12:44 -0700, Trent Piepho wrote:
> 
> Someone should update memory-barriers.txt, because it doesn't say
> that, and
> all I/O accessors for all the arches, because none of them are.

There have been long discussions about that. The end result was that
being too weakly ordered is just asking for trouble because the majority
of drivers are written & tested on x86 which is in order.

If you look at our accessors, minus that gcc problem you found, the
barriers in there should pretty much guarantee ordering in the cases
that matter, which are basically MMIO read followed by memory accesses
and memory writes followed by MMIO. In fact, MMIO read are fully
sychronous.

> No, it's compiled with a normal kernel build, which includes
> -fno-strict-aliasing

Ok, so there is a very bad bug indeed, we need to fix that.

Ben.
