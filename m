Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1987EDDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 04:11:54 +1100 (EST)
In-Reply-To: <20070110011200.20342.5712.stgit@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<20070110011200.20342.5712.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <628EF2F5-2700-4CB9-B1E4-3DB225232AE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads
Date: Wed, 10 Jan 2007 11:11:05 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2007, at 7:12 PM, Vitaly Bordug wrote:

>
> Recent update of asm-powerpc/io.h caused cpm-related stuff to break  
> in the
> current kernel. Current patch fixes it, and includes other overhaul  
> and
> improvements (incomplete list is below). Required for proper  
> functioning of
> the 8xx stuff as well.
>
> - Updated dts with a chosen node with interrupt controller,
> - fixed messed device IDs among CPM2 SoC devices,
> - corrected odd header name and fixed type in defines,
> - Added 82xx subdir to the powerpc/platforms Makefile, new
>   solely-powerpc header for 8260 family (was using one from arch/ 
> ppc, this
>   one cleaned up from the extra stuff).
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
>
>  arch/powerpc/platforms/82xx/mpc82xx.c     |    2 +-
>  arch/powerpc/platforms/82xx/mpc82xx_ads.c |    2 +-
>  arch/powerpc/platforms/82xx/pq2ads.h      |    5 +++--
>  arch/powerpc/platforms/Makefile           |    1 +
>  drivers/net/fs_enet/fs_enet.h             |    1 +
>  drivers/serial/cpm_uart/cpm_uart_cpm1.h   |    3 ---
>  drivers/serial/cpm_uart/cpm_uart_cpm2.h   |    3 ---
>  include/asm-powerpc/fs_pd.h               |    6 ++++++
>  include/asm-powerpc/io.h                  |    6 ++++++
>  9 files changed, 19 insertions(+), 10 deletions(-)

> diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
> index 3d0e819..2ba51b9 100644
> --- a/include/asm-powerpc/fs_pd.h
> +++ b/include/asm-powerpc/fs_pd.h
> @@ -25,6 +25,12 @@ static inline int uart_clock(void)
>          return ppc_proc_freq;
>  }
>
> +#if defined(CONFIG_8260)
> +#include <asm/mpc8260.h>
> +#elif defined(CONFIG_85xx)
> +#include <asm/mpc85xx.h>
> +#endif
> +

what do we need these includes for?

>  #define cpm2_map(member)						\
>  ({									\
>  	u32 offset = offsetof(cpm2_map_t, member);			\

- k
