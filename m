Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E772FDDECF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 23:57:52 +1100 (EST)
Date: Thu, 17 Jan 2008 16:06:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] [POWERPC] CPM1: implement GPIO LIB API
Message-ID: <20080117130610.GA13408@localhost.localdomain>
References: <478F4514.7030906@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <478F4514.7030906@scram.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jochen,

Thanks for the patch.

On Thu, Jan 17, 2008 at 01:07:48PM +0100, Jochen Friedrich wrote:
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> arch/powerpc/platforms/8xx/Kconfig |    2 +
> arch/powerpc/sysdev/commproc.c     |  162 
> +++++++++++++++++++++++++++++++++++-
> 2 files changed, 163 insertions(+), 1 deletions(-)

Something happened wrt long lines, your editor seem to wrap them. :-(

> diff --git a/arch/powerpc/platforms/8xx/Kconfig 
> b/arch/powerpc/platforms/8xx/Kconfig
> index 91fbe42..08e927c 100644
> --- a/arch/powerpc/platforms/8xx/Kconfig
> +++ b/arch/powerpc/platforms/8xx/Kconfig
[...]
> diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
> index 621bc6c..be78e65 100644
> --- a/arch/powerpc/sysdev/commproc.c
> +++ b/arch/powerpc/sysdev/commproc.c
[...]
> +int cpm1_gpiochip_add16(struct device_node *np)
> +{
> +	return of_mm_gpiochip_add(np, &cpm1_gc16);
> +}

(1)

> +int cpm1_gpiochip_add32(struct device_node *np)
> +{
> +	return of_mm_gpiochip_add(np, &cpm1_gc32);
> +}

(2)

> +static int cpm_init_par_io(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
> +		cpm1_gpiochip_add16(np);
> +
> +	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32")
> +		cpm1_gpiochip_add32(np);
> +	return 0;
> +}
> +arch_initcall(cpm_init_par_io);

I was unable to use arch_initcall() because lack of kmalloc() that
early (needed for of_mm_gpiochip_add() and GPIO LIB in general). So,
does it really work here?

Though, I tried arch_initcall() in the board file, and well... link
order matters a lot, so arch_initcall could indeed work in the
arch/powerpc/sysdev/. I should try that for QE. :-)

If it works, you'd better make (1) and (2) static, or just remove
them completely, since there are no users outside of this file.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
