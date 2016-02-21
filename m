Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E7D91A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:02:17 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 15:02:15 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C05E01FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 14:50:23 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1LM2EnX27459618
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:02:14 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1LM2DLc026721
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:02:14 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 05/18] cxl: Rename some bare-metal specific
 functions
References: <1455658751-16970-6-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2C97.8000906@linux.vnet.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling1@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CA33F6.9090501@linux.vnet.ibm.com>
Date: Sun, 21 Feb 2016 16:02:30 -0600
MIME-Version: 1.0
In-Reply-To: <56CA2C97.8000906@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar



> Subject: [PATCH v4 05/18] cxl: Rename some bare-metal specific functions
> Date: Tue, 16 Feb 2016 22:38:58 +0100
> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
> mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
>
> Rename a few functions, changing the 'cxl_' prefix to either
> 'cxl_pci_' or 'cxl_native_', to make clear that the implementation is
> bare-metal specific.
>
> Those functions will have an equivalent implementation for a guest in
> a later patch.
>
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h    | 28 +++++++-------
>   drivers/misc/cxl/native.c | 98
> ++++++++++++++++++++++++-----------------------
>   drivers/misc/cxl/pci.c    | 78 +++++++++++++++++++------------------
>   3 files changed, 104 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 8233af3..02065b4 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -519,14 +519,14 @@ struct cxl {
>       bool perst_same_image;
>   };
>
> -int cxl_alloc_one_irq(struct cxl *adapter);
> -void cxl_release_one_irq(struct cxl *adapter, int hwirq);
> -int cxl_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter, unsigned int num);
> -void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter);
> -int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int
> virq);
> +int cxl_pci_alloc_one_irq(struct cxl *adapter);
> +void cxl_pci_release_one_irq(struct cxl *adapter, int hwirq);
> +int cxl_pci_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter, unsigned int num);
> +void cxl_pci_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter);
> +int cxl_pci_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned
> int virq);
>   int cxl_update_image_control(struct cxl *adapter);
> -int cxl_reset(struct cxl *adapter);
> -void cxl_release_afu(struct device *dev);
> +int cxl_pci_reset(struct cxl *adapter);
> +void cxl_pci_release_afu(struct device *dev);
>
>   /* common == phyp + powernv */
>   struct cxl_process_element_common {
> @@ -623,7 +623,7 @@ static inline u64 cxl_p2n_read(struct cxl_afu *afu,
> cxl_p2n_reg_t reg)
>           return ~0ULL;
>   }
>
> -ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> +ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
>                   loff_t off, size_t count);
>
>
> @@ -663,12 +663,12 @@ struct cxl *cxl_alloc_adapter(void);
>   struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice);
>   int cxl_afu_select_best_mode(struct cxl_afu *afu);
>
> -int cxl_register_psl_irq(struct cxl_afu *afu);
> -void cxl_release_psl_irq(struct cxl_afu *afu);
> -int cxl_register_psl_err_irq(struct cxl *adapter);
> -void cxl_release_psl_err_irq(struct cxl *adapter);
> -int cxl_register_serr_irq(struct cxl_afu *afu);
> -void cxl_release_serr_irq(struct cxl_afu *afu);
> +int cxl_native_register_psl_irq(struct cxl_afu *afu);
> +void cxl_native_release_psl_irq(struct cxl_afu *afu);
> +int cxl_native_register_psl_err_irq(struct cxl *adapter);
> +void cxl_native_release_psl_err_irq(struct cxl *adapter);
> +int cxl_native_register_serr_irq(struct cxl_afu *afu);
> +void cxl_native_release_serr_irq(struct cxl_afu *afu);
>   int afu_register_irqs(struct cxl_context *ctx, u32 count);
>   void afu_release_irqs(struct cxl_context *ctx, void *cookie);
>   void afu_irq_name_free(struct cxl_context *ctx);
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 16d3b1a..b8a6ad5 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -80,7 +80,7 @@ int cxl_afu_disable(struct cxl_afu *afu)
>   }
>
>   /* This will disable as well as reset */
> -static int __cxl_afu_reset(struct cxl_afu *afu)
> +static int native_afu_reset(struct cxl_afu *afu)
>   {
>       pr_devel("AFU reset request\n");
>
> @@ -90,7 +90,7 @@ static int __cxl_afu_reset(struct cxl_afu *afu)
>                  false);
>   }
>
> -static int cxl_afu_check_and_enable(struct cxl_afu *afu)
> +static int native_afu_check_and_enable(struct cxl_afu *afu)
>   {
>       if (!cxl_ops->link_ok(afu->adapter)) {
>           WARN(1, "Refusing to enable afu while link down!\n");
> @@ -631,7 +631,7 @@ static int deactivate_dedicated_process(struct
> cxl_afu *afu)
>       return 0;
>   }
>
> -static int cxl_afu_deactivate_mode(struct cxl_afu *afu, int mode)
> +static int native_afu_deactivate_mode(struct cxl_afu *afu, int mode)
>   {
>       if (mode == CXL_MODE_DIRECTED)
>           return deactivate_afu_directed(afu);
> @@ -640,7 +640,7 @@ static int cxl_afu_deactivate_mode(struct cxl_afu
> *afu, int mode)
>       return 0;
>   }
>
> -static int cxl_afu_activate_mode(struct cxl_afu *afu, int mode)
> +static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
>   {
>       if (!mode)
>           return 0;
> @@ -660,7 +660,8 @@ static int cxl_afu_activate_mode(struct cxl_afu
> *afu, int mode)
>       return -EINVAL;
>   }
>
> -static int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64
> wed, u64 amr)
> +static int native_attach_process(struct cxl_context *ctx, bool kernel,
> +                u64 wed, u64 amr)
>   {
>       if (!cxl_ops->link_ok(ctx->afu->adapter)) {
>           WARN(1, "Device link is down, refusing to attach process!\n");
> @@ -697,7 +698,7 @@ static inline int
> detach_process_native_afu_directed(struct cxl_context *ctx)
>       return 0;
>   }
>
> -static int cxl_detach_process(struct cxl_context *ctx)
> +static int native_detach_process(struct cxl_context *ctx)
>   {
>       trace_cxl_detach(ctx);
>
> @@ -707,7 +708,7 @@ static int cxl_detach_process(struct cxl_context *ctx)
>       return detach_process_native_afu_directed(ctx);
>   }
>
> -static int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info)
> +static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info
> *info)
>   {
>       u64 pidtid;
>
> @@ -729,7 +730,8 @@ static int cxl_get_irq(struct cxl_afu *afu, struct
> cxl_irq_info *info)
>       return 0;
>   }
>
> -static irqreturn_t handle_psl_slice_error(struct cxl_context *ctx, u64
> dsisr, u64 errstat)
> +static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
> +                        u64 dsisr, u64 errstat)
>   {
>       u64 fir1, fir2, fir_slice, serr, afu_debug;
>
> @@ -762,7 +764,7 @@ static irqreturn_t fail_psl_irq(struct cxl_afu *afu,
> struct cxl_irq_info *irq_in
>       return IRQ_HANDLED;
>   }
>
> -static irqreturn_t cxl_irq_multiplexed(int irq, void *data)
> +static irqreturn_t native_irq_multiplexed(int irq, void *data)
>   {
>       struct cxl_afu *afu = data;
>       struct cxl_context *ctx;
> @@ -770,7 +772,7 @@ static irqreturn_t cxl_irq_multiplexed(int irq, void
> *data)
>       int ph = cxl_p2n_read(afu, CXL_PSL_PEHandle_An) & 0xffff;
>       int ret;
>
> -    if ((ret = cxl_get_irq(afu, &irq_info))) {
> +    if ((ret = native_get_irq_info(afu, &irq_info))) {
>           WARN(1, "Unable to get CXL IRQ Info: %i\n", ret);
>           return fail_psl_irq(afu, &irq_info);
>       }
> @@ -791,7 +793,7 @@ static irqreturn_t cxl_irq_multiplexed(int irq, void
> *data)
>       return fail_psl_irq(afu, &irq_info);
>   }
>
> -static irqreturn_t cxl_slice_irq_err(int irq, void *data)
> +static irqreturn_t native_slice_irq_err(int irq, void *data)
>   {
>       struct cxl_afu *afu = data;
>       u64 fir_slice, errstat, serr, afu_debug;
> @@ -812,7 +814,7 @@ static irqreturn_t cxl_slice_irq_err(int irq, void
> *data)
>       return IRQ_HANDLED;
>   }
>
> -static irqreturn_t cxl_irq_err(int irq, void *data)
> +static irqreturn_t native_irq_err(int irq, void *data)
>   {
>       struct cxl *adapter = data;
>       u64 fir1, fir2, err_ivte;
> @@ -833,7 +835,7 @@ static irqreturn_t cxl_irq_err(int irq, void *data)
>       return IRQ_HANDLED;
>   }
>
> -int cxl_register_psl_err_irq(struct cxl *adapter)
> +int cxl_native_register_psl_err_irq(struct cxl *adapter)
>   {
>       int rc;
>
> @@ -842,7 +844,7 @@ int cxl_register_psl_err_irq(struct cxl *adapter)
>       if (!adapter->irq_name)
>           return -ENOMEM;
>
> -    if ((rc = cxl_register_one_irq(adapter, cxl_irq_err, adapter,
> +    if ((rc = cxl_register_one_irq(adapter, native_irq_err, adapter,
>                          &adapter->err_hwirq,
>                          &adapter->err_virq,
>                          adapter->irq_name))) {
> @@ -856,7 +858,7 @@ int cxl_register_psl_err_irq(struct cxl *adapter)
>       return 0;
>   }
>
> -void cxl_release_psl_err_irq(struct cxl *adapter)
> +void cxl_native_release_psl_err_irq(struct cxl *adapter)
>   {
>       if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
>           return;
> @@ -867,7 +869,7 @@ void cxl_release_psl_err_irq(struct cxl *adapter)
>       kfree(adapter->irq_name);
>   }
>
> -int cxl_register_serr_irq(struct cxl_afu *afu)
> +int cxl_native_register_serr_irq(struct cxl_afu *afu)
>   {
>       u64 serr;
>       int rc;
> @@ -877,7 +879,7 @@ int cxl_register_serr_irq(struct cxl_afu *afu)
>       if (!afu->err_irq_name)
>           return -ENOMEM;
>
> -    if ((rc = cxl_register_one_irq(afu->adapter, cxl_slice_irq_err, afu,
> +    if ((rc = cxl_register_one_irq(afu->adapter, native_slice_irq_err,
> afu,
>                          &afu->serr_hwirq,
>                          &afu->serr_virq, afu->err_irq_name))) {
>           kfree(afu->err_irq_name);
> @@ -892,7 +894,7 @@ int cxl_register_serr_irq(struct cxl_afu *afu)
>       return 0;
>   }
>
> -void cxl_release_serr_irq(struct cxl_afu *afu)
> +void cxl_native_release_serr_irq(struct cxl_afu *afu)
>   {
>       if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
>           return;
> @@ -903,7 +905,7 @@ void cxl_release_serr_irq(struct cxl_afu *afu)
>       kfree(afu->err_irq_name);
>   }
>
> -int cxl_register_psl_irq(struct cxl_afu *afu)
> +int cxl_native_register_psl_irq(struct cxl_afu *afu)
>   {
>       int rc;
>
> @@ -912,7 +914,7 @@ int cxl_register_psl_irq(struct cxl_afu *afu)
>       if (!afu->psl_irq_name)
>           return -ENOMEM;
>
> -    if ((rc = cxl_register_one_irq(afu->adapter, cxl_irq_multiplexed, afu,
> +    if ((rc = cxl_register_one_irq(afu->adapter,
> native_irq_multiplexed, afu,
>                       &afu->psl_hwirq, &afu->psl_virq,
>                       afu->psl_irq_name))) {
>           kfree(afu->psl_irq_name);
> @@ -921,7 +923,7 @@ int cxl_register_psl_irq(struct cxl_afu *afu)
>       return rc;
>   }
>
> -void cxl_release_psl_irq(struct cxl_afu *afu)
> +void cxl_native_release_psl_irq(struct cxl_afu *afu)
>   {
>       if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
>           return;
> @@ -945,7 +947,7 @@ static void recover_psl_err(struct cxl_afu *afu, u64
> errstat)
>       cxl_p2n_write(afu, CXL_PSL_ErrStat_An, errstat);
>   }
>
> -static int cxl_ack_irq(struct cxl_context *ctx, u64 tfc, u64
> psl_reset_mask)
> +static int native_ack_irq(struct cxl_context *ctx, u64 tfc, u64
> psl_reset_mask)
>   {
>       trace_cxl_psl_irq_ack(ctx, tfc);
>       if (tfc)
> @@ -961,7 +963,7 @@ int cxl_check_error(struct cxl_afu *afu)
>       return (cxl_p1n_read(afu, CXL_PSL_SCNTL_An) == ~0ULL);
>   }
>
> -static int cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64
> *out)
> +static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off,
> u64 *out)
>   {
>       if (unlikely(!cxl_ops->link_ok(afu->adapter)))
>           return -EIO;
> @@ -972,7 +974,7 @@ static int cxl_afu_cr_read64(struct cxl_afu *afu,
> int cr, u64 off, u64 *out)
>       return 0;
>   }
>
> -static int cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off, u32
> *out)
> +static int native_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off,
> u32 *out)
>   {
>       if (unlikely(!cxl_ops->link_ok(afu->adapter)))
>           return -EIO;
> @@ -983,25 +985,25 @@ static int cxl_afu_cr_read32(struct cxl_afu *afu,
> int cr, u64 off, u32 *out)
>       return 0;
>   }
>
> -static int cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off, u16
> *out)
> +static int native_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off,
> u16 *out)
>   {
>       u64 aligned_off = off & ~0x3L;
>       u32 val;
>       int rc;
>
> -    rc = cxl_afu_cr_read32(afu, cr, aligned_off, &val);
> +    rc = native_afu_cr_read32(afu, cr, aligned_off, &val);
>       if (!rc)
>           *out = (val >> ((off & 0x3) * 8)) & 0xffff;
>       return rc;
>   }
>
> -static int cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off, u8 *out)
> +static int native_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off, u8
> *out)
>   {
>       u64 aligned_off = off & ~0x3L;
>       u32 val;
>       int rc;
>
> -    rc = cxl_afu_cr_read32(afu, cr, aligned_off, &val);
> +    rc = native_afu_cr_read32(afu, cr, aligned_off, &val);
>       if (!rc)
>           *out = (val >> ((off & 0x3) * 8)) & 0xff;
>       return rc;
> @@ -1009,26 +1011,26 @@ static int cxl_afu_cr_read8(struct cxl_afu *afu,
> int cr, u64 off, u8 *out)
>
>   const struct cxl_backend_ops cxl_native_ops = {
>       .module = THIS_MODULE,
> -    .adapter_reset = cxl_reset,
> -    .alloc_one_irq = cxl_alloc_one_irq,
> -    .release_one_irq = cxl_release_one_irq,
> -    .alloc_irq_ranges = cxl_alloc_irq_ranges,
> -    .release_irq_ranges = cxl_release_irq_ranges,
> -    .setup_irq = cxl_setup_irq,
> -    .handle_psl_slice_error = handle_psl_slice_error,
> +    .adapter_reset = cxl_pci_reset,
> +    .alloc_one_irq = cxl_pci_alloc_one_irq,
> +    .release_one_irq = cxl_pci_release_one_irq,
> +    .alloc_irq_ranges = cxl_pci_alloc_irq_ranges,
> +    .release_irq_ranges = cxl_pci_release_irq_ranges,
> +    .setup_irq = cxl_pci_setup_irq,
> +    .handle_psl_slice_error = native_handle_psl_slice_error,
>       .psl_interrupt = NULL,
> -    .ack_irq = cxl_ack_irq,
> -    .attach_process = cxl_attach_process,
> -    .detach_process = cxl_detach_process,
> +    .ack_irq = native_ack_irq,
> +    .attach_process = native_attach_process,
> +    .detach_process = native_detach_process,
>       .link_ok = cxl_adapter_link_ok,
> -    .release_afu = cxl_release_afu,
> -    .afu_read_err_buffer = cxl_afu_read_err_buffer,
> -    .afu_check_and_enable = cxl_afu_check_and_enable,
> -    .afu_activate_mode = cxl_afu_activate_mode,
> -    .afu_deactivate_mode = cxl_afu_deactivate_mode,
> -    .afu_reset = __cxl_afu_reset,
> -    .afu_cr_read8 = cxl_afu_cr_read8,
> -    .afu_cr_read16 = cxl_afu_cr_read16,
> -    .afu_cr_read32 = cxl_afu_cr_read32,
> -    .afu_cr_read64 = cxl_afu_cr_read64,
> +    .release_afu = cxl_pci_release_afu,
> +    .afu_read_err_buffer = cxl_pci_afu_read_err_buffer,
> +    .afu_check_and_enable = native_afu_check_and_enable,
> +    .afu_activate_mode = native_afu_activate_mode,
> +    .afu_deactivate_mode = native_afu_deactivate_mode,
> +    .afu_reset = native_afu_reset,
> +    .afu_cr_read8 = native_afu_cr_read8,
> +    .afu_cr_read16 = native_afu_cr_read16,
> +    .afu_cr_read32 = native_afu_cr_read32,
> +    .afu_cr_read64 = native_afu_cr_read64,
>   };
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 6e2c274..23b84c5 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -415,8 +415,8 @@ static int init_implementation_afu_regs(struct
> cxl_afu *afu)
>       return 0;
>   }
>
> -int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq,
> -             unsigned int virq)
> +int cxl_pci_setup_irq(struct cxl *adapter, unsigned int hwirq,
> +        unsigned int virq)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>
> @@ -458,28 +458,30 @@ int cxl_update_image_control(struct cxl *adapter)
>       return 0;
>   }
>
> -int cxl_alloc_one_irq(struct cxl *adapter)
> +int cxl_pci_alloc_one_irq(struct cxl *adapter)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>
>       return pnv_cxl_alloc_hwirqs(dev, 1);
>   }
>
> -void cxl_release_one_irq(struct cxl *adapter, int hwirq)
> +void cxl_pci_release_one_irq(struct cxl *adapter, int hwirq)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>
>       return pnv_cxl_release_hwirqs(dev, hwirq, 1);
>   }
>
> -int cxl_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter, unsigned int num)
> +int cxl_pci_alloc_irq_ranges(struct cxl_irq_ranges *irqs,
> +            struct cxl *adapter, unsigned int num)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>
>       return pnv_cxl_alloc_hwirq_ranges(irqs, dev, num);
>   }
>
> -void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl
> *adapter)
> +void cxl_pci_release_irq_ranges(struct cxl_irq_ranges *irqs,
> +                struct cxl *adapter)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>
> @@ -540,7 +542,7 @@ static int switch_card_to_cxl(struct pci_dev *dev)
>       return 0;
>   }
>
> -static int cxl_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter,
> struct pci_dev *dev)
> +static int pci_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter,
> struct pci_dev *dev)
>   {
>       u64 p1n_base, p2n_base, afu_desc;
>       const u64 p1n_size = 0x100;
> @@ -570,7 +572,7 @@ err:
>       return -ENOMEM;
>   }
>
> -static void cxl_unmap_slice_regs(struct cxl_afu *afu)
> +static void pci_unmap_slice_regs(struct cxl_afu *afu)
>   {
>       if (afu->p2n_mmio) {
>           iounmap(afu->p2n_mmio);
> @@ -586,11 +588,11 @@ static void cxl_unmap_slice_regs(struct cxl_afu *afu)
>       }
>   }
>
> -void cxl_release_afu(struct device *dev)
> +void cxl_pci_release_afu(struct device *dev)
>   {
>       struct cxl_afu *afu = to_cxl_afu(dev);
>
> -    pr_devel("cxl_release_afu\n");
> +    pr_devel("%s\n", __func__);
>
>       idr_destroy(&afu->contexts_idr);
>       cxl_release_spa(afu);
> @@ -729,7 +731,7 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
>    * 4/8 bytes aligned access. So in case the requested offset/count
> arent 8 byte
>    * aligned the function uses a bounce buffer which can be max PAGE_SIZE.
>    */
> -ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> +ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
>                   loff_t off, size_t count)
>   {
>       loff_t aligned_start, aligned_end;
> @@ -766,11 +768,11 @@ ssize_t cxl_afu_read_err_buffer(struct cxl_afu
> *afu, char *buf,
>       return count;
>   }
>
> -static int cxl_configure_afu(struct cxl_afu *afu, struct cxl *adapter,
> struct pci_dev *dev)
> +static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter,
> struct pci_dev *dev)
>   {
>       int rc;
>
> -    if ((rc = cxl_map_slice_regs(afu, adapter, dev)))
> +    if ((rc = pci_map_slice_regs(afu, adapter, dev)))
>           return rc;
>
>       if ((rc = sanitise_afu_regs(afu)))
> @@ -792,29 +794,29 @@ static int cxl_configure_afu(struct cxl_afu *afu,
> struct cxl *adapter, struct pc
>       if ((rc = init_implementation_afu_regs(afu)))
>           goto err1;
>
> -    if ((rc = cxl_register_serr_irq(afu)))
> +    if ((rc = cxl_native_register_serr_irq(afu)))
>           goto err1;
>
> -    if ((rc = cxl_register_psl_irq(afu)))
> +    if ((rc = cxl_native_register_psl_irq(afu)))
>           goto err2;
>
>       return 0;
>
>   err2:
> -    cxl_release_serr_irq(afu);
> +    cxl_native_release_serr_irq(afu);
>   err1:
> -    cxl_unmap_slice_regs(afu);
> +    pci_unmap_slice_regs(afu);
>       return rc;
>   }
>
> -static void cxl_deconfigure_afu(struct cxl_afu *afu)
> +static void pci_deconfigure_afu(struct cxl_afu *afu)
>   {
> -    cxl_release_psl_irq(afu);
> -    cxl_release_serr_irq(afu);
> -    cxl_unmap_slice_regs(afu);
> +    cxl_native_release_psl_irq(afu);
> +    cxl_native_release_serr_irq(afu);
> +    pci_unmap_slice_regs(afu);
>   }
>
> -static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev
> *dev)
> +static int pci_init_afu(struct cxl *adapter, int slice, struct pci_dev
> *dev)
>   {
>       struct cxl_afu *afu;
>       int rc;
> @@ -827,7 +829,7 @@ static int cxl_init_afu(struct cxl *adapter, int
> slice, struct pci_dev *dev)
>       if (rc)
>           goto err_free;
>
> -    rc = cxl_configure_afu(afu, adapter, dev);
> +    rc = pci_configure_afu(afu, adapter, dev);
>       if (rc)
>           goto err_free;
>
> @@ -852,7 +854,7 @@ static int cxl_init_afu(struct cxl *adapter, int
> slice, struct pci_dev *dev)
>       return 0;
>
>   err_put1:
> -    cxl_deconfigure_afu(afu);
> +    pci_deconfigure_afu(afu);
>       cxl_debugfs_afu_remove(afu);
>       device_unregister(&afu->dev);
>       return rc;
> @@ -863,9 +865,9 @@ err_free:
>
>   }
>
> -static void cxl_remove_afu(struct cxl_afu *afu)
> +static void cxl_pci_remove_afu(struct cxl_afu *afu)
>   {
> -    pr_devel("cxl_remove_afu\n");
> +    pr_devel("%s\n", __func__);
>
>       if (!afu)
>           return;
> @@ -880,11 +882,11 @@ static void cxl_remove_afu(struct cxl_afu *afu)
>       cxl_context_detach_all(afu);
>       cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>
> -    cxl_deconfigure_afu(afu);
> +    pci_deconfigure_afu(afu);
>       device_unregister(&afu->dev);
>   }
>
> -int cxl_reset(struct cxl *adapter)
> +int cxl_pci_reset(struct cxl *adapter)
>   {
>       struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
>       int rc;
> @@ -1130,7 +1132,7 @@ static int cxl_configure_adapter(struct cxl
> *adapter, struct pci_dev *dev)
>       if ((rc = cxl_setup_psl_timebase(adapter, dev)))
>           goto err;
>
> -    if ((rc = cxl_register_psl_err_irq(adapter)))
> +    if ((rc = cxl_native_register_psl_err_irq(adapter)))
>           goto err;
>
>       return 0;
> @@ -1145,13 +1147,13 @@ static void cxl_deconfigure_adapter(struct cxl
> *adapter)
>   {
>       struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
>
> -    cxl_release_psl_err_irq(adapter);
> +    cxl_native_release_psl_err_irq(adapter);
>       cxl_unmap_adapter_regs(adapter);
>
>       pci_disable_device(pdev);
>   }
>
> -static struct cxl *cxl_init_adapter(struct pci_dev *dev)
> +static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>   {
>       struct cxl *adapter;
>       int rc;
> @@ -1198,7 +1200,7 @@ err_put1:
>       return ERR_PTR(rc);
>   }
>
> -static void cxl_remove_adapter(struct cxl *adapter)
> +static void cxl_pci_remove_adapter(struct cxl *adapter)
>   {
>       pr_devel("cxl_remove_adapter\n");
>
> @@ -1219,14 +1221,14 @@ static int cxl_probe(struct pci_dev *dev, const
> struct pci_device_id *id)
>       if (cxl_verbose)
>           dump_cxl_config_space(dev);
>
> -    adapter = cxl_init_adapter(dev);
> +    adapter = cxl_pci_init_adapter(dev);
>       if (IS_ERR(adapter)) {
>           dev_err(&dev->dev, "cxl_init_adapter failed: %li\n",
> PTR_ERR(adapter));
>           return PTR_ERR(adapter);
>       }
>
>       for (slice = 0; slice < adapter->slices; slice++) {
> -        if ((rc = cxl_init_afu(adapter, slice, dev))) {
> +        if ((rc = pci_init_afu(adapter, slice, dev))) {
>               dev_err(&dev->dev, "AFU %i failed to initialise: %i\n",
> slice, rc);
>               continue;
>           }
> @@ -1252,9 +1254,9 @@ static void cxl_remove(struct pci_dev *dev)
>       for (i = 0; i < adapter->slices; i++) {
>           afu = adapter->afu[i];
>           cxl_pci_vphb_remove(afu);
> -        cxl_remove_afu(afu);
> +        cxl_pci_remove_afu(afu);
>       }
> -    cxl_remove_adapter(adapter);
> +    cxl_pci_remove_adapter(adapter);
>   }
>
>   static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
> @@ -1401,7 +1403,7 @@ static pci_ers_result_t
> cxl_pci_error_detected(struct pci_dev *pdev,
>
>           cxl_context_detach_all(afu);
>           cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -        cxl_deconfigure_afu(afu);
> +        pci_deconfigure_afu(afu);
>       }
>       cxl_deconfigure_adapter(adapter);
>
> @@ -1424,7 +1426,7 @@ static pci_ers_result_t cxl_pci_slot_reset(struct
> pci_dev *pdev)
>       for (i = 0; i < adapter->slices; i++) {
>           afu = adapter->afu[i];
>
> -        if (cxl_configure_afu(afu, adapter, pdev))
> +        if (pci_configure_afu(afu, adapter, pdev))
>               goto err;
>
>           if (cxl_afu_select_best_mode(afu))
