Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 89CCDDDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:12:12 +1000 (EST)
Date: Wed, 20 Aug 2008 01:12:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] rtc: rtc-ds1374: fix 'no irq' case handling
Message-ID: <20080819211210.GA16708@oksana.dev.rtsoft.ru>
References: <20080812161733.GA32164@oksana.dev.rtsoft.ru>
	<9e4733910808191339s28a05f90pef57961e8d24fbdb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910808191339s28a05f90pef57961e8d24fbdb@mail.gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2008 at 04:39:09PM -0400, Jon Smirl wrote:
> On 8/12/08, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > On a PowerPC board with ds1374 RTC I'm getting this error while
> >  RTC tries to probe:
> >
> >  rtc-ds1374 0-0068: unable to request IRQ
> >
> >  This happens because I2C probing code (drivers/of/of_i2c.c) is
> >  specifying IRQ0 for 'no irq' case, which is correct.
> 
> Shouldn't this be
> 
> >  -       if (client->irq <= NO_IRQ)
> 
> instead of
> 
> >  -       if (client->irq < 0)
> >  +       if (client->irq <= 0)
> 
> Since NO_IRQ can vary by platform (0 or -1)?

First of all, NO_IRQ is not defined for every architecture. You can't
use it for truly cross-platform drivers.

Secondly, "<= 0" will work for both NO_IRQ == 0 and NO_IRQ == -1,
since client->irq is signed type.

As for false positives, I don't believe that there is any platform
that use IRQ0 for external interrupts.

[...]
> In of_i2c.c shouldn't there be an error check?
> 
> 		info.irq = irq_of_parse_and_map(node, 0);
> 
> if (info.irq < NO_IRQ) {report error; continue }

irq_of_parse_and_map() returns unsigned type, plus it is defined
only for PowerPC, and for PowerPC NO_IRQ is always 0.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
