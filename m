Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1937CDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 01:40:51 +1100 (EST)
Message-Id: <D6AED5C1-6936-48BB-8D0F-98471C6841B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Ocker <weo@reccoware.de>
In-Reply-To: <1224772209.4082.61.camel@galileo.recco.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc: Specify GPIO number base for controller in DT
Date: Thu, 23 Oct 2008 09:40:45 -0500
References: <1224764850.4082.54.camel@galileo.recco.de>
	<5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
	<1224772209.4082.61.camel@galileo.recco.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2008, at 9:30 AM, Wolfgang Ocker wrote:

> --- linux-2.6.27.2/Documentation/powerpc/booting-without- 
> of.txt.of_gpiospecbase	2008-10-18 19:57:22.000000000 +0200
> +++ linux-2.6.27.2/Documentation/powerpc/booting-without-of.txt	 
> 2008-10-23 16:23:07.000000000 +0200
> @@ -2580,12 +2582,17 @@
> Every GPIO controller node must have #gpio-cells property defined,
> this information will be used to translate gpio-specifiers.
>
> +Optional properties:
> +	base: first GPIO number handled by this controller; default is -1,
> +		meaning dynamic ID allocation

"default -1" doesn't make any sense.  I assume you mean if the  
property doesn't it exist the behavior is "dynamic ID allocation"

>
> +
> Example of two SOC GPIO banks defined as gpio-controller nodes:
>
> 	qe_pio_a: gpio-controller@1400 {
> 		#gpio-cells = <2>;
> 		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
> 		reg = <0x1400 0x18>;
> +		base = < 0x20 >;
> 		gpio-controller;
> 	};
>
