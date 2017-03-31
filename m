Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvYjS2tjvzDqH8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 18:56:28 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V7sOlB017803
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 03:56:18 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29h4bp6g40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 03:56:17 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 31 Mar 2017 17:56:14 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2V7u52h49545254
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 18:56:13 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2V7teS9025690
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 18:55:40 +1100
Subject: Re: [PATCH V3 5/7] cxl: Rename some psl8 specific functions
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-6-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 31 Mar 2017 18:55:15 +1100
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-6-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <05c7116e-84ff-c89e-9918-02a3769da8ef@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/03/17 02:14, Christophe Lombard wrote:
> Rename a few functions, changing the '_psl' suffix to '_psl8', to make
> clear that the implementation is psl8 specific.
> Those functions will have an equivalent implementation for the psl9 in
> a later patch.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Looks fine to me

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/cxl.h     | 26 +++++++++++++-------------
>  drivers/misc/cxl/debugfs.c |  6 +++---
>  drivers/misc/cxl/guest.c   |  2 +-
>  drivers/misc/cxl/irq.c     |  2 +-
>  drivers/misc/cxl/native.c  | 12 ++++++------
>  drivers/misc/cxl/pci.c     | 46 +++++++++++++++++++++++-----------------------
>  6 files changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 65d9fb6..c7dd315 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -813,10 +813,10 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count);
>  void afu_release_irqs(struct cxl_context *ctx, void *cookie);
>  void afu_irq_name_free(struct cxl_context *ctx);
>
> -int cxl_attach_afu_directed_psl(struct cxl_context *ctx, u64 wed, u64 amr);
> -int cxl_activate_dedicated_process_psl(struct cxl_afu *afu);
> -int cxl_attach_dedicated_process_psl(struct cxl_context *ctx, u64 wed, u64 amr);
> -void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx);
> +int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> +int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu);
> +int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> +void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx);
>
>  #ifdef CONFIG_DEBUG_FS
>
> @@ -826,10 +826,10 @@ int cxl_debugfs_adapter_add(struct cxl *adapter);
>  void cxl_debugfs_adapter_remove(struct cxl *adapter);
>  int cxl_debugfs_afu_add(struct cxl_afu *afu);
>  void cxl_debugfs_afu_remove(struct cxl_afu *afu);
> -void cxl_stop_trace_psl(struct cxl *cxl);
> -void cxl_debugfs_add_adapter_regs_psl(struct cxl *adapter, struct dentry *dir);
> +void cxl_stop_trace_psl8(struct cxl *cxl);
> +void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
>  void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir);
> -void cxl_debugfs_add_afu_regs_psl(struct cxl_afu *afu, struct dentry *dir);
> +void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir);
>
>  #else /* CONFIG_DEBUG_FS */
>
> @@ -860,11 +860,11 @@ static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
>  {
>  }
>
> -static inline void cxl_stop_trace(struct cxl *cxl)
> +static inline void cxl_stop_trace_psl8(struct cxl *cxl)
>  {
>  }
>
> -static inline void cxl_debugfs_add_adapter_regs_psl(struct cxl *adapter,
> +static inline void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
>  						    struct dentry *dir)
>  {
>  }
> @@ -874,7 +874,7 @@ static inline void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter,
>  {
>  }
>
> -static inline void cxl_debugfs_add_afu_regs_psl(struct cxl_afu *afu, struct dentry *dir)
> +static inline void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
>  {
>  }
>
> @@ -932,8 +932,8 @@ struct cxl_irq_info {
>  };
>
>  void cxl_assign_psn_space(struct cxl_context *ctx);
> -int cxl_invalidate_all_psl(struct cxl *adapter);
> -irqreturn_t cxl_irq_psl(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> +int cxl_invalidate_all_psl8(struct cxl *adapter);
> +irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
>  irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
>  int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
>  			void *cookie, irq_hw_number_t *dest_hwirq,
> @@ -945,7 +945,7 @@ int cxl_data_cache_flush(struct cxl *adapter);
>  int cxl_afu_disable(struct cxl_afu *afu);
>  int cxl_psl_purge(struct cxl_afu *afu);
>
> -void cxl_native_irq_dump_regs_psl(struct cxl_context *ctx);
> +void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx);
>  void cxl_native_err_irq_dump_regs(struct cxl *adapter);
>  int cxl_pci_vphb_add(struct cxl_afu *afu);
>  void cxl_pci_vphb_remove(struct cxl_afu *afu);
> diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
> index 4848ebf..2ff10a9 100644
> --- a/drivers/misc/cxl/debugfs.c
> +++ b/drivers/misc/cxl/debugfs.c
> @@ -15,7 +15,7 @@
>
>  static struct dentry *cxl_debugfs;
>
> -void cxl_stop_trace_psl(struct cxl *adapter)
> +void cxl_stop_trace_psl8(struct cxl *adapter)
>  {
>  	int slice;
>
> @@ -53,7 +53,7 @@ static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
>  					  (void __force *)value, &fops_io_x64);
>  }
>
> -void cxl_debugfs_add_adapter_regs_psl(struct cxl *adapter, struct dentry *dir)
> +void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
>  {
>  	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
>  	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
> @@ -92,7 +92,7 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
>  	debugfs_remove_recursive(adapter->debugfs);
>  }
>
> -void cxl_debugfs_add_afu_regs_psl(struct cxl_afu *afu, struct dentry *dir)
> +void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
>  {
>  	debugfs_create_io_x64("fir", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
>  	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index f6ba698..3ad7381 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -169,7 +169,7 @@ static irqreturn_t guest_psl_irq(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>
> -	rc = cxl_irq_psl(irq, ctx, &irq_info);
> +	rc = cxl_irq_psl8(irq, ctx, &irq_info);
>  	return rc;
>  }
>
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 2fa119e..fa9f8a2 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -34,7 +34,7 @@ static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 da
>  	return IRQ_HANDLED;
>  }
>
> -irqreturn_t cxl_irq_psl(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
> +irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
>  {
>  	u64 dsisr, dar;
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index c5048e8..9f7f06d 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -258,7 +258,7 @@ void cxl_release_spa(struct cxl_afu *afu)
>  	}
>  }
>
> -int cxl_invalidate_all_psl(struct cxl *adapter)
> +int cxl_invalidate_all_psl8(struct cxl *adapter)
>  {
>  	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
>
> @@ -578,7 +578,7 @@ static void update_ivtes_directed(struct cxl_context *ctx)
>  		WARN_ON(add_process_element(ctx));
>  }
>
> -int cxl_attach_afu_directed_psl(struct cxl_context *ctx, u64 wed, u64 amr)
> +int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  {
>  	u32 pid;
>  	int result;
> @@ -671,7 +671,7 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
>  	return 0;
>  }
>
> -int cxl_activate_dedicated_process_psl(struct cxl_afu *afu)
> +int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu)
>  {
>  	dev_info(&afu->dev, "Activating dedicated process mode\n");
>
> @@ -694,7 +694,7 @@ int cxl_activate_dedicated_process_psl(struct cxl_afu *afu)
>  	return cxl_chardev_d_afu_add(afu);
>  }
>
> -void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx)
> +void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx)
>  {
>  	struct cxl_afu *afu = ctx->afu;
>
> @@ -710,7 +710,7 @@ void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx)
>  			((u64)ctx->irqs.range[3] & 0xffff));
>  }
>
> -int cxl_attach_dedicated_process_psl(struct cxl_context *ctx, u64 wed, u64 amr)
> +int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  {
>  	struct cxl_afu *afu = ctx->afu;
>  	u64 pid;
> @@ -880,7 +880,7 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
>  	return 0;
>  }
>
> -void cxl_native_irq_dump_regs_psl(struct cxl_context *ctx)
> +void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx)
>  {
>  	u64 fir1, fir2, fir_slice, serr, afu_debug;
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 4d475a5..cb76013 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -377,7 +377,7 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
>  	return 0;
>  }
>
> -static int init_implementation_adapter_regs_psl(struct cxl *adapter, struct pci_dev *dev)
> +static int init_implementation_adapter_regs_psl8(struct cxl *adapter, struct pci_dev *dev)
>  {
>  	u64 psl_dsnctl, psl_fircntl;
>  	u64 chipid;
> @@ -434,7 +434,7 @@ static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_
>  /* For the PSL this is a multiple for 0 < n <= 7: */
>  #define PSL_2048_250MHZ_CYCLES 1
>
> -static void write_timebase_ctrl_psl(struct cxl *adapter)
> +static void write_timebase_ctrl_psl8(struct cxl *adapter)
>  {
>  	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
>  		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
> @@ -455,7 +455,7 @@ static void write_timebase_ctrl_xsl(struct cxl *adapter)
>  		     TBSYNC_CNT(XSL_4000_CLOCKS));
>  }
>
> -static u64 timebase_read_psl(struct cxl *adapter)
> +static u64 timebase_read_psl8(struct cxl *adapter)
>  {
>  	return cxl_p1_read(adapter, CXL_PSL_Timebase);
>  }
> @@ -513,7 +513,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
>  	return;
>  }
>
> -static int init_implementation_afu_regs_psl(struct cxl_afu *afu)
> +static int init_implementation_afu_regs_psl8(struct cxl_afu *afu)
>  {
>  	/* read/write masks for this slice */
>  	cxl_p1n_write(afu, CXL_PSL_APCALLOC_A, 0xFFFFFFFEFEFEFEFEULL);
> @@ -996,7 +996,7 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
>  	return 0;
>  }
>
> -static int sanitise_afu_regs_psl(struct cxl_afu *afu)
> +static int sanitise_afu_regs_psl8(struct cxl_afu *afu)
>  {
>  	u64 reg;
>
> @@ -1526,26 +1526,26 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
>  	pci_disable_device(pdev);
>  }
>
> -static const struct cxl_service_layer_ops psl_ops = {
> -	.adapter_regs_init = init_implementation_adapter_regs_psl,
> -	.invalidate_all = cxl_invalidate_all_psl,
> -	.afu_regs_init = init_implementation_afu_regs_psl,
> -	.sanitise_afu_regs = sanitise_afu_regs_psl,
> +static const struct cxl_service_layer_ops psl8_ops = {
> +	.adapter_regs_init = init_implementation_adapter_regs_psl8,
> +	.invalidate_all = cxl_invalidate_all_psl8,
> +	.afu_regs_init = init_implementation_afu_regs_psl8,
> +	.sanitise_afu_regs = sanitise_afu_regs_psl8,
>  	.register_serr_irq = cxl_native_register_serr_irq,
>  	.release_serr_irq = cxl_native_release_serr_irq,
> -	.handle_interrupt = cxl_irq_psl,
> +	.handle_interrupt = cxl_irq_psl8,
>  	.fail_irq = cxl_fail_irq_psl,
> -	.activate_dedicated_process = cxl_activate_dedicated_process_psl,
> -	.attach_afu_directed = cxl_attach_afu_directed_psl,
> -	.attach_dedicated_process = cxl_attach_dedicated_process_psl,
> -	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl,
> -	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl,
> -	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl,
> -	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl,
> +	.activate_dedicated_process = cxl_activate_dedicated_process_psl8,
> +	.attach_afu_directed = cxl_attach_afu_directed_psl8,
> +	.attach_dedicated_process = cxl_attach_dedicated_process_psl8,
> +	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl8,
> +	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl8,
> +	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl8,
> +	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl8,
>  	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
> -	.debugfs_stop_trace = cxl_stop_trace_psl,
> -	.write_timebase_ctrl = write_timebase_ctrl_psl,
> -	.timebase_read = timebase_read_psl,
> +	.debugfs_stop_trace = cxl_stop_trace_psl8,
> +	.write_timebase_ctrl = write_timebase_ctrl_psl8,
> +	.timebase_read = timebase_read_psl8,
>  	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
>  	.needs_reset_before_disable = true,
>  };
> @@ -1566,8 +1566,8 @@ static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
>  		adapter->native->sl_ops = &xsl_ops;
>  		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
>  	} else {
> -		dev_info(&dev->dev, "Device uses a PSL\n");
> -		adapter->native->sl_ops = &psl_ops;
> +		dev_info(&dev->dev, "Device uses a PSL8\n");
> +		adapter->native->sl_ops = &psl8_ops;
>  	}
>  }
>
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
