Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59FEB1A0590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:01:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A92F31400DA
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 10:01:39 +1000 (EST)
Message-ID: <1401235290.8262.9.camel@pasglop>
Subject: Re: [PATCH] tty/hvc/hvc_console: Fix wakeup of HVC thread on
 hvc_kick()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 May 2014 10:01:30 +1000
In-Reply-To: <1400838066.29150.69.camel@pasglop>
References: <1400838066.29150.69.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jiri Slaby <jslaby@suse.cz>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 19:41 +1000, Benjamin Herrenschmidt wrote:
> Some backends call hvc_kick() to wakeup the HVC thread from its
> slumber upon incoming characters. This however doesn't work
> properly because it uses msleep_interruptible() which is mostly
> immune to wake_up_process(). It will basically go back to sleep
> until the timeout is expired (only signals can really wake it).
>
> Replace it with a simple shedule_timeout_interruptible() instead,
> which may wakeup earlier every now and then but we really don't
> care in this case.

Nobody commented ? :-)

Greg, do you want to take this in the tty tree or can I stick it in
powerpc ?

Cheers,
Ben 

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/tty/hvc/hvc_console.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 94f9e3a..1094265 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -760,10 +760,17 @@ static int khvcd(void *unused)
>  			if (poll_mask == 0)
>  				schedule();
>  			else {
> +				unsigned long j_timeout;
> +
>  				if (timeout < MAX_TIMEOUT)
>  					timeout += (timeout >> 6) + 1;
>  
> -				msleep_interruptible(timeout);
> +				/*
> +				 * We don't use msleep_interruptible otherwise
> +				 * "kick" will fail to wake us up
> +				 */
> +				j_timeout = msecs_to_jiffies(timeout) + 1;
> +				schedule_timeout_interruptible(j_timeout);
>  			}
>  		}
>  		__set_current_state(TASK_RUNNING);
> 
