Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 01F8368311
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 02:02:49 +1000 (EST)
Date: Mon, 19 Sep 2005 08:21:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
Message-ID: <20050919082151.E25356@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509191302.15462.sr@denx.de> <20050919065942.A25356@cox.net>
	<200509191706.24298.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509191706.24298.sr@denx.de>;
	from sr@denx.de on Mon, Sep 19, 2005 at 05:06:23PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2005 at 05:06:23PM +0200, Stefan Roese wrote:
> Hi Matt,
> 
> On Monday 19 September 2005 15:59, Matt Porter wrote:
> > On Mon, Sep 19, 2005 at 01:02:14PM +0200, Stefan Roese wrote:
> > > Just to be sure: The 44x boot-wrapper approach you mention is
> > > "boot/simple/pibs.c"?
> >
> > Yes, there's both boot/simple/pibs.c and boot/simple/openbios.c that
> > were created so we could have the default firmware and u-boot use the
> > same kernel build.
> 
> Yes, that's what I thought. But Eugene mentioned, that he boots vmlinux 
> without any boot-wrapper on the OpenBIOS targets (except Ebony probably). You 
> would loose this possibility, if I add this wrapper and switch from OpenBIOS 
> to U-Boot bd_info struct in the kernel.
> 
> Did I miss something here? How should I proceed?

I thought he was talking about booting a uImage, which from the 
perspective of not having the zImage wrapper around it, is like booting
a vmlinux.  He may referring to his own production firmware capabilities
too. I'll let him comment.

In any case, if you follow the model used on 44x where the board info
is the standard method of passing info into the kernel, then we'll be
alright. This means you have to add additional code in the
arch/ppc/boot/simple/openbios.c shim to generate some compatible board
info.

-Matt
