Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29DBF67D95
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:49:04 +1000 (EST)
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060811204105.GK3233@localdomain>
References: <20060811204105.GK3233@localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:48:54 +0200
Message-Id: <1155772134.11312.119.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-11 at 15:41 -0500, Nathan Lynch wrote:

> +	/* Sampling the time base must be done after loading
> +	 * do_gtod.varp in order to avoid racing with update_gtod.
> +	 */
> +	rmb();
> +	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;

The barrier isn't necessary and the race not completely closed imho... I
need to think about it a bit more closely but what about instead just
check if tb_ticks goes negative, and if yes, just do get_tb() again ?
That might be faster than having a sync in there and should still be
correct.

>  	temp_tb_to_xs = temp_varp->tb_to_xs;
>  	temp_stamp_xsec = temp_varp->stamp_xsec;
>  	xsec = temp_stamp_xsec + mulhdu(tb_ticks, temp_tb_to_xs);
> @@ -464,7 +469,7 @@ void do_gettimeofday(struct timeval *tv)
>  		tv->tv_usec = usec;
>  		return;
>  	}
> -	__do_gettimeofday(tv, get_tb());
> +	__do_gettimeofday(tv);
>  }
>  
>  EXPORT_SYMBOL(do_gettimeofday);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
