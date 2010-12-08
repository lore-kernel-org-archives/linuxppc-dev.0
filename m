Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50573B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Dec 2010 11:52:43 +1100 (EST)
Received: from mail99-va3 (localhost.localdomain [127.0.0.1])	by
	mail99-va3-R.bigfish.com (Postfix) with ESMTP id 3F2C410808E	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 00:37:31 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.247])	by
	mail99-va3.bigfish.com (Postfix) with ESMTP id D3DD51C804F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 00:37:30 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id oB80dd1H023103	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Dec 2010 17:39:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB80bTDo013076	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Dec 2010 18:37:29 -0600 (CST)
Date: Tue, 7 Dec 2010 18:37:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: Mark Mason <mason@postdiluvian.org>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101207183726.6a06b846@udp111988uds.am.freescale.net>
In-Reply-To: <20101207232445.GB29218@postdiluvian.org>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
	<20101207232445.GB29218@postdiluvian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 7 Dec 2010 18:24:45 -0500
Mark Mason <mason@postdiluvian.org> wrote:

> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Mon, 6 Dec 2010 22:15:54 -0500
> > Mark Mason <mason@postdiluvian.org> wrote:
> >
> > > What I found, though, was that the NAND did not inherently assert BUSY
> > > as part of the erase - BUSY was asserted because the driver polled for
> > > the status (NAND_CMD_STATUS).  If the status poll was delayed for the
> > > duration of the erase then the MPC could talk to the video chip while
> > > the erase was in progress.  At the end of the 1ms delay I would then
> > > poll for status, which would complete effectively immediately.
> > 
> > That's what we originially did.  The problem is that during this
> > interval the NAND chip will be driving the busy pin, which corrupts
> > other LBC transactions.
> 
> This is not what we observed with our flash part.  For a page erase,
> the NAND did not assert the busy pin until the status read was done.
> This was confirmed with a logic analyzer, and taking advantage of this
> behavior is the sole purpose of the change.

How would that work, in the normal case where you wait for busy to go
away before reading status?

We observed this corruption happening.  It was the motivation for
commit 476459a6cf46d20ec73d9b211f3894ced5f9871e.

> > Newer chips have this added text in their reference manuals under
> > "NAND Flash Block Erase Command Sequence Example":
> > 
> >   Note that operations specified by OP3 and OP4 (status read) should
> >   never be skipped while erasing a NAND Flash device, because, in
> >   case that happens, contention may arise on LGPL4.  A possible case
> >   is that the next transaction from eLBC may try to use that pin as
> >   an output and since the NAND Flash device might already be driving
> >   it, contention will occur.  In case OP3 and OP4 operations are
> >   skipped, it may also happen that a new command is issued to the
> >   NAND Flash device even when the device has not yet finished
> >   processing the previous request.  This may also result in
> >   unpredictable behavior.
> 
> I would expect those operations to be mandatory.

...but you remove them from the original FIR.  They're not just
mandatory to be done eventually, it has to be done within the one
transaction that is atomic at the LBC.

> > > I know almost nothing at all about the scheduler, but I'm pretty
> > > sure that this behavior would cause the scheduler to think the
> > > video thread was a CPU hog, since the video thread was running for
> > > 1ms for every 20us that the UBI BGT ran, which would cause the
> > > scheduler to unfairly prefer the UBI BGT.  I initially tried to
> > > address this problem with thread priorities, but the unfortunate
> > > reality was that either the NAND writes could fall behind or the
> > > video chip could fall behind, and there wasn't spare bandwidth to
> > > allow either.
> > 
> > If you set a realtime priority and have preemption enabled, you
> > should be able to avoid being delayed by more than one NAND
> > transaction, until the realtime thread sleeps.  Be careful to ensure
> > that it does sleep enough for other things to run.
> 
> I tried that, but if the erases were held off enough to get the other
> bus bandwidth we required then the NAND writes fell behind and the
> kernel oom'd.


Another possibility (but still hackish) is to have the NAND driver
poll rather than be interrupt driven, and disable interrupts while
polling.  Then, whenever anything else runs (assuming no SMP), it
should be safe to access LBC without high latency -- so the scheduler
shouldn't get confused.

To make it somewhat cleaner, provide the same benefit on SMP, and allow
non-LBC things to run, you could use a mutex to synchronize between all
LBC users, though that's more work and could be a nuisance if you want
to access the LBC from an interrupt handler.

-Scott
