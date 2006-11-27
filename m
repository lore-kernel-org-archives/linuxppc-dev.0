Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E746667B77
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:02:35 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1164401124.5653.86.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 21:02:16 +0000
Message-Id: <1164661336.11001.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-25 at 07:45 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-11-24 at 16:21 +0000, Adrian Cox wrote:
> > Does anybody have any ideas what could make up() take so long in this
> > circumstance? I'd expect cache transfers to make the operation about 100
> > times slower, but this looks like repeated cache ping-pong between the
> > two CPUs.
> 
> Is it hung in up() (toplevel) or __up (low level) ?

Not yet proven.

> Have you tried some oprofile runs to catch the exact instruction where
> the cycles appear to be wasted ?

I've spent a day wrestling with oprofile, but I've not managed to
trigger the problem while profiling yet.  It's possible that the slight
overhead of oprofile is enough to change the scheduling behaviour.

It remains an odd problem, and rather hard to reproduce.  Unless I get
better data with oprofile this one may remain in the mystery file.

> Have you tried moving the semaphore away from whatever other data might
> be manipulated at the same time ? In it's own cache line maybe ?

I did try that, but it didn't make any difference.

-- 
Adrian Cox <adrian@humboldt.co.uk>
