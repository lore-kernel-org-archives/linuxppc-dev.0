Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 9C414B6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 08:55:48 +1100 (EST)
Date: Tue, 22 Dec 2009 00:55:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Trouble specifying dts gpio-leds with GPIO expander chip
Message-ID: <20091221215544.GA30974@oksana.dev.rtsoft.ru>
References: <4B2FCF40.3050204@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B2FCF40.3050204@billgatliff.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 01:40:48PM -0600, Bill Gatliff wrote:
[...]
> I'm stumped.  Could it be that the startup code is trying to register
> the heartbeat device before it has registered the MAX7314, so it doesn't
> know yet that the GPIO line exists?
> 
> Anyone have any suggestions?

drivers/gpio/pca953x.c doesn't register itself with the
OF GPIO infrastructure (plus the driver has an absolutely
bogus linux,gpio-base stuff, heh).

As an example of how to do the OF GPIO properly, see
arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:mcu_gpiochip_add().

Though, soon there will be an easier way to register I2C/SPI chips
with the OF GPIO infrastructure.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
