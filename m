Return-Path: <david-b@pacbell.net>
Received: from smtp128.sbc.mail.sp1.yahoo.com (smtp128.sbc.mail.sp1.yahoo.com
	[69.147.65.187]) by ozlabs.org (Postfix) with SMTP id 32B53DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 08:52:49 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 14:52:46 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810221404.52798.david-b@pacbell.net>
	<20081022212217.GA32378@oksana.dev.rtsoft.ru>
In-Reply-To: <20081022212217.GA32378@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810221452.46786.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> > 
> > > So if we register the board infos after 
> > > the controller registered, then nobody will probe the board infos.
> > 
> > See above.  If you're doing it right, there's no problem.
> > That is, scan the OF tables early.  Just like PNP tables
> > get scanned early, for example.
> 
> Heh. If we don't want to be able to make the OF-parsing code
> be a module then there is no problem at all. I can use the bus
> notifiers. And it is most straightforward solution then.
> 
> But I quite dislike to bloat the kernel image with
> maybe-never-used-on-this-board code.

So have it live in the __init text section.  If you're
building a kernel with support for several boards, you
know it's necessarily going to be larger than it would
be if only one board were supported.  But you can shrink
kernel size by judicious use of __init sections..



> My aim was to make the 
> OF-parsing part be a module too. Because in the long run we
> need the OF-parsing stuff for _every_ driver that needs
> platform data. It's quite expensive to have it always built-in,
> don't you think?

If it's discarded early, after translating the data from
OF format into what the drivers need, there will be no
RAM footprint.

- Dave
