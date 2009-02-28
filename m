Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A1DADDE07
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 08:13:18 +1100 (EST)
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 01 Mar 2009 08:09:39 +1100
Message-Id: <1235855379.7388.113.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-02-28 at 09:23 -0800, Linus Torvalds wrote:
> 
> On Fri, 27 Feb 2009, Roland McGrath wrote:
> > 
> > I don't know any other arch well enough to be sure that TIF_32BIT isn't the
> > wrong test there too.  I'd like to leave that worry to the arch maintainers.
> 
> Agreed - it may be that others will want to not use TIF_32BIT too. It 
> really does make much more sense to have it as a thread-local status flag 
> than as an atomic (and thus expensive to modify) thread-flag, not just on 
> x86.

FYI. _TIF_32BIT is the right test on powerpc (it's also what entry_64.S
tests to pick the appropriate syscall table).

Cheers,
Ben.
