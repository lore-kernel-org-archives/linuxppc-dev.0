Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5071BDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 17:59:48 +1000 (EST)
Date: Thu, 4 Jun 2009 09:59:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] powerpc/mpc85xx: add support for suspend mode
Message-ID: <20090604075935.GA3744@www.tglx.de>
References: <20090603195429.GA31269@www.tglx.de>
	<E6E25BED-8561-4C3B-9501-489FC53F53DE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <E6E25BED-8561-4C3B-9501-489FC53F53DE@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-06-03 16:31:42 [-0500]:

>On Jun 3, 2009, at 2:54 PM, Sebastian Andrzej Siewior wrote:
>
>>This patch adds support for the MPC85xx boards to enter the SLEEP  
>>mode.
>>The wake up is done via an external interrupt.
>>mpc85xx_enter_sleep() does not clear HID0_SLEEP in resume but it may  
>>be
>>okay since it gets cleared on next NAP/DOZE.
>>mpc85xx_enter_sleep() is mostly copied from NAP/DOZE. It does not look
>>like it is worth to merge into e500_idle(). I removed the feature  
>>check
>>for NAP/DOZE because it does not look required. It is just there to  
>>work
>>around the BDI. If it is required it could be moved to
>>mpc85xx_init_suspend().
>>The suspend.c file contains a sample implementation. I need  
>>additionally
>>to add hooks prio and after mpc85xx_enter_sleep() to toggle a few bits
>>in my FPGA. Since the suspend.c is really short I'm not sure if it is
>>worth to keep it here and add couple function prototypes or add the
>>required bits directly into the board code.
>>
>>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>---
>>arch/powerpc/Kconfig                  |    2 +-
>>arch/powerpc/kernel/idle_e500.S       |   43 ++++++++++++++++++++++++ 
>>+++++++++
>>arch/powerpc/platforms/85xx/Makefile  |    1 +
>>arch/powerpc/platforms/85xx/suspend.c |   27 ++++++++++++++++++++
>>4 files changed, 72 insertions(+), 1 deletions(-)
>>create mode 100644 arch/powerpc/platforms/85xx/suspend.c
>
>On what system did you test / develop this on?

An mpc8544ds based custom board. Non-SMP machine. The only negative
thing I've noticed is that the clock stops in SLEEP. The spec says
that all clocks will halt so I thing it is okay :) I have no RTC
directly on my board so I'm not sure if I have to call something to sync
with a RTC or the suspend code is doing this on its own.

>
>- k

Sebastian
