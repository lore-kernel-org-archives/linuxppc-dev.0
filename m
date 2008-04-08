Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CBF2DDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 14:06:18 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3846C49000868
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 00:06:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3846CKx250848
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 00:06:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3846CiB007963
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 00:06:12 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Date: Mon, 7 Apr 2008 23:06:10 -0500
References: <patchbomb.1207601611@localhost.localdomain>
	<200804072225.33040.hollisb@us.ibm.com>
	<20080408035441.GA18501@localhost.localdomain>
In-Reply-To: <20080408035441.GA18501@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804072306.10684.hollisb@us.ibm.com>
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

On Monday 07 April 2008 22:54:41 David Gibson wrote:
> On Mon, Apr 07, 2008 at 10:25:32PM -0500, Hollis Blanchard wrote:
> > On Monday 07 April 2008 20:11:28 David Gibson wrote:
> > > On Mon, Apr 07, 2008 at 03:53:33PM -0500, Hollis Blanchard wrote:
> > > > 1 file changed, 7 insertions(+)
> > > > include/linux/kvm.h |    7 +++++++
> > > >
> > > >
> > > > Device Control Registers are essentially another address space found
> > > > on PowerPC 4xx processors, analogous to PIO on x86. DCRs are always
> > > > 32 bits, and are identified by a 32-bit number.
> > >
> > > Well... 10-bit, actually.
> >
> > The mtdcrux description in the ppc440x6 user manual says the following:
> >
> > 	Let the contents of register RA denote a Device Control Register.
> > 	The contents of GPR[RS] are placed into the designated Device Control
> > Register.
> >
> > I take that to mean that we must worry about 32 bits worth of DCR
> > numbers. Perhaps I should say "no more than" rather than "always".
>
> I think that's less misleading.  mtdcrux is very new, anything which
> only has the mtdcr instruction certainly can't take DCR numbers above
> 10 bits, and I would expect that even on chips with mtdcrux the DCR
> bus is probably still only 10-bits, although it could be extended.

We're defining a kernel/userspace interface here, and since the hardware is 
capable of 32-bit DCR numbers, I don't think it makes any sense to not 
support that. Also, we would just end up placing that number into a u32 
anyways, so... :)

-- 
Hollis Blanchard
IBM Linux Technology Center
