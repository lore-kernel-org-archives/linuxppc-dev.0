Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id EB3B72BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 04:37:00 +1100 (EST)
Date: Wed, 5 Jan 2005 10:36:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20050105173658.GE4213@smtp.west.cox.net>
References: <313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com>
	<1104256077.20042.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1104256077.20042.125.camel@localhost.localdomain>
Cc: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Dec 28, 2004 at 12:47:57PM -0500, Steven Rostedt wrote:
> On Tue, 2004-12-28 at 12:28 -0500, Povolotsky, Alexander wrote:
> > Hi! (Thanks !) 
> > 
> > I guess I need some more education - since I am getting my problem right at
> > the boot - is 
> > I-Cache enabled (by default ?) for 8xx on 2.6 at the booting ? - I do not
> > see anything in .config 
> > which controls it (or I am missing it there ?) 
> > How (where and at what point during the boot)-) I could disable I-Cache ?
> 
> Since you where able to get to the prekernel portion (that was
> relocated) I don't think you have a problem with caches, unless for some
> reason the pre-kernel can relocate itself, but it doesn't know to
> refresh the cache after relocating the actual kernel.

The in-kernel bootwrapper codes does indeed relocate itself (overlap
isn't a problem either, except for a small window.  All of this can be
avoided if you link the kernel where it will be loaded into memory by
the firmware as well), but it should also do all needed cache flushing.

But as has been said before, since the CPU15 errata doesn't exist with
i-cache disabled, the simple workaround would be to disable the i-cache
as quickly as possible from the head.S portions of the in-kernel
bootwrapper and make sure we don't re-enable it later on (I _think_ we
do for speed reasons).

-- 
Tom Rini
http://gate.crashing.org/~trini/
