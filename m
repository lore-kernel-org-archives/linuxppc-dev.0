Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 36882DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:55:48 +1100 (EST)
Date: Thu, 30 Oct 2008 22:55:46 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3 RFC] MMC SPI support for OpenFirmware platforms
Message-ID: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here are the bindings, again. Still RFC.

This patch series depends on:
http://lkml.org/lkml/2008/10/16/250
http://lkml.org/lkml/2008/10/24/416 
+ of_gpio_flags enum (Trent Piepho will post an updated patch soon,
I believe).

Pierre, the approach is somewhat similar to this one:
http://lkml.org/lkml/2008/5/26/135
Posted few months ago.

I know you don't like it, but I ask you to reconsider it. The
I2C and SPI cases are similar, and recently we tried to write
bindings for some I2C GPIO controllers.

There we've learned that we:

1. Don't like the bus notifiers approach b/c we can't place the OF
   code into the module.
   http://lkml.org/lkml/2008/10/21/425
   Hacks are possible, but they're are ugly.
2. Don't want to write new drivers to solely handle the platform
   data:
   http://lkml.org/lkml/2008/10/28/257
   http://lkml.org/lkml/2008/10/28/268

And personally I don't want to do refactoring for every driver that
we'd want to use with the OpenFirmware...

If I understood correctly, for GPIO controllers David agreed that
we can live with the platform data accessors, at least for now:
http://lkml.org/lkml/2008/10/23/24

And when/if we'll find something better I'll be the first who
will offer help to convert the bindings code to this "something
better".

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
