Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFD6667C26
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 02:49:23 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB4Fn3TF001650
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 10:49:03 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB4Fn3Vu304686
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 10:49:03 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB4Fn37U021315
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 10:49:03 -0500
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <45707469.9060604@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 09:48:58 -0600
Message-Id: <1165247338.18104.21.camel@localhost>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-12 at 12:28 -0600, Manish Ahuja wrote:
> During power outages, the ups notifies the system for a shutdown. In the
> current setup, it isn't possible to poweron when power is restored. This
> patch fixes the issue by calling the right ibm,power-off-ups token
> during such events. It also adds a proc interface so that rc.powerfail
> can parse the epow events and modify the power-off behavior accordingly
> to enable the right token to be called.
> 
> Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>
> 


> plain text document attachment (power-off-ups.patch)
> Index: 2.6-git2/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- 2.6-git2.orig/arch/powerpc/kernel/rtas.c	2006-11-29 12:00:26.000000000 -0800
> +++ 2.6-git2/arch/powerpc/kernel/rtas.c	2006-11-30 10:56:12.000000000 -0800
> @@ -603,11 +603,30 @@
> 
>  void rtas_power_off(void)
>  {
> +	int rc = 0;
> +	int rtas_poweron_auto_token;
> +
>  	if (rtas_flash_term_hook)
>  		rtas_flash_term_hook(SYS_POWER_OFF);
> -	/* allow power on only with power button press */
> -	printk("RTAS power-off returned %d\n",
> -	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
> +
> +	if (rtas_poweron_auto == 0) {
> +		/* allow power on only with power button press */

I expect someone will agree or strongly disagree with me here on
cosmetics.. :-)  I'd be tempted to pull the one-liner comments out of
the code and replace them with a short paragraph above the function
name.

And.. 
Do we have a preference for  "(rtas_poweron_auto == 0)" versus "(!rtas_poweron_auto)" 
notation?    rtas.c has some of each, so I'm not sure.


> +		printk(KERN_INFO "RTAS power-off returned %d\n",
> +			rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
> +	} else {
> +		rtas_poweron_auto_token = rtas_token("ibm,power-off-ups");
> +
> +		if (rtas_poweron_auto_token == RTAS_UNKNOWN_SERVICE) {
> +			/* ibm,power-off-ups failed or token does not exist */
> +			rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
> +	 		printk(KERN_EMERG "Power-off called instead %d\n", rc );
> +		} else {
> +			/* Enable the system to reboot if power comes back on */
> +			rc = rtas_call(rtas_token("ibm,power-off-ups"), 0, 1, NULL);
> +			printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
> +		}

You could eliminate the temp variable rtas_poweron_auto_token, and
rewrite as something like:

               if (rtas_token("ibm,power-off-ups") == RTAS_UNKNOWN_SERVICE) {
                       rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
                       printk(KERN_EMERG "Power-off called instead %d\n", rc );
               } else {
                       rc = rtas_call(rtas_token("ibm,power-off-ups"),0, 1, NULL);
                       printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
               }


> +
> +	}
>  	for (;;);
>  }

<snippage> 
> +static ssize_t ppc_rtas_poweron_auto_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	unsigned long ups_restart;
> +	int error = parse_number(buf, count, &ups_restart);
> +	if (error)
> +		return error;
> +
> +	if (ups_restart != 0)
> +		rtas_poweron_auto = 1;

the !=0 is redundant here..  just "if (ups_restart) " should be
sufficient. 

> +
> +	return count;
> +}

>  /**
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
