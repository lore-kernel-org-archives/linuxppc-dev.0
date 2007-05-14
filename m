Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D00FDDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:03:52 +1000 (EST)
In-Reply-To: <20070514045404.GP6517@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Mon, 14 May 2007 14:59:31 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -			i-cache-size = <0>;
> -			d-cache-size = <0>;
> +			i-cache-size = <2000000>; /* 32 kB */
> +			d-cache-size = <2000000>; /* 32 kB */

That's 32MB, not 32kB.  Better fix this :-)

>  	UIC0: interrupt-controller0 {

>  	UIC1: interrupt-controller1 {

It's a shame you can't use unit addresses for these since
you use "dcr-reg" instead of "reg".  Oh well.

>  		SDRAM0: sdram {
> -			device_type = "memory-controller";
>  			compatible = "ibm,sdram-440gp", "ibm,sdram";

Maybe rename the node to "memory-controller"?

> +		SRAM0: sram {
> +			compatible = "ibm,sram440gp";
> +			dcr-reg = <020 8 00a 1>;
> +		};

Is this thing _only_ addressable over DCRs?  Weird.

>  		MAL0: mcmal {
> -			device_type = "mcmal-dma";
> +			device_type = "dma-controller";
>  			compatible = "ibm,mcmal-440gp", "ibm,mcmal";

Remove "device_type", change name to "dma-controller"?

>  			EBC0: ebc {
> -				device_type = "ibm,ebc";
>  				compatible = "ibm,ebc-440gp";

You forgot "ibm,ebc" here.


Segher
