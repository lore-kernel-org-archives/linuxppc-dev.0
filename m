Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83ADAB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 08:49:50 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 25594DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 08:49:49 +1000 (EST)
Subject: Re: kexec on e300 core / mpc5121
From: Kenneth Johansson <kenneth@southpole.se>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 00:49:45 +0200
Message-Id: <1249512585.13069.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-05 at 01:06 +0200, Sebastian Andrzej Siewior wrote:
> I've tried kexec on e300 core which should be easy since it is possible
> to disable the MMU on that core. However it does not work.

Is it not possible to disable the mmu on all cpu's that have one ?? 

> Once I disable the MMU, I can't access my MBAR and print chars on the
> serial port. Is this "normal" or do I have still some caches on?

Yes cache and mmu is separate. the 5121 is not cache coherent and do not
limit cache to only memory regions so serial port or any memory mapped
register is a no no unless you have cache off or cache on and mmu on
with a correct setting for what address range to cache. 

Before you turn off the cache you need to flush out all dirty data. best
done by simply reading in 32kb of crap from somewhere. otherwise you are
sure to loose at least the stack and you do not want that.
