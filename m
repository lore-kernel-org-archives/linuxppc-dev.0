Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 399D667F36
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 09:32:05 +1000 (EST)
Date: Sat, 6 Aug 2005 20:27:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050806232701.GD1099@dmt.cnet>
References: <20050806180353.GW5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050806180353.GW5210@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Aris,

It already is exported, declared as

commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to comm processor */


and many drivers use the pointer directly.

arch/ppc/8260_io/ drivers also use the same convention.

Not sure I see much advantage in changing it?

On Sat, Aug 06, 2005 at 03:03:53PM -0300, Aristeu Sergio Rozanski Filho wrote:
> 8xx: add cpm_get_cpmp() to make cpmp visible to modules
> 
> Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
> 
> Index: 2.6-8xx/arch/ppc/8xx_io/commproc.c
> ===================================================================
> --- 2.6-8xx.orig/arch/ppc/8xx_io/commproc.c	2005-08-03 17:26:05.000000000 -0300
> +++ 2.6-8xx/arch/ppc/8xx_io/commproc.c	2005-08-05 17:13:21.000000000 -0300
> @@ -462,3 +462,10 @@
>  	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
>  }
>  EXPORT_SYMBOL(cpm_dpram_addr);
> +
> +cpm8xx_t *cpm_get_cpmp(void)
> +{
> +	return cpmp;
> +}
> +EXPORT_SYMBOL(cpm_get_cpmp);
> +
> Index: 2.6-8xx/include/asm/commproc.h
> ===================================================================
> --- 2.6-8xx.orig/include/asm/commproc.h	2005-07-28 12:06:51.000000000 -0300
> +++ 2.6-8xx/include/asm/commproc.h	2005-08-05 17:14:28.000000000 -0300
> @@ -78,6 +78,7 @@
>  extern void cpm_dpdump(void);
>  extern void *cpm_dpram_addr(uint offset);
>  extern void cpm_setbrg(uint brg, uint rate);
> +extern cpm8xx_t *cpm_get_cpmp(void);
>  
>  extern uint m8xx_cpm_hostalloc(uint size);
>  extern int  m8xx_cpm_hostfree(uint start);
