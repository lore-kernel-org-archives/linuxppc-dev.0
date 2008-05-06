Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2F3BDE483
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 05:42:20 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46JgHZT027821
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:42:17 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46JgH4U264538
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:42:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46JgGqm011726
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:42:16 -0400
Date: Tue, 6 May 2008 14:41:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix problem with new TLB storage
	attibute fields on 440x6 core
Message-ID: <20080506144102.62a0ca95@zod.rchland.ibm.com>
In-Reply-To: <200805061841.44277.sr@denx.de>
References: <1209970399-4464-1-git-send-email-sr@denx.de>
	<20080506100117.22c88b09@zod.rchland.ibm.com>
	<200805061841.44277.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 May 2008 18:41:44 +0200
Stefan Roese <sr@denx.de> wrote:

> On Tuesday 06 May 2008, Josh Boyer wrote:
> > > The new 440x6 core used on AMCC 460EX/GT introduces new storage attibure
> > > fields to the TLB2 word. Those are:
> > >
> > > Bit  11   12   13   14   15
> > >      WL1  IL1I IL1D IL2I IL2D
> > >
> > > With these bits the cache (L1 and L2) can be configured in a more
> > > flexible way, instruction- and data-cache independently now. The "old" I
> > > and W bits are still available and setting these old bits will
> > > automically set these new bits too (for backward compatibilty).
> > >
> > > The current code does not clear these fields resulting in disabling the
> > > cache by chance. This patch now makes sure that these new bits are
> > > cleared when the TLB2 word is written.
> > >
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> >
> > Finally catching back up with email.  This looks like .26 material,
> > correct?
> 
> Definitely, yes.

Figured.  I have it queued up.

josh
