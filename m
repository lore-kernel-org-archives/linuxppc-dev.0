Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0313CDDEB7
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 07:18:38 +1000 (EST)
Date: Fri, 26 Oct 2007 16:17:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: reg adjust_total_lowmem
In-Reply-To: <47225327.2070103@freescale.com>
Message-ID: <Pine.LNX.4.64.0710261615380.23925@blarg.am.freescale.net>
References: <4dd2a2ce0710252051pe83a943q48f52d148f5a9603@mail.gmail.com>
	<524E69ED-899B-452F-B593-44499C5181A3@kernel.crashing.org>
	<20071026194005.GA4571@loki.buserror.net>
	<47225327.2070103@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Surya Ravikiran <koduks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Oct 2007, Scott Wood wrote:

> Scott Wood wrote:
> > On Fri, Oct 26, 2007 at 10:04:19AM -0500, Kumar Gala wrote:
> > > The reason you have 192M is that lowmem is the total amount of memory
> > > that can be covered by up to three CAM entries.  In the case of  setting
> > > mem=252M that max that three CAM entries can cover is 192M (64 +64+64).
> > > You should be able to access the other 60M via HIGHMEM.
> >
> > Why doesn't it just use a 256M mapping, and not access the last 4M?

This has some possibility, not sure what the threshold should be.  Do we
just always map 768M of lowmem regardless of how much memory we have?

> Not to mention, why highmem and not just normal TLB0 mappings for the extra
> pages?

Because we do not handle recursive misses in the TLB handlers.  We expect
any load/store that occurs in the TLB handlers to not have a TLB fault
associated with (and thus all of lowmem must be pinned).

- k
