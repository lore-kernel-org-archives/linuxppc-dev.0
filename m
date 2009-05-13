Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87204DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:56:11 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4D4ruC5023834
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:53:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4D4u8w51622268
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:56:08 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4D4u8HS031874
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:56:08 +1000
Date: Wed, 13 May 2009 13:00:55 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090513030055.GO24338@yookeroo.seuss>
References: <20090511200355.GA17988@in.ibm.com>
	<20090512115149.GA1885@yoda.jdub.homelinux.org>
	<20090512202545.GE6033@in.ibm.com>
	<20090513025717.GN24338@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090513025717.GN24338@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 12:57:17PM +1000, David Gibson wrote:
> On Wed, May 13, 2009 at 01:55:45AM +0530, K.Prasad wrote:
> > On Tue, May 12, 2009 at 07:51:49AM -0400, Josh Boyer wrote:
> > > On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
> [snip]
> > I do see that Book-E processors will have severe memory footprint
> > constraints (in embedded environment) and if the maintainers carry a
> > different perspective (than the one cited above), the relevant fields
> > can be migrated to a new structure whose pointer will be embedded in
> > task_struct. The generic code may have to carry some #ifdefs though.
> 
> I think moving the debug register info into a separate structure makes
> a fair bit of sense.  As well as reducing the memory footprint for
> systems with lots of debug regs, checking it the pointer is NULL
> provides a simple and generic way of determining if the process has
> touched the debug regs.
> 
> It seems to me that a kind of minimal requirement for a sensible
> generic debug interface is that if no processes actually ask to use
> the debug regs, then we should never touch them in the hardware.  This
> means that debugging hacks in the kernel can just use the debug regs
> directly and don't have to go through the interface to avoid having
> their stuff clobbered on context switch.

Uh, sorry, didn't fully read the earlier mail.  Ingo makes a good
point that detaching the structure complicates locking / lifetime
issues.  Leaving it in the thread_struct probably makes sense for now.

Although it raises other issues for when different CPUs in the same
architecture have different sets of debug registers (e.g. PPC server's
DABR/IABR set versus 44x's IAC/DAC/DBCR regs).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
