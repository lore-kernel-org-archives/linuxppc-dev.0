Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E10067BB2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 14:48:46 +1000 (EST)
In-Reply-To: <1149720157.23938.202.camel@cashmere.sps.mot.com>
References: <1149720157.23938.202.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <542A1CA4-6A5A-41DA-98D2-C61D5376B761@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 7/10] Add use of mpc86xx.h include files in legacy header
	files.
Date: Wed, 7 Jun 2006 23:49:07 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 7, 2006, at 5:42 PM, Jon Loeliger wrote:

>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>
> ---
>
>  include/asm-ppc/io.h      |    2 ++
>  include/asm-ppc/ppc_sys.h |    2 ++
>  include/asm-ppc/serial.h  |    2 ++
>  3 files changed, 6 insertions(+), 0 deletions(-)

Are the io.h & serial.h really needed for ARCH=powerpc?  What does  
serial.h get from asm/mpc86xx.h?  I can see the possibility of io.h  
needing some stuff from asm/mpc86xx.h

- k

>
> diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
> index b919d8f..0802be9 100644
> --- a/include/asm-ppc/io.h
> +++ b/include/asm-ppc/io.h
> @@ -37,6 +37,8 @@ #elif defined(CONFIG_83xx)
>  #include <asm/mpc83xx.h>
>  #elif defined(CONFIG_85xx)
>  #include <asm/mpc85xx.h>
> +#elif defined(CONFIG_PPC_86xx)
> +#include <asm/mpc86xx.h>
>  #elif defined(CONFIG_APUS)
>  #define _IO_BASE	0
>  #define _ISA_MEM_BASE	0
> diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
> index 40f197a..4eaf80d 100644
> --- a/include/asm-ppc/ppc_sys.h
> +++ b/include/asm-ppc/ppc_sys.h
> @@ -27,6 +27,8 @@ #elif defined(CONFIG_83xx)
>  #include <asm/mpc83xx.h>
>  #elif defined(CONFIG_85xx)
>  #include <asm/mpc85xx.h>
> +#elif defined(CONFIG_PPC_86xx)
> +#include <asm/mpc86xx.h>

this should go since I can't imagine your using ppc_sys.

>  #elif defined(CONFIG_8xx)
>  #include <asm/mpc8xx.h>
>  #elif defined(CONFIG_PPC_MPC52xx)
> diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
> index b74af54..e819250 100644
> --- a/include/asm-ppc/serial.h
> +++ b/include/asm-ppc/serial.h
> @@ -36,6 +36,8 @@ #elif defined(CONFIG_83xx)
>  #include <asm/mpc83xx.h>
>  #elif defined(CONFIG_85xx)
>  #include <asm/mpc85xx.h>
> +#elif defined(CONFIG_PPC_86xx)
> +#include <asm/mpc86xx.h>
>  #elif defined(CONFIG_RADSTONE_PPC7D)
>  #include <platforms/radstone_ppc7d.h>
>  #else
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
