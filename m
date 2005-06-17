Return-Path: <egoforth@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id 82D38679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 15:42:09 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so159994wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 22:42:08 -0700 (PDT)
Message-ID: <75b39f0105061622421d81bc92@mail.gmail.com>
Date: Fri, 17 Jun 2005 01:42:07 -0400
From: Ed Goforth <egoforth@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050616214155.A7062@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <75b39f0105061614333199ec37@mail.gmail.com>
	<20050616155525.A4541@cox.net>
	<75b39f010506162047236fec19@mail.gmail.com>
	<20050616214155.A7062@cox.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mmap on 440gx
Reply-To: Ed Goforth <egoforth@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/17/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> On Thu, Jun 16, 2005 at 11:47:22PM -0400, Ed Goforth wrote:
> > On 6/16/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> > > On Thu, Jun 16, 2005 at 05:33:44PM -0400, Ed Goforth wrote:
> >
> > Thanks for taking the time to reply.
> >
> > > > I've been struggling with implementing mmap on a 440gx-based custom
> > > > board.  I have been able to use ioremap(), but we really need a mma=
p()
> > > > for our software.  The kernel is 2.4.18 (TimeSys 4.0).
> > >
>=20
>=20
> > For what it's worth, __pa(0x5000_0000) returns 0x9000_0000.
>=20
> Sure, you just asked it to subtract KERNELBASE from a physical address.
> Don't use __pa() in drivers. That's expected behavior. Why are
> you doing that?

Desperation.

>=20
> > > You need something like the bigphys_remap patch for 2.4 that can be
> > > found at ftp://source.mvista.com/pub/linuxppc/
> >
> > I just checked the source, and that patch has indeed been applied.
>=20
> Ok, assuming it's all correct then I don't know why it does work
> for you in your vendor tree. Have you asked Timesys for help?

Not yet.  I wanted to get some confidence that I was using the correct
APIs appropriately.

>=20
> Put some debug statements throughout fixup_bigphys_addr() to see
> what's going on.

My include/asm/mmu.h has it defined as:
#ifndef CONFIG_440
#include <asm-generic/mmu.h>
#else
typedef unsigned long long phys_addr_t;
#define fixup_bigphys_addr(addr, size)   (addr)
#endif

I see that in later 2.4 kernels and in mainline 2.6 it is implemented
as an actual working routine.  Perhaps that explains it all.  The
ioremap() in my tree implements the fixup code inline, which would
explain why it works, right?

>=20
> -Matt
>=20

Thanks again.
Ed
