Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id C835DDE4B1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:47:55 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so264210nfd.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 15:47:45 -0700 (PDT)
Date: Fri, 18 Apr 2008 02:47:40 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080417224740.GA25323@zarina>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192832.GA28286@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080417192832.GA28286@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 11:28:32PM +0400, Anton Vorontsov wrote:
> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts. These timers are used by the drivers that
> need time precise interrupts (like for USB transactions scheduling for
> the Freescale USB Host controller as found in some QE and CPM chips),
> or these timers could be used as wakeup events from the CPU deep-sleep
> mode.
> 
> Things unimplemented:
> 1. Cascaded (32 bit) timers (1-2, 3-4).
>    This is straightforward to implement when needed, two timers should
>    be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>    This is also straightforward to implement when needed, all timers
>    should be marked as "requested" and configured as appropriate.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   32 +++-
>  arch/powerpc/Kconfig                         |    5 +
>  arch/powerpc/sysdev/Makefile                 |    1 +
>  arch/powerpc/sysdev/fsl_gtm.c                |  362 ++++++++++++++++++++++++++
>  include/asm-powerpc/fsl_gtm.h                |  108 ++++++++
>  5 files changed, 507 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
>  create mode 100644 include/asm-powerpc/fsl_gtm.h
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 4cc7800..827b630 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
[...]
> +/**
> + * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
> + * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
> + * @usec:	timer interval in microseconds
> + * @reload:	if set, the timer will reset upon expiry rather than
> + *         	continue running free.
> + *
> + * This function (re)sets the GTM timer so that it counts up to the requested
> + * interval value, and fires the interrupt when the value is reached. This
> + * function will reduce the precision of the timer as needed in order for the
> + * requested timeout to fit in a 16-bit register.
> + */
> +int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec, bool reload)
> +{
> +	/* quite obvious, frequency which is enough for µSec precision */
> +	int freq = 1000000;
> +	unsigned int bit;
> +
> +	bit = fls_long(usec);
> +	if (bit > 15) {
> +		freq >>= bit - 15;
> +		usec >>= bit - 15;
> +	}

if (!freq)
	return -EINVAL;

> +	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
> +}
> +EXPORT_SYMBOL(gtm_reset_timer16);

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
