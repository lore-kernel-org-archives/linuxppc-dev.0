Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EFE1DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:33:24 +1100 (EST)
Message-Id: <642F4CC7-918B-4FD9-9C23-5A17E3496B02@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090319180142.GA6114@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/4] powerpc/83xx: Add power management support for
	MPC837x boards
Date: Tue, 24 Mar 2009 08:33:13 -0500
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
	<20090319180142.GA6114@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2009, at 1:01 PM, Anton Vorontsov wrote:

> This patch adds pmc nodes to the device tree files so that the boards
> will able to use standby capability of MPC837x processors. The MPC837x
> PMC controllers are compatible with MPC8349 ones (i.e. no deep sleep).
>
> sleep = <> properties are used to specify SCCR masks as described
> in "Specifying Device Power Management Information (sleep property)"
> chapter in Documentation/powerpc/booting-without-of.txt.
>
> Since I2C1 and eSDHC controllers share the same clock source, they
> are now placed under sleep-nexus nodes.
>
> A processor is able to wakeup the boards on LAN events (Wake-On-Lan),
> console events (with no_console_suspend kernel command line), GPIO
> events and external IRQs (IRQ1 and IRQ2).
>
> The processor can also wakeup the boards by the fourth general purpose
> timer in GTM1 block, but the GTM wakeup support isn't yet implemented
> (it's tested to work, but it's unclear how can we use the quite short
> GTM timers, and how do we want to expose the GTM to userspace).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |   68 ++++++++++++++++-------
> arch/powerpc/boot/dts/mpc8377_rdb.dts |   98 ++++++++++++++++++++ 
> +------------
> arch/powerpc/boot/dts/mpc8378_mds.dts |   66 +++++++++++++++-------
> arch/powerpc/boot/dts/mpc8378_rdb.dts |   96 +++++++++++++++++++ 
> +------------
> arch/powerpc/boot/dts/mpc8379_mds.dts |   68 ++++++++++++++++-------
> arch/powerpc/boot/dts/mpc8379_rdb.dts |   98 ++++++++++++++++++++ 
> +------------
> 6 files changed, 323 insertions(+), 171 del

applied to next

- k
