Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201108111413.51764.arnd@arndb.de>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-2-git-send-email-a.heider@gmail.com>
	<4E39CC67.2060606@infradead.org> <201108111413.51764.arnd@arndb.de>
Date: Thu, 11 Aug 2011 19:32:14 +0200
Message-ID: <CAHsu+b8e2eZZA_ogVP5fpsepWXGWw=dvJAAVCGD94rW3WdZj=w@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 01/15] [PS3] Add udbg driver using the PS3
	gelic Ethernet device
From: Andre Heider <a.heider@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2011 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 August 2011, Geoff Levand wrote:
>> > + *
>> > + * udbg debug output routine via GELIC UDP broadcasts
>> > + * Copyright (C) 2010 Hector Martin <hector@marcansoft.com>
>> > + * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>
>>
>> Some of this seems to be taken from the gelic driver, so shouldn't
>> the copyright info from there be included here?
>
> Moreover, if there is a significant amount of code duplication
> between this driver and gelic, I would expect to actually share
> the code instead, either by integrating the udbg code into the
> gelic driver in form of netconsole support, or by moving the
> common parts into a separate module.

No, thankfully there is no significant code duplication :)
It contains a few structs and defines found elsewhere, but that's
because it's not a real netdev. It just prepares the eth/ip/udp header
once for its single purpose, then uses the hypervisor to send and poll
- in contrast to the gelic driver, which reuses its irqhandler for
netconsole support.
