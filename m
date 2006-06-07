Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9374567BCA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 09:05:48 +1000 (EST)
In-Reply-To: <1149645693.27572.90.camel@localhost.localdomain>
References: <1149645693.27572.90.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <406DD901-DC8E-4755-8755-A16C8006E64D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix call to ibm,client-architecture-support
Date: Thu, 8 Jun 2006 01:07:09 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The code in prom_init.c calling the firmware
> ibm,client-architecture-support on pSeries has a bug where it fails to
> properly pass the instance handle of the firmware object when  
> trying to
> call a method. Result ranges from the call doing nothing to the  
> firmware
> crashing. (Found by Segher, thanks !)

Dry debugging is one of the most fun things in the world, second
only to reverse engineering.  Am I pathetic or what?

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

> Index: linux-work/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-05-30  
> 13:00:51.000000000 +1000
> +++ linux-work/arch/powerpc/kernel/prom_init.c	2006-06-06  
> 11:59:20.000000000 +1000
> @@ -822,6 +822,7 @@ static void __init prom_send_capabilitie
>  		/* try calling the ibm,client-architecture-support method */
>  		if (call_prom_ret("call-method", 3, 2, &ret,
>  				  ADDR("ibm,client-architecture-support"),
> +				  root,
>  				  ADDR(ibm_architecture_vec)) == 0) {
>  			/* the call exists... */
>  			if (ret)
