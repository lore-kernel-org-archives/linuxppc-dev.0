Return-Path: <jengelh@linux01.gwdg.de>
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21527DDFBD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 18:33:04 +1000 (EST)
Date: Tue, 1 May 2007 10:30:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/11] Consolidation of Open Firmware routines
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.61.0705011028090.18504@yvahk01.tjqt.qr>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1 2007 17:22, Stephen Rothwell wrote:
>
>Just thought I would show you all where I am up to.  I have moved from
>openfw.h, drivers/openf and CONFIG_OPENFW to of.h, drivers/of and
>CONFIG_OF - if this offends anyone please scream soon so I can change
>that back.

/me screams. There was already talk about abbreviations [
http://lkml.org/lkml/2006/12/5/7 and replies ], and thank god
"drivers/fw" did not made it (fw: firmware, firewall, firewire...)

>The current diffstat looks like below, so some progress has been made:
>
> arch/powerpc/Kconfig              |    3 +
> arch/powerpc/kernel/of_device.c   |  122 +----------------
> arch/powerpc/kernel/prom.c        |  249 +---------------------------------
> arch/sparc/Kconfig                |    3 +
> arch/sparc/kernel/of_device.c     |  151 +++-----------------
> arch/sparc/kernel/prom.c          |  173 +-----------------------
> arch/sparc/kernel/time.c          |    2 +-
> arch/sparc64/Kconfig              |    3 +
> arch/sparc64/kernel/auxio.c       |    2 +-
> arch/sparc64/kernel/of_device.c   |  164 ++++------------------
> arch/sparc64/kernel/power.c       |    2 +-
> arch/sparc64/kernel/prom.c        |  173 +-----------------------
> arch/sparc64/kernel/time.c        |    2 +-

should be ok,

> drivers/Kconfig                   |    2 +
> drivers/Makefile                  |    1 +
> drivers/of/Kconfig                |    3 +
> drivers/of/Makefile               |    2 +
> drivers/of/base.c                 |  274 +++++++++++++++++++++++++++++++++++++
> drivers/of/device.c               |  131 ++++++++++++++++++

but i'd kinda want drivers/openfirmware, even if it's a bit longer.

> include/asm-powerpc/of_device.h   |   22 +---
> include/asm-powerpc/of_platform.h |   38 +-----
> include/asm-powerpc/prom.h        |   47 ++-----
> include/asm-sparc/of_device.h     |   49 +------
> include/asm-sparc/of_platform.h   |   32 +++++
> include/asm-sparc/prom.h          |   65 +++------
> include/asm-sparc64/of_device.h   |   50 +------
> include/asm-sparc64/of_platform.h |   33 +++++
> include/asm-sparc64/prom.h        |   65 +++------
> include/linux/of.h                |   60 ++++++++
> include/linux/of_device.h         |   26 ++++
> include/linux/of_platform.h       |   55 ++++++++
>
>The battle continues :-)
>--
>Cheers,
>Stephen Rothwell                    sfr@canb.auug.org.au
>http://www.canb.auug.org.au/~sfr/
>

Jan
-- 
