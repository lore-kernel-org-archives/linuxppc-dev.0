Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BC78DE067
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 02:42:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m41GgSbh004583
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 09:42:29 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m41GgSfk012654
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 11:42:28 -0500 (CDT)
Date: Thu, 1 May 2008 11:42:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Message-ID: <20080501164228.GA17992@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
	<2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
	<20080501161451.GH17142@ld0162-tx32.am.freescale.net>
	<78125A27-D99A-447D-9C65-4705DD153567@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78125A27-D99A-447D-9C65-4705DD153567@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 01, 2008 at 11:33:34AM -0500, Kumar Gala wrote:
> Let me ask the question differently.  Are there cases that some event  
> occurs in the system and a signal is delivered to the current process  
> regardless of what that process is.

Yes, timers that expire based on CPU usage.

>  I'm guessing so, based on the tty example.

I don't think tty interrupts would -- it'd go to the process group
associated with the tty.

> So for the specific case I'm looking at (kprobes & debug exceptions  
> from kernel space), I think its reasonable to BUG_ON() if thread_info- 
> >flags changes such that TIF_SIGPENDING or TIF_NEED_RESCHED get set  
> we aren't from user-space.

Why?  It may not happen currently, but it seems more future-proof to just
copy the flags.  And it's certainly not reasonable for normal interrupts.

-Scott
