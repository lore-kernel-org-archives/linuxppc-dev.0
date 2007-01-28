Return-Path: <hollis@penguinppc.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net
	(elasmtp-spurfowl.atl.sa.earthlink.net [209.86.89.66])
	by ozlabs.org (Postfix) with ESMTP id 0FB13DE18E
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:40:57 +1100 (EST)
In-Reply-To: <995B09A8299C2C44B59866F6391D26356C26C3@zch01exm21.fsl.freescale.net>
References: <995B09A8299C2C44B59866F6391D26356C26C3@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <828f5d9417b425c0b17236bf9d748b05@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH]Disable early console in default to avoid printing boot
	message twice
Date: Sun, 28 Jan 2007 17:34:13 -0600
To: "Li Tony-r64360" <Tony.Li@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is also very annoying that the early boot messages are printed twice=20=

on ppc64. Can you include ppc64 in this patch?

-Hollis

On Jan 26, 2007, at 2:00 AM, Li Tony-r64360 wrote:

> The early console is default enable in powerpc 32 now.
> This cause the boot message from beginning to console_init() printed=20=

> twice.
> The early console is useful only when the kernel dead before=20
> console_init.
> The patch=A0make the early console optional and disable the early=20
> console in default.
> The patch has been tested on mpc8313erdb board
> =A0
> Signed-off-by: Li=A0Tony <tony.li@freescale.com>
> ---
> =A0arch/powerpc/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 2 +-
> =A0arch/powerpc/kernel/setup_32.c |=A0=A0=A0 2 ++
> =A02 files changed, 3 insertions(+), 1 deletions(-)
> =A0
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 0673dbe..0c18951 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -59,7 +59,7 @@ config PPC
> =A0
> =A0config EARLY_PRINTK
> =A0=A0bool
> -=A0default y
> +=A0default t
> =A0
> =A0config COMPAT
> =A0=A0bool
> diff --git a/arch/powerpc/kernel/setup_32.c=20
> b/arch/powerpc/kernel/setup_32.c
> index a4c2964..71eb320 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -242,8 +242,10 @@ void __init setup_arch(char **cmdline_p)
> =A0
> =A0=A0smp_setup_cpu_maps();
> =A0
> +#ifdef CONFIG_EARLY_PRINTK
> =A0=A0/* Register early console */
> =A0=A0register_early_udbg_console();
> +#endif
> =A0
> =A0=A0xmon_setup();
> =A0
> --=20
> 1.4.2
> =A0
> =A0_______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev=
