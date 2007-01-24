Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC52CDE078
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:57:46 +1100 (EST)
In-Reply-To: <20070124191927.3033.60973.stgit@localhost.localdomain>
References: <20070124191552.3033.93568.stgit@localhost.localdomain>
	<20070124191927.3033.60973.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75A90F7F-60B5-45CC-ACEB-109672475283@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] POWERPC] cpm2: CPM2 interrupt controller fix
Date: Wed, 24 Jan 2007 15:56:42 -0600
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


On Jan 24, 2007, at 1:19 PM, Vitaly Bordug wrote:

>
> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the  
> interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors. Fixed all the sense  
> values to
> keep coherency with ipic. In the current code, CPM2 stuff will have  
> no IRQs
> and hence could be hardly usable.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
>
>  arch/powerpc/boot/dts/mpc8272ads.dts |   47 +++++++-----
>  arch/powerpc/boot/dts/mpc8560ads.dts |   10 +-
>  arch/powerpc/sysdev/cpm2_pic.c       |  138 ++++++++++++++++++ 
> +---------------
>  arch/powerpc/sysdev/cpm2_pic.h       |    9 ++
>  include/asm-powerpc/mpc8260.h        |   24 ++++++
>  5 files changed, 142 insertions(+), 86 deletions(-)

[snip]

> diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/ 
> cpm2_pic.h
> index 2840616..643a857 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.h
> +++ b/arch/powerpc/sysdev/cpm2_pic.h
> @@ -1,6 +1,15 @@
>  #ifndef _PPC_KERNEL_CPM2_H
>  #define _PPC_KERNEL_CPM2_H
>
> +
> +/* External IRQS */
> +#define CPM2_IRQ_EXT1		19
> +#define CPM2_IRQ_EXT7		25
> +
> +/* Port C IRQS */
> +#define CPM2_IRQ_PORTC15	48
> +#define CPM2_IRQ_PORTC0		63
> +

Let's just add these defines in the .c since they aren't needed by  
anyone else.

>  extern intctl_cpm2_t *cpm2_intctl;

Can you explain the logic here with cpm2_intctl?  It seems like  
cpm2_reset sets this pointer and that's it.  Would it make more sense  
to just have cpm2_pic_init use cpm2_immr and keep cpm2_intctl static  
to cpm2_pic.c?

>  extern unsigned int cpm2_get_irq(void);

Also, we should think about moving cpm2_cascade() from 85xx into  
cpm2_pic.c/h

- kumar
