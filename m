Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A1EEB6F65
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 01:03:06 +1000 (EST)
Message-ID: <4E81D6C0.3010201@embedded-sol.com>
Date: Tue, 27 Sep 2011 16:59:28 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"jacmet@sunsite.dk" <jacmet@sunsite.dk>, grant.likely@secretlab.ca
Subject: Handling multiple GPIO controllers in 8xxx GPIO driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Looks like  8xxx GPIO driver cannot properly handle interrupts
when multiple GPIO controllers exist in the system.

On Freescale P1022 there are 3 GPIO controllers. All 3 use
the same interrupt line, internal interrupt 31. If all controllers
are defined in device tree set_irq_chained_handler() is invoked
3 times with same  hardware irq number. The result is interrupt
storm,  mpc8xxx_gpio_irq_cascade() is invoked indefinitely.

What would be the best way to fix the problem ?

Thanks.

Felix Radensky.
