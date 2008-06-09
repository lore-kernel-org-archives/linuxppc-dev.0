Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB917DDF37
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:45:31 +1000 (EST)
Subject: Re: [patch 3/5] macintosh: therm_windtunnel: semaphore to mutex
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200806092326.m59NQ9vo014224@imap1.linux-foundation.org>
References: <200806092326.m59NQ9vo014224@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 09:40:14 +1000
Message-Id: <1213054814.25745.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, dwalker@mvista.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-09 at 16:26 -0700, akpm@linux-foundation.org wrote:
> From: Daniel Walker <dwalker@mvista.com>
> 
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  drivers/macintosh/therm_windtunnel.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff -puN drivers/macintosh/therm_windtunnel.c~macintosh-therm_windtunnel-semaphore-to-mutex drivers/macintosh/therm_windtunnel.c
> --- a/drivers/macintosh/therm_windtunnel.c~macintosh-therm_windtunnel-semaphore-to-mutex
> +++ a/drivers/macintosh/therm_windtunnel.c
> @@ -62,7 +62,7 @@ static struct {
>  	volatile int		running;
>  	struct task_struct	*poll_task;
>  	
> -	struct semaphore 	lock;
> +	struct mutex	 	lock;
>  	struct of_device	*of_dev;
>  	
>  	struct i2c_client	*thermostat;
> @@ -286,23 +286,23 @@ restore_regs( void )
>  
>  static int control_loop(void *dummy)
>  {
> -	down(&x.lock);
> +	mutex_lock(&x.lock);
>  	setup_hardware();
> -	up(&x.lock);
> +	mutex_unlock(&x.lock);
>  
>  	for (;;) {
>  		msleep_interruptible(8000);
>  		if (kthread_should_stop())
>  			break;
>  
> -		down(&x.lock);
> +		mutex_lock(&x.lock);
>  		poll_temp();
> -		up(&x.lock);
> +		mutex_unlock(&x.lock);
>  	}
>  
> -	down(&x.lock);
> +	mutex_lock(&x.lock);
>  	restore_regs();
> -	up(&x.lock);
> +	mutex_unlock(&x.lock);
>  
>  	return 0;
>  }
> @@ -489,7 +489,7 @@ g4fan_init( void )
>  	const struct apple_thermal_info *info;
>  	struct device_node *np;
>  
> -	init_MUTEX( &x.lock );
> +	mutex_init(&x.lock);
>  
>  	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
>  		return -ENODEV;
> _
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
