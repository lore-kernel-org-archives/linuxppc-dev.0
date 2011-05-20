Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09FBCB71C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 11:51:00 +1000 (EST)
Subject: Re: [PATCH 2/7] [RFC] add bluegene entry to cputable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
In-Reply-To: <BANLkTimEqYnTn10rV2=gfDkXfgxX+2OSCg@mail.gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-2-git-send-email-ericvh@gmail.com>
	<1305851709.7481.89.camel@pasglop>
	<BANLkTimEqYnTn10rV2=gfDkXfgxX+2OSCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 11:50:51 +1000
Message-ID: <1305856251.7481.117.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 20:08 -0500, Eric Van Hensbergen wrote:
> On Thu, May 19, 2011 at 7:35 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
> >> +             .dcache_bsize           = 32,
> >> +             .cpu_setup              = __setup_cpu_460gt,
> >                                            ^^^^^^^^^^^^^^^^^^
> > Are you sure ?
> >
> 
> That surprised me too, I figured it must have been a close enough
> match (at least in the 2.6.29.1 time frame which is where I'm trying
> to merge the BG/P patches up from.  The kittyhawk patches don't even
> use this, so its possible we could just remove it.
>
> _GLOBAL(__setup_cpu_460ex)
> _GLOBAL(__setup_cpu_460gt)
>         mflr    r4
>         bl      __init_fpu_44x
>         bl      __fixup_440A_mcheck
>         mtlr    r4
>         blr
> 
> Looks like the 460 setup invokes a bunch of 440 calls!  Would you
> prefer I setup my own entry point (setup_cpu_bgp or setup_cpu_450)
> which makes the same calls?

Yes, add an entry. 460's are just 440's btw :-)

Cheers,
Ben.
