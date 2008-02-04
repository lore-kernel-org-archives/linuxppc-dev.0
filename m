Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C18E8DDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 21:42:39 +1100 (EST)
Date: Mon, 4 Feb 2008 10:42:32 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Commit for mm/page_alloc.c breaks boot process on my machine
Message-ID: <20080204104232.GB29484@csn.ul.ie>
References: <20080201184254.174020@gmx.net> <20080201191119.GI18688@csn.ul.ie>
	<20080201200518.174050@gmx.net> <20080201202518.GJ18688@csn.ul.ie>
	<20080201210656.174030@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080201210656.174030@gmx.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (01/02/08 22:06), Gerhard Pircher didst pronounce:
> 
> -------- Original-Nachricht --------
> > Datum: Fri, 1 Feb 2008 20:25:18 +0000
> > Von: Mel Gorman <mel@csn.ul.ie>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > CC: linux-kernel@vger.kernel.org
> > Betreff: Re: Commit for mm/page_alloc.c breaks boot process on my machine
> 
> > I meant uninitialised memory but I also wonder could something like this
> > happen if you are trying to use memory that doesn't exist. i.e. you are
> > trying to access more memory than you really have but you indicate later
> > that this is not the case.
>
> Good question. The memory is in the physical address range from 0x00000000
> to 0x60000000 (1536MB).
> 
> > > > 2. Any chance of seeing a dmesg log?
> > > That's a little bit of a problem. The kernel log in memory doesn't show
> > > any kernel oops, but is also fragmented (small fragments seem to have
> > > been overwritten with 0x0).
> > 
> > err, that doesn't sound very healthy.
>
> Yeah, I know. But the platform code hasn't changed much when porting it
> from arch/ppc to arch/powerpc. That's why I'm a little bit lost in this
> case. :-)
> 

I'm at a bit of a loss to guess what might have changed in powerpc code
that would explain this. I've added the linuxppc-dev mailing list in
case they can make a guess.

I think you are also going to need to start bisecting searching
specifically for the patch that causes these overwrites.

> > > Well, I can't answer this question. The kernel currently locks up when
> > > loading the INIT program. But that is another problem (I still have to
> > > bisect it) and doesn't seem to be related to this problem.
> > 
> > INIT would be the first MOVABLE allocation so it would be using memory
> > at the end of the physical adddress range. i.e. the crash happens when
> > memory towards the end and the only difference between the patch applied
> > and reverted is when it happens.
> Oh, that sounds interesting!
> 
> > Could you try booting with 16MB less memory using mem=?
> I started the kernel with 512MB RAM (mem=496) and 1.5GB (mem=1520). The
> kernel oopes in both cases with a "Unable to handle kernel paging request
> for data address 0xbffff000", followed by a "Oops: kernel access of bad
> area, sig 11" message. The end of the stack trace shows the start_here()
> function.
> I'm not a PowerPC expert, but if 0xbffff000 is a virtual address, then
> it would be in the user program address space, right? If it is a physical
> address, then it is somewhere in the unallocated PCI address space.
> 

It's a virtual address so it depends on the value of CONFIG_KERNEL_START
as to whether this is a user program address or not.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
