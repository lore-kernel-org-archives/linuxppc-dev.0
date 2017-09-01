Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk7tm6vGhzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 16:02:24 +1000 (AEST)
Message-ID: <1504245709.4974.75.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 6/8] powerpc/xive: introduce H_INT_ESB hcall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 01 Sep 2017 16:01:49 +1000
In-Reply-To: <20170830194617.26621-7-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
 <20170830194617.26621-7-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 21:46 +0200, Cédric Le Goater wrote:
> The H_INT_ESB hcall() is used to issue a load or store to the ESB page
> instead of using the MMIO pages. This can be used as a workaround on
> some HW issues. The OS knows that this hcall should be used on an
> interrupt source when the ESB hcall flag is set to 1 in the hcall
> H_INT_GET_SOURCE_INFO.
> 
> To maintain the frontier between the xive frontend and backend, we
> introduce a new xive operation 'esb_rw' to be used in the routines
> doing memory accesses on the ESBs.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
>  arch/powerpc/include/asm/xive.h          |  1 +
>  arch/powerpc/sysdev/xive/common.c        | 10 ++++++--
>  arch/powerpc/sysdev/xive/spapr.c         | 44 +++++++++++++++++++++++++++++++-
>  arch/powerpc/sysdev/xive/xive-internal.h |  1 +
>  4 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index 64ec9bbcf03e..371fbebf1ec9 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -56,6 +56,7 @@ struct xive_irq_data {
>  #define XIVE_IRQ_FLAG_SHIFT_BUG	0x04
>  #define XIVE_IRQ_FLAG_MASK_FW	0x08
>  #define XIVE_IRQ_FLAG_EOI_FW	0x10
> +#define XIVE_IRQ_FLAG_H_INT_ESB	0x20
>  
>  #define XIVE_INVALID_CHIP_ID	-1
>  
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index ac5f18a66742..8fd58773c241 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -198,7 +198,10 @@ static u8 xive_esb_read(struct xive_irq_data *xd, u32 offset)
>  	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
>  		offset |= offset << 4;
>  
> -	val = in_be64(xd->eoi_mmio + offset);
> +	if ((xd->flags & XIVE_IRQ_FLAG_H_INT_ESB) && xive_ops->esb_rw)
> +		val = xive_ops->esb_rw(xd->hw_irq, offset, 0, 0);
> +	else
> +		val = in_be64(xd->eoi_mmio + offset);
>  
>  	return (u8)val;
>  }
> @@ -209,7 +212,10 @@ static void xive_esb_write(struct xive_irq_data *xd, u32 offset, u64 data)
>  	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
>  		offset |= offset << 4;
>  
> -	out_be64(xd->eoi_mmio + offset, data);
> +	if ((xd->flags & XIVE_IRQ_FLAG_H_INT_ESB) && xive_ops->esb_rw)
> +		xive_ops->esb_rw(xd->hw_irq, offset, data, 1);
> +	else
> +		out_be64(xd->eoi_mmio + offset, data);
>  }
>  
>  #ifdef CONFIG_XMON
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 0fcae7504353..43e9eeb0d39f 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -224,7 +224,46 @@ static long plpar_int_sync(unsigned long flags, unsigned long lisn)
>  	return 0;
>  }
>  
> -#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60)) /* TODO */
> +#define XIVE_ESB_FLAG_STORE (1ull << (63 - 63))
> +
> +static long plpar_int_esb(unsigned long flags,
> +			  unsigned long lisn,
> +			  unsigned long offset,
> +			  unsigned long in_data,
> +			  unsigned long *out_data)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +	long rc;
> +
> +	pr_devel("H_INT_ESB flags=%lx lisn=%lx offset=%lx in=%lx\n",
> +		flags,  lisn, offset, in_data);
> +
> +	rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
> +	if (rc) {
> +		pr_err("H_INT_ESB lisn=%ld offset=%ld returned %ld\n",
> +		       lisn, offset, rc);
> +		return  rc;
> +	}
> +
> +	*out_data = retbuf[0];
> +
> +	return 0;
> +}
> +
> +static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u64 data, bool write)
> +{
> +	unsigned long read_data;
> +	long rc;
> +
> +	rc = plpar_int_esb(write ? XIVE_ESB_FLAG_STORE : 0,
> +			   lisn, offset, data, &read_data);
> +	if (rc)
> +		return -1;
> +
> +	return write ? 0 : read_data;
> +}
> +
> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
>  #define XIVE_SRC_LSI           (1ull << (63 - 61))
>  #define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
>  #define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> @@ -244,6 +283,8 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
>  	if (rc)
>  		return  -EINVAL;
>  
> +	if (flags & XIVE_SRC_H_INT_ESB)
> +		data->flags  |= XIVE_IRQ_FLAG_H_INT_ESB;
>  	if (flags & XIVE_SRC_STORE_EOI)
>  		data->flags  |= XIVE_IRQ_FLAG_STORE_EOI;
>  	if (flags & XIVE_SRC_LSI)
> @@ -487,6 +528,7 @@ static const struct xive_ops xive_spapr_ops = {
>  	.setup_cpu		= xive_spapr_setup_cpu,
>  	.teardown_cpu		= xive_spapr_teardown_cpu,
>  	.sync_source		= xive_spapr_sync_source,
> +	.esb_rw			= xive_spapr_esb_rw,
>  #ifdef CONFIG_SMP
>  	.get_ipi		= xive_spapr_get_ipi,
>  	.put_ipi		= xive_spapr_put_ipi,
> diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysdev/xive/xive-internal.h
> index dd1e2022cce4..f34abed0c05f 100644
> --- a/arch/powerpc/sysdev/xive/xive-internal.h
> +++ b/arch/powerpc/sysdev/xive/xive-internal.h
> @@ -47,6 +47,7 @@ struct xive_ops {
>  	void	(*update_pending)(struct xive_cpu *xc);
>  	void	(*eoi)(u32 hw_irq);
>  	void	(*sync_source)(u32 hw_irq);
> +	u64	(*esb_rw)(u32 hw_irq, u32 offset, u64 data, bool write);
>  #ifdef CONFIG_SMP
>  	int	(*get_ipi)(unsigned int cpu, struct xive_cpu *xc);
>  	void	(*put_ipi)(unsigned int cpu, struct xive_cpu *xc);
