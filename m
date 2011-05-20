Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48935B71B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 13:13:55 +1000 (EST)
Subject: Re: [bg-linux] [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kazutomo Yoshii <kazutomo@mcs.anl.gov>
In-Reply-To: <4DD5D9C9.3020000@mcs.anl.gov>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-5-git-send-email-ericvh@gmail.com>
	<1305851769.7481.90.camel@pasglop>  <4DD5C49E.4050103@gmail.com>
	<1305857301.7481.121.camel@pasglop> <1305857610.7481.124.camel@pasglop>
	<4DD5D9C9.3020000@mcs.anl.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 13:13:41 +1000
Message-ID: <1305861221.7481.126.camel@pasglop>
Mime-Version: 1.0
Cc: Kazutomo Yoshii <kazutomo.yoshii@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 22:02 -0500, Kazutomo Yoshii wrote:
> On 05/19/2011 09:13 PM, Benjamin Herrenschmidt wrote:
> > On Fri, 2011-05-20 at 12:08 +1000, Benjamin Herrenschmidt wrote:
> >    
> >> On Thu, 2011-05-19 at 20:32 -0500, Kazutomo Yoshii wrote:
> >>      
> >>> Actually DMA sends invalidate requests to the snoop unit(L2 level).
> >>> BGP SoC is a bit different from other 4xx base.
> >>>        
> >> Well, some other 44x also have a snooping L2 (more or less), but L1 is
> >> usually the problem.
> >>      
> > Hrm... looking at the doco you pointed me to, it looks like the L1 -is-
> > coherent, it gets snoop kills from the L2.
> >    
> Right, L1D is coherent if write throug is set.
> L1I(virtually tagged) is not coherent, btw.

Yes, I wrote the horrid hack to ping pong the pages between writable and
executable afaik :-)

> > Ok so we do need to make this non-coherent cache stuff a runtime option
> > (well, we need that for 440+476 too anyways so may as well do it now).
> >    
> What sort of runtime option do you mean?

I've asked Tony to give it a go since he's taking over the 476 stuff.
The idea is to make it a MMU feature and call into the cache flush
conditionally on it rather than under the control of a ifdef.

I want it to be possible to build a unified kernel that supports
multiple 44x and 47x platforms including BGP if we can make it happen.

There's still some roadblocks to support 47x and 44x in the same kernel,
most notably the cache line size, but I have hopes I'll get Tony to fix
them soon :-)

Cheers,
Ben.

> - kaz
> > As for the alignment of kmalloc, it looks like a hack that should be
> > done in the torus code itself.
> >
> > Cheers,
> > Ben.
> >
> > _______________________________________________
> > bg-linux mailing list
> > bg-linux@lists.anl-external.org
> > https://lists.anl-external.org/mailman/listinfo/bg-linux
> > http://bg-linux.anl-external.org/wiki
> >    
