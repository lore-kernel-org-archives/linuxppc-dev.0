Subject: Re: patch against linuxppc_2_4_devel: ppc405_wdt.c needs to be fixed
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3EDD9B7C.3080101@esd-electronics.com>
References: <3EDD9B7C.3080101@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 04 Jun 2003 15:06:20 +0200
Message-Id: <1054731981.27503.17.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dose the watchdog actually work ??

What happens when you get into a infinite loop when interrupts are
turned off?

On Wed, 2003-06-04 at 09:10, Matthias Fuchs wrote:
> Hi,
>
> I noticed that the 405 watchdog driver's ioctl() for GETPERIOD and SETPERIOD
> are not working correctly. The ioctls pass the watchdog timer period in microseconds.
> The variable wdt_period stores the current period in seconds.
>
> The attached patch fixes this behavior.
>
> Matthias
> ----
>

> --- drivers/char/ppc405_wdt.c	Wed Jun  4 08:58:42 2003
> +++ /usr/src/linuxppc_2_4_devel/drivers/char/ppc405_wdt.c	Tue Dec 24 06:00:15 2002
> @@ -190,8 +190,7 @@
>  			}
>  		case WDIOC_GETPERIOD:
>  			/* return watchdog period (units = microseconds) */
> -			period = wdt_period * MICROSECBASE;
> -
> +			period = (wdt_period / HZ) * MICROSECBASE;
>  			if (copy_to_user((unsigned long *)arg, &period,
>  			    sizeof(period))) {
>  				return -EFAULT;
> @@ -234,7 +233,8 @@
>  			if (period == 0)
>  				period = MAXONEHOUR * MICROSECBASE;
>
> -			wdt_period = period / MICROSECBASE;
> +			heartbeat_count(0) = (period / TENMSBASE) +
> +				(period % TENMSBASE ? 1 : 0);
>  			ppc405wd_update_timer();
>
>  			break;
--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
