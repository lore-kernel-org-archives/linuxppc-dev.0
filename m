From: deepesh@india.tejasnetworks.com
Date: Sat, 16 Nov 2002 09:20:49 +0530 (IST)
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cache Enabling
In-Reply-To: <20021112044053.32962.qmail@web20706.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0211160914590.22513-100000@deepesh.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

 I was able to solve this problem with the help of some one in the company
itself.

      One of my devices was mmaped. And when cache was enabled, the
cache of this device was also getting enabled. I had to selectively
disable the cache. This was done by adding some more flags to the
input parameter for "protection, (pgprot_t) which is part of the vma
area structure" in the driver's mmap function. The flags to be added are
"PAGE_NO_CACHE, PAGE_GUARDED and PAGE_WRITETHRU". With this every thing
started working!!!!!!!!!!!!!!!


Deepesh


On Mon, 11 Nov 2002, bhupinder sahran wrote:

> hi
> U will have to play with ur bat registers.
> U can map ur devices non cachable through bat
> registers.
>
> u will be having a function in arch/ppc/kernel/(ur
> arch)setup.c  .
>
> see there & use the bats
> if still have problem send me ur setup file
>
> thanx
> Bhupi
> Linux+Hypertransport --->Silicon
> www.gdatech.com
>
>
>
>
> --- deepesh@india.tejasnetworks.com wrote:
> >
> > I had enabled the Data Cache. I forgot to mention
> > that.
> >
> > Deepesh
> >
> >
> >
> >
> > On Mon, 11 Nov 2002 deepesh@india.tejasnetworks.com
> > wrote:
> >
> > >
> > >
> > > Dear All,
> > >
> > >
> > > I am using Power PC. The system which I am using
> > takes 2 minutes more than
> > > usual for the software in the system to come up
> > without cache
> > > enabling. These 2 minutes are really crucial.
> > > But there are problems when I enabled cache. The
> > devices which I am using
> > > are mmapped. I do not want cache to be enabled for
> > the memory mapped
> > > devices. When cache is enabled, none of the
> > mmapped devices work in the
> > > usual way. How do I selectively disable the cache
> > for the mmapped devices?
> > >
> > >
> > > Thank you,
> > > Deepesh
> > >
> > >
> >
> > --
> >
> > D.Deepesh
> > R&D Engineer,
> > Tejas Networks
> >
> >
> >
>
>
>

--

D.Deepesh
R&D Engineer,
Tejas Networks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
