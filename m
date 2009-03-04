Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 592FADDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:09:14 +1100 (EST)
Date: Tue, 3 Mar 2009 16:09:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Trent Piepho <tpiepho@freescale.com>, Grant Likely
	<grant.likely@secretlab.ca>, Sean MacLennan <smaclennan@pikatech.com>,
	Richard Purdie <rpurdie@linux.intel.com>
Subject: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303160906.9b30b376.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


linux-next's dc0f6e94d7f487c624254597a0b86ef41c525673 (which I don't
seem to be able to find on any mailing lists to which I subscribe)
breaks the sparc64 allmodconfig build:

drivers/leds/leds-gpio.c: In function `gpio_led_init':
drivers/leds/leds-gpio.c:286: error: implicit declaration of function `of_register_platform_driver'
drivers/leds/leds-gpio.c: In function `gpio_led_exit':
drivers/leds/leds-gpio.c:302: error: implicit declaration of function `of_unregister_platform_driver'

afacit that interface is powerpc-only.
