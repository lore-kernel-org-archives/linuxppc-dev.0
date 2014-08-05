Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A5261A019A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 07:38:03 +1000 (EST)
Message-ID: <1407274663.7427.7.camel@snotra.buserror.net>
Subject: Re: [PATCH] fsl-rio: add support for mapping inbound windows
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Date: Tue, 5 Aug 2014 16:37:43 -0500
In-Reply-To: <1407246752-21639-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
References: <1407246752-21639-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Alexandre.Bounine@idt.com, Liu Gang <Gang.Liu@freescale.com>,
 Barry.Wood@idt.com, linuxppc-dev@lists.ozlabs.org,
 stef.van.os@prodrive-technologies.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 15:52 +0200, Martijn de Gouw wrote:
> Add support for mapping and unmapping of inbound rapidio windows.
> 
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>

Could you elaborate in the changelog on what this fixes or makes
possible?  E.g. did the driver previously not support inbound
transactions at all, or did it assume the window was set up by a
bootloader?

Liu Gang, could you review this?

-Scott

> ---
>  arch/powerpc/sysdev/fsl_rio.c |  104 +++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_rio.h |   13 ++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
> index c04b718..08d60f1 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -58,6 +58,19 @@
>  #define RIO_ISR_AACR		0x10120
>  #define RIO_ISR_AACR_AA		0x1	/* Accept All ID */
>  
> +#define RIWTAR_TRAD_VAL_SHIFT	12
> +#define RIWTAR_TRAD_MASK	0x00FFFFFF
> +#define RIWBAR_BADD_VAL_SHIFT	12
> +#define RIWBAR_BADD_MASK	0x003FFFFF
> +#define RIWAR_ENABLE		0x80000000
> +#define RIWAR_TGINT_LOCAL	0x00F00000
> +#define RIWAR_RDTYP_NO_SNOOP	0x00040000
> +#define RIWAR_RDTYP_SNOOP	0x00050000
> +#define RIWAR_WRTYP_NO_SNOOP	0x00004000
> +#define RIWAR_WRTYP_SNOOP	0x00005000
> +#define RIWAR_WRTYP_ALLOC	0x00006000
> +#define RIWAR_SIZE_MASK		0x0000003F
> +
>  #define __fsl_read_rio_config(x, addr, err, op)		\
>  	__asm__ __volatile__(				\
>  		"1:	"op" %1,0(%2)\n"		\
> @@ -266,6 +279,89 @@ fsl_rio_config_write(struct rio_mport *mport, int index, u16 destid,
>  	return 0;
>  }
>  
> +static void fsl_rio_inbound_mem_init(struct rio_priv *priv)
> +{
> +	int i;
> +
> +	/* close inbound windows */
> +	for (i = 0; i < RIO_INB_ATMU_COUNT; i++)
> +		out_be32(&priv->inb_atmu_regs[i].riwar, 0);
> +}
> +
> +int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
> +	u64 rstart, u32 size, u32 flags)
> +{
> +	struct rio_priv *priv = mport->priv;
> +	u32 base_size;
> +	unsigned int base_size_log;
> +	u64 win_start, win_end;
> +	u32 riwar;
> +	int i;
> +
> +	if ((size & (size - 1)) != 0)
> +		return -EINVAL;
> +
> +	base_size_log = ilog2(size);
> +	base_size = 1 << base_size_log;
> +
> +	/* check if addresses are aligned with the window size */
> +	if (lstart & (base_size - 1))
> +		return -EINVAL;
> +	if (rstart & (base_size - 1))
> +		return -EINVAL;
> +
> +	/* check for conflicting ranges */
> +	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
> +		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
> +		if ((riwar & RIWAR_ENABLE) == 0)
> +			continue;
> +		win_start = ((u64)(in_be32(&priv->inb_atmu_regs[i].riwbar) & RIWBAR_BADD_MASK))
> +			<< RIWBAR_BADD_VAL_SHIFT;
> +		win_end = win_start + ((1 << ((riwar & RIWAR_SIZE_MASK) + 1)) - 1);
> +		if (rstart < win_end && (rstart + size) > win_start)
> +			return -EINVAL;
> +	}
> +
> +	/* find unused atmu */
> +	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
> +		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
> +		if ((riwar & RIWAR_ENABLE) == 0)
> +			break;
> +	}
> +	if (i >= RIO_INB_ATMU_COUNT)
> +		return -ENOMEM;
> +
> +	out_be32(&priv->inb_atmu_regs[i].riwtar, lstart >> RIWTAR_TRAD_VAL_SHIFT);
> +	out_be32(&priv->inb_atmu_regs[i].riwbar, rstart >> RIWBAR_BADD_VAL_SHIFT);
> +	out_be32(&priv->inb_atmu_regs[i].riwar, RIWAR_ENABLE | RIWAR_TGINT_LOCAL |
> +		RIWAR_RDTYP_SNOOP | RIWAR_WRTYP_SNOOP | (base_size_log - 1));
> +
> +	return 0;
> +}
> +
> +void fsl_unmap_inb_mem(struct rio_mport *mport, dma_addr_t lstart)
> +{
> +	u32 win_start_shift, base_start_shift;
> +	struct rio_priv *priv = mport->priv;
> +	u32 riwar, riwtar;
> +	int i;
> +
> +	/* skip default window */
> +	base_start_shift = lstart >> RIWTAR_TRAD_VAL_SHIFT;
> +	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
> +		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
> +		if ((riwar & RIWAR_ENABLE) == 0)
> +			continue;
> +
> +		riwtar = in_be32(&priv->inb_atmu_regs[i].riwtar);
> +		win_start_shift = riwtar & RIWTAR_TRAD_MASK;
> +		if (win_start_shift == base_start_shift) {
> +			out_be32(&priv->inb_atmu_regs[i].riwar, riwar & ~RIWAR_ENABLE);
> +			return;
> +		}
> +	}
> +}
> +
>  void fsl_rio_port_error_handler(int offset)
>  {
>  	/*XXX: Error recovery is not implemented, we just clear errors */
> @@ -389,6 +485,8 @@ int fsl_rio_setup(struct platform_device *dev)
>  	ops->add_outb_message = fsl_add_outb_message;
>  	ops->add_inb_buffer = fsl_add_inb_buffer;
>  	ops->get_inb_message = fsl_get_inb_message;
> +	ops->map_inb = fsl_map_inb_mem;
> +	ops->unmap_inb = fsl_unmap_inb_mem;
>  
>  	rmu_node = of_parse_phandle(dev->dev.of_node, "fsl,srio-rmu-handle", 0);
>  	if (!rmu_node) {
> @@ -602,6 +700,11 @@ int fsl_rio_setup(struct platform_device *dev)
>  			RIO_ATMU_REGS_PORT2_OFFSET));
>  
>  		priv->maint_atmu_regs = priv->atmu_regs + 1;
> +		priv->inb_atmu_regs = (struct rio_inb_atmu_regs __iomem *)
> +			(priv->regs_win +
> +			((i == 0) ? RIO_INB_ATMU_REGS_PORT1_OFFSET :
> +			RIO_INB_ATMU_REGS_PORT2_OFFSET));
> +
>  
>  		/* Set to receive any dist ID for serial RapidIO controller. */
>  		if (port->phy_type == RIO_PHY_SERIAL)
> @@ -620,6 +723,7 @@ int fsl_rio_setup(struct platform_device *dev)
>  		rio_law_start = range_start;
>  
>  		fsl_rio_setup_rmu(port, rmu_np[i]);
> +		fsl_rio_inbound_mem_init(priv);
>  
>  		dbell->mport[i] = port;
>  
> diff --git a/arch/powerpc/sysdev/fsl_rio.h b/arch/powerpc/sysdev/fsl_rio.h
> index ae8e274..d53407a 100644
> --- a/arch/powerpc/sysdev/fsl_rio.h
> +++ b/arch/powerpc/sysdev/fsl_rio.h
> @@ -50,9 +50,12 @@
>  #define RIO_S_DBELL_REGS_OFFSET	0x13400
>  #define RIO_S_PW_REGS_OFFSET	0x134e0
>  #define RIO_ATMU_REGS_DBELL_OFFSET	0x10C40
> +#define RIO_INB_ATMU_REGS_PORT1_OFFSET 0x10d60
> +#define RIO_INB_ATMU_REGS_PORT2_OFFSET 0x10f60
>  
>  #define MAX_MSG_UNIT_NUM	2
>  #define MAX_PORT_NUM		4
> +#define RIO_INB_ATMU_COUNT	4
>  
>  struct rio_atmu_regs {
>  	 u32 rowtar;
> @@ -63,6 +66,15 @@ struct rio_atmu_regs {
>  	 u32 pad2[3];
>  };
>  
> +struct rio_inb_atmu_regs {
> +	u32 riwtar;
> +	u32 pad1;
> +	u32 riwbar;
> +	u32 pad2;
> +	u32 riwar;
> +	u32 pad3[3];
> +};
> +
>  struct rio_dbell_ring {
>  	void *virt;
>  	dma_addr_t phys;
> @@ -99,6 +111,7 @@ struct rio_priv {
>  	void __iomem *regs_win;
>  	struct rio_atmu_regs __iomem *atmu_regs;
>  	struct rio_atmu_regs __iomem *maint_atmu_regs;
> +	struct rio_inb_atmu_regs __iomem *inb_atmu_regs;
>  	void __iomem *maint_win;
>  	void *rmm_handle; /* RapidIO message manager(unit) Handle */
>  };
