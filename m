Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A728167C1C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 00:07:27 +1000 (EST)
In-Reply-To: <1144213870220-git-send-email-sfr@canb.auug.org.au>
References: <1144213870220-git-send-email-sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F008C883-E78D-46A2-BCC3-359819111899@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/15] powerpc: move asm/ocp_ids.h
Date: Wed, 5 Apr 2006 09:07:49 -0500
To: sfr@canb.auug.org.au
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nack. OCP should not exist in arch/powerpc so leave this header where  
it is.

- k

On Apr 5, 2006, at 12:10 AM, sfr@canb.auug.org.au wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Since the ARCH=powerpc build depends on this file, move it to
> include/asm-powerpc.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> ---
>
>  include/asm-powerpc/ocp_ids.h |   75 ++++++++++++++++++++++++++++++ 
> +++++++++++
>  include/asm-ppc/ocp_ids.h     |   73  
> ----------------------------------------
>  2 files changed, 75 insertions(+), 73 deletions(-)
>  create mode 100644 include/asm-powerpc/ocp_ids.h
>  delete mode 100644 include/asm-ppc/ocp_ids.h
>
> a374f458829d868a3142bff918ef872e0ecff1a8
> diff --git a/include/asm-powerpc/ocp_ids.h b/include/asm-powerpc/ 
> ocp_ids.h
> new file mode 100644
> index 0000000..78e5906
> --- /dev/null
> +++ b/include/asm-powerpc/ocp_ids.h
> @@ -0,0 +1,75 @@
> +#ifndef _ASM_POWERPC_OCP_IDS_H
> +#define _ASM_POWERPC_OCP_IDS_H
> +/*
> + * OCP device ids based on the ideas from PCI
> + *
> + * The numbers below are almost completely arbitrary, and in fact
> + * strings might work better.  -- paulus
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/*
> + * Vender  device
> + * [xxxx]  [xxxx]
> + *
> + *  Keep in order, please
> + */
> +
> +/* Vendor IDs 0x0001 - 0xFFFF copied from pci_ids.h */
> +
> +#define	OCP_VENDOR_INVALID	0x0000
> +#define	OCP_VENDOR_ARM		0x0004
> +#define OCP_VENDOR_FREESCALE	0x1057
> +#define OCP_VENDOR_IBM		0x1014
> +#define OCP_VENDOR_MOTOROLA	OCP_VENDOR_FREESCALE
> +#define	OCP_VENDOR_XILINX	0x10ee
> +#define	OCP_VENDOR_UNKNOWN	0xFFFF
> +
> +/* device identification */
> +
> +/* define type */
> +#define OCP_FUNC_INVALID	0x0000
> +
> +/* system 0x0001 - 0x001F */
> +
> +/* Timers 0x0020 - 0x002F */
> +
> +/* Serial 0x0030 - 0x006F*/
> +#define OCP_FUNC_16550		0x0031
> +#define OCP_FUNC_IIC		0x0032
> +#define OCP_FUNC_USB		0x0033
> +#define OCP_FUNC_PSC_UART	0x0034
> +
> +/* Memory devices 0x0090 - 0x009F */
> +#define OCP_FUNC_MAL		0x0090
> +#define OCP_FUNC_DMA		0x0091
> +
> +/* Display 0x00A0 - 0x00AF */
> +
> +/* Sound 0x00B0 - 0x00BF */
> +
> +/* Mass Storage 0x00C0 - 0xxCF */
> +#define OCP_FUNC_IDE		0x00C0
> +
> +/* Misc 0x00D0 - 0x00DF*/
> +#define OCP_FUNC_GPIO		0x00D0
> +#define OCP_FUNC_ZMII		0x00D1
> +#define OCP_FUNC_PERFMON	0x00D2	/* Performance Monitor */
> +#define OCP_FUNC_RGMII		0x00D3
> +#define OCP_FUNC_TAH		0x00D4
> +#define OCP_FUNC_SEC2		0x00D5	/* Crypto/Security 2.0 */
> +
> +/* Network 0x0200 - 0x02FF */
> +#define OCP_FUNC_EMAC		0x0200
> +#define OCP_FUNC_GFAR		0x0201	/* TSEC & FEC */
> +
> +/* Bridge devices 0xE00 - 0xEFF */
> +#define OCP_FUNC_OPB		0x0E00
> +
> +#define OCP_FUNC_UNKNOWN	0xFFFF
> +
> +#endif /* _ASM_POWERPC_OCP_IDS_H */
> diff --git a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
> deleted file mode 100644
> index 8ae4b31..0000000
> --- a/include/asm-ppc/ocp_ids.h
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/*
> - * ocp_ids.h
> - *
> - * OCP device ids based on the ideas from PCI
> - *
> - * The numbers below are almost completely arbitrary, and in fact
> - * strings might work better.  -- paulus
> - *
> - * This program is free software; you can redistribute  it and/or  
> modify it
> - * under  the terms of  the GNU General  Public License as  
> published by the
> - * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> - * option) any later version.
> - */
> -
> -/*
> - * Vender  device
> - * [xxxx]  [xxxx]
> - *
> - *  Keep in order, please
> - */
> -
> -/* Vendor IDs 0x0001 - 0xFFFF copied from pci_ids.h */
> -
> -#define	OCP_VENDOR_INVALID	0x0000
> -#define	OCP_VENDOR_ARM		0x0004
> -#define OCP_VENDOR_FREESCALE	0x1057
> -#define OCP_VENDOR_IBM		0x1014
> -#define OCP_VENDOR_MOTOROLA	OCP_VENDOR_FREESCALE
> -#define	OCP_VENDOR_XILINX	0x10ee
> -#define	OCP_VENDOR_UNKNOWN	0xFFFF
> -
> -/* device identification */
> -
> -/* define type */
> -#define OCP_FUNC_INVALID	0x0000
> -
> -/* system 0x0001 - 0x001F */
> -
> -/* Timers 0x0020 - 0x002F */
> -
> -/* Serial 0x0030 - 0x006F*/
> -#define OCP_FUNC_16550		0x0031
> -#define OCP_FUNC_IIC		0x0032
> -#define OCP_FUNC_USB		0x0033
> -#define OCP_FUNC_PSC_UART	0x0034
> -
> -/* Memory devices 0x0090 - 0x009F */
> -#define OCP_FUNC_MAL		0x0090
> -#define OCP_FUNC_DMA		0x0091
> -
> -/* Display 0x00A0 - 0x00AF */
> -
> -/* Sound 0x00B0 - 0x00BF */
> -
> -/* Mass Storage 0x00C0 - 0xxCF */
> -#define OCP_FUNC_IDE		0x00C0
> -
> -/* Misc 0x00D0 - 0x00DF*/
> -#define OCP_FUNC_GPIO		0x00D0
> -#define OCP_FUNC_ZMII		0x00D1
> -#define OCP_FUNC_PERFMON	0x00D2	/* Performance Monitor */
> -#define OCP_FUNC_RGMII		0x00D3
> -#define OCP_FUNC_TAH		0x00D4
> -#define OCP_FUNC_SEC2		0x00D5	/* Crypto/Security 2.0 */
> -
> -/* Network 0x0200 - 0x02FF */
> -#define OCP_FUNC_EMAC		0x0200
> -#define OCP_FUNC_GFAR		0x0201	/* TSEC & FEC */
> -
> -/* Bridge devices 0xE00 - 0xEFF */
> -#define OCP_FUNC_OPB		0x0E00
> -
> -#define OCP_FUNC_UNKNOWN	0xFFFF
> -- 
> 1.2.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
