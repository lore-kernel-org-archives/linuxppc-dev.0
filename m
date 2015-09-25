Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4F911A0024
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 09:02:09 +1000 (AEST)
Date: Fri, 25 Sep 2015 18:01:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <madalin.bucur@freescale.com>
Subject: Re: [V5, 2/6] fsl/fman: Add FMan support
Message-ID: <20150925230153.GA4626@home.buserror.net>
References: <1442836354-5445-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442836354-5445-1-git-send-email-igal.liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 02:52:34PM +0300, Igal.Liberman wrote:
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> new file mode 100644
> index 0000000..924685f
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -0,0 +1,2738 @@
> +/*
> + * Copyright 2008-2015 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> +//  *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.

What is that // doing there?

> +/* Exceptions bit map */
> +#define EX_DMA_BUS_ERROR		0x80000000
> +#define EX_DMA_READ_ECC			0x40000000
> +#define EX_DMA_SYSTEM_WRITE_ECC	0x20000000
> +#define EX_DMA_FM_WRITE_ECC		0x10000000
> +#define EX_FPM_STALL_ON_TASKS		0x08000000
> +#define EX_FPM_SINGLE_ECC		0x04000000
> +#define EX_FPM_DOUBLE_ECC		0x02000000
> +#define EX_QMI_SINGLE_ECC		0x01000000
> +#define EX_QMI_DEQ_FROM_UNKNOWN_PORTID	0x00800000
> +#define EX_QMI_DOUBLE_ECC		0x00400000
> +#define EX_BMI_LIST_RAM_ECC		0x00200000
> +#define EX_BMI_STORAGE_PROFILE_ECC	0x00100000
> +#define EX_BMI_STATISTICS_RAM_ECC	0x00080000
> +#define EX_IRAM_ECC			0x00040000
> +#define EX_MURAM_ECC			0x00020000
> +#define EX_BMI_DISPATCH_RAM_ECC	0x00010000
> +#define EX_DMA_SINGLE_PORT_ECC		0x00008000
> +
> +#define DFLT_EXCEPTIONS	\
> +	 ((EX_DMA_BUS_ERROR)            | \
> +	  (EX_DMA_READ_ECC)              | \
> +	  (EX_DMA_SYSTEM_WRITE_ECC)      | \
> +	  (EX_DMA_FM_WRITE_ECC)          | \
> +	  (EX_FPM_STALL_ON_TASKS)        | \
> +	  (EX_FPM_SINGLE_ECC)            | \
> +	  (EX_FPM_DOUBLE_ECC)            | \
> +	  (EX_QMI_DEQ_FROM_UNKNOWN_PORTID) | \
> +	  (EX_BMI_LIST_RAM_ECC)          | \
> +	  (EX_BMI_STORAGE_PROFILE_ECC)   | \
> +	  (EX_BMI_STATISTICS_RAM_ECC)    | \
> +	  (EX_MURAM_ECC)                 | \
> +	  (EX_BMI_DISPATCH_RAM_ECC)      | \
> +	  (EX_QMI_DOUBLE_ECC)            | \
> +	  (EX_QMI_SINGLE_ECC))

You don't need parentheses around each symbol.

This is only used in one place -- why put the list here rather than in
the place where it's used?

> +struct fman_state_struct {
> +	u8 fm_id;
> +	u16 fm_clk_freq;
> +	struct fman_rev_info rev_info;
> +	bool enabled_time_stamp;
> +	u8 count1_micro_bit;
> +	u8 total_num_of_tasks;
> +	u8 accumulated_num_of_tasks;
> +	u32 accumulated_fifo_size;
> +	u8 accumulated_num_of_open_dmas;
> +	u8 accumulated_num_of_deq_tnums;
> +	bool low_end_restriction;
> +	u32 exceptions;
> +	u32 extra_fifo_pool_size;
> +	u8 extra_tasks_pool_size;
> +	u8 extra_open_dmas_pool_size;
> +	u16 port_mfl[MAX_NUM_OF_MACS];
> +	u16 mac_mfl[MAX_NUM_OF_MACS];
> +
> +	/* SOC specific */
> +	u32 fm_iram_size;
> +	/* DMA */
> +	u32 dma_thresh_max_commq;
> +	u32 dma_thresh_max_buf;
> +	u32 max_num_of_open_dmas;
> +	/* QMI */
> +	u32 qmi_max_num_of_tnums;
> +	u32 qmi_def_tnums_thresh;
> +	/* BMI */
> +	u32 bmi_max_num_of_tasks;
> +	u32 bmi_max_fifo_size;
> +	/* General */
> +	u32 fm_port_num_of_cg;
> +	u32 num_of_rx_ports;
> +	u32 total_fifo_size;
> +
> +	u32 qman_channel_base;
> +	u32 num_of_qman_channels;
> +
> +	struct resource *res;
> +};
> +
> +struct fman_cfg {
> +	u8 disp_limit_tsh;
> +	u8 prs_disp_tsh;
> +	u8 plcr_disp_tsh;
> +	u8 kg_disp_tsh;
> +	u8 bmi_disp_tsh;
> +	u8 qmi_enq_disp_tsh;
> +	u8 qmi_deq_disp_tsh;
> +	u8 fm_ctl1_disp_tsh;
> +	u8 fm_ctl2_disp_tsh;
> +	int dma_cache_override;
> +	enum fman_dma_aid_mode dma_aid_mode;
> +	bool dma_aid_override;
> +	u32 dma_axi_dbg_num_of_beats;
> +	u32 dma_cam_num_of_entries;
> +	u32 dma_watchdog;
> +	u8 dma_comm_qtsh_asrt_emer;
> +	u32 dma_write_buf_tsh_asrt_emer;
> +	u32 dma_read_buf_tsh_asrt_emer;
> +	u8 dma_comm_qtsh_clr_emer;
> +	u32 dma_write_buf_tsh_clr_emer;
> +	u32 dma_read_buf_tsh_clr_emer;
> +	u32 dma_sos_emergency;
> +	int dma_dbg_cnt_mode;
> +	bool dma_stop_on_bus_error;
> +	bool dma_en_emergency;
> +	u32 dma_emergency_bus_select;
> +	int dma_emergency_level;
> +	bool dma_en_emergency_smoother;
> +	u32 dma_emergency_switch_counter;
> +	bool halt_on_external_activ;
> +	bool halt_on_unrecov_ecc_err;
> +	int catastrophic_err;
> +	int dma_err;
> +	bool en_muram_test_mode;
> +	bool en_iram_test_mode;
> +	bool external_ecc_rams_enable;
> +	u16 tnum_aging_period;
> +	u32 exceptions;
> +	u16 clk_freq;
> +	bool pedantic_dma;
> +	u32 cam_base_addr;
> +	u32 fifo_base_addr;
> +	u32 total_fifo_size;
> +	u32 total_num_of_tasks;
> +	bool qmi_deq_option_support;
> +	u32 qmi_def_tnums_thresh;
> +};

Some documentation on this stuff would be nice.

> +static inline u8 hw_port_id_to_sw_port_id(u8 major, u8 hw_port_id)
> +{
> +	u8 sw_port_id = 0;
> +
> +	if (hw_port_id >= BASE_TX_PORTID) {
> +		sw_port_id = hw_port_id - BASE_TX_PORTID;
> +	} else if (hw_port_id >= BASE_RX_PORTID) {
> +		sw_port_id = hw_port_id - BASE_RX_PORTID;
> +	} else {
> +		sw_port_id = 0;
> +		WARN_ON(false);

WARN_ON(false) is a no-op.

> +	}
> +
> +	return sw_port_id;
> +}
> +
> +static void set_port_order_restoration(struct fman_fpm_regs __iomem *fpm_rg,
> +				       u8 port_id)
> +{
> +	u32 tmp = 0;
> +
> +	tmp = (u32)(port_id << FPM_PORT_FM_CTL_PORTID_SHIFT);

Unnecessary cast.  Likewise elsewhere.

> +
> +	tmp |= (FPM_PRT_FM_CTL2 | FPM_PRT_FM_CTL1);
> +
> +	/* order restoration */
> +	if (port_id % 2)
> +		tmp |= (FPM_PRT_FM_CTL1 << FPM_PRC_ORA_FM_CTL_SEL_SHIFT);
> +	else
> +		tmp |= (FPM_PRT_FM_CTL2 << FPM_PRC_ORA_FM_CTL_SEL_SHIFT);

Unnecessary parens.

> +static int clear_iram(struct fman *fman)
> +{
> +	struct fman_iram_regs __iomem *iram;
> +	int i;
> +
> +	iram = (struct fman_iram_regs __iomem *)(fman->base_addr + IMEM_OFFSET);
> +
> +	/* Enable the auto-increment */
> +	out_be32(&iram->iadd, IRAM_IADD_AIE);
> +	while (in_be32(&iram->iadd) != IRAM_IADD_AIE)
> +		;
> +
> +	for (i = 0; i < (fman->state->fm_iram_size / 4); i++)
> +		out_be32(&iram->idata, 0xffffffff);
> +
> +	out_be32(&iram->iadd, fman->state->fm_iram_size - 4);
> +	/* Memory barrier */
> +	mb();

This comment is useless, and was probably inserted to falsely silence
checkpatch.  We know it's a memory barrier.  Explain why it's needed,
especially given that the I/O accessors have their own barrriers.

> +	while (in_be32(&iram->idata) != 0xffffffff)
> +		;

Spin loops waiting for hardware should have timeouts.

> +static int get_module_event(enum fman_event_modules module, u8 mod_id,
> +			    enum fman_intr_type intr_type)
> +{
> +	int event;
> +
> +	switch (module) {
> +	case FMAN_MOD_MAC:
> +			event = (intr_type == FMAN_INTR_TYPE_ERR) ?
> +			(FMAN_EV_ERR_MAC0 + mod_id) :
> +			(FMAN_EV_MAC0 + mod_id);

Use if/else...

> +		break;
> +	case FMAN_MOD_FMAN_CTRL:
> +		if (intr_type == FMAN_INTR_TYPE_ERR)
> +			event = FMAN_EV_CNT;
> +		else
> +			event = (FMAN_EV_FMAN_CTRL_0 + mod_id);
> +		break;

...just like here.

> +	/* Read, modify and write to HW */
> +	tmp = (u32)((fifo / FMAN_BMI_FIFO_UNITS - 1) |
> +		    ((extra_fifo / FMAN_BMI_FIFO_UNITS) <<
> +		    BMI_EXTRA_FIFO_SIZE_SHIFT));

Unnecessary cast.

> +	if (extra_tasks)
> +		fman->state->extra_tasks_pool_size =
> +		(u8)max(fman->state->extra_tasks_pool_size, extra_tasks);

Unnecessary cast.

> +static int fman_init(struct fman *fman)
> +{
> +	struct fman_cfg *cfg = NULL;
> +	struct fman_rg fman_rg;
> +	int err = 0, i;
> +
> +	if (is_init_done(fman->cfg))
> +		return -EINVAL;
> +
> +	fman_rg.bmi_rg = fman->bmi_regs;
> +	fman_rg.qmi_rg = fman->qmi_regs;
> +	fman_rg.fpm_rg = fman->fpm_regs;
> +	fman_rg.dma_rg = fman->dma_regs;

Why keep this information in two different places and formats?

> +	/* Reset the FM if required. */
> +	if (fman->reset_on_init) {

When is this ever not true?

> +		if (fman->state->rev_info.major >= 6) {
> +			/* Errata A007273 */
> +			pr_debug("FManV3 reset is not supported!\n");

No plan to implement the workaround involving DEVDISR2?

> +		} else {
> +			out_be32(&fman->fpm_regs->fm_rstc, FPM_RSTC_FM_RESET);
> +			/* Memory barrier */
> +			mb();
> +			usleep_range(100, 300);
> +		}

Where does 100us come from?  Shouldn't you wait for the FM_RESET bit to
be cleared?

> +
> +		if (!!(ioread32be(&fman_rg.qmi_rg->fmqm_gs) &
> +		    QMI_GS_HALT_NOT_BUSY)) {
> +			resume(fman->fpm_regs);
> +			usleep_range(100, 300);
> +		}

There's no need for !! here.

Same question as above regarding the delay.

> +static int fman_set_exception(struct fman *fman,
> +			      enum fman_exceptions exception, bool enable)
> +{
> +	u32 bit_mask = 0;
> +	struct fman_rg fman_rg;
> +
> +	if (!is_init_done(fman->cfg))
> +		return -EINVAL;
> +
> +	fman_rg.bmi_rg = fman->bmi_regs;
> +	fman_rg.qmi_rg = fman->qmi_regs;
> +	fman_rg.fpm_rg = fman->fpm_regs;
> +	fman_rg.dma_rg = fman->dma_regs;
> +
> +	bit_mask = get_exception_flag(exception);
> +	if (bit_mask) {
> +		if (enable)
> +			fman->state->exceptions |= bit_mask;
> +		else
> +			fman->state->exceptions &= ~bit_mask;
> +	} else {
> +		pr_err("Undefined exception\n");
> +		return -EINVAL;

This is not a useful error message.

Use dev_err, __func__, and print the unexpected value.

Likewise elsewhere.

> +	}
> +
> +	return set_exckeption(&fman_rg, exception, enable);
> +}
> +
> +void fman_register_intr(struct fman *fman, enum fman_event_modules module,
> +			u8 mod_id, enum fman_intr_type intr_type,
> +			void (*isr_cb)(void *src_arg), void *src_arg)
> +{
> +	int event = 0;
> +
> +	event = get_module_event(module, mod_id, intr_type);
> +	WARN_ON(!(event < FMAN_EV_CNT));

This isn't floating point.  You can safely say WARN_ON(event >=
FMAN_EV_CNT). :-P

> +	spin_lock_irqsave(&fman->spinlock, int_flags);

"flags", rather than "int_flags" is idiomatic.

> +
> +	err = set_num_of_tasks(fman, port_params->port_id,
> +			       &port_params->num_of_tasks,
> +			       &port_params->num_of_extra_tasks);
> +	if (err) {
> +		spin_unlock_irqrestore(&fman->spinlock, int_flags);
> +		return err;
> +	}

Use the standard goto error handling model.

> +		/* if deq_th is too small, we enlarge it to the min
> +		 * value that is still 0.
> +		 * depTh may not be larger than 63
> +		 * (fman->state->qmi_max_num_of_tnums-1).
> +		 */
> +		if ((deq_th <= fman->state->accumulated_num_of_deq_tnums) &&
> +		    (deq_th < fman->state->qmi_max_num_of_tnums - 1)) {
> +				deq_th =
> +				fman->state->accumulated_num_of_deq_tnums + 1;
> +			reg = ioread32be(&fman_rg.qmi_rg->fmqm_gc);

Whitespace

> +/* Max frame size, across all interfaces.
> + * Configurable from bootargs, to avoid allocating oversized (socket)
> + * buffers when not using jumbo frames.
> + * Must be large enough to accommodate the network MTU, but small enough
> + * to avoid wasting skb memory.
> + *
> + * Could be overridden once, at boot-time, via the
> + * fm_set_max_frm() callback.
> + */
> +int fsl_fm_max_frm = FSL_FM_MAX_FRAME_SIZE;
> +module_param(fsl_fm_max_frm, int, 0);
> +MODULE_PARM_DESC(fsl_fm_max_frm, "Maximum frame size, across all interfaces");
> +
> +u16 fman_get_max_frm(void)
> +{
> +	static bool fm_check_mfl;
> +
> +	if (!fm_check_mfl) {
> +		if (fsl_fm_max_frm > FSL_FM_MAX_POSSIBLE_FRAME_SIZE ||
> +		    fsl_fm_max_frm < FSL_FM_MIN_POSSIBLE_FRAME_SIZE) {
> +			pr_warn("Invalid fsl_fm_max_frm value (%d) in bootargs, valid range is %d-%d. Falling back to the default (%d)\n",
> +				fsl_fm_max_frm,
> +				FSL_FM_MIN_POSSIBLE_FRAME_SIZE,
> +				FSL_FM_MAX_POSSIBLE_FRAME_SIZE,
> +				FSL_FM_MAX_FRAME_SIZE);
> +			fsl_fm_max_frm = FSL_FM_MAX_FRAME_SIZE;
> +		}
> +		fm_check_mfl = true;
> +	}
> +
> +	return fsl_fm_max_frm;
> +}
> +EXPORT_SYMBOL(fman_get_max_frm);
> +
> +int fman_get_rx_extra_headroom(void)
> +{
> +	static bool fm_check_rx_extra_headroom;
> +
> +	if (!fm_check_rx_extra_headroom) {
> +		if (fsl_fm_rx_extra_headroom > FSL_FM_RX_EXTRA_HEADROOM_MAX ||
> +		    fsl_fm_rx_extra_headroom < FSL_FM_RX_EXTRA_HEADROOM_MIN) {
> +			pr_warn("Invalid fsl_fm_rx_extra_headroom value (%d) in bootargs, valid range is %d-%d. Falling back to the default (%d)\n",
> +				fsl_fm_rx_extra_headroom,
> +				FSL_FM_RX_EXTRA_HEADROOM_MIN,
> +				FSL_FM_RX_EXTRA_HEADROOM_MAX,
> +				FSL_FM_RX_EXTRA_HEADROOM);
> +			fsl_fm_rx_extra_headroom = FSL_FM_RX_EXTRA_HEADROOM;
> +		}
> +
> +		fsl_fm_rx_extra_headroom = true;
> +		fsl_fm_rx_extra_headroom = ALIGN(fsl_fm_rx_extra_headroom, 16);
> +	}
> +
> +	return fsl_fm_rx_extra_headroom;
> +}
> +EXPORT_SYMBOL(fman_get_rx_extra_headroom);
> +

What calls these functions?

> +struct fman *fman_bind(struct device *fm_dev)
> +{
> +	return (struct fman *)(dev_get_drvdata(get_device(fm_dev)));
> +}
> +
> +void fman_unbind(struct fman *fman)
> +{
> +	put_device(fman->dev);
> +}

Why?

> +
> +struct device *fman_get_device(struct fman *fman)
> +{
> +	return fman->dev;
> +}

Is this really necessary?

> +static irqreturn_t fman_irq(int irq, void *fman)
> +{
> +	fman_event_isr(fman);
> +
> +	return IRQ_HANDLED;
> +}

Only return IRQ_HANDLED if something was actually handled.

> +static const struct of_device_id fman_muram_match[] = {
> +	{
> +	 .compatible = "fsl,fman-muram"},
> +	{}
k> +};

Whitespace

> +	clk = of_clk_get_by_name(fm_node, NULL);
> +	if (IS_ERR(clk)) {
> +		pr_err("Failed to get FM%d clock structure\n",
> +		       fman->dts_params.id);
> +		goto fman_node_put;
> +	}

Why is name NULL?  If you just want to get the first/only clock without
needing a name, why not use of_clk_get(fm_node, 0)?


> +
> +	clk_rate = clk_get_rate(clk);
> +	if (!clk_rate) {
> +		pr_err("Failed to determine FM%d clock rate\n",
> +		       fman->dts_params.id);
> +		goto fman_node_put;
> +	}
> +	/* Rounding to MHz */
> +	fman->dts_params.clk_freq = (u16)((clk_rate + 500000) / 1000000);

DIV_ROUND_UP()

> +
> +	u32_prop = (const u32 *)of_get_property(fm_node,
> +						"fsl,qman-channel-range",
> +						&lenp);
> +	if (!u32_prop) {
> +		pr_err("of_get_property(%s, fsl,qman-channel-range) failed\n",
> +		       fm_node->full_name);
> +		goto fman_node_put;
> +	}
> +	if (WARN_ON(lenp != sizeof(u32) * 2))
> +		goto fman_node_put;
> +	fman->dts_params.qman_channel_base = u32_prop[0];
> +	fman->dts_params.num_of_qman_channels = u32_prop[1];

fdt32_to_cpu()

> +
> +	/* Get the MURAM base address and size */
> +	muram_node = of_find_matching_node(fm_node, fman_muram_match);
> +	if (!muram_node) {
> +		pr_err("could not find MURAM node\n");
> +		goto fman_node_put;
> +	}
> +
> +	err = of_address_to_resource(muram_node, 0, res);
> +	if (err) {
> +		of_node_put(muram_node);
> +		pr_err("of_address_to_resource() = %d\n", err);
> +		goto fman_node_put;
> +	}
> +
> +	fman->dts_params.muram_phy_base_addr = res->start;
> +	fman->dts_params.muram_size = res->end + 1 - res->start;

Why not just put a struct resource in fman->dts_params?

> +	{
> +		/* In B4 rev 2.0 (and above) the MURAM size is 512KB.
> +		 * Check the SVR and update MURAM size if required.
> +		 */
> +		u32 svr;
> +
> +		svr = mfspr(SPRN_SVR);
> +
> +		if ((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_MAJ(svr) >= 2))
> +			fman->dts_params.muram_size = 0x80000;
> +	}

Why wasn't the MURAM size described in the device tree, as it was with
CPM/QE?

> +
> +	of_node_put(muram_node);
> +	of_node_put(fm_node);
> +
> +	err = devm_request_irq(&of_dev->dev, irq, fman_irq,
> +			       IRQF_NO_SUSPEND, "fman", fman);
> +	if (err < 0) {
> +		pr_err("Error: allocating irq %d (error = %d)\n", irq, err);
> +		goto fman_free;
> +	}

Why IRQF_NO_SUSPEND?

Also please use dev_err where possible.

> +static const struct of_device_id fman_match[] = {
> +	{
> +	 .compatible = "fsl,fman"},
> +	{}
> +};

Whitespace

> +
> +MODULE_DEVICE_TABLE(of, fm_match);
> +
> +static struct platform_driver fman_driver = {
> +	.driver = {
> +		   .name = "fsl-fman",
> +		   .of_match_table = fman_match,
> +		   },
> +	.probe = fman_probe,
> +};

Whitespace

> +/* Parse results memory layout */
> +struct fman_prs_result {
> +	u8 lpid;		/* Logical port id */
> +	u8 shimr;		/* Shim header result  */
> +	u16 l2r;		/* Layer 2 result */
> +	u16 l3r;		/* Layer 3 result */
> +	u8 l4r;		/* Layer 4 result */
> +	u8 cplan;		/* Classification plan id */
> +	u16 nxthdr;		/* Next Header  */
> +	u16 cksum;		/* Running-sum */
> +	/* Flags&fragment-offset field of the last IP-header */
> +	u16 flags_frag_off;
> +	/* Routing type field of a IPV6 routing extension header */
> +	u8 route_type;
> +	/* Routing Extension Header Present; last bit is IP valid */
> +	u8 rhp_ip_valid;
> +	u8 shim_off[2];		/* Shim offset */
> +	u8 ip_pid_off;		/* IP PID (last IP-proto) offset */
> +	u8 eth_off;		/* ETH offset */
> +	u8 llc_snap_off;	/* LLC_SNAP offset */
> +	u8 vlan_off[2];		/* VLAN offset */
> +	u8 etype_off;		/* ETYPE offset */
> +	u8 pppoe_off;		/* PPP offset */
> +	u8 mpls_off[2];		/* MPLS offset */
> +	u8 ip_off[2];		/* IP offset */
> +	u8 gre_off;		/* GRE offset */
> +	u8 l4_off;		/* Layer 4 offset */
> +	u8 nxthdr_off;		/** Parser end point */
> +} __attribute__((__packed__));

Why is this packed?

Why does "Parser end point" have a kerneldoc comment? 

> +
> +/**
> + * fman_get_revision
> + * @fman		- Pointer to the FMan module
> + * @rev_info		- A structure of revision information parameters.
> + *
> + * Returns the FM revision
> + *
> + * Allowed only following fman_init().
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +void fman_get_revision(struct fman *fman, struct fman_rev_info *rev_info);
> +
> +/**
> + * fman_register_intr
> + * @fman:	A Pointer to FMan device
> + * @mod:	Calling module
> + * @mod_id:	Module id (if more than 1 exists, '0' if not)
> + * @intr_type:	Interrupt type (error/normal) selection.
> + * @f_isr:	The interrupt service routine.
> + * @h_src_arg:	Argument to be passed to f_isr.
> + *
> + * Used to register an event handler to be processed by FMan
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +void fman_register_intr(struct fman *fman, enum fman_event_modules mod,
> +			u8 mod_id, enum fman_intr_type intr_type,
> +			void (*f_isr)(void *h_src_arg), void *h_src_arg);
> +
> +/**
> + * fman_unregister_intr
> + * @fman:	A Pointer to FMan device
> + * @mod:	Calling module
> + * @mod_id:	Module id (if more than 1 exists, '0' if not)
> + * @intr_type:	Interrupt type (error/normal) selection.
> + *
> + * Used to unregister an event handler to be processed by FMan
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +void fman_unregister_intr(struct fman *fman, enum fman_event_modules mod,
> +			  u8 mod_id, enum fman_intr_type intr_type);
> +
> +/**
> + * fman_set_port_params
> + * @fman:		A Pointer to FMan device
> + * @port_params:	Port parameters
> + *
> + * Used by FMan Port to pass parameters to the FMan
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +int fman_set_port_params(struct fman *fman,
> +			 struct fman_port_init_params *port_params);
> +
> +/**
> + * fman_reset_mac
> + * @fman:	A Pointer to FMan device
> + * @mac_id:	MAC id to be reset
> + *
> + * Reset a specific MAC
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +int fman_reset_mac(struct fman *fman, u8 mac_id);
> +
> +/**
> + * fman_get_clock_freq
> + * @fman:	A Pointer to FMan device
> + *
> + * Get FMan clock frequency
> + *
> + * Return: FMan clock frequency
> + */
> +
> +u16 fman_get_clock_freq(struct fman *fman);
> +
> +/**
> + * fman_get_bmi_max_fifo_size
> + * @fman:	A Pointer to FMan device
> + *
> + * Get FMan maximum FIFO size
> + *
> + * Return: FMan Maximum FIFO size
> + */
> +u32 fman_get_bmi_max_fifo_size(struct fman *fman);
> +
> +/**
> + * fman_set_mac_max_frame
> + * @fman:	A Pointer to FMan device
> + * @mac_id:	MAC id
> + * @mfl:	Maximum frame length
> + *
> + * Set maximum frame length of specific MAC in FMan driver
> + *
> + * Return: 0 on success; Error code otherwise.
> + */
> +int fman_set_mac_max_frame(struct fman *fman, u8 mac_id, u16 mfl);
> +
> +/**
> + * fman_get_qman_channel_id
> + * @fman:	A Pointer to FMan device
> + * @port_id:	Port id
> + *
> + * Get QMan channel ID associated to the Port id
> + *
> + * Return: QMan channel ID
> + */
> +u32 fman_get_qman_channel_id(struct fman *fman, u32 port_id);
> +
> +/**
> + * fman_get_mem_region
> + * @fman:	A Pointer to FMan device
> + *
> + * Get FMan memory region
> + *
> + * Return: A structure with FMan memory region information
> + */
> +struct resource *fman_get_mem_region(struct fman *fman);
> +
> +/**
> + * fman_get_max_frm
> + *
> + * Return: Max frame length configured in the FM driver
> + */
> +u16 fman_get_max_frm(void);
> +
> +/**
> + * fman_get_rx_extra_headroom
> + *
> + * Return: Extra headroom size configured in the FM driver
> + */
> +int fman_get_rx_extra_headroom(void);
> +
> +/**
> + * fman_bind
> + * @dev:	FMan OF device pointer
> + *
> + * Bind to a specific FMan device.
> + *
> + * Allowed only after the port was created.
> + *
> + * Return: A pointer to the FMan device
> + */
> +struct fman *fman_bind(struct device *dev);
> +
> +/**
> + * fman_unbind
> + * @fman:	Pointer to the FMan device
> + *
> + * Un-bind from a specific FMan device.
> + *
> + * Allowed only after the port was created.
> + */
> +void fman_unbind(struct fman *fman);
> +
> +/**
> + * fman_get_device
> + * @fman:	A pointer to the FMan device.
> + *
> + * Get the FMan device pointer
> + *
> + * Return: Pointer to FMan device.
> + */
> +struct device *fman_get_device(struct fman *fman);

Usually kerneldoc comments go on the implementation, not the prototype.

-Scott
