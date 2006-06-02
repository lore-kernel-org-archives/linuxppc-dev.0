Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id E760767A3A
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 07:33:28 +1000 (EST)
Date: Fri, 2 Jun 2006 16:33:08 -0500
From: Nathan Lynch <ntl@pobox.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] reorg RTAS delay code
Message-ID: <20060602213308.GP8934@localdomain>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<1149177349.9812.16.camel@sinatra.austin.ibm.com>
	<1149200718.15158.0.camel@sinatra.austin.ibm.com>
	<1149280229.18052.3.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149280229.18052.3.camel@sinatra.austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +/* For an RTAS busy status code, perform the hinted delay. */
> +unsigned int rtas_busy_delay(int status)
> +{
> +	unsigned int ms;
>  
> -	return ms; 
> +	ms = rtas_busy_delay_time(status);
> +	if (ms)
> +		msleep(ms);
> +
> +	return ms;
>  }

Can you put a might_sleep() at the beginning of this function so that
we can reliably catch unsafe uses of it?  Otherwise we'll get warnings
only when a delay is actually executed.


> @@ -438,22 +449,14 @@ int rtas_get_power_level(int powerdomain
>  int rtas_set_power_level(int powerdomain, int level, int *setlevel)
>  {
>  	int token = rtas_token("set-power-level");
> -	unsigned int wait_time;
>  	int rc;
>  
>  	if (token == RTAS_UNKNOWN_SERVICE)
>  		return -ENOENT;
>  
> -	while (1) {
> +	do
>  		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
> -		if (rc == RTAS_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		} else
> -			break;
> -	}
> +	while (rtas_busy_delay(rc));

Coding style nit -- am I alone in thinking that do/while without the
brackets looks weird?  Given the single-statement body of the loop, I
guess the brackets aren't necessary, but omitting the brackets doesn't
save lines in this case.
