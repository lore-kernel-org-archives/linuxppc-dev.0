Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 01/15] [PS3] Add udbg driver using the
	PS3 gelic Ethernet device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Heider <a.heider@gmail.com>
In-Reply-To: <CAHsu+b8e2eZZA_ogVP5fpsepWXGWw=dvJAAVCGD94rW3WdZj=w@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-2-git-send-email-a.heider@gmail.com>
	<4E39CC67.2060606@infradead.org> <201108111413.51764.arnd@arndb.de>
	<CAHsu+b8e2eZZA_ogVP5fpsepWXGWw=dvJAAVCGD94rW3WdZj=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Aug 2011 14:26:36 +1000
Message-ID: <1314764796.2488.134.camel@pasglop>
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
	Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-08-11 at 19:32 +0200, Andre Heider wrote:
> On Thu, Aug 11, 2011 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 04 August 2011, Geoff Levand wrote:
> >> > + *
> >> > + * udbg debug output routine via GELIC UDP broadcasts
> >> > + * Copyright (C) 2010 Hector Martin <hector@marcansoft.com>
> >> > + * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>
> >>
> >> Some of this seems to be taken from the gelic driver, so shouldn't
> >> the copyright info from there be included here?
> >
> > Moreover, if there is a significant amount of code duplication
> > between this driver and gelic, I would expect to actually share
> > the code instead, either by integrating the udbg code into the
> > gelic driver in form of netconsole support, or by moving the
> > common parts into a separate module.
> 
> No, thankfully there is no significant code duplication :)
> It contains a few structs and defines found elsewhere, but that's
> because it's not a real netdev. It just prepares the eth/ip/udp header
> once for its single purpose, then uses the hypervisor to send and poll
> - in contrast to the gelic driver, which reuses its irqhandler for
> netconsole support.

Ack. As long as it's not enabled by default and understood to be what it
is, ie, a tool to debug really early boot code before a more "proper"
console is available, I have no objection. There is really no code dup,
just a couple of struct definitions and it's not a big deal.

I'll merge it.

Cheers,
Ben.
