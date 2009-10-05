Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1ECF9B7BAD
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 07:09:29 +1100 (EST)
Date: Mon, 5 Oct 2009 15:09:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
Message-ID: <20091005200941.GD3576@loki.buserror.net>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091005181233.GA3576@loki.buserror.net>
	<OF44D5E829.2889B774-ONC1257646.00645628-C1257646.006568EE@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF44D5E829.2889B774-ONC1257646.00645628-C1257646.006568EE@transmode.se>
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 05, 2009 at 08:27:39PM +0200, Joakim Tjernlund wrote:
> > After resolving the conflict, without adding tlbil_va in do_page_fault(), I
> > get the same stuck behavior as before.
> 
> Expected, I havn't not tried to fix the missing tlbil_va(). That is
> different problem that you and Ben needs to sort out.

Right, I just wanted to be clear about which results were from which
modifications.

> >  With tlbil_va, I get this (not sure
> > if it's related to using the wrong base tree):
> 
> Could be the debug code doing something bad or the
> "Fixup DAR from buggy dcbX instructions". Could you back that one out?

That gets rid of the segfaults.  The bootup gets stuck running udev, though
-- the system is either idle, or it's stuck doing some syscall.

I see it sometimes (but less reliably) without this patchset, so it may just
be changing the circumstances to expose the issue more consistently.  Or
maybe I'm seeing the dcbX bug?  There do seem to be dcbX instructions in the
dynamic linker I'm using (including a disturbing section that appears to be
assuming 32 byte cache lines, even though this is supposed to be an 8xx
RFS).

I'll look into it.

> and if that does not help, backout:
> "start using dcbX instructions in various copy routines" too.

No difference.

-Scott
