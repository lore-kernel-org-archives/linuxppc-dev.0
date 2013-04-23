Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04B1A2C0124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 10:18:19 +1000 (EST)
Message-ID: <1366676290.2886.3.camel@pasglop>
Subject: Re: [PATCH v3 4/12] Move architecture vector definitions to prom.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 10:18:10 +1000
In-Reply-To: <51758306.4000009@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <51758306.4000009@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-22 at 13:35 -0500, Nathan Fontenot wrote:
> As part of handling handling PRRN events we will need to check the
> vector 5 portion of the architecture bits reported in the device tree
> to ensure that PRRN event handling is enabled. In order to do this
> firmware_has_feature is updated (in a subsequent patch) to
> make this check.  To avoid having to re-define bits in the architecture
> vector the bits are moved to prom.h.
> 
> This patch is the first step in updating firmware_has_feature
> by simply moving the bit definitions from prom_init.c to asm/prom.h.
> There are no functional changes.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/include/asm/prom.h |   73 ++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/prom_init.c |   75 +++-------------------------------------
>  2 files changed, 79 insertions(+), 69 deletions(-)
> 
> Index: powerpc/arch/powerpc/include/asm/prom.h
> ===================================================================
> --- powerpc.orig/arch/powerpc/include/asm/prom.h	2013-04-16 21:25:16.000000000 -0500
> +++ powerpc/arch/powerpc/include/asm/prom.h	2013-04-17 13:43:13.000000000 -0500
> @@ -74,6 +74,79 @@
>  #define DRCONF_MEM_AI_INVALID	0x00000040
>  #define DRCONF_MEM_RESERVED	0x00000080
>  
> +#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> +/

The ifdef is unnecessary

> + * There are two methods for telling firmware what our capabilities are.
> + * Newer machines have an "ibm,client-architecture-support" method on the
> + * root node.  For older machines, we have to call the "process-elf-header"
> + * method in the /packages/elf-loader node, passing it a fake 32-bit
> + * ELF header containing a couple of PT_NOTE sections that contain
> + * structures that contain various information.
> + */
> +
> +/* New method - extensible architecture description vector. */
> +
> +/* Option vector bits - generic bits in byte 1 */
> +#define OV_IGNORE		0x80	/* ignore this vector */
> +#define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
> +
> +/* Option vector 1: processor architectures supported */
> +#define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
> +#define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
> +#define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
> +#define OV1_PPC_2_03		0x10	/* set if we support PowerPC 2.03 */
> +#define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
> +#define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
> +#define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
> +#define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
> +
> +/* Option vector 2: Open Firmware options supported */
> +#define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
> +
> +/* Option vector 3: processor options supported */
> +#define OV3_FP			0x80	/* floating point */
> +#define OV3_VMX			0x40	/* VMX/Altivec */
> +#define OV3_DFP			0x20	/* decimal FP */
> +
> +/* Option vector 4: IBM PAPR implementation */
> +#define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
> +
> +/* Option vector 5: PAPR/OF options supported */
> +#define OV5_LPAR		0x80	/* logical partitioning supported */
> +#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
> +/* ibm,dynamic-reconfiguration-memory property supported */
> +#define OV5_DRCONF_MEMORY	0x20
> +#define OV5_LARGE_PAGES		0x10	/* large pages supported */
> +#define OV5_DONATE_DEDICATE_CPU	0x02	/* donate dedicated CPU support */
> +/* PCIe/MSI support.  Without MSI full PCIe is not supported */
> +#ifdef CONFIG_PCI_MSI
> +#define OV5_MSI			0x01	/* PCIe/MSI support */
> +#else
> +#define OV5_MSI			0x00
> +#endif /* CONFIG_PCI_MSI */
> +#ifdef CONFIG_PPC_SMLPAR
> +#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
> +#define OV5_XCMO		0x40	/* Page Coalescing */
> +#else
> +#define OV5_CMO			0x00
> +#define OV5_XCMO		0x00
> +#endif
> +#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
> +#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
> +#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
> +#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
> +#define OV5_SUB_PROCESSORS	0x01	/* 1,2,or 4 Sub-Processors supported */
> +
> +/* Option Vector 6: IBM PAPR hints */
> +#define OV6_LINUX		0x02	/* Linux is our OS */
> +
> +/*
> + * The architecture vector has an array of PVR mask/value pairs,
> + * followed by # option vectors - 1, followed by the option vectors.
> + */
> +extern unsigned char ibm_architecture_vec[];
> +#endif
> +
>  /* These includes are put at the bottom because they may contain things
>   * that are overridden by this file.  Ideally they shouldn't be included
>   * by this file, but there are a bunch of .c files that currently depend
> Index: powerpc/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-04-16 21:25:16.000000000 -0500
> +++ powerpc/arch/powerpc/kernel/prom_init.c	2013-04-17 13:43:13.000000000 -0500
> @@ -627,16 +627,11 @@
>  
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>  /*
> - * There are two methods for telling firmware what our capabilities are.
> - * Newer machines have an "ibm,client-architecture-support" method on the
> - * root node.  For older machines, we have to call the "process-elf-header"
> - * method in the /packages/elf-loader node, passing it a fake 32-bit
> - * ELF header containing a couple of PT_NOTE sections that contain
> - * structures that contain various information.
> - */
> -
> -/*
> - * New method - extensible architecture description vector.
> + * The architecture vector has an array of PVR mask/value pairs,
> + * followed by # option vectors - 1, followed by the option vectors.
> + *
> + * See prom.h for the definition of the bits specified in the
> + * achitecture vector.
>   *
>   * Because the description vector contains a mix of byte and word
>   * values, we declare it as an unsigned char array, and use this
> @@ -645,65 +640,7 @@
>  #define W(x)	((x) >> 24) & 0xff, ((x) >> 16) & 0xff, \
>  		((x) >> 8) & 0xff, (x) & 0xff
>  
> -/* Option vector bits - generic bits in byte 1 */
> -#define OV_IGNORE		0x80	/* ignore this vector */
> -#define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
> -
> -/* Option vector 1: processor architectures supported */
> -#define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
> -#define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
> -#define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
> -#define OV1_PPC_2_03		0x10	/* set if we support PowerPC 2.03 */
> -#define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
> -#define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
> -#define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
> -#define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
> -
> -/* Option vector 2: Open Firmware options supported */
> -#define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
> -
> -/* Option vector 3: processor options supported */
> -#define OV3_FP			0x80	/* floating point */
> -#define OV3_VMX			0x40	/* VMX/Altivec */
> -#define OV3_DFP			0x20	/* decimal FP */
> -
> -/* Option vector 4: IBM PAPR implementation */
> -#define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
> -
> -/* Option vector 5: PAPR/OF options supported */
> -#define OV5_LPAR		0x80	/* logical partitioning supported */
> -#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
> -/* ibm,dynamic-reconfiguration-memory property supported */
> -#define OV5_DRCONF_MEMORY	0x20
> -#define OV5_LARGE_PAGES		0x10	/* large pages supported */
> -#define OV5_DONATE_DEDICATE_CPU 0x02	/* donate dedicated CPU support */
> -/* PCIe/MSI support.  Without MSI full PCIe is not supported */
> -#ifdef CONFIG_PCI_MSI
> -#define OV5_MSI			0x01	/* PCIe/MSI support */
> -#else
> -#define OV5_MSI			0x00
> -#endif /* CONFIG_PCI_MSI */
> -#ifdef CONFIG_PPC_SMLPAR
> -#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
> -#define OV5_XCMO			0x40	/* Page Coalescing */
> -#else
> -#define OV5_CMO			0x00
> -#define OV5_XCMO			0x00
> -#endif
> -#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
> -#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
> -#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
> -#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
> -#define OV5_SUB_PROCESSORS	0x01    /* 1,2,or 4 Sub-Processors supported */
> -
> -/* Option Vector 6: IBM PAPR hints */
> -#define OV6_LINUX		0x02	/* Linux is our OS */
> -
> -/*
> - * The architecture vector has an array of PVR mask/value pairs,
> - * followed by # option vectors - 1, followed by the option vectors.
> - */
> -static unsigned char ibm_architecture_vec[] = {
> +unsigned char ibm_architecture_vec[] = {
>  	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
>  	W(0xffff0000), W(0x003e0000),	/* POWER6 */
>  	W(0xffff0000), W(0x003f0000),	/* POWER7 */
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
