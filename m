Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id F0B5E2BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 07:38:40 +1000 (EST)
Date: Fri, 8 Oct 2004 14:38:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041008213838.GJ14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
	<944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008180209.GD14773@smtp.west.cox.net>
	<7079964C-1959-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008194807.GG14773@smtp.west.cox.net>
	<85927CE7-196B-11D9-9299-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85927CE7-196B-11D9-9299-003065F9B7DC@embeddededge.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 08, 2004 at 04:49:17PM -0400, Dan Malek wrote:
> On Oct 8, 2004, at 3:48 PM, Tom Rini wrote:
> 
> >I don't get it.  We do agree that the very specific stuff does indeed
> >belong somewhere that's obvious to the user, right?
> 
> I want all of the CPM and 8xx/82xx/85xx configuration to be in
> a common menu, just like it is today.

That's not exactly how it is, but I see what you're saying.

> I don't understand the
> fascination with syslib/, but if that's where you want things,
> that's fine.

ok.

> Drivers that are common to multiple platforms or
> otherwise interact with common subsystems (like uarts and
> network drivers) should be in the standard directories.

No driver should ever live under arch/.  I'll point to the example of
'm32r' which was just merged with arch/m32r/drivers/ and within a week
or so had it all moved properly to drivers/, with help from community
folks.  And let me remind you of drivers/net/fec.c again. :)

> As the discussion started out earlier today, I also don't like
> the configuration options scattered about and in the past
> we have discussed this was not to be the case.  Those of
> us writing the new code or updating existing code all
> thought this was the configuration process, and now today
> you are arguing for something different and are likely to
> implement it that way against our wishes.  Based upon the
> processor type, we should be invoking different Kconfig
> scripts that although may use the same sources have different
> configuration option criteria.  It is significantly easier for
> us to keep those things local for consistent modification,
> and I contend will make it easier to focus on the configuration
> selections when doing so interactively.

I really hate the 'grafted on' feeling 8xx has in the kernel right now.
I know that when the work was started, various upstreams weren't
responsive or didn't care about some embedded platform, but things
have changed.  It does make sense to put 8xx_CPU6 in arch/ppc/
something, and it does make sense to have some obvious menu for 8xx
sub-options, but it doesn't make sense anymore to have serial, enet,
sound, usb, atm, or anything else grouped there anymore.  It's not hard
to get changes upstream.  Andrew listens.  Linus listens.  Other
maintainers listen.  And it just doesn't make sense to me why for 8xx it
all has to be under one menu, but SH can surive with it's serial driver
in drivers/serial/Kconfig and STNIC under drivers/net/Kconfig.

-- 
Tom Rini
http://gate.crashing.org/~trini/
