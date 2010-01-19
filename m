Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 03DD6B7CBB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 09:36:13 +1100 (EST)
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
From: Joe Perches <joe@perches.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20100119221647.GC29306@sirena.org.uk>
References: <20100119211759.GE3804@infomag.iguana.be>
	<1263937351.18117.69.camel@Joe-Laptop.home>
	<20100119221647.GC29306@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jan 2010 14:36:11 -0800
Message-ID: <1263940571.18117.86.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, uclinux-dist-devel@blackfin.uclinux.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-01-19 at 22:16 +0000, Mark Brown wrote:
> On Tue, Jan 19, 2010 at 01:42:31PM -0800, Joe Perches wrote:
> > Maybe a standard #define WATCHDOG_NAME <foo>
> > .identity = WATCHGOD_NAME
> 
> I don't really see that the indrection via the #define would buy us
> anything?

Maybe not, just a suggestion.
There are already 17 uses though.

It might have some value like DRV_NAME does or
any other frequent #define used in printks or
#include code.

It may be useful standardization prior to or post
some generic watchdog code consolidation.

$ grep -r --include=*.[ch] -Poh "^#define\s*\w+NAME\b" drivers | \
  sed -r -e 's/\s+/ /g' | sort | uniq -c | sort -rn | head -10
    334 #define DRV_NAME
    137 #define DRIVER_NAME
     59 #define MODULE_NAME
     25 #define DRVNAME
     21 #define DRV_MODULE_NAME
     18 #define DEVICE_NAME
     17 #define WATCHDOG_NAME
     15 #define MY_NAME
     12 #define BOARD_MAP_NAME
     11 #define DSS_SUBSYS_NAME
