Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8sj95wqyzDvVX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 04:41:49 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id 62so7898979oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 10:41:49 -0700 (PDT)
Date: Fri, 4 Nov 2016 02:40:40 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@suse.de>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
Message-ID: <20161103174040.GB423@swordfish>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103125758.3415-1-paul.burton@imgtec.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (11/03/16 12:57), Paul Burton wrote:
> If a device tree specified a preferred device for kernel console output
> via the stdout-path or linux,stdout-path chosen node properties there's
> no guarantee that it will have specified a device for which we have a
> driver. It may also be the case that we do have a driver but it doesn't
> call of_console_check() to register as a preferred console (eg. offb
> driver as used on powermac systems).

so why that driver doesn't call of_console_check() then? if there is a
misconfiguration then why do we want to fix it/fallback in printk code?

[..]
> @@ -260,10 +260,18 @@ void console_set_by_of(void)
>  {
>  	of_specified_console = true;
>  }
> +
> +static void clear_of_specified_console(void)
> +{
> +	of_specified_console = false;
> +}
>  #else
>  # define of_specified_console false
> +static void clear_of_specified_console(void) { }
>  #endif
>  
> +struct console *of_fallback_console;
> +
>  /* Flag: console code may call schedule() */
>  static int console_may_schedule;
>  
> @@ -2657,10 +2665,26 @@ void register_console(struct console *newcon)
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
>  	 */
> -	if (preferred_console < 0 && !of_specified_console) {
> +	if (preferred_console < 0) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
> -		if (newcon->setup == NULL ||
> +		if (of_specified_console) {
> +			/*
> +			 * The device tree stdout-path chosen node property was
> +			 * specified so we don't want to enable the first
> +			 * registered console just now in order to give the
> +			 * device indicated by stdout-path a chance to be
> +			 * registered first. Do however keep track of the
> +			 * first console we see so that we can fall back to
> +			 * using it if we don't see the desired device, either
> +			 * because stdout-path isn't valid, or because we have
> +			 * no driver for the device or our driver doesn't call
> +			 * of_console_check(). See printk_late_init() for this
> +			 * fallback.

if the path is not valid then correct the path. no?

> +			 */
> +			if (!of_fallback_console)
> +				of_fallback_console = newcon;
> +		} else if (newcon->setup == NULL ||
>  		    newcon->setup(newcon, NULL) == 0) {
>  			newcon->flags |= CON_ENABLED;
>  			if (newcon->device) {
> @@ -2844,6 +2868,22 @@ static int __init printk_late_init(void)
>  {
>  	struct console *con;
>  
> +	if (of_specified_console && of_fallback_console &&
> +	    (!console_drivers || !(console_drivers->flags & CON_CONSDEV))) {
> +		/*
> +		 * The system has a device tree which specified stdout-path,
> +		 * but we haven't seen a console associated with the device
> +		 * specified by the stdout-path chosen node property.
> +		 *
> +		 * We do however know which console would have been used
> +		 * if stdout-path weren't specified at all, so in an attempt
> +		 * to provide some output we'll re-register that console
> +		 * pretending that we never saw stdout-path.
> +		 */

DT screwed up, so why would printk() care? does any other
sub-system/driver fixes up a DT misconfiguration?

	-ss

> +		clear_of_specified_console();
> +		register_console(of_fallback_console);
> +	}
> +
>  	for_each_console(con) {
>  		if (!keep_bootcon && con->flags & CON_BOOT) {
>  			/*
> -- 
> 2.10.2
> 
