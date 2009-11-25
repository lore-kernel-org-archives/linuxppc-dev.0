Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CC60CB7B68
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 22:53:00 +1100 (EST)
Date: Wed, 25 Nov 2009 12:30:23 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Li Yang <leoli@freescale.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Message-ID: <20091125113023.GC12738@iram.es>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
	<2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 04:07:46PM +0800, Li Yang wrote:
> On Sun, Nov 22, 2009 at 4:01 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >>> You need to be a bit more careful tho. You must not allow RAM managed by
> >>> the kernel to be mapped non-cachable.
> >>
> >> Even if the user explicitly sets the O_SYNC flag?  IMHO, it's a bug of
> >> the application if it uses O_SYNC on main memory to be mmap'ed later.
> >> And we don't need to cover up the bug.
> >
> > Is that "embedded thinking"?  Conflicts like this cause machine checks or
> > checkstops on many PowerPC implementations, we do not normally allow such
> > to be caused by userland.
> 
> So what you are saying is that if the kernel has mapped a physical
> page as cacheable while user application is trying to map it as
> non-cacheable, there will be machine checks and checkstops rather than
> just performance drop?  This is new to me.  Could you elaborate a bit?

That's called cache paradoxes. And yes they may be a problem. 

Besides that, existing  application may have used mmap without O_SYNC on
I/O devices, knowing that the kernel would map them uncached. Your
patch would break them by using cached accesses (and it can cause
really hard to debug lockups, I've seen this, probably caused by 
infinite retries on the PCI bus).

	Gabriel
