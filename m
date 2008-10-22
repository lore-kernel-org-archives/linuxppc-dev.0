Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 79F48DDEE0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 08:22:19 +1100 (EST)
Date: Thu, 23 Oct 2008 01:22:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Message-ID: <20081022212217.GA32378@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022104606.GA510@oksana.dev.rtsoft.ru>
	<20081022183218.GA19025@oksana.dev.rtsoft.ru>
	<200810221404.52798.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810221404.52798.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 02:04:52PM -0700, David Brownell wrote:
> On Wednesday 22 October 2008, Anton Vorontsov wrote:
> > 
> > > > The board info has another problem though. We can't remove it, thus
> > > > we can't implement module_exit() for the 'OF glue'.
> 
> That's not a problem.  Why would you want to remove it?
> 
> 
> > > And try to solve this problem... maybe then things will begin to
> > > move forward.
> > 
> > There is another problem: board infos are scanned at the controller
> > registration time only.
> 
> Right.  Such board description data should be made available
> early in boot.  As a rule:  before arch_initcall() finishes,
> so that subsys_initcall() code can use the associated GPIOs.
> 
> (It's fairly well acknowledged that init dependency handling
> has a lot of problems.  Until that's fixed ... for GPIOs, the
> general advice is to make sure everything is available by
> subsys_initcall time,  so the subsystems which rely on GPIOs
> to initialize -- power switches, resets, etc -- can initialize.
> That can require i2c adapter drivers to use subsys_initcall,
> for example.)
> 
> 
> > So if we register the board infos after 
> > the controller registered, then nobody will probe the board infos.
> 
> See above.  If you're doing it right, there's no problem.
> That is, scan the OF tables early.  Just like PNP tables
> get scanned early, for example.

Heh. If we don't want to be able to make the OF-parsing code
be a module then there is no problem at all. I can use the bus
notifiers. And it is most straightforward solution then.

But I quite dislike to bloat the kernel image with
maybe-never-used-on-this-board code. My aim was to make the
OF-parsing part be a module too. Because in the long run we
need the OF-parsing stuff for _every_ driver that needs
platform data. It's quite expensive to have it always built-in,
don't you think?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
