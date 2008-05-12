Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94CC3DE35D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 05:24:36 +1000 (EST)
Message-Id: <64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080512185206.GA25818@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Date: Mon, 12 May 2008 14:24:20 -0500
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 12, 2008, at 1:52 PM, Anton Vorontsov wrote:

> On MPC86xx the watchdog could be enabled only at power-on-reset, and
> could not be disabled afterwards. We must ping the watchdog from the
> kernel until the userspace handles it.
>
> MPC83xx CPUs are only differ in a way that watchdog could be disabled
> once, but after it was enabled via software it becomes just the same
> as MPC86xx.
>
> Thus, to support MPC86xx I added the kernel timer which pings the
> watchdog until the userspace opens it.
>
> Since we implemented the timer, now we're able to implement proper
> handling for the CONFIG_WATCHDOG_NOWAYOUT case, for MPC83xx and  
> MPC86xx.
>
> Also move the probe code into subsys_initcall, because we want start
> pinging the watchdog ASAP, and misc devices are available in
> subsys_initcall.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/watchdog/Kconfig       |    4 +-
> drivers/watchdog/mpc83xx_wdt.c |   63 +++++++++++++++++++++++++++++++ 
> +++++----

we should rename it to mpc8xxx_wdt.c

- k
