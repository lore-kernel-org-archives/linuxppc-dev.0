Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2408DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 07:32:08 +1000 (EST)
Message-Id: <E6E25BED-8561-4C3B-9501-489FC53F53DE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20090603195429.GA31269@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC] powerpc/mpc85xx: add support for suspend mode
Date: Wed, 3 Jun 2009 16:31:42 -0500
References: <20090603195429.GA31269@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2009, at 2:54 PM, Sebastian Andrzej Siewior wrote:

> This patch adds support for the MPC85xx boards to enter the SLEEP  
> mode.
> The wake up is done via an external interrupt.
> mpc85xx_enter_sleep() does not clear HID0_SLEEP in resume but it may  
> be
> okay since it gets cleared on next NAP/DOZE.
> mpc85xx_enter_sleep() is mostly copied from NAP/DOZE. It does not look
> like it is worth to merge into e500_idle(). I removed the feature  
> check
> for NAP/DOZE because it does not look required. It is just there to  
> work
> around the BDI. If it is required it could be moved to
> mpc85xx_init_suspend().
> The suspend.c file contains a sample implementation. I need  
> additionally
> to add hooks prio and after mpc85xx_enter_sleep() to toggle a few bits
> in my FPGA. Since the suspend.c is really short I'm not sure if it is
> worth to keep it here and add couple function prototypes or add the
> required bits directly into the board code.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/Kconfig                  |    2 +-
> arch/powerpc/kernel/idle_e500.S       |   43 ++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/Makefile  |    1 +
> arch/powerpc/platforms/85xx/suspend.c |   27 ++++++++++++++++++++
> 4 files changed, 72 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/suspend.c

On what system did you test / develop this on?

- k
