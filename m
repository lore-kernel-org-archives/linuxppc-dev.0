Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0030EDDFF8
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:14:05 +1100 (EST)
Message-Id: <C6C3D8D0-E412-420B-BF09-A98F5880E06A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <47A2118B.2060808@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: build fails for adder875 for new pulls of powerpc.git
Date: Thu, 31 Jan 2008 13:13:24 -0600
References: <mailman.1812.1201784040.6908.linuxppc-dev@ozlabs.org>
	<39417DF3286A66428FA558987839F44F0356C232@SINTEFXCH01.sintef.no>
	<47A2118B.2060808@scram.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 12:20 PM, Jochen Friedrich wrote:

> Hi Rognlien,
>
>> The latest commits to powerpc.git removes commproc.h files used by  
>> arch/powerpc/platforms/8xx/adder875.c
>>
>> The kernel fails to build for the adder configs.
>
> This should fix it:
>
> diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/ 
> platforms/8xx/adder875.c
> index c6bc078..b49d62a 100644
> --- a/arch/powerpc/platforms/8xx/adder875.c
> +++ b/arch/powerpc/platforms/8xx/adder875.c
> @@ -15,12 +15,12 @@
>
> #include <asm/time.h>
> #include <asm/machdep.h>
> -#include <asm/commproc.h>
> +#include <asm/cpm1.h>
> #include <asm/fs_pd.h>
> #include <asm/udbg.h>
> #include <asm/prom.h>
>
> -#include <sysdev/commproc.h>
> +#include "mpc8xx.h"
>
> struct cpm_pin {
> 	int port, pin, flags;
>
> Thanks,
> Jochen

I'll take scott's version as its more complete and fixes another board.

- k
