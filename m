Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 082CBDE171
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:13:16 +1100 (EST)
Date: Sat, 18 Oct 2008 01:13:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/7] of/gpio: implement of_dev_gpiochip_{add,remove} calls
Message-ID: <20081017211314.GA30061@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171303.GE5515@oksana.dev.rtsoft.ru>
	<200810171325.01729.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810171325.01729.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 01:25:01PM -0700, David Brownell wrote:
> On Thursday 16 October 2008, Anton Vorontsov wrote:
> > +       if (of_gc->chip)
> > +               return of_gc->chip;
> > +       return &of_gc->gc;
> 
> presumably there's a reason not to
> 
> 	of_gc->chip = &of_gc->gc;

Yes, there are two reasons:

1. I need some place to insert the huge comment, which you snipped. ;-)

2. I didn't want to break current users. That is, the line you purpose
   ("of_gc->chip = &of_gc->gc;") should be inserted to every of_gpio
   controller. Most of them use of_mm_gpiochip_add(), so these are easy.
   But some (mcu_mpc8349emitx.c) are doing things by themselves.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
