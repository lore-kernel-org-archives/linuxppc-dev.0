Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4D022BDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 21:26:38 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
In-Reply-To: <16752.64288.975262.790788@alkaid.it.uu.se>
References: <16752.64288.975262.790788@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1097925801.8965.42.camel@gaston>
Mime-Version: 1.0
Date: Sat, 16 Oct 2004 21:23:21 +1000
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 745x coherency fix for 2.4?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  
> -#ifdef CONFIG_SMP
> -	if ((flags & _PAGE_NO_CACHE) == 0)
> +	if (((flags & _PAGE_NO_CACHE) == 0) &&
> +	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_NEED_COHERENT))
>  		flags |= _PAGE_COHERENT;
> -#endif

Wouldn't your patch result in _not_ setting _PAGE_COHERENT on non-broken
CPUs when CONFIG_SMP is set ?

Ben.
