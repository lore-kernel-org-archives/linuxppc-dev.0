Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DB51DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 14:39:48 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l764frDo1753238
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 14:41:53 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l764csxl263274
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 14:38:54 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l764dl6M002641
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 14:39:47 +1000
Date: Mon, 6 Aug 2007 14:38:55 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 04/10] 4xx bootwrapper reworks
Message-ID: <20070806043855.GF6103@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161710.676644000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070803161710.676644000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 11:09:04AM -0500, Josh Boyer wrote:
> Make the fixup_memsize function common for all of 4xx as several chips share
> the same SDRAM controller.  Also add functions to reset 40x chips and quiesce
> the ethernet.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/boot/44x.h   |    4 ----
>  arch/powerpc/boot/4xx.c   |   36 +++++++++++++++++++++++++++++++-----
>  arch/powerpc/boot/4xx.h   |   20 ++++++++++++++++++++
>  arch/powerpc/boot/dcr.h   |    2 ++
>  arch/powerpc/boot/ebony.c |    3 ++-
>  5 files changed, 55 insertions(+), 10 deletions(-)
> 
> --- linux-2.6.orig/arch/powerpc/boot/44x.h
> +++ linux-2.6/arch/powerpc/boot/44x.h
> @@ -10,10 +10,6 @@
>  #ifndef _PPC_BOOT_44X_H_
>  #define _PPC_BOOT_44X_H_
>  
> -void ibm44x_fixup_memsize(void);
> -void ibm4xx_fixup_ebc_ranges(const char *ebc);
> -
> -void ibm44x_dbcr_reset(void);
>  void ebony_init(void *mac0, void *mac1);
>  
>  #endif /* _PPC_BOOT_44X_H_ */
> --- linux-2.6.orig/arch/powerpc/boot/4xx.c
> +++ linux-2.6/arch/powerpc/boot/4xx.c
> @@ -21,8 +21,8 @@
>  #include "reg.h"
>  #include "dcr.h"
>  
> -/* Read the 44x memory controller to get size of system memory. */
> -void ibm44x_fixup_memsize(void)
> +/* Read the 4xx SDRAM controller to get size of system memory. */
> +void ibm4xx_fixup_memsize(void)
>  {
>  	int i;
>  	unsigned long memsize, bank_config;
> @@ -39,22 +39,48 @@ void ibm44x_fixup_memsize(void)
>  	dt_fixup_memory(0, memsize);
>  }
>  
> -#define SPRN_DBCR0		0x134
> -#define   DBCR0_RST_SYSTEM	0x30000000
> +#define DBCR0_RST_SYSTEM 0x30000000

Rather than just removing these defines and using hardcoded values,
I'd prefer to see separate SPRN_DBCR0_40X and SPRN_DBCR0_44X defines.

[snip]
> +#define EMAC_RESET 0x20000000
> +#define MAL_RESET 0x80000000

I think the MAL_RESET definition should go in the same place as the
DCR number definition.

> +void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1)
> +{

As I think I said before, I'm not really happy with this being
hardcoded assuming exactly 2 ethernets.

> +	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us */
> +	if (emac0)
> +		*emac0 = EMAC_RESET;
> +	if (emac1)
> +		*emac1 = EMAC_RESET;
> +
> +	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
> +}
[snip]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
