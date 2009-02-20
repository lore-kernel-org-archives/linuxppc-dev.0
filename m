Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 99A11DDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 10:50:57 +1100 (EST)
Date: Fri, 20 Feb 2009 15:50:54 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: PCI reading without endian conversion
Message-ID: <20090220235054.GA27349@ovro.caltech.edu>
References: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
	<20090220191108.GA21163@ovro.caltech.edu>
	<b5e2fc790902201205t4bd03373w7e7624fce60f5eb0@mail.gmail.com>
	<20090220210744.GB21163@ovro.caltech.edu>
	<b5e2fc790902201356v7e01b17al3ecd7e06ac59af3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b5e2fc790902201356v7e01b17al3ecd7e06ac59af3d@mail.gmail.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2009 at 03:56:39PM -0600, Matt Sealey wrote:
> On Fri, Feb 20, 2009 at 3:07 PM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> > On Fri, Feb 20, 2009 at 02:05:08PM -0600, Matt Sealey wrote:
> >> On Fri, Feb 20, 2009 at 1:11 PM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> >> > On Fri, Feb 20, 2009 at 12:57:36PM -0600, Matt Sealey wrote:
> >> >
> >> > I'm pretty sure memcpy_fromio() and memcpy_toio() will get you what you
> >> > want. They don't change byte ordering.
> >>
> >> Are they guaranteed to only do 32-bit, aligned accesses?
> >>
> >
> > I don't think so. I certainly wouldn't count on anything better than a
> > byte-by-byte memcpy.
> >
> >> I made some cheats on my CPLD to ignore byte enables and so on,
> >> because it makes the design cleaner and easier to read (for students)
> >> plus, saves a ton of logic cells. It's totally within the PCI
> >> standard, but it means if you do a byte read memcpy() you get.. very
> >> weird results (i.e. not great).
> >>
> >
> > Right, I understand how that works :)
> >
> > Some usage of cscope shows that __raw_readl() might be what you want,
> > as well as __raw_writel() for writing. I'm not sure it is universally
> > available, but maybe they are.
> >
> > The comment on PowerPC says "Non ordered and non-swapping "raw"
> > accessors". Looks about right. ARM's implementation uses them to
> > implement ioread32() and friends by adding byteswapping.
> 
> Am I correct in saying that cpu_to_le32 and le32_to_cpu are the
> functions/macros I need to use to do byte swapping to make everything
> go little endian (and back again when I read them back in the kernel)?
> 
> Or is there some cleverer way already implemented in the kernel?
> 

I would say that the __raw_readl() reads in cpu order. If you wanted to
convert that to le32, you'd use cpu_to_le32().

Ira
