Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1385DDDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 14:18:42 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m384IgGF013312
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 14:18:42 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m384IbPs528432
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 14:18:37 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m384IbRH024524
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 14:18:38 +1000
Date: Tue, 8 Apr 2008 14:16:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Message-ID: <20080408041603.GB18501@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
	<200804072225.33040.hollisb@us.ibm.com>
	<20080408035441.GA18501@localhost.localdomain>
	<200804072306.10684.hollisb@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804072306.10684.hollisb@us.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 11:06:10PM -0500, Hollis Blanchard wrote:
> On Monday 07 April 2008 22:54:41 David Gibson wrote:
> > On Mon, Apr 07, 2008 at 10:25:32PM -0500, Hollis Blanchard wrote:
> > > On Monday 07 April 2008 20:11:28 David Gibson wrote:
> > > > On Mon, Apr 07, 2008 at 03:53:33PM -0500, Hollis Blanchard wrote:
> > > > > 1 file changed, 7 insertions(+)
> > > > > include/linux/kvm.h |    7 +++++++
> > > > >
> > > > >
> > > > > Device Control Registers are essentially another address space found
> > > > > on PowerPC 4xx processors, analogous to PIO on x86. DCRs are always
> > > > > 32 bits, and are identified by a 32-bit number.
> > > >
> > > > Well... 10-bit, actually.
> > >
> > > The mtdcrux description in the ppc440x6 user manual says the following:
> > >
> > > 	Let the contents of register RA denote a Device Control Register.
> > > 	The contents of GPR[RS] are placed into the designated Device Control
> > > Register.
> > >
> > > I take that to mean that we must worry about 32 bits worth of DCR
> > > numbers. Perhaps I should say "no more than" rather than "always".
> >
> > I think that's less misleading.  mtdcrux is very new, anything which
> > only has the mtdcr instruction certainly can't take DCR numbers above
> > 10 bits, and I would expect that even on chips with mtdcrux the DCR
> > bus is probably still only 10-bits, although it could be extended.
> 
> We're defining a kernel/userspace interface here, and since the hardware is 
> capable of 32-bit DCR numbers, I don't think it makes any sense to not 
> support that. Also, we would just end up placing that number into a u32 
> anyways, so... :)

Oh, of course you should represent it as a u32 and support 32-bit
addresses, it's only the patch comment I'm objecting to.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
