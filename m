Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B95C3B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 06:44:14 +1000 (EST)
Date: Tue, 15 Sep 2009 16:44:01 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090915204400.GA8287@windriver.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<20090915193205.GA8115@windriver.com>
	<20090915200223.GH12372@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090915200223.GH12372@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: RFC: delete UART current-speed from 4xx DTS?] On 15/09/2009 (Tue 16:02) Josh Boyer wrote:

> On Tue, Sep 15, 2009 at 03:32:05PM -0400, Paul Gortmaker wrote:
> >[Re: RFC: delete UART current-speed from 4xx DTS?] On 15/09/2009 (Tue 11:32) Josh Boyer wrote:
> >
> >> On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
> >> >One of the guys here was getting a messed up console on a bamboo board
> >
> >I meant to say Yosemite board (and hence u-boot), sorry for that.  It
> >gives garbage up until the udbg -> ttyS0 handover, at which point the
> >console=ttyS0,115200 fixes things.
> 
> Ok.
> 
> >> >(on linux boot), which he traced to the fact that the default dts has a
> >> >9600 baudrate coded into it (board was running 115k2, not 9600).  Either
> >> >deleting the line, or replacing the 9600 with zero fixed the problem.
> >> 
> >> Once booted, was there a valid current-speed property in /proc/device-tree
> >> for the serial node?  I'm curious if U-Boot created it, or if the kernel
> >> just used whatever baud was present already.
> >
> >Had to go back to get this info; it turns out there is a valid prop in
> >all the serial nodes (2.6.31-rc7), and hexdumping it gives 0x2580 (9600).
> 
> Sorry, that was after you removed the property in the DTS entirely, or setting
> it to 0, or just using the existing DTS as-is?  I should have phrased my
> question better, but I think I answered it myself already.
> 
> In my brief test with Sequoia and Bamboo, I removed the current-speed property
> entirely and once booted there was no property in the serial node, which is
> what I would expect for the old version of U-Boot on these boards.  The good
> news is that it seems to work fine :).

Yep - and if there is a node with a current-speed that differs from what
u-boot (1.3.3) is actively using, that current-speed setting will take
precedence for early printk and also that baud will appear in the
/proc/device-tree (just to clarify on what I'd tried to convey earlier).

[...]

> >> It's easy enough for me to whip up a patch, and since I'll be testing either
> >> way I'd be happy to do that if you'd like.
> >
> >Sure -- the testing effort will be greater than the time to make the
> >patch, so you doing coverage on all those would be great.  I think I've
> >probably only got easy immediate access to a PIBS/bamboo at the moment.
> >We already know the yosemite is OK with the change, so that is one less
> >to test.
> 
> OK, sounds good.  I'll do some more testing over the next few days and post
> a patch.  Thanks for bringing this to my attention.

No problem; thanks for the quick response and volunteering to test on
the boards you have.

Paul.

> 
> josh
