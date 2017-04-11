Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2VB33dm3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 00:41:47 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3BEd9Hs119283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:41:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ru2t1tdv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:41:42 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 15:41:41 +0100
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 16:41:11 +0200
MIME-Version: 1.0
In-Reply-To: <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2584b575-bc19-d7d8-3017-7c462a5fa800@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/04/2017 à 16:11, Christophe Lombard a écrit :
> The new Coherent Accelerator Interface Architecture, level 2, for the
> IBM POWER9 brings new content and features:
> - POWER9 Service Layer
> - Registers
> - Radix mode
> - Process element entry
> - Dedicated-Shared Process Programming Model
> - Translation Fault Handling
> - CAPP
> - Memory Context ID
>     If a valid mm_struct is found the memory context id is used for each
>     transaction associated with the process handle. The PSL uses the
>     context ID to find the corresponding process element.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---


I'm ok with the code. However checkpatch is complaining about a 
tab/space error in native.c

If you have a quick respin, I also have a comment below about the 
documentation.


>  Documentation/powerpc/cxl.txt |  11 +-
>  drivers/misc/cxl/context.c    |  16 ++-
>  drivers/misc/cxl/cxl.h        | 137 +++++++++++++++++++----
>  drivers/misc/cxl/debugfs.c    |  19 ++++
>  drivers/misc/cxl/fault.c      |  64 +++++++----
>  drivers/misc/cxl/guest.c      |   8 +-
>  drivers/misc/cxl/irq.c        |  53 +++++++++
>  drivers/misc/cxl/native.c     | 225 +++++++++++++++++++++++++++++++++++---
>  drivers/misc/cxl/pci.c        | 246 +++++++++++++++++++++++++++++++++++++++---
>  drivers/misc/cxl/trace.h      |  43 ++++++++
>  10 files changed, 748 insertions(+), 74 deletions(-)
>
> diff --git a/Documentation/powerpc/cxl.txt b/Documentation/powerpc/cxl.txt
> index d5506ba0..4a77462 100644
> --- a/Documentation/powerpc/cxl.txt
> +++ b/Documentation/powerpc/cxl.txt
> @@ -21,7 +21,7 @@ Introduction
>  Hardware overview
>  =================
>
> -          POWER8               FPGA
> +         POWER8/9             FPGA
>         +----------+        +---------+
>         |          |        |         |
>         |   CPU    |        |   AFU   |
> @@ -34,7 +34,7 @@ Hardware overview
>         |   | CAPP |<------>|         |
>         +---+------+  PCIE  +---------+
>
> -    The POWER8 chip has a Coherently Attached Processor Proxy (CAPP)
> +    The POWER8/9 chip has a Coherently Attached Processor Proxy (CAPP)
>      unit which is part of the PCIe Host Bridge (PHB). This is managed
>      by Linux by calls into OPAL. Linux doesn't directly program the
>      CAPP.
> @@ -59,6 +59,13 @@ Hardware overview
>      the fault. The context to which this fault is serviced is based on
>      who owns that acceleration function.


> +    POWER8 <-----> PSL Version 8 is compliant to the CAIA Version 1.0.
> +    POWER9 <-----> PSL Version 9 is compliant to the CAIA Version 2.0.
> +    This PSL Version 9 provides new features as:
> +    * Native DMA support.
> +    * Supports sending ASB_Notify messages for host thread wakeup.
> +    * Supports Atomic operations.
> +    * ....


I think one of the most important difference is missing: the PSL on 
power9 uses the new nest MMU on the power9 chip and no longer has its 
own MMU.

   Fred

>
>  AFU Modes
>  =========
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index ac2531e..45363be 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -188,12 +188,24 @@ int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
>  	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
>  		if (start + len > ctx->afu->adapter->ps_size)
>  			return -EINVAL;
> +
> +		if (cxl_is_psl9(ctx->afu)) {
> +			/* make sure there is a valid problem state
> +			 * area space for this AFU
> +			 */
> +			if (ctx->master && !ctx->afu->psa) {
> +				pr_devel("AFU doesn't support mmio space\n");
> +				return -EINVAL;
> +			}
> +
> +			/* Can't mmap until the AFU is enabled */
> +			if (!ctx->afu->enabled)
> +				return -EBUSY;
> +		}
>  	} else {
>  		if (start + len > ctx->psn_size)
>  			return -EINVAL;
> -	}
>
> -	if (ctx->afu->current_mode != CXL_MODE_DEDICATED) {
>  		/* make sure there is a valid per process space for this AFU */
>  		if ((ctx->master && !ctx->afu->psa) || (!ctx->afu->pp_psa)) {
>  			pr_devel("AFU doesn't support mmio space\n");
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 82335c0..df40e6e 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -63,7 +63,7 @@ typedef struct {
>  /* Memory maps. Ref CXL Appendix A */
>
>  /* PSL Privilege 1 Memory Map */
> -/* Configuration and Control area */
> +/* Configuration and Control area - CAIA 1&2 */
>  static const cxl_p1_reg_t CXL_PSL_CtxTime = {0x0000};
>  static const cxl_p1_reg_t CXL_PSL_ErrIVTE = {0x0008};
>  static const cxl_p1_reg_t CXL_PSL_KEY1    = {0x0010};
> @@ -98,11 +98,29 @@ static const cxl_p1_reg_t CXL_XSL_Timebase  = {0x0100};
>  static const cxl_p1_reg_t CXL_XSL_TB_CTLSTAT = {0x0108};
>  static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
>  static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
> +/* PSL registers - CAIA 2 */
> +static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
> +static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
> +static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
> +static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
> +static const cxl_p1_reg_t CXL_PSL9_Timebase = {0x0310};
> +static const cxl_p1_reg_t CXL_PSL9_DEBUG    = {0x0320};
> +static const cxl_p1_reg_t CXL_PSL9_FIR_CNTL = {0x0348};
> +static const cxl_p1_reg_t CXL_PSL9_DSNDCTL  = {0x0350};
> +static const cxl_p1_reg_t CXL_PSL9_TB_CTLSTAT = {0x0340};
> +static const cxl_p1_reg_t CXL_PSL9_TRACECFG = {0x0368};
> +static const cxl_p1_reg_t CXL_PSL9_APCDEDALLOC = {0x0378};
> +static const cxl_p1_reg_t CXL_PSL9_APCDEDTYPE = {0x0380};
> +static const cxl_p1_reg_t CXL_PSL9_TNR_ADDR = {0x0388};
> +static const cxl_p1_reg_t CXL_PSL9_GP_CT = {0x0398};
> +static const cxl_p1_reg_t CXL_XSL9_IERAT = {0x0588};
> +static const cxl_p1_reg_t CXL_XSL9_ILPP  = {0x0590};
> +
>  /* 0x7F00:7FFF Reserved PCIe MSI-X Pending Bit Array area */
>  /* 0x8000:FFFF Reserved PCIe MSI-X Table Area */
>
>  /* PSL Slice Privilege 1 Memory Map */
> -/* Configuration Area */
> +/* Configuration Area - CAIA 1&2 */
>  static const cxl_p1n_reg_t CXL_PSL_SR_An          = {0x00};
>  static const cxl_p1n_reg_t CXL_PSL_LPID_An        = {0x08};
>  static const cxl_p1n_reg_t CXL_PSL_AMBAR_An       = {0x10};
> @@ -111,17 +129,18 @@ static const cxl_p1n_reg_t CXL_PSL_ID_An          = {0x20};
>  static const cxl_p1n_reg_t CXL_PSL_SERR_An        = {0x28};
>  /* Memory Management and Lookaside Buffer Management - CAIA 1*/
>  static const cxl_p1n_reg_t CXL_PSL_SDR_An         = {0x30};
> +/* Memory Management and Lookaside Buffer Management - CAIA 1&2 */
>  static const cxl_p1n_reg_t CXL_PSL_AMOR_An        = {0x38};
> -/* Pointer Area */
> +/* Pointer Area - CAIA 1&2 */
>  static const cxl_p1n_reg_t CXL_HAURP_An           = {0x80};
>  static const cxl_p1n_reg_t CXL_PSL_SPAP_An        = {0x88};
>  static const cxl_p1n_reg_t CXL_PSL_LLCMD_An       = {0x90};
> -/* Control Area */
> +/* Control Area - CAIA 1&2 */
>  static const cxl_p1n_reg_t CXL_PSL_SCNTL_An       = {0xA0};
>  static const cxl_p1n_reg_t CXL_PSL_CtxTime_An     = {0xA8};
>  static const cxl_p1n_reg_t CXL_PSL_IVTE_Offset_An = {0xB0};
>  static const cxl_p1n_reg_t CXL_PSL_IVTE_Limit_An  = {0xB8};
> -/* 0xC0:FF Implementation Dependent Area */
> +/* 0xC0:FF Implementation Dependent Area - CAIA 1&2 */
>  static const cxl_p1n_reg_t CXL_PSL_FIR_SLICE_An   = {0xC0};
>  static const cxl_p1n_reg_t CXL_AFU_DEBUG_An       = {0xC8};
>  /* 0xC0:FF Implementation Dependent Area - CAIA 1 */
> @@ -131,7 +150,7 @@ static const cxl_p1n_reg_t CXL_PSL_RXCTL_A        = {0xE0};
>  static const cxl_p1n_reg_t CXL_PSL_SLICE_TRACE    = {0xE8};
>
>  /* PSL Slice Privilege 2 Memory Map */
> -/* Configuration and Control Area */
> +/* Configuration and Control Area - CAIA 1&2 */
>  static const cxl_p2n_reg_t CXL_PSL_PID_TID_An = {0x000};
>  static const cxl_p2n_reg_t CXL_CSRP_An        = {0x008};
>  /* Configuration and Control Area - CAIA 1 */
> @@ -145,17 +164,17 @@ static const cxl_p2n_reg_t CXL_PSL_AMR_An     = {0x030};
>  static const cxl_p2n_reg_t CXL_SLBIE_An       = {0x040};
>  static const cxl_p2n_reg_t CXL_SLBIA_An       = {0x048};
>  static const cxl_p2n_reg_t CXL_SLBI_Select_An = {0x050};
> -/* Interrupt Registers */
> +/* Interrupt Registers - CAIA 1&2 */
>  static const cxl_p2n_reg_t CXL_PSL_DSISR_An   = {0x060};
>  static const cxl_p2n_reg_t CXL_PSL_DAR_An     = {0x068};
>  static const cxl_p2n_reg_t CXL_PSL_DSR_An     = {0x070};
>  static const cxl_p2n_reg_t CXL_PSL_TFC_An     = {0x078};
>  static const cxl_p2n_reg_t CXL_PSL_PEHandle_An = {0x080};
>  static const cxl_p2n_reg_t CXL_PSL_ErrStat_An = {0x088};
> -/* AFU Registers */
> +/* AFU Registers - CAIA 1&2 */
>  static const cxl_p2n_reg_t CXL_AFU_Cntl_An    = {0x090};
>  static const cxl_p2n_reg_t CXL_AFU_ERR_An     = {0x098};
> -/* Work Element Descriptor */
> +/* Work Element Descriptor - CAIA 1&2 */
>  static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>  /* 0x0C0:FFF Implementation Dependent Area */
>
> @@ -182,6 +201,10 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>  #define CXL_PSL_SR_An_SF  MSR_SF            /* 64bit */
>  #define CXL_PSL_SR_An_TA  (1ull << (63-1))  /* Tags active,   GA1: 0 */
>  #define CXL_PSL_SR_An_HV  MSR_HV            /* Hypervisor,    GA1: 0 */
> +#define CXL_PSL_SR_An_XLAT_hpt (0ull << (63-6))/* Hashed page table (HPT) mode */
> +#define CXL_PSL_SR_An_XLAT_roh (2ull << (63-6))/* Radix on HPT mode */
> +#define CXL_PSL_SR_An_XLAT_ror (3ull << (63-6))/* Radix on Radix mode */
> +#define CXL_PSL_SR_An_BOT (1ull << (63-10)) /* Use the in-memory segment table */
>  #define CXL_PSL_SR_An_PR  MSR_PR            /* Problem state, GA1: 1 */
>  #define CXL_PSL_SR_An_ISL (1ull << (63-53)) /* Ignore Segment Large Page */
>  #define CXL_PSL_SR_An_TC  (1ull << (63-54)) /* Page Table secondary hash */
> @@ -298,12 +321,38 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>  #define CXL_PSL_DSISR_An_S  DSISR_ISSTORE     /* Access was afu_wr or afu_zero */
>  #define CXL_PSL_DSISR_An_K  DSISR_KEYFAULT    /* Access not permitted by virtual page class key protection */
>
> +/****** CXL_PSL_DSISR_An - CAIA 2 ****************************************************/
> +#define CXL_PSL9_DSISR_An_TF (1ull << (63-3))  /* Translation fault */
> +#define CXL_PSL9_DSISR_An_PE (1ull << (63-4))  /* PSL Error (implementation specific) */
> +#define CXL_PSL9_DSISR_An_AE (1ull << (63-5))  /* AFU Error */
> +#define CXL_PSL9_DSISR_An_OC (1ull << (63-6))  /* OS Context Warning */
> +#define CXL_PSL9_DSISR_An_S (1ull << (63-38))  /* TF for a write operation */
> +#define CXL_PSL9_DSISR_PENDING (CXL_PSL9_DSISR_An_TF | CXL_PSL9_DSISR_An_PE | CXL_PSL9_DSISR_An_AE | CXL_PSL9_DSISR_An_OC)
> +/* NOTE: Bits 56:63 (Checkout Response Status) are valid when DSISR_An[TF] = 1
> + * Status (0:7) Encoding
> + */
> +#define CXL_PSL9_DSISR_An_CO_MASK 0x00000000000000ffULL
> +#define CXL_PSL9_DSISR_An_SF      0x0000000000000080ULL  /* Segment Fault                        0b10000000 */
> +#define CXL_PSL9_DSISR_An_PF_SLR  0x0000000000000088ULL  /* PTE not found (Single Level Radix)   0b10001000 */
> +#define CXL_PSL9_DSISR_An_PF_RGC  0x000000000000008CULL  /* PTE not found (Radix Guest (child))  0b10001100 */
> +#define CXL_PSL9_DSISR_An_PF_RGP  0x0000000000000090ULL  /* PTE not found (Radix Guest (parent)) 0b10010000 */
> +#define CXL_PSL9_DSISR_An_PF_HRH  0x0000000000000094ULL  /* PTE not found (HPT/Radix Host)       0b10010100 */
> +#define CXL_PSL9_DSISR_An_PF_STEG 0x000000000000009CULL  /* PTE not found (STEG VA)              0b10011100 */
> +
>  /****** CXL_PSL_TFC_An ******************************************************/
>  #define CXL_PSL_TFC_An_A  (1ull << (63-28)) /* Acknowledge non-translation fault */
>  #define CXL_PSL_TFC_An_C  (1ull << (63-29)) /* Continue (abort transaction) */
>  #define CXL_PSL_TFC_An_AE (1ull << (63-30)) /* Restart PSL with address error */
>  #define CXL_PSL_TFC_An_R  (1ull << (63-31)) /* Restart PSL transaction */
>
> +/****** CXL_XSL9_IERAT_ERAT - CAIA 2 **********************************/
> +#define CXL_XSL9_IERAT_MLPID    (1ull << (63-0))  /* Match LPID */
> +#define CXL_XSL9_IERAT_MPID     (1ull << (63-1))  /* Match PID */
> +#define CXL_XSL9_IERAT_PRS      (1ull << (63-4))  /* PRS bit for Radix invalidations */
> +#define CXL_XSL9_IERAT_INVR     (1ull << (63-3))  /* Invalidate Radix */
> +#define CXL_XSL9_IERAT_IALL     (1ull << (63-8))  /* Invalidate All */
> +#define CXL_XSL9_IERAT_IINPROG  (1ull << (63-63)) /* Invalidate in progress */
> +
>  /* cxl_process_element->software_status */
>  #define CXL_PE_SOFTWARE_STATE_V (1ul << (31 -  0)) /* Valid */
>  #define CXL_PE_SOFTWARE_STATE_C (1ul << (31 - 29)) /* Complete */
> @@ -654,25 +703,38 @@ int cxl_pci_reset(struct cxl *adapter);
>  void cxl_pci_release_afu(struct device *dev);
>  ssize_t cxl_pci_read_adapter_vpd(struct cxl *adapter, void *buf, size_t len);
>
> -/* common == phyp + powernv */
> +/* common == phyp + powernv - CAIA 1&2 */
>  struct cxl_process_element_common {
>  	__be32 tid;
>  	__be32 pid;
>  	__be64 csrp;
> -	__be64 aurp0;
> -	__be64 aurp1;
> -	__be64 sstp0;
> -	__be64 sstp1;
> +	union {
> +		struct {
> +			__be64 aurp0;
> +			__be64 aurp1;
> +			__be64 sstp0;
> +			__be64 sstp1;
> +		} psl8;  /* CAIA 1 */
> +		struct {
> +			u8     reserved2[8];
> +			u8     reserved3[8];
> +			u8     reserved4[8];
> +			u8     reserved5[8];
> +		} psl9;  /* CAIA 2 */
> +	} u;
>  	__be64 amr;
> -	u8     reserved3[4];
> +	u8     reserved6[4];
>  	__be64 wed;
>  } __packed;
>
> -/* just powernv */
> +/* just powernv - CAIA 1&2 */
>  struct cxl_process_element {
>  	__be64 sr;
>  	__be64 SPOffset;
> -	__be64 sdr;
> +	union {
> +		__be64 sdr;          /* CAIA 1 */
> +		u8     reserved1[8]; /* CAIA 2 */
> +	} u;
>  	__be64 haurp;
>  	__be32 ctxtime;
>  	__be16 ivte_offsets[4];
> @@ -761,6 +823,16 @@ static inline bool cxl_is_power8(void)
>  	return false;
>  }
>
> +static inline bool cxl_is_power9(void)
> +{
> +	/* intermediate solution */
> +	if (!cxl_is_power8() &&
> +	   (cpu_has_feature(CPU_FTRS_POWER9) ||
> +	    cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +		return true;
> +	return false;
> +}
> +
>  static inline bool cxl_is_psl8(struct cxl_afu *afu)
>  {
>  	if (afu->adapter->caia_major == 1)
> @@ -768,6 +840,13 @@ static inline bool cxl_is_psl8(struct cxl_afu *afu)
>  	return false;
>  }
>
> +static inline bool cxl_is_psl9(struct cxl_afu *afu)
> +{
> +	if (afu->adapter->caia_major == 2)
> +		return true;
> +	return false;
> +}
> +
>  ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
>  				loff_t off, size_t count);
>
> @@ -794,7 +873,6 @@ int cxl_update_properties(struct device_node *dn, struct property *new_prop);
>
>  void cxl_remove_adapter_nr(struct cxl *adapter);
>
> -int cxl_alloc_spa(struct cxl_afu *afu);
>  void cxl_release_spa(struct cxl_afu *afu);
>
>  dev_t cxl_get_dev(void);
> @@ -832,9 +910,13 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count);
>  void afu_release_irqs(struct cxl_context *ctx, void *cookie);
>  void afu_irq_name_free(struct cxl_context *ctx);
>
> +int cxl_attach_afu_directed_psl9(struct cxl_context *ctx, u64 wed, u64 amr);
>  int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> +int cxl_activate_dedicated_process_psl9(struct cxl_afu *afu);
>  int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu);
> +int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr);
>  int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> +void cxl_update_dedicated_ivtes_psl9(struct cxl_context *ctx);
>  void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx);
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -845,9 +927,12 @@ int cxl_debugfs_adapter_add(struct cxl *adapter);
>  void cxl_debugfs_adapter_remove(struct cxl *adapter);
>  int cxl_debugfs_afu_add(struct cxl_afu *afu);
>  void cxl_debugfs_afu_remove(struct cxl_afu *afu);
> +void cxl_stop_trace_psl9(struct cxl *cxl);
>  void cxl_stop_trace_psl8(struct cxl *cxl);
> +void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir);
>  void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
>  void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir);
> +void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir);
>  void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir);
>
>  #else /* CONFIG_DEBUG_FS */
> @@ -879,10 +964,19 @@ static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
>  {
>  }
>
> +static inline void cxl_stop_trace_psl9(struct cxl *cxl)
> +{
> +}
> +
>  static inline void cxl_stop_trace_psl8(struct cxl *cxl)
>  {
>  }
>
> +static inline void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
> +						    struct dentry *dir)
> +{
> +}
> +
>  static inline void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
>  						    struct dentry *dir)
>  {
> @@ -893,6 +987,10 @@ static inline void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter,
>  {
>  }
>
> +static inline void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
> +{
> +}
> +
>  static inline void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
>  {
>  }
> @@ -938,7 +1036,9 @@ struct cxl_irq_info {
>  };
>
>  void cxl_assign_psn_space(struct cxl_context *ctx);
> +int cxl_invalidate_all_psl9(struct cxl *adapter);
>  int cxl_invalidate_all_psl8(struct cxl *adapter);
> +irqreturn_t cxl_irq_psl9(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
>  irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
>  irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
>  int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
> @@ -951,6 +1051,7 @@ int cxl_data_cache_flush(struct cxl *adapter);
>  int cxl_afu_disable(struct cxl_afu *afu);
>  int cxl_psl_purge(struct cxl_afu *afu);
>
> +void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
>  void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx);
>  void cxl_native_err_irq_dump_regs(struct cxl *adapter);
>  int cxl_pci_vphb_add(struct cxl_afu *afu);
> diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
> index 43a1a27..eae9d74 100644
> --- a/drivers/misc/cxl/debugfs.c
> +++ b/drivers/misc/cxl/debugfs.c
> @@ -15,6 +15,12 @@
>
>  static struct dentry *cxl_debugfs;
>
> +void cxl_stop_trace_psl9(struct cxl *adapter)
> +{
> +	/* Stop the trace */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x4480000000000000ULL);
> +}
> +
>  void cxl_stop_trace_psl8(struct cxl *adapter)
>  {
>  	int slice;
> @@ -53,6 +59,14 @@ static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
>  					  (void __force *)value, &fops_io_x64);
>  }
>
> +void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
> +{
> +	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR1));
> +	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR2));
> +	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR_CNTL));
> +	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_TRACECFG));
> +}
> +
>  void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
>  {
>  	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
> @@ -92,6 +106,11 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
>  	debugfs_remove_recursive(adapter->debugfs);
>  }
>
> +void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
> +{
> +	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
> +}
> +
>  void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
>  {
>  	debugfs_create_io_x64("sstp0", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index e6f8f05..5344448 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -146,25 +146,26 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>  		return cxl_ack_ae(ctx);
>  	}
>
> -	/*
> -	 * update_mmu_cache() will not have loaded the hash since current->trap
> -	 * is not a 0x400 or 0x300, so just call hash_page_mm() here.
> -	 */
> -	access = _PAGE_PRESENT | _PAGE_READ;
> -	if (dsisr & CXL_PSL_DSISR_An_S)
> -		access |= _PAGE_WRITE;
> -
> -	access |= _PAGE_PRIVILEGED;
> -	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
> -		access &= ~_PAGE_PRIVILEGED;
> -
> -	if (dsisr & DSISR_NOHPTE)
> -		inv_flags |= HPTE_NOHPTE_UPDATE;
> -
> -	local_irq_save(flags);
> -	hash_page_mm(mm, dar, access, 0x300, inv_flags);
> -	local_irq_restore(flags);
> -
> +	if (!radix_enabled()) {
> +		/*
> +		 * update_mmu_cache() will not have loaded the hash since current->trap
> +		 * is not a 0x400 or 0x300, so just call hash_page_mm() here.
> +		 */
> +		access = _PAGE_PRESENT | _PAGE_READ;
> +		if (dsisr & CXL_PSL_DSISR_An_S)
> +			access |= _PAGE_WRITE;
> +
> +		access |= _PAGE_PRIVILEGED;
> +		if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
> +			access &= ~_PAGE_PRIVILEGED;
> +
> +		if (dsisr & DSISR_NOHPTE)
> +			inv_flags |= HPTE_NOHPTE_UPDATE;
> +
> +		local_irq_save(flags);
> +		hash_page_mm(mm, dar, access, 0x300, inv_flags);
> +		local_irq_restore(flags);
> +	}
>  	pr_devel("Page fault successfully handled for pe: %i!\n", ctx->pe);
>  	cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
>  }
> @@ -184,7 +185,28 @@ static struct mm_struct *get_mem_context(struct cxl_context *ctx)
>  	return ctx->mm;
>  }
>
> +static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
> +{
> +	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DS))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
> +{
> +	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DM))
> +		return true;
> +
> +	if ((cxl_is_psl9(ctx->afu)) &&
> +	   ((dsisr & CXL_PSL9_DSISR_An_CO_MASK) &
> +		(CXL_PSL9_DSISR_An_PF_SLR | CXL_PSL9_DSISR_An_PF_RGC |
> +		 CXL_PSL9_DSISR_An_PF_RGP | CXL_PSL9_DSISR_An_PF_HRH |
> +		 CXL_PSL9_DSISR_An_PF_STEG)))
> +		return true;
>
> +	return false;
> +}
>
>  void cxl_handle_fault(struct work_struct *fault_work)
>  {
> @@ -230,9 +252,9 @@ void cxl_handle_fault(struct work_struct *fault_work)
>  		}
>  	}
>
> -	if (dsisr & CXL_PSL_DSISR_An_DS)
> +	if (cxl_is_segment_miss(ctx, dsisr))
>  		cxl_handle_segment_miss(ctx, mm, dar);
> -	else if (dsisr & CXL_PSL_DSISR_An_DM)
> +	else if (cxl_is_page_fault(ctx, dsisr))
>  		cxl_handle_page_fault(ctx, mm, dsisr, dar);
>  	else
>  		WARN(1, "cxl_handle_fault has nothing to handle\n");
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index 3ad7381..f58b4b6c 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -551,13 +551,13 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
>  	elem->common.tid    = cpu_to_be32(0); /* Unused */
>  	elem->common.pid    = cpu_to_be32(pid);
>  	elem->common.csrp   = cpu_to_be64(0); /* disable */
> -	elem->common.aurp0  = cpu_to_be64(0); /* disable */
> -	elem->common.aurp1  = cpu_to_be64(0); /* disable */
> +	elem->common.u.psl8.aurp0  = cpu_to_be64(0); /* disable */
> +	elem->common.u.psl8.aurp1  = cpu_to_be64(0); /* disable */
>
>  	cxl_prefault(ctx, wed);
>
> -	elem->common.sstp0  = cpu_to_be64(ctx->sstp0);
> -	elem->common.sstp1  = cpu_to_be64(ctx->sstp1);
> +	elem->common.u.psl8.sstp0  = cpu_to_be64(ctx->sstp0);
> +	elem->common.u.psl8.sstp1  = cpu_to_be64(ctx->sstp1);
>
>  	/*
>  	 * Ensure we have at least one interrupt allocated to take faults for
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index fa9f8a2..1eb5168 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -34,6 +34,59 @@ static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 da
>  	return IRQ_HANDLED;
>  }
>
> +irqreturn_t cxl_irq_psl9(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
> +{
> +	u64 dsisr, dar;
> +
> +	dsisr = irq_info->dsisr;
> +	dar = irq_info->dar;
> +
> +	trace_cxl_psl9_irq(ctx, irq, dsisr, dar);
> +
> +	pr_devel("CXL interrupt %i for afu pe: %i DSISR: %#llx DAR: %#llx\n", irq, ctx->pe, dsisr, dar);
> +
> +	if (dsisr & CXL_PSL9_DSISR_An_TF) {
> +		pr_devel("CXL interrupt: Scheduling translation fault"
> +			 " handling for later (pe: %i)\n", ctx->pe);
> +		return schedule_cxl_fault(ctx, dsisr, dar);
> +	}
> +
> +	if (dsisr & CXL_PSL9_DSISR_An_PE)
> +		return cxl_ops->handle_psl_slice_error(ctx, dsisr,
> +						irq_info->errstat);
> +	if (dsisr & CXL_PSL9_DSISR_An_AE) {
> +		pr_devel("CXL interrupt: AFU Error 0x%016llx\n", irq_info->afu_err);
> +
> +		if (ctx->pending_afu_err) {
> +			/*
> +			 * This shouldn't happen - the PSL treats these errors
> +			 * as fatal and will have reset the AFU, so there's not
> +			 * much point buffering multiple AFU errors.
> +			 * OTOH if we DO ever see a storm of these come in it's
> +			 * probably best that we log them somewhere:
> +			 */
> +			dev_err_ratelimited(&ctx->afu->dev, "CXL AFU Error "
> +					    "undelivered to pe %i: 0x%016llx\n",
> +					    ctx->pe, irq_info->afu_err);
> +		} else {
> +			spin_lock(&ctx->lock);
> +			ctx->afu_err = irq_info->afu_err;
> +			ctx->pending_afu_err = 1;
> +			spin_unlock(&ctx->lock);
> +
> +			wake_up_all(&ctx->wq);
> +		}
> +
> +		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_A, 0);
> +		return IRQ_HANDLED;
> +	}
> +	if (dsisr & CXL_PSL9_DSISR_An_OC)
> +		pr_devel("CXL interrupt: OS Context Warning\n");
> +
> +	WARN(1, "Unhandled CXL PSL IRQ\n");
> +	return IRQ_HANDLED;
> +}
> +
>  irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
>  {
>  	u64 dsisr, dar;
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 0401e4dc..1e3c5c2 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -120,6 +120,7 @@ int cxl_psl_purge(struct cxl_afu *afu)
>  	u64 AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
>  	u64 dsisr, dar;
>  	u64 start, end;
> +	u64 trans_fault = 0x0ULL;
>  	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
>  	int rc = 0;
>
> @@ -127,6 +128,11 @@ int cxl_psl_purge(struct cxl_afu *afu)
>
>  	pr_devel("PSL purge request\n");
>
> +	if (cxl_is_psl8(afu))
> +		trans_fault = CXL_PSL_DSISR_TRANS;
> +	if (cxl_is_psl9(afu))
> +		trans_fault = CXL_PSL9_DSISR_An_TF;
> +
>  	if (!cxl_ops->link_ok(afu->adapter, afu)) {
>  		dev_warn(&afu->dev, "PSL Purge called with link down, ignoring\n");
>  		rc = -EIO;
> @@ -159,12 +165,12 @@ int cxl_psl_purge(struct cxl_afu *afu)
>  				     "  PSL_DSISR: 0x%016llx\n",
>  				     PSL_CNTL, dsisr);
>
> -		if (dsisr & CXL_PSL_DSISR_TRANS) {
> +		if (dsisr & trans_fault) {
>  			dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
>  			dev_notice(&afu->dev, "PSL purge terminating "
>  					      "pending translation, "
>  					      "DSISR: 0x%016llx, DAR: 0x%016llx\n",
> -					       dsisr, dar);
> +					      dsisr, dar);
>  			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
>  		} else if (dsisr) {
>  			dev_notice(&afu->dev, "PSL purge acknowledging "
> @@ -204,7 +210,7 @@ static int spa_max_procs(int spa_size)
>  	return ((spa_size / 8) - 96) / 17;
>  }
>
> -int cxl_alloc_spa(struct cxl_afu *afu)
> +static int cxl_alloc_spa(struct cxl_afu *afu, int mode)
>  {
>  	unsigned spa_size;
>
> @@ -217,7 +223,8 @@ int cxl_alloc_spa(struct cxl_afu *afu)
>  		if (spa_size > 0x100000) {
>  			dev_warn(&afu->dev, "num_of_processes too large for the SPA, limiting to %i (0x%x)\n",
>  					afu->native->spa_max_procs, afu->native->spa_size);
> -			afu->num_procs = afu->native->spa_max_procs;
> +			if (mode != CXL_MODE_DEDICATED)
> +				afu->num_procs = afu->native->spa_max_procs;
>  			break;
>  		}
>
> @@ -266,6 +273,35 @@ void cxl_release_spa(struct cxl_afu *afu)
>  	}
>  }
>
> +/* Invalidation of all ERAT entries is no longer required by CAIA2. Use
> + * only for debug
> + */
> +int cxl_invalidate_all_psl9(struct cxl *adapter)
> +{
> +	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> +	u64 ierat;
> +
> +	pr_devel("CXL adapter - invalidation of all ERAT entries\n");
> +
> +	/* Invalidates all ERAT entries for Radix or HPT */
> +	ierat = CXL_XSL9_IERAT_IALL;
> +	if (radix_enabled())
> +		ierat |= CXL_XSL9_IERAT_INVR;
> +	cxl_p1_write(adapter, CXL_XSL9_IERAT, ierat);
> +
> +	while (cxl_p1_read(adapter, CXL_XSL9_IERAT) & CXL_XSL9_IERAT_IINPROG) {
> +		if (time_after_eq(jiffies, timeout)) {
> +			dev_warn(&adapter->dev,
> +			"WARNING: CXL adapter invalidation of all ERAT entries timed out!\n");
> +			return -EBUSY;
> +		}
> +		if (!cxl_ops->link_ok(adapter, NULL))
> +			return -EIO;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
>  int cxl_invalidate_all_psl8(struct cxl *adapter)
>  {
>  	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> @@ -502,7 +538,7 @@ static int activate_afu_directed(struct cxl_afu *afu)
>
>  	afu->num_procs = afu->max_procs_virtualised;
>  	if (afu->native->spa == NULL) {
> -		if (cxl_alloc_spa(afu))
> +		if (cxl_alloc_spa(afu, CXL_MODE_DIRECTED))
>  			return -ENOMEM;
>  	}
>  	attach_spa(afu);
> @@ -552,10 +588,19 @@ static u64 calculate_sr(struct cxl_context *ctx)
>  		sr |= (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
>  	} else {
>  		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
> -		sr &= ~(CXL_PSL_SR_An_HV);
> +		if (radix_enabled())
> +			sr |= CXL_PSL_SR_An_HV;
> +		else
> +			sr &= ~(CXL_PSL_SR_An_HV);
>  		if (!test_tsk_thread_flag(current, TIF_32BIT))
>  			sr |= CXL_PSL_SR_An_SF;
>  	}
> +	if (cxl_is_psl9(ctx->afu)) {
> +		if (radix_enabled())
> +			sr |= CXL_PSL_SR_An_XLAT_ror;
> +		else
> +			sr |= CXL_PSL_SR_An_XLAT_hpt;
> +	}
>  	return sr;
>  }
>
> @@ -588,6 +633,70 @@ static void update_ivtes_directed(struct cxl_context *ctx)
>  		WARN_ON(add_process_element(ctx));
>  }
>
> +static int process_element_entry_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> +{
> +	u32 pid;
> +
> +	cxl_assign_psn_space(ctx);
> +
> +	ctx->elem->ctxtime = 0; /* disable */
> +	ctx->elem->lpid = cpu_to_be32(mfspr(SPRN_LPID));
> +	ctx->elem->haurp = 0; /* disable */
> +
> +	if (ctx->kernel)
> +		pid = 0;
> +	else {
> +		if (ctx->mm == NULL) {
> +			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
> +				__func__, ctx->pe, pid_nr(ctx->pid));
> +			return -EINVAL;
> +		}
> +		pid = ctx->mm->context.id;
> +	}
> +
> +	ctx->elem->common.tid = 0;
> +	ctx->elem->common.pid = cpu_to_be32(pid);
> +
> +	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
> +
> +	ctx->elem->common.csrp = 0; /* disable */
> +
> +	cxl_prefault(ctx, wed);
> +
> +	/*
> +	 * Ensure we have the multiplexed PSL interrupt set up to take faults
> +	 * for kernel contexts that may not have allocated any AFU IRQs at all:
> +	 */
> +	if (ctx->irqs.range[0] == 0) {
> +		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
> +		ctx->irqs.range[0] = 1;
> +	}
> +
> +	ctx->elem->common.amr = cpu_to_be64(amr);
> +	ctx->elem->common.wed = cpu_to_be64(wed);
> +
> +	return 0;
> +}
> +
> +int cxl_attach_afu_directed_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> +{
> +	int result;
> +
> +	/* fill the process element entry */
> +	result = process_element_entry_psl9(ctx, wed, amr);
> +	if (result)
> +		return result;
> +
> +	update_ivtes_directed(ctx);
> +
> +	/* first guy needs to enable */
> +	result = cxl_ops->afu_check_and_enable(ctx->afu);
> +	if (result)
> +		return result;
> +
> +	return add_process_element(ctx);
> +}
> +
>  int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  {
>  	u32 pid;
> @@ -598,7 +707,7 @@ int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  	ctx->elem->ctxtime = 0; /* disable */
>  	ctx->elem->lpid = cpu_to_be32(mfspr(SPRN_LPID));
>  	ctx->elem->haurp = 0; /* disable */
> -	ctx->elem->sdr = cpu_to_be64(mfspr(SPRN_SDR1));
> +	ctx->elem->u.sdr = cpu_to_be64(mfspr(SPRN_SDR1));
>
>  	pid = current->pid;
>  	if (ctx->kernel)
> @@ -609,13 +718,13 @@ int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
>
>  	ctx->elem->common.csrp = 0; /* disable */
> -	ctx->elem->common.aurp0 = 0; /* disable */
> -	ctx->elem->common.aurp1 = 0; /* disable */
> +	ctx->elem->common.u.psl8.aurp0 = 0; /* disable */
> +	ctx->elem->common.u.psl8.aurp1 = 0; /* disable */
>
>  	cxl_prefault(ctx, wed);
>
> -	ctx->elem->common.sstp0 = cpu_to_be64(ctx->sstp0);
> -	ctx->elem->common.sstp1 = cpu_to_be64(ctx->sstp1);
> +	ctx->elem->common.u.psl8.sstp0 = cpu_to_be64(ctx->sstp0);
> +	ctx->elem->common.u.psl8.sstp1 = cpu_to_be64(ctx->sstp1);
>
>  	/*
>  	 * Ensure we have the multiplexed PSL interrupt set up to take faults
> @@ -681,6 +790,31 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
>  	return 0;
>  }
>
> +int cxl_activate_dedicated_process_psl9(struct cxl_afu *afu)
> +{
> +	dev_info(&afu->dev, "Activating dedicated process mode\n");
> +
> +	/* If XSL is set to dedicated mode (Set in PSL_SCNTL reg), the
> +	 * XSL and AFU are programmed to work with a single context.
> +	 * The context information should be configured in the SPA area
> +	 * index 0 (so PSL_SPAP must be configured before enabling the
> +	 * AFU).
> +	 */
> +	afu->num_procs = 1;
> +	if (afu->native->spa == NULL) {
> +		if (cxl_alloc_spa(afu, CXL_MODE_DEDICATED))
> +			return -ENOMEM;
> +	}
> +	attach_spa(afu);
> +
> +	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_Process);
> +	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
> +
> +	afu->current_mode = CXL_MODE_DEDICATED;
> +
> +	return cxl_chardev_d_afu_add(afu);
> +}
> +
>  int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu)
>  {
>  	dev_info(&afu->dev, "Activating dedicated process mode\n");
> @@ -704,6 +838,16 @@ int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu)
>  	return cxl_chardev_d_afu_add(afu);
>  }
>
> +void cxl_update_dedicated_ivtes_psl9(struct cxl_context *ctx)
> +{
> +	int r;
> +
> +	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> +		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
> +		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
> +	}
> +}
> +
>  void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx)
>  {
>  	struct cxl_afu *afu = ctx->afu;
> @@ -720,6 +864,26 @@ void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx)
>  			((u64)ctx->irqs.range[3] & 0xffff));
>  }
>
> +int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> +{
> +	struct cxl_afu *afu = ctx->afu;
> +	int result;
> +
> +	/* fill the process element entry */
> +	result = process_element_entry_psl9(ctx, wed, amr);
> +	if (result)
> +		return result;
> +
> +	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
> +		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
> +
> +	result = cxl_ops->afu_reset(afu);
> +	if (result)
> +		return result;
> +
> +	return afu_enable(afu);
> +}
> +
>  int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
>  {
>  	struct cxl_afu *afu = ctx->afu;
> @@ -891,6 +1055,21 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
>  	return 0;
>  }
>
> +void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx)
> +{
> +	u64 fir1, fir2, serr;
> +
> +	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL9_FIR1);
> +	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL9_FIR2);
> +
> +	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
> +	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
> +	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
> +		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> +		cxl_afu_decode_psl_serr(ctx->afu, serr);
> +	}
> +}
> +
>  void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx)
>  {
>  	u64 fir1, fir2, fir_slice, serr, afu_debug;
> @@ -927,9 +1106,20 @@ static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
>  	return cxl_ops->ack_irq(ctx, 0, errstat);
>  }
>
> +static bool cxl_is_translation_fault(struct cxl_afu *afu, u64 dsisr)
> +{
> +	if ((cxl_is_psl8(afu)) && (dsisr & CXL_PSL_DSISR_TRANS))
> +		return true;
> +
> +	if ((cxl_is_psl9(afu)) && (dsisr & CXL_PSL9_DSISR_An_TF))
> +		return true;
> +
> +	return false;
> +}
> +
>  irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
>  {
> -	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> +	if (cxl_is_translation_fault(afu, irq_info->dsisr))
>  		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
>  	else
>  		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> @@ -998,6 +1188,9 @@ static void native_irq_wait(struct cxl_context *ctx)
>  		if (cxl_is_psl8(ctx->afu) &&
>  		   ((dsisr & CXL_PSL_DSISR_PENDING) == 0))
>  			return;
> +		if (cxl_is_psl9(ctx->afu) &&
> +		   ((dsisr & CXL_PSL9_DSISR_PENDING) == 0))
> +			return;
>  		/*
>  		 * We are waiting for the workqueue to process our
>  		 * irq, so need to let that run here.
> @@ -1125,7 +1318,13 @@ int cxl_native_register_serr_irq(struct cxl_afu *afu)
>
>  	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
>  	if (cxl_is_power8())
> -		serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
> + 		serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
> +	if (cxl_is_power9()) {
> +		/* By default, all errors are masked. So don't set all masks.
> +		 * Slice errors will be transfered.
> +		 */
> +		serr = (serr & ~0xff0000007fffffffULL) | (afu->serr_hwirq & 0xffff);
> +	}
>  	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
>
>  	return 0;
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index a910115..1789ad8 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -60,7 +60,7 @@
>  #define CXL_VSEC_PROTOCOL_MASK   0xe0
>  #define CXL_VSEC_PROTOCOL_1024TB 0x80
>  #define CXL_VSEC_PROTOCOL_512TB  0x40
> -#define CXL_VSEC_PROTOCOL_256TB  0x20 /* Power 8 uses this */
> +#define CXL_VSEC_PROTOCOL_256TB  0x20 /* Power 8/9 uses this */
>  #define CXL_VSEC_PROTOCOL_ENABLE 0x01
>
>  #define CXL_READ_VSEC_PSL_REVISION(dev, vsec, dest) \
> @@ -326,14 +326,20 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
>
>  #define P8_CAPP_UNIT0_ID 0xBA
>  #define P8_CAPP_UNIT1_ID 0XBE
> +#define P9_CAPP_UNIT0_ID 0xC0
> +#define P9_CAPP_UNIT1_ID 0xE0
>
> -static u64 get_capp_unit_id(struct device_node *np)
> +static u32 get_phb_index(struct device_node *np)
>  {
>  	u32 phb_index;
>
>  	if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
> -		return 0;
> +		return -ENODEV;
> +	return phb_index;
> +}
>
> +static u64 get_capp_unit_id(struct device_node *np, u32 phb_index)
> +{
>  	/*
>  	 * POWER 8:
>  	 *  - For chips other than POWER8NVL, we only have CAPP 0,
> @@ -352,10 +358,25 @@ static u64 get_capp_unit_id(struct device_node *np)
>  			return P8_CAPP_UNIT1_ID;
>  	}
>
> +	/*
> +	 * POWER 9:
> +	 *   PEC0 (PHB0). Capp ID = CAPP0 (0b1100_0000)
> +	 *   PEC1 (PHB1 - PHB2). No capi mode
> +	 *   PEC2 (PHB3 - PHB4 - PHB5): Capi mode on PHB3 only. Capp ID = CAPP1 (0b1110_0000)
> +	 */
> +	if (cxl_is_power9()) {
> +		if (phb_index == 0)
> +			return P9_CAPP_UNIT0_ID;
> +
> +		if (phb_index == 3)
> +			return P9_CAPP_UNIT1_ID;
> +	}
> +
>  	return 0;
>  }
>
> -static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id)
> +static int calc_capp_routing(struct pci_dev *dev, u64 *chipid,
> +			     u32 *phb_index, u64 *capp_unit_id)
>  {
>  	struct device_node *np;
>  	const __be32 *prop;
> @@ -367,8 +388,16 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
>  		np = of_get_next_parent(np);
>  	if (!np)
>  		return -ENODEV;
> +
>  	*chipid = be32_to_cpup(prop);
> -	*capp_unit_id = get_capp_unit_id(np);
> +
> +	*phb_index = get_phb_index(np);
> +	if (*phb_index == -ENODEV) {
> +		pr_err("cxl: invalid phb index\n");
> +		return -ENODEV;
> +	}
> +
> +	*capp_unit_id = get_capp_unit_id(np, *phb_index);
>  	of_node_put(np);
>  	if (!*capp_unit_id) {
>  		pr_err("cxl: invalid capp unit id\n");
> @@ -378,14 +407,97 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
>  	return 0;
>  }
>
> +static int init_implementation_adapter_regs_psl9(struct cxl *adapter, struct pci_dev *dev)
> +{
> +	u64 xsl_dsnctl, psl_fircntl;
> +	u64 chipid;
> +	u32 phb_index;
> +	u64 capp_unit_id;
> +	int rc;
> +
> +	rc = calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
> +	if (rc)
> +		return rc;
> +
> +	/* CAPI Identifier bits [0:7]
> +	 * bit 61:60 MSI bits --> 0
> +	 * bit 59 TVT selector --> 0
> +	 */
> +	/* Tell XSL where to route data to.
> +	 * The field chipid should match the PHB CAPI_CMPM register
> +	 */
> +	xsl_dsnctl = ((u64)0x2 << (63-7)); /* Bit 57 */
> +	xsl_dsnctl |= (capp_unit_id << (63-15));
> +
> +	/* nMMU_ID Defaults to: b’000001001’*/
> +	xsl_dsnctl |= ((u64)0x09 << (63-28));
> +
> +	if (cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +		/* Used to identify CAPI packets which should be sorted into
> +		 * the Non-Blocking queues by the PHB. This field should match
> +		 * the PHB PBL_NBW_CMPM register
> +		 * nbwind=0x03, bits [57:58], must include capi indicator.
> +		 * Not supported on P9 DD1.
> +		 */
> +		xsl_dsnctl |= ((u64)0x03 << (63-47));
> +
> +		/* Upper 16b address bits of ASB_Notify messages sent to the
> +		 * system. Need to match the PHB’s ASN Compare/Mask Register.
> +		 * Not supported on P9 DD1.
> +		 */
> +		xsl_dsnctl |= ((u64)0x04 << (63-55));
> +	}
> +
> +	cxl_p1_write(adapter, CXL_XSL9_DSNCTL, xsl_dsnctl);
> +
> +	/* Set fir_cntl to recommended value for production env */
> +	psl_fircntl = (0x2ULL << (63-3)); /* ce_report */
> +	psl_fircntl |= (0x1ULL << (63-6)); /* FIR_report */
> +	psl_fircntl |= 0x1ULL; /* ce_thresh */
> +	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
> +
> +	/* vccredits=0x1  pcklat=0x4 */
> +	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0000000000001810ULL);
> +
> +	/* For debugging with trace arrays.
> +	 * Configure RX trace 0 segmented mode.
> +	 * Configure CT trace 0 segmented mode.
> +	 * Configure LA0 trace 0 segmented mode.
> +	 * Configure LA1 trace 0 segmented mode.
> +	 */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000000ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000003ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000005ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000006ULL);
> +
> +	/* A response to an ASB_Notify request is returned by the
> +	 * system as an MMIO write to the address defined in
> +	 * the PSL_TNR_ADDR register
> +	 */
> +	/* PSL_TNR_ADDR */
> +
> +	/* NORST */
> +	cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
> +
> +	/* allocate the apc machines */
> +	cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
> +
> +	/* Disable vc dd1 fix */
> +	if ((cxl_is_power9() && cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
> +
> +	return 0;
> +}
> +
>  static int init_implementation_adapter_regs_psl8(struct cxl *adapter, struct pci_dev *dev)
>  {
>  	u64 psl_dsnctl, psl_fircntl;
>  	u64 chipid;
> +	u32 phb_index;
>  	u64 capp_unit_id;
>  	int rc;
>
> -	rc = calc_capp_routing(dev, &chipid, &capp_unit_id);
> +	rc = calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
>  	if (rc)
>  		return rc;
>
> @@ -414,10 +526,11 @@ static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_
>  {
>  	u64 xsl_dsnctl;
>  	u64 chipid;
> +	u32 phb_index;
>  	u64 capp_unit_id;
>  	int rc;
>
> -	rc = calc_capp_routing(dev, &chipid, &capp_unit_id);
> +	rc = calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
>  	if (rc)
>  		return rc;
>
> @@ -435,6 +548,12 @@ static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_
>  /* For the PSL this is a multiple for 0 < n <= 7: */
>  #define PSL_2048_250MHZ_CYCLES 1
>
> +static void write_timebase_ctrl_psl9(struct cxl *adapter)
> +{
> +	cxl_p1_write(adapter, CXL_PSL9_TB_CTLSTAT,
> +		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
> +}
> +
>  static void write_timebase_ctrl_psl8(struct cxl *adapter)
>  {
>  	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
> @@ -456,6 +575,11 @@ static void write_timebase_ctrl_xsl(struct cxl *adapter)
>  		     TBSYNC_CNT(XSL_4000_CLOCKS));
>  }
>
> +static u64 timebase_read_psl9(struct cxl *adapter)
> +{
> +	return cxl_p1_read(adapter, CXL_PSL9_Timebase);
> +}
> +
>  static u64 timebase_read_psl8(struct cxl *adapter)
>  {
>  	return cxl_p1_read(adapter, CXL_PSL_Timebase);
> @@ -514,6 +638,11 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
>  	return;
>  }
>
> +static int init_implementation_afu_regs_psl9(struct cxl_afu *afu)
> +{
> +	return 0;
> +}
> +
>  static int init_implementation_afu_regs_psl8(struct cxl_afu *afu)
>  {
>  	/* read/write masks for this slice */
> @@ -612,7 +741,7 @@ static int setup_cxl_bars(struct pci_dev *dev)
>  	/*
>  	 * BAR 4/5 has a special meaning for CXL and must be programmed with a
>  	 * special value corresponding to the CXL protocol address range.
> -	 * For POWER 8 that means bits 48:49 must be set to 10
> +	 * For POWER 8/9 that means bits 48:49 must be set to 10
>  	 */
>  	pci_write_config_dword(dev, PCI_BASE_ADDRESS_4, 0x00000000);
>  	pci_write_config_dword(dev, PCI_BASE_ADDRESS_5, 0x00020000);
> @@ -997,6 +1126,52 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
>  	return 0;
>  }
>
> +static int sanitise_afu_regs_psl9(struct cxl_afu *afu)
> +{
> +	u64 reg;
> +
> +	/*
> +	 * Clear out any regs that contain either an IVTE or address or may be
> +	 * waiting on an acknowledgment to try to be a bit safer as we bring
> +	 * it online
> +	 */
> +	reg = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> +	if ((reg & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
> +		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#016llx\n", reg);
> +		if (cxl_ops->afu_reset(afu))
> +			return -EIO;
> +		if (cxl_afu_disable(afu))
> +			return -EIO;
> +		if (cxl_psl_purge(afu))
> +			return -EIO;
> +	}
> +	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0x0000000000000000);
> +	cxl_p1n_write(afu, CXL_PSL_AMBAR_An, 0x0000000000000000);
> +	reg = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> +	if (reg) {
> +		dev_warn(&afu->dev, "AFU had pending DSISR: %#016llx\n", reg);
> +		if (reg & CXL_PSL9_DSISR_An_TF)
> +			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> +		else
> +			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> +	}
> +	if (afu->adapter->native->sl_ops->register_serr_irq) {
> +		reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +		if (reg) {
> +			if (reg & ~0x000000007fffffff)
> +				dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
> +			cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
> +		}
> +	}
> +	reg = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> +	if (reg) {
> +		dev_warn(&afu->dev, "AFU had pending error status: %#016llx\n", reg);
> +		cxl_p2n_write(afu, CXL_PSL_ErrStat_An, reg);
> +	}
> +
> +	return 0;
> +}
> +
>  static int sanitise_afu_regs_psl8(struct cxl_afu *afu)
>  {
>  	u64 reg;
> @@ -1254,10 +1429,10 @@ int cxl_pci_reset(struct cxl *adapter)
>
>  	/*
>  	 * The adapter is about to be reset, so ignore errors.
> -	 * Not supported on P9 DD1 but don't forget to enable it
> -	 * on P9 DD2
> +	 * Not supported on P9 DD1
>  	 */
> -	if (cxl_is_power8())
> +	if ((cxl_is_power8()) ||
> +	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
>  		cxl_data_cache_flush(adapter);
>
>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
> @@ -1393,6 +1568,9 @@ static bool cxl_compatible_caia_version(struct cxl *adapter)
>  	if (cxl_is_power8() && (adapter->caia_major == 1))
>  		return true;
>
> +	if (cxl_is_power9() && (adapter->caia_major == 2))
> +		return true;
> +
>  	return false;
>  }
>
> @@ -1460,8 +1638,12 @@ static int sanitise_adapter_regs(struct cxl *adapter)
>  	/* Clear PSL tberror bit by writing 1 to it */
>  	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, CXL_PSL_ErrIVTE_tberror);
>
> -	if (adapter->native->sl_ops->invalidate_all)
> +	if (adapter->native->sl_ops->invalidate_all) {
> +		/* do not invalidate ERAT entries when not reloading on PERST */
> +		if (cxl_is_power9() && (adapter->perst_loads_image))
> +			return 0;
>  		rc = adapter->native->sl_ops->invalidate_all(adapter);
> +	}
>
>  	return rc;
>  }
> @@ -1546,6 +1728,30 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
>  	pci_disable_device(pdev);
>  }
>
> +static const struct cxl_service_layer_ops psl9_ops = {
> +	.adapter_regs_init = init_implementation_adapter_regs_psl9,
> +	.invalidate_all = cxl_invalidate_all_psl9,
> +	.afu_regs_init = init_implementation_afu_regs_psl9,
> +	.sanitise_afu_regs = sanitise_afu_regs_psl9,
> +	.register_serr_irq = cxl_native_register_serr_irq,
> +	.release_serr_irq = cxl_native_release_serr_irq,
> +	.handle_interrupt = cxl_irq_psl9,
> +	.fail_irq = cxl_fail_irq_psl,
> +	.activate_dedicated_process = cxl_activate_dedicated_process_psl9,
> +	.attach_afu_directed = cxl_attach_afu_directed_psl9,
> +	.attach_dedicated_process = cxl_attach_dedicated_process_psl9,
> +	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl9,
> +	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
> +	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
> +	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
> +	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
> +	.debugfs_stop_trace = cxl_stop_trace_psl9,
> +	.write_timebase_ctrl = write_timebase_ctrl_psl9,
> +	.timebase_read = timebase_read_psl9,
> +	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
> +	.needs_reset_before_disable = true,
> +};
> +
>  static const struct cxl_service_layer_ops psl8_ops = {
>  	.adapter_regs_init = init_implementation_adapter_regs_psl8,
>  	.invalidate_all = cxl_invalidate_all_psl8,
> @@ -1597,6 +1803,9 @@ static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
>  		if (cxl_is_power8()) {
>  			dev_info(&dev->dev, "Device uses a PSL8\n");
>  			adapter->native->sl_ops = &psl8_ops;
> +		} else {
> +			dev_info(&dev->dev, "Device uses a PSL9\n");
> +			adapter->native->sl_ops = &psl9_ops;
>  		}
>  	}
>  }
> @@ -1667,8 +1876,12 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
>  	cxl_sysfs_adapter_remove(adapter);
>  	cxl_debugfs_adapter_remove(adapter);
>
> -	/* Flush adapter datacache as its about to be removed */
> -	cxl_data_cache_flush(adapter);
> +	/* Flush adapter datacache as its about to be removed.
> +	 * Not supported on P9 DD1
> +	 */
> +	if ((cxl_is_power8()) ||
> +	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
> +		cxl_data_cache_flush(adapter);
>
>  	cxl_deconfigure_adapter(adapter);
>
> @@ -1752,6 +1965,11 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENODEV;
>  	}
>
> +	if (cxl_is_power9() && !radix_enabled()) {
> +		dev_info(&dev->dev, "Only Radix mode supported\n");
> +		return -ENODEV;
> +	}
> +
>  	if (cxl_verbose)
>  		dump_cxl_config_space(dev);
>
> diff --git a/drivers/misc/cxl/trace.h b/drivers/misc/cxl/trace.h
> index 751d611..b8e300a 100644
> --- a/drivers/misc/cxl/trace.h
> +++ b/drivers/misc/cxl/trace.h
> @@ -17,6 +17,15 @@
>
>  #include "cxl.h"
>
> +#define dsisr_psl9_flags(flags) \
> +	__print_flags(flags, "|", \
> +		{ CXL_PSL9_DSISR_An_CO_MASK,	"FR" }, \
> +		{ CXL_PSL9_DSISR_An_TF,		"TF" }, \
> +		{ CXL_PSL9_DSISR_An_PE,		"PE" }, \
> +		{ CXL_PSL9_DSISR_An_AE,		"AE" }, \
> +		{ CXL_PSL9_DSISR_An_OC,		"OC" }, \
> +		{ CXL_PSL9_DSISR_An_S,		"S" })
> +
>  #define DSISR_FLAGS \
>  	{ CXL_PSL_DSISR_An_DS,	"DS" }, \
>  	{ CXL_PSL_DSISR_An_DM,	"DM" }, \
> @@ -154,6 +163,40 @@ TRACE_EVENT(cxl_afu_irq,
>  	)
>  );
>
> +TRACE_EVENT(cxl_psl9_irq,
> +	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
> +
> +	TP_ARGS(ctx, irq, dsisr, dar),
> +
> +	TP_STRUCT__entry(
> +		__field(u8, card)
> +		__field(u8, afu)
> +		__field(u16, pe)
> +		__field(int, irq)
> +		__field(u64, dsisr)
> +		__field(u64, dar)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->card = ctx->afu->adapter->adapter_num;
> +		__entry->afu = ctx->afu->slice;
> +		__entry->pe = ctx->pe;
> +		__entry->irq = irq;
> +		__entry->dsisr = dsisr;
> +		__entry->dar = dar;
> +	),
> +
> +	TP_printk("afu%i.%i pe=%i irq=%i dsisr=0x%016llx dsisr=%s dar=0x%016llx",
> +		__entry->card,
> +		__entry->afu,
> +		__entry->pe,
> +		__entry->irq,
> +		__entry->dsisr,
> +		dsisr_psl9_flags(__entry->dsisr),
> +		__entry->dar
> +	)
> +);
> +
>  TRACE_EVENT(cxl_psl_irq,
>  	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
>
