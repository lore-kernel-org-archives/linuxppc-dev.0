Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24CA5DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 00:36:47 +1000 (EST)
In-Reply-To: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
References: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 49/61] 8xx: Update device trees.
Date: Thu, 19 Jul 2007 16:36:36 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -			d-cache-line-size = <20>;	// 32 bytes
> -			i-cache-line-size = <20>;	// 32 bytes
> -			d-cache-size = <2000>;		// L1, 8K
> -			i-cache-size = <4000>;		// L1, 16K
> +			d-cache-line-size = <d#32>;
> +			i-cache-line-size = <d#32>;
> +			d-cache-size = <d#8192>;
> +			i-cache-size = <d#16384>;

IMHO this isn't an improvement, but it's your tree :-)
You removed the comment that those caches are L1; is
there an L2 cache on this CPU?

> -		mpc8xx_pic: pic@ff000000 {
> +		PIC: pic@0 {

interrupt-controller@0

> -			cpm_pic: pic@930 {
> +			CPM_PIC: pic@930 {

similar

> +				compatible = "fsl,mpc866-smc-uart",
> +				             "fsl,cpm1-smc-uart",
> +				             "fsl,cpm1-uart",
> +				             "fsl,cpm-smc-uart",
> +				             "fsl,cpm-uart";

Do you need _all_ of these?  :-)

> +				fsl,cpm-brg = <1>;
> +				fsl,cpm-command = <0090>;

Are these two documented?  Your patch queue is too
long for me to check for myself.

> -	soc885@ff000000 {
> +	bcsr@ff080000 {

Maybe use a more generic name, I have no idea what a
"BCSR" is.

Good improvements over all, thank you!


Segher
