Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6zNq3K3RzDvMT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 02:51:06 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Andreas Schwab <schwab@linux-m68k.org>, Andrew Morton
 <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Larry Finger
 <Larry.Finger@lwfinger.net>, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
Date: Mon, 31 Oct 2016 15:50:56 +0000
Message-ID: <1593250.MZpe3pfUW6@np-p-burton>
In-Reply-To: <20161031121455.23280-1-paul.burton@imgtec.com>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5747718.aDoyDcDeRa";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart5747718.aDoyDcDeRa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 31 October 2016 12:14:55 GMT Paul Burton wrote:
> If a device tree specified a preferred device for kernel console output
> via the stdout-path or linux,stdout-path chosen node properties there's
> no guarantee that it will have specified a device for which we have a
> driver. It may also be the case that we do have a driver but it doesn't
> call of_console_check() to register as a preferred console (eg. offb
> driver as used on powermac systems). In these cases try to ensure that
> we provide some console output by enabling the first usable registered
> console, which we keep track of with the of_fallback_console variable.
> 
> Tested in QEMU with a PowerPC pseries_defconfig kernel.

Actually whilst this fixes the output in QEMU it has other problems. I'm still 
digging...

Thanks,
    Paul

> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 05fd007e4629 ("console: don't prefer first registered if DT specifies
> stdout-path") Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> 
> ---
> 
> Changes in v2:
> - Split enable_console() out of register_console() & call in the fallback
> case. - Track the console we would have enabled as of_fallback_console.
> 
>  kernel/printk/printk.c | 60
> +++++++++++++++++++++++++++++++++++++++++++++----- 1 file changed, 55
> insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index de08fc9..b02c00a 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -264,6 +264,13 @@ void console_set_by_of(void)
>  # define of_specified_console false
>  #endif
> 
> +/*
> + * The first usable console, which we'll fall back to using if the system
> + * uses a device tree which indicates a stdout-path device for which we
> + * have no driver, or for which our driver doesn't call of_console_check().
> + */
> +static struct console *of_fallback_console;
> +
>  /* Flag: console code may call schedule() */
>  static int console_may_schedule;
> 
> @@ -2598,6 +2605,8 @@ static int __init keep_bootcon_setup(char *str)
> 
>  early_param("keep_bootcon", keep_bootcon_setup);
> 
> +static void enable_console(struct console *newcon);
> +
>  /*
>   * The console driver calls this routine during kernel initialization
>   * to register the console printing procedure with printk() and to
> @@ -2620,7 +2629,6 @@ early_param("keep_bootcon", keep_bootcon_setup);
>  void register_console(struct console *newcon)
>  {
>  	int i;
> -	unsigned long flags;
>  	struct console *bcon = NULL;
>  	struct console_cmdline *c;
> 
> @@ -2657,7 +2665,9 @@ void register_console(struct console *newcon)
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
>  	 */
> -	if (preferred_console < 0 && !of_specified_console) {
> +	if (preferred_console < 0 && of_specified_console) {
> +		of_fallback_console = of_fallback_console ?: newcon;
> +	} else if (preferred_console < 0) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
>  		if (newcon->setup == NULL ||
> @@ -2705,8 +2715,18 @@ void register_console(struct console *newcon)
>  		break;
>  	}
> 
> -	if (!(newcon->flags & CON_ENABLED))
> -		return;
> +	if (newcon->flags & CON_ENABLED)
> +		enable_console(newcon);
> +}
> +EXPORT_SYMBOL(register_console);
> +
> +static void enable_console(struct console *newcon)
> +{
> +	struct console *bcon = NULL;
> +	unsigned long flags;
> +
> +	if (console_drivers && console_drivers->flags & CON_BOOT)
> +		bcon = console_drivers;
> 
>  	/*
>  	 * If we have a bootconsole, and are switching to a real console,
> @@ -2777,7 +2797,6 @@ void register_console(struct console *newcon)
>  				unregister_console(bcon);
>  	}
>  }
> -EXPORT_SYMBOL(register_console);
> 
>  int unregister_console(struct console *console)
>  {
> @@ -2839,10 +2858,41 @@ EXPORT_SYMBOL(unregister_console);
>   * intersects with the init section. Note that code exists elsewhere to get
> * rid of the boot console as soon as the proper console shows up, so there
> * won't be side-effects from postponing the removal.
> + *
> + * Additionally we may be using a device tree which specifies valid
> + * stdout-path referencing a device for which we don't have a driver, or
> for + * which we have a driver that doesn't register itself as preferred
> console + * using of_console_check(). In these cases we attempt here to
> enable the + * first usable registered console, which we assigned to
> of_fallback_console. */
>  static int __init printk_late_init(void)
>  {
>  	struct console *con;
> +	bool any_enabled = false;
> +
> +	for_each_console(con) {
> +		if (!(con->flags & CON_ENABLED))
> +			continue;
> +
> +		any_enabled = true;
> +		break;
> +	}
> +
> +	if (!any_enabled && of_fallback_console) {
> +		if (of_fallback_console->index < 0)
> +			of_fallback_console->index = 0;
> +
> +		if (!of_fallback_console->setup ||
> +		    !of_fallback_console->setup(of_fallback_console, NULL)) {
> +			of_fallback_console->flags |= CON_ENABLED;
> +			if (of_fallback_console->device) {
> +				of_fallback_console->flags |= CON_CONSDEV;
> +				preferred_console = 0;
> +			}
> +		}
> +
> +		enable_console(of_fallback_console);
> +	}
> 
>  	for_each_console(con) {
>  		if (!keep_bootcon && con->flags & CON_BOOT) {


--nextPart5747718.aDoyDcDeRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYF2hgAAoJEIIg2fppPBxl7kAP/Ro67pzl+/h1XvCf8JAOZMSR
FLjcwtE1AwjJpbaXL1lkq83Uy8DybNJAS9sMmc4119yty/ERUy/EIrFiyKTkBTe+
k74qTVzcO1njH0vfyubtV+zZEwE0U790iYSEV3Td6sgI/K60U6LqWmf22kSdxT97
0rpnGZcZ87p4lyXaikhRxDPu6pvMt2nzUINqSzlPr7mD+YKezSwePyT34Cp0cwT/
vQkI45T5UtmTVRnCHdcyZ8t4QIIo8J7ZScEWsvgEU7z2qSuYJBpZGl3cZifGxNSk
NfLfuyrJezuaGiuAP5R7SAmKbyBN47U1+4DjAs7DTD5/lsLmszaXs3nadGckRBxy
2IcxJcp9nMROQjAA3rwZYWJo2ZR/YdwVkIpCONsqLGvI/069pfLjOXLTRQ0mCNTS
rNLFOa/WLFAl8nH1TaidO4rDFDlW6MU3j4ytLvizGoKKp5DoTw4uz2l/8N+gnLcH
Cc060HB/E5D+go+rDpdfKuzkgl1xRuSYVm3xvodyomVrLy1Bk54WvXnpi+eqNQ2g
5HBgc3tpAO1zP1Nbc+HQFdINuip8joUgEJEXW/7V+28DFr/tzCXoEkUmphkiKBmc
LezxnsOz0T4BHsZjvexFhwur6SewK5KyKcZw0EXaycl9jhLm2yBbkdPYtw1VwC+q
HQG6GqCPUbrSwN56QEcD
=w1sa
-----END PGP SIGNATURE-----

--nextPart5747718.aDoyDcDeRa--
