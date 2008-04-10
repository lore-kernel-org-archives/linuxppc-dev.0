Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7820ADE30D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 02:49:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3AGngGK005321
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 12:49:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3AGng4R214542
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:49:42 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3AGne4A024530
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:49:42 -0600
Date: Thu, 10 Apr 2008 11:47:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Message-ID: <20080410114734.4b702caa@zod.rchland.ibm.com>
In-Reply-To: <20080408035441.GA18501@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
	<474b35009da7b7bdb58c.1207601613@localhost.localdomain>
	<20080408011128.GA13454@localhost.localdomain>
	<200804072225.33040.hollisb@us.ibm.com>
	<20080408035441.GA18501@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Apr 2008 13:54:41 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> On Mon, Apr 07, 2008 at 10:25:32PM -0500, Hollis Blanchard wrote:
> > On Monday 07 April 2008 20:11:28 David Gibson wrote:
> > > On Mon, Apr 07, 2008 at 03:53:33PM -0500, Hollis Blanchard wrote:
> > > > 1 file changed, 7 insertions(+)
> > > > include/linux/kvm.h |    7 +++++++
> > > >
> > > >
> > > > Device Control Registers are essentially another address space found on
> > > > PowerPC 4xx processors, analogous to PIO on x86. DCRs are always 32 bits,
> > > > and are identified by a 32-bit number.
> > >
> > > Well... 10-bit, actually.
> > 
> > The mtdcrux description in the ppc440x6 user manual says the following:
> > 
> > 	Let the contents of register RA denote a Device Control Register.
> > 	The contents of GPR[RS] are placed into the designated Device Control 
> > Register.
> > 
> > I take that to mean that we must worry about 32 bits worth of DCR numbers. 
> > Perhaps I should say "no more than" rather than "always".
> 
> I think that's less misleading.  mtdcrux is very new, anything which
> only has the mtdcr instruction certainly can't take DCR numbers above
> 10 bits, and I would expect that even on chips with mtdcrux the DCR
> bus is probably still only 10-bits, although it could be extended.

http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/C94B06BE313211B887257110006EFFBD/$file/460migrate.pdf

page 4.  "DCR Address Space Increased to 32 bits".

I realize that the above is for 460 cores, but I would not be surprised
at all if that shows up in a future 440 core.  440x6 already seems to
be a conglomeration of some of the features 460 has.

josh
