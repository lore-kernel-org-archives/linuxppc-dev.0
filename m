Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id B471867C1B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2005 04:32:39 +1000 (EST)
Date: Sun, 3 Jul 2005 11:32:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050703183237.GC16764@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050703172955.GA25976@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 03, 2005 at 07:29:55PM +0200, Olaf Hering wrote:
>  On Wed, May 04, Paul Mackeras wrote:
> 
> > What do people think of this patch?  The motivation for it is that a
> > biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
> > compile, meaning that we end up with a lot of nops we don't need.
> > This also takes out -mstring.
> > 
> > With this, the text size reduces by about 120k for my normal config
> > when compiling with a biarch gcc-4.0.  The text size also reduces
> > slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
> > biarch).
> > 
> > If there are no objections I'll send this to Andrew and Linus.
> 
> What will be done about this patch? -mcpu=750 reduces .text by 70k.

The fix for the real problem is now in.  Perhaps, based off gcc's info
page, we should update (from what 2.6.12 looks like) to do:
cpu-as-y = -Wa,-mcpu=powerpc	# Pure ppc32
cpu-as-$(CONFIG_6xx) += -Wa,-maltivec
cpu-as-$(CONFIG_PPC_601) := -Wa,-mcpu=601 # Or whatever the 601 option is
cpu-as-$(CONFIG_PPC64BRIDGE) := -Wa,mcpu=powerpc64
< add 4xx/BookE here >

And see what we get.  I really don't think we should fall into the i386
ugly trap of i386/i486/i586/i586tsc/... 20 other options ..., esp since
it looks like the main win is switching from 100% generic powerpc to
something more specific.  And going with the generic name means if gcc
starts doing something different on 750 vs 7400 vs 604, we win.

-- 
Tom Rini
http://gate.crashing.org/~trini/
