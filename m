Date: Wed, 25 Aug 2004 16:05:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Oliver King-Smith <oliver.king-smith@nuvation.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem trying to address custom hardware
Message-ID: <20040825160525.F9986@home.com>
References: <FC3C0DD86B79DF4FA423AF0379A5476101554372@mailguy2.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A5476101554372@mailguy2.nuvation.com>; from oliver.king-smith@nuvation.com on Wed, Aug 25, 2004 at 03:29:20PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 25, 2004 at 03:29:20PM -0700, Oliver King-Smith wrote:
>
> Things are working much better.  Both the driver and the main code work
> without crashing now.
>
> > Others addressed your core problem, but you should know that this
> > mmap request won't produce the desired result. You need MAP_SHARED
> > since MAP_PRIVATE will result in a COW when you attempt to modify
> > your register.
>
> I am not sure I understand why this needs to be MAP_SHARED (it sure does
> though).  Is there a good resource I can read to understand this a bit
> better?

The mmap(2) manpage explains the difference pretty well.  MAP_PRIVATE
indicates that any modification are local to the process. So, as
soon as you write to it, it makes a copy of the page for your process
to modify. MAP_SHARED indicates that any modifications are seen by
any processes that also map the region.

googling will probably yield many threads on lkml on this topic.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
