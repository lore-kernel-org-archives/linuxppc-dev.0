Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D3FB5B7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 10:30:12 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6BE24DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 10:30:12 +1000 (EST)
Date: Fri, 28 Aug 2009 04:30:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] rtc: Set wakeup capability for I2C and SPI RTC drivers
Message-ID: <20090828003010.GA19160@oksana.dev.rtsoft.ru>
References: <20090827182207.GA7358@oksana.dev.rtsoft.ru>
	<200908271452.37358.david-b@pacbell.net>
	<20090827231925.GA1131@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090827231925.GA1131@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 03:19:25AM +0400, Anton Vorontsov wrote:
[...]
> > That is why platform code should device_init_wakeup() and
> > drivers should check device_can_wakeup(dev) ...
> 
> They should (and do) check may_wakeup() (i.e. should_wakeup) before
> suspending, not can_wakeup().
> 
> static int ds1374_suspend(struct i2c_client *client, pm_message_t state)
> {
>         if (client->irq >= 0 && device_may_wakeup(&client->dev))
>                 enable_irq_wake(client->irq);
>         return 0;
> }
> 
> (quite funny, they issue enable_irq_wake(), assuming that otherwise
> IRQ line won't trigger CPU wakeup. But in reality, there are interrupt
> controllers that you can't control in that regard: any IRQ activity
> will always resume CPU. And so 'echo disable > /sys/.../wakeup' won't
> guarantee anything. Unreliable, nasty? Could be.)

BTW, of course we can fix this by masking interrupts before
suspending, but nobody actually do this (but should, I think).

And if RTC's IRQ is wired to power switch you're in trouble
without any way to fix this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
