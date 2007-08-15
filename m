Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 59808DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 08:23:39 +1000 (EST)
Date: Thu, 16 Aug 2007 00:23:37 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: fix i2c device string format
In-Reply-To: <46C3701E.3090205@freescale.com>
Message-ID: <Pine.LNX.4.60.0708160016040.10160@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
	<Pine.LNX.4.60.0708092233130.5995@poirot.grange>
	<18114.39893.913684.592560@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0708152106090.10160@poirot.grange>
	<46C3701E.3090205@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 15 Aug 2007, Scott Wood wrote:

> BTW, is there any reason this stuff is fsl_soc specific?  I'd think
> prom_parse.c (or better yet, drivers/of/ or drivers/i2c/, now that some OF
> calls have been factored out) would be a better place.

Minimal intrusion:-) Initially in your patch you added the 
of_register_i2c_devices() function to prom_parse.c, of_find_i2c_driver() 
is just an abstracted out search function, that is practically inlined in 
the former one. I moved of_register_i2c_devices() into fsl_soc.c because 
that's where its only (ATM) caller fsl_i2c_of_init() is. So, this way it's 
all nicely inlined by the compiler, and we don't need any external 
functions... If we get another user of this function, sure, we can move it 
out. So far no other i2c bus driver is trying to parse OF i2c tree.

Thanks
Guennadi
---
Guennadi Liakhovetski
