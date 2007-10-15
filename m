Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59CFCDDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:02:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9F22fSY002598
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:02:41 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9F22eDF888934
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:02:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9F1xm3i018148
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 11:59:48 +1000
Date: Mon, 15 Oct 2007 11:45:24 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] Use PAGE_OFFSET to tell if an address is
	user/kernel in SW TLB handlers
Message-ID: <20071015014524.GG14108@localhost.localdomain>
References: <Pine.LNX.4.64.0710111341140.27045@blarg.am.freescale.net>
	<20071012033032.GH21056@localhost.localdomain>
	<1192190184.3061.27.camel@localhost.localdomain>
	<20071015005447.GD14108@localhost.localdomain>
	<1192410079.13993.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192410079.13993.4.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 14, 2007 at 08:01:19PM -0500, Josh Boyer wrote:
> On Mon, 2007-10-15 at 10:54 +1000, David Gibson wrote:
> > On Fri, Oct 12, 2007 at 06:56:24AM -0500, Josh Boyer wrote:
> > > On Fri, 2007-10-12 at 13:30 +1000, David Gibson wrote:
> > > > On Thu, Oct 11, 2007 at 01:42:30PM -0500, Kumar Gala wrote:
> > > > > Move to using PAGE_OFFSET instead of TASK_SIZE or KERNELBASE value on
> > > > > 6xx/40x/44x/fsl-booke to determine if the faulting address is a kernel or
> > > > > user space address.  This mimics how the macro is_kernel_addr()
> > > > > works.
> > > > 
> > > > Actually it's ambiguous whether TASK_SIZE or PAGE_OFFSET is correct in
> > > > most of these cases (KERNELBASE is certainly wrong, though).
> > > > 
> > > > TASK_SIZE is the top of the userspace mapped area, PAGE_OFFSET is the
> > > > bottom of the linear mapping.  So, strictly speaking there are 3 paths
> > > > for the miss handlers: < TASK_SIZE => user mapping, >= PAGE_OFFSET =>
> > > > kernel mapping, between the two => immediate fault.
> > > > 
> > > > We get away with a two way comparison on 32-bit because, a) they have
> > > > the same value and b) none of the pagetables, user or kernel, should
> > > > have any entries in the in between region so we'll end up in
> > > > do_page_fault in the end, anyway.
> > > 
> > > Kumar's other patch removes the gap.  He changed the default
> > > CONFIG_TASK_SIZE to 0xc0000000.
> > 
> > That's (a) and only removes the gap in the default configuration..
> 
> I believe the idea was that as defconfigs get updated for 2.6.24, they
> would pick up the new default.

Yes, but if someone overrides CONFIG_TASK_SIZE, it should still work,
yes?  Or else this should not be a CONFIG option at all.  Which it
will, of course, because of (b), but one should still be aware of the
theoretical 3-way branch when touching this code, even if it can be
reduced to  2-way branch in practice.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
