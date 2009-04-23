Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id EBCDADE14C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 00:13:52 +1000 (EST)
Date: Thu, 23 Apr 2009 18:13:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423141347.GA25351@oksana.dev.rtsoft.ru>
References: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
	<49F07509.8030603@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49F07509.8030603@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 09:02:49AM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > And note that most developers are using up-to-date firmwares
> > (U-Boots), device trees, and kernels. 
> 
> Developers? Yes.
> End-users? No.

If end-users upgraded the kernel on some FSL board, then there
should be no technical problem upgrading device tree too.

> Updating U-Boot itself is often unacceptable for end-users.  There's
> also a strong connection between U-Boot and the device tree.  That
> connection gets stronger with every release, as U-Boot makes more and
> more changes to the device tree before passing it to the kernel.  This
> means that if you cannot update U-Boot, you might not be able to update
> your device tree either.

As I said, this case is a separate matter. Just as device_type = "soc",
yes we should avoid removing it. But if we 100% sure that our device
tree changes won't break compatibility with officially supported
firmware, then IMO we should just go ahead with the changes.

> We've run into plenty of situations where customers will update the
> kernel, but insist that U-Boot

That I can understand.

> and the device tree remain unchanged.

That I can't. I wonder what was the rationale behind this.

> > And that means that old
> > device-tree + new kernel combination is left untested for years.
> > And untested stuff is broken stuff, by definition.
> 
> I'm not saying that should officially support it.  I'm saying we should
> make an effort to minimize the problem.

That doesn't work in practice. I bet if I'll try booting recent Linux
with FSL-provided device-tree on, say, MPC8323E-RDB it simply won't
boot.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
