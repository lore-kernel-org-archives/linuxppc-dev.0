Return-Path: <david-b@pacbell.net>
Received: from smtp126.sbc.mail.sp1.yahoo.com (smtp126.sbc.mail.sp1.yahoo.com
	[69.147.65.185]) by ozlabs.org (Postfix) with SMTP id F0B73DDFEB
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 07:38:28 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 5/7] of/gpio: implement of_dev_gpiochip_{add, remove} calls
Date: Fri, 17 Oct 2008 13:25:01 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171303.GE5515@oksana.dev.rtsoft.ru>
In-Reply-To: <20081016171303.GE5515@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810171325.01729.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 October 2008, Anton Vorontsov wrote:
> +       if (of_gc->chip)
> +               return of_gc->chip;
> +       return &of_gc->gc;

presumably there's a reason not to

	of_gc->chip = &of_gc->gc;

when this gets set up, so this can always be a simple

	return of_gc->chip;

(and inlined)?  Needlessly complex...
