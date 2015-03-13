Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD831A0B9A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 07:28:40 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B7EE140140
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2015 07:28:39 +1100 (AEDT)
Message-ID: <1426278513.3643.117.camel@redhat.com>
Subject: Re: [PATCH 1/2] powerpc/eeh: Introduce eeh_pe_inject_err()
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 13 Mar 2015 14:28:33 -0600
In-Reply-To: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, agraf@suse.de, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-11 at 17:34 +1100, Gavin Shan wrote:
> The patch defines PCI error types and functions in eeh.h and
> exports function eeh_pe_inject_err(), which will be called by
> VFIO driver to inject the specified PCI error to the indicated
> PE for testing purpose.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h | 24 ++++++++++++++++
>  arch/powerpc/kernel/eeh.c      | 63 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 9de87ce..eb20c62 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -196,6 +196,28 @@ enum {
>  #define EEH_RESET_COMPLETE	4	/* PHB complete reset		*/
>  #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
>  #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
> +#define EEH_ERR_TYPE_32		0	/* 32-bits PCI error	*/
> +#define EEH_ERR_TYPE_64		1	/* 64-bits PCI error	*/
> +#define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
> +#define EEH_ERR_FUNC_LD_MEM_DATA	1
> +#define EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load	*/
> +#define EEH_ERR_FUNC_LD_IO_DATA		3
> +#define EEH_ERR_FUNC_LD_CFG_ADDR	4	/* Config load	*/
> +#define EEH_ERR_FUNC_LD_CFG_DATA	5
> +#define EEH_ERR_FUNC_ST_MEM_ADDR	6	/* Memory store	*/
> +#define EEH_ERR_FUNC_ST_MEM_DATA	7
> +#define EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store	*/
> +#define EEH_ERR_FUNC_ST_IO_DATA		9
> +#define EEH_ERR_FUNC_ST_CFG_ADDR	10	/* Config store	*/
> +#define EEH_ERR_FUNC_ST_CFG_DATA	11
> +#define EEH_ERR_FUNC_DMA_RD_ADDR	12	/* DMA read	*/
> +#define EEH_ERR_FUNC_DMA_RD_DATA	13
> +#define EEH_ERR_FUNC_DMA_RD_MASTER	14
> +#define EEH_ERR_FUNC_DMA_RD_TARGET	15
> +#define EEH_ERR_FUNC_DMA_WR_ADDR	16	/* DMA write	*/
> +#define EEH_ERR_FUNC_DMA_WR_DATA	17
> +#define EEH_ERR_FUNC_DMA_WR_MASTER	18
> +#define EEH_ERR_FUNC_DMA_WR_TARGET	19
>  
>  struct eeh_ops {
>  	char *name;
> @@ -296,6 +318,8 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option);
>  int eeh_pe_get_state(struct eeh_pe *pe);
>  int eeh_pe_reset(struct eeh_pe *pe, int option);
>  int eeh_pe_configure(struct eeh_pe *pe);
> +int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
> +		      unsigned long addr, unsigned long mask);
>  
>  /**
>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 60a0f15ce..dbab1a4 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1657,6 +1657,69 @@ int eeh_pe_configure(struct eeh_pe *pe)
>  }
>  EXPORT_SYMBOL_GPL(eeh_pe_configure);
>  
> +/**
> + * eeh_pe_inject_err - Injecting the specified PCI error to the indicated PE
> + * @pe: the indicated PE
> + * @type: error type
> + * @function: error function
> + * @addr: address
> + * @mask: address mask
> + *
> + * The routine is called to inject the specified PCI error, which
> + * is determined by @type and @function, to the indicated PE for
> + * testing purpose.
> + */
> +int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
> +		      unsigned long addr, unsigned long mask)
> +{
> +	/* Invalid PE ? */
> +	if (!pe)
> +		return -ENODEV;
> +
> +	/* Unsupported operation ? */
> +	if (!eeh_ops || !eeh_ops->err_inject)
> +		return -ENOENT;
> +
> +	/* Check on PCI error type */
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +	case EEH_ERR_TYPE_64:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Check on PCI error function */
> +	switch (func) {
> +	case EEH_ERR_FUNC_LD_MEM_ADDR:
> +	case EEH_ERR_FUNC_LD_MEM_DATA:
> +	case EEH_ERR_FUNC_LD_IO_ADDR:
> +	case EEH_ERR_FUNC_LD_IO_DATA:
> +	case EEH_ERR_FUNC_LD_CFG_ADDR:
> +	case EEH_ERR_FUNC_LD_CFG_DATA:
> +	case EEH_ERR_FUNC_ST_MEM_ADDR:
> +	case EEH_ERR_FUNC_ST_MEM_DATA:
> +	case EEH_ERR_FUNC_ST_IO_ADDR:
> +	case EEH_ERR_FUNC_ST_IO_DATA:
> +	case EEH_ERR_FUNC_ST_CFG_ADDR:
> +	case EEH_ERR_FUNC_ST_CFG_DATA:
> +	case EEH_ERR_FUNC_DMA_RD_ADDR:
> +	case EEH_ERR_FUNC_DMA_RD_DATA:
> +	case EEH_ERR_FUNC_DMA_RD_MASTER:
> +	case EEH_ERR_FUNC_DMA_RD_TARGET:
> +	case EEH_ERR_FUNC_DMA_WR_ADDR:
> +	case EEH_ERR_FUNC_DMA_WR_DATA:
> +	case EEH_ERR_FUNC_DMA_WR_MASTER:
> +	case EEH_ERR_FUNC_DMA_WR_TARGET:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Potentially a good use case for an enum for both type and func.  Then
you could close each enum with a "MAX" entry and simply test type/func <
MAX.  Thanks,

Alex

> +
> +	return eeh_ops->err_inject(pe, type, func, addr, mask);
> +}
> +EXPORT_SYMBOL_GPL(eeh_pe_inject_err);
> +
>  static int proc_eeh_show(struct seq_file *m, void *v)
>  {
>  	if (!eeh_enabled()) {
