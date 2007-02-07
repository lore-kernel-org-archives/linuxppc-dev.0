Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 111CFDDF66
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:51:12 +1100 (EST)
Date: Wed, 7 Feb 2007 10:59:01 -0600
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20070207165901.GA974@lixom.net>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<45C40C97.807@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45C40C97.807@austin.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2007 at 10:16:23PM -0600, Manish Ahuja wrote:
> Resubmitting this patch with a sysfs interface instead of /proc.
> During some off line discussion, /sys/power was suggested as a possible 
> candidate area for this functionality to reside.

Minor nitpick since you have to respin based on Paul's comments anyway...

>  void rtas_power_off(void)
>  {
> +	int rc;
> +	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
> +
>  	if (rtas_flash_term_hook)
> -		rtas_flash_term_hook(SYS_POWER_OFF);
> -	/* allow power on only with power button press */
> -	printk("RTAS power-off returned %d\n",
> -	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
> +	rtas_flash_term_hook(SYS_POWER_OFF);

Looks like you have an if (rtas_flash_term_hook) with an unindented line
right after it.



-Olof
