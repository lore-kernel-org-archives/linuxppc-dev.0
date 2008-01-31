Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 67FE3DDDED
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:27:43 +1100 (EST)
Message-ID: <47A21543.6060003@scram.de>
Date: Thu, 31 Jan 2008 19:36:51 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Subject: Re: build fails for adder875 for new pulls of powerpc.git
References: <mailman.1812.1201784040.6908.linuxppc-dev@ozlabs.org>
	<39417DF3286A66428FA558987839F44F0356C232@SINTEFXCH01.sintef.no>
	<47A2118B.2060808@scram.de>
In-Reply-To: <47A2118B.2060808@scram.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Rognlien,

> Hi Rognlien,
> 
>> The latest commits to powerpc.git removes commproc.h files used by arch/powerpc/platforms/8xx/adder875.c
>>
>> The kernel fails to build for the adder configs.
> 
> This should fix it:
> 
> diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
> index c6bc078..b49d62a 100644
> --- a/arch/powerpc/platforms/8xx/adder875.c
> +++ b/arch/powerpc/platforms/8xx/adder875.c
> @@ -15,12 +15,12 @@
>  
>  #include <asm/time.h>
>  #include <asm/machdep.h>
> -#include <asm/commproc.h>
> +#include <asm/cpm1.h>
>  #include <asm/fs_pd.h>
>  #include <asm/udbg.h>
>  #include <asm/prom.h>
>  
> -#include <sysdev/commproc.h>
> +#include "mpc8xx.h"
>  
>  struct cpm_pin {
>  	int port, pin, flags;

sorry, this fix was incomplete. Scott Wood just posted a correct fix.

Thanks,
Jochen
