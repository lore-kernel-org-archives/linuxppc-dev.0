Subject: Re: Large TLBs on 40x
From: Josh Boyer <jwboyer@charter.net>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040803171641.B5454@home.com>
References: <1091574342.2578.83.camel@c68.115.86.108.roc.mn.charter.com>
	 <20040803171641.B5454@home.com>
Content-Type: text/plain
Message-Id: <1091620178.2578.97.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Date: Wed, 04 Aug 2004 06:49:39 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-08-03 at 19:16, Matt Porter wrote:
> > I would think that you would want the kernel text pages to be
> > non-writable so that if something like the above scenario happened you
> > don't have possibly bad text pages.  Debugging wouldn't be much fun.
>
> Ideally, that's true. However, the kernel lowmem large TLB mapping is
> there for performance. There's no way to manage default page size
> protection on the text pages. It's a tradeoff between performance
> and the ease of debugging a misguided driver. With all the kernel
> debugging tools these days, it sure seems like performance is the
> clear winner.

Well at least my understanding of what was going on was right :).  I see
the tradeoff, I was just wondering if there was some happy medium.
Maybe pinning a read-only TLB entry for most of the text pages for
however large you can get would work...  or maybe not.

It's probably not that large of an issue for a normal user because the
kernel and drivers are fairly stable, which makes performance more
important.  But when someone is writing new drivers, randomly poking
holes in the kernel text pages and then executing instructions from
there leads to some strange panics.  Although, the new driver should be
suspect in that case anyway :).

>
> > I think I am missing something here.  If so, please excuse my lack of
> > knowledge on TLBs, but I am somewhat new to the low level stuff.  Anyone
> > care to point out what I am missing?
>
> Well, it should be noted that the Classic PPC mapin_ram does a similar
> thing. When mapping with BATs, the ability to do per (default size) page
> RO is not available.  For reasons of performance, this is the default
> method to map kernel lowmem on Classic PPC cores.
>
> The same situation is present on Book E parts (44x/85xx). Since they
> map all of kernel lowmem staticly with large TLB entries, they also
> lack the ability to cover kernel text with read-only entries.
>
> Anyway, this isn't just 4xx, it's pretty much everywhere. It's
> possible to make 4xx large TLB mapping optional, but it's not
> clear that adding the option is really that useful (at least
> to me, YMMV).

Yeah, I figured it was more than just 40x, it's just that is what I am
using right now.  Thanks for the info.

josh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
