Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id A530EB7CFD
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 07:49:51 +1100 (EST)
Date: Fri, 5 Feb 2010 23:49:49 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH RFC 0/3] Implement refcounting for OF GPIO chips
Message-ID: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Simek <monstr@monstr.eu>, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
that of_get_gpio()'s returned GPIO number will be no longer valid, or
worse, it may point to an unexpected GPIO controller.

This scenario is possible:

driver A:               driver B:              driver C:
---------               ---------              ---------
                        gpiochip_add()
gpio = of_get_gpio()
                        gpiochip_remove()
                                               gpiochip_add()
gpio_request(gpio);
gpio_set_value(gpio);

That is, driver A assumes that it is working with GPIO from driver B,
but in practice it may disappear and driver C will take its GPIO base
number, so it will provide the same GPIO numbers.

The above situation is hard to trigger, but the issue is there
nonetheless, and so needs fixing.

Thanks,

p.s. The patches are based on top of
     '[PATCH v2 0/4] OF GPIO integration for I2C/SPI GPIO chips'
     http://lkml.org/lkml/2010/2/5/243

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
