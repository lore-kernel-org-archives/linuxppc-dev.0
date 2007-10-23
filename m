Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74D7CDDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:33:48 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9N0XkZT010544
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:33:46 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9N0XlP22363640
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:33:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9N0XVC3028790
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:33:31 +1000
Date: Tue, 23 Oct 2007 10:26:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a
	correct type.
Message-ID: <20071023002631.GB31839@localhost.localdomain>
References: <E1IivsP-00078Q-Hf@jdl.com>
	<20071020071920.GF26642@localhost.localdomain>
	<jesl46yxri.fsf@sykes.suse.de>
	<20071020090633.GH26642@localhost.localdomain>
	<E1Ik0UO-000389-AN@jdl.com>
	<20071022115511.0b902044@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071022115511.0b902044@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 11:55:11AM -0500, Josh Boyer wrote:
> On Mon, 22 Oct 2007 11:50:52 -0500
> Jon Loeliger <jdl@jdl.com> wrote:
> 
> > So, like, the other day David Gibson mumbled:
> > > On Sat, Oct 20, 2007 at 10:51:29AM +0200, Andreas Schwab wrote:
> > > > David Gibson <david@gibson.dropbear.id.au> writes:
> > > > 
> > > > > What compiler/platform is this?  I can't off the top of my head think
> > > > > of one where size_t shouldn't be promoted to int automatically.
> > > > 
> > > > Only types narrower than int are subject to integer promotion.
> > > 
> > > Duh, yes.  Sorry.
> > 
> > So, Hmm.  You want the patch as I wrote it applied?
> > Or do you want to use %z in the format instead?  It does
> > seem like there is precedent to do that (in the kernel):
> > 
> >     % grep -r '%z' arch/
> >     arch/alpha/boot/tools/mkbb.c:   fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
> >     arch/alpha/boot/tools/mkbb.c:   fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          (0x00.w,%a3,%za4.l*8),%d2:%d3
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          (-0x10.w,%za3,%a4.l*1),%d2:%d3
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          (ea_77_mem+0x00.w,%pc,%za4.l*8),%d2:%d3
> >     ...
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%zpc,%zd4.l*1]),%d2:%d3
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%pc],%zd4.l*8,0x20.l),%d2:%d3
> >     arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%zpc],%d4.l*8),%d2:%d3
> >     arch/um/drivers/cow_user.c:             /* Below, %zd is for a size_t value */
> >     arch/um/drivers/cow_user.c:                        "limited to %zd characters\n", backing_file,
> >     arch/x86/kernel/pci-nommu_64.c:                     "nommu_%s: overflow %Lx+%zu of device mask %Lx\n",
> > 
> > Opinions?
> 
> %z is fairly common now-a-days.  The kernel janitors tend to LART
> people for not using it rather quickly.

Yes, I think %z is preferable.  It used to be a glibc (et al)
extension, but I think it's now specified in C99 (we should double
check that).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
