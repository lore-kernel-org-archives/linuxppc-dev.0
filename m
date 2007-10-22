Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
In-Reply-To: Your message of "Sat, 20 Oct 2007 19:06:33 +1000."
	<20071020090633.GH26642@localhost.localdomain>
References: <E1IivsP-00078Q-Hf@jdl.com>
	<20071020071920.GF26642@localhost.localdomain>
	<jesl46yxri.fsf@sykes.suse.de>
	<20071020090633.GH26642@localhost.localdomain>
Date: Mon, 22 Oct 2007 11:50:52 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik0UO-000389-AN@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> On Sat, Oct 20, 2007 at 10:51:29AM +0200, Andreas Schwab wrote:
> > David Gibson <david@gibson.dropbear.id.au> writes:
> > 
> > > What compiler/platform is this?  I can't off the top of my head think
> > > of one where size_t shouldn't be promoted to int automatically.
> > 
> > Only types narrower than int are subject to integer promotion.
> 
> Duh, yes.  Sorry.

So, Hmm.  You want the patch as I wrote it applied?
Or do you want to use %z in the format instead?  It does
seem like there is precedent to do that (in the kernel):

    % grep -r '%z' arch/
    arch/alpha/boot/tools/mkbb.c:   fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
    arch/alpha/boot/tools/mkbb.c:   fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
    arch/m68k/ifpsp060/src/itest.S: mulu.l          (0x00.w,%a3,%za4.l*8),%d2:%d3
    arch/m68k/ifpsp060/src/itest.S: mulu.l          (-0x10.w,%za3,%a4.l*1),%d2:%d3
    arch/m68k/ifpsp060/src/itest.S: mulu.l          (ea_77_mem+0x00.w,%pc,%za4.l*8),%d2:%d3
    ...
    arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%zpc,%zd4.l*1]),%d2:%d3
    arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%pc],%zd4.l*8,0x20.l),%d2:%d3
    arch/m68k/ifpsp060/src/itest.S: mulu.l          ([EASTORE.l,%zpc],%d4.l*8),%d2:%d3
    arch/um/drivers/cow_user.c:             /* Below, %zd is for a size_t value */
    arch/um/drivers/cow_user.c:                        "limited to %zd characters\n", backing_file,
    arch/x86/kernel/pci-nommu_64.c:                     "nommu_%s: overflow %Lx+%zu of device mask %Lx\n",

Opinions?

Thanks,
jdl
