Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 2A0C3DDF09
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 05:30:22 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so1431624eyi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 12:30:20 -0700 (PDT)
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 17 Sep 2008 21:30:16 +0200
In-Reply-To: <20080917175820.GA22539@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Wed\, 17 Sep 2008 21\:58\:20 +0400")
Message-ID: <871vziwoxj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,

 Anton> This patch implements GPIOLIB support for MPC8349-compatible SOC GPIOs.
 Anton> MPC8610 adopted this GPIO unit, so let's place it into sysdev.

 Anton> We'll need these gpios to support IrDA transceiver on MPC8610HPCD.

It seems basically the same as my patch (gpio driver for
mpc831x/mpc834x/mpc837x with OF bindings) from September 5th except
you don't have any documentation and the Kconfig doesn't depend on
831x/834x/837x.

Galak, did you have time to look at these patches yet?

 Anton> +struct fsl_gpio_chip {
 Anton> +	struct of_mm_gpio_chip mm_gc;
 Anton> +	spinlock_t lock;
 Anton> +
 Anton> +	/* shadowed data register to clear/set bits safely */
 Anton> +	u32 gpdat;

Why do you need this when you have the lock?

-- 
Bye, Peter Korsgaard
