Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHl3h4mjczDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 21:07:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JA4ilM028744
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:07:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpmwep7vd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:07:41 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 11:07:39 +0100
Subject: Re: [PATCH] cxl: Rework the implementation of cxl_stop_trace_psl9()
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20171011123020.17594-1-vaibhav@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 12:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171011123020.17594-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <baeedfba-e02f-2c84-7a76-d0f9b86607a6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/10/2017 à 14:30, Vaibhav Jain a écrit :
> Presently the PSL9 specific cxl_stop_trace_psl9() only stops the RX0
> traces on the CXL adapter when a PSL error irq is triggered. The patch
> updates the function to stop all the traces arrays and move them to
> the FIN state. The implementation issues the mmio to TRACECFG register
> to stop the trace array iff it already not in FIN state. This prevents
> the issue of trace data being reset in case of multiple stop mmio
> issued for a single trace array.
> 
> Also the patch does some refactoring of existing cxl_stop_trace_psl9()
> and cxl_stop_trace_psl8() functions by moving them to 'pci.c' from
> 'debugfs.c' file and marking them as static.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Looks ok to me.
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/cxl/cxl.h     | 14 ++++----------
>   drivers/misc/cxl/debugfs.c | 22 ----------------------
>   drivers/misc/cxl/pci.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 111c689b1771..d064ec24cdca 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -114,6 +114,7 @@ static const cxl_p1_reg_t CXL_PSL9_TRACECFG = {0x0368};
>   static const cxl_p1_reg_t CXL_PSL9_APCDEDALLOC = {0x0378};
>   static const cxl_p1_reg_t CXL_PSL9_APCDEDTYPE = {0x0380};
>   static const cxl_p1_reg_t CXL_PSL9_TNR_ADDR = {0x0388};
> +static const cxl_p1_reg_t CXL_PSL9_CTCCFG = {0x0390};
>   static const cxl_p1_reg_t CXL_PSL9_GP_CT = {0x0398};
>   static const cxl_p1_reg_t CXL_XSL9_IERAT = {0x0588};
>   static const cxl_p1_reg_t CXL_XSL9_ILPP  = {0x0590};
> @@ -416,6 +417,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>   #define CXL_CARD_MINOR(adapter) (adapter->adapter_num * CXL_DEV_MINORS)
>   #define CXL_DEVT_ADAPTER(dev) (MINOR(dev) / CXL_DEV_MINORS)
> 
> +#define CXL_PSL9_TRACEID_MAX 0xAU
> +#define CXL_PSL9_TRACESTATE_FIN 0x3U
> +
>   enum cxl_context_status {
>   	CLOSED,
>   	OPENED,
> @@ -940,8 +944,6 @@ int cxl_debugfs_adapter_add(struct cxl *adapter);
>   void cxl_debugfs_adapter_remove(struct cxl *adapter);
>   int cxl_debugfs_afu_add(struct cxl_afu *afu);
>   void cxl_debugfs_afu_remove(struct cxl_afu *afu);
> -void cxl_stop_trace_psl9(struct cxl *cxl);
> -void cxl_stop_trace_psl8(struct cxl *cxl);
>   void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir);
>   void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
>   void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir);
> @@ -977,14 +979,6 @@ static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
>   {
>   }
> 
> -static inline void cxl_stop_trace_psl9(struct cxl *cxl)
> -{
> -}
> -
> -static inline void cxl_stop_trace_psl8(struct cxl *cxl)
> -{
> -}
> -
>   static inline void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
>   						    struct dentry *dir)
>   {
> diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
> index 52e3d97db114..cf4ee3114ab1 100644
> --- a/drivers/misc/cxl/debugfs.c
> +++ b/drivers/misc/cxl/debugfs.c
> @@ -15,28 +15,6 @@
> 
>   static struct dentry *cxl_debugfs;
> 
> -void cxl_stop_trace_psl9(struct cxl *adapter)
> -{
> -	/* Stop the trace */
> -	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x4480000000000000ULL);
> -}
> -
> -void cxl_stop_trace_psl8(struct cxl *adapter)
> -{
> -	int slice;
> -
> -	/* Stop the trace */
> -	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x8000000000000017LL);
> -
> -	/* Stop the slice traces */
> -	spin_lock(&adapter->afu_list_lock);
> -	for (slice = 0; slice < adapter->slices; slice++) {
> -		if (adapter->afu[slice])
> -			cxl_p1n_write(adapter->afu[slice], CXL_PSL_SLICE_TRACE, 0x8000000000000000LL);
> -	}
> -	spin_unlock(&adapter->afu_list_lock);
> -}
> -
>   /* Helpers to export CXL mmaped IO registers via debugfs */
>   static int debugfs_io_u64_get(void *data, u64 *val)
>   {
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index d185b47eb536..bb7fd3f4edab 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1747,6 +1747,44 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
>   	pci_disable_device(pdev);
>   }
> 
> +static void cxl_stop_trace_psl9(struct cxl *adapter)
> +{
> +	int traceid;
> +	u64 trace_state, trace_mask;
> +	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> +
> +	/* read each tracearray state and issue mmio to stop them is needed */
> +	for (traceid = 0; traceid <= CXL_PSL9_TRACEID_MAX; ++traceid) {
> +		trace_state = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
> +		trace_mask = (0x3ULL << (62 - traceid * 2));
> +		trace_state = (trace_state & trace_mask) >> (62 - traceid * 2);
> +		dev_dbg(&dev->dev, "cxl: Traceid-%d trace_state=0x%0llX\n",
> +			traceid, trace_state);
> +
> +		/* issue mmio if the trace array isn't in FIN state */
> +		if (trace_state != CXL_PSL9_TRACESTATE_FIN)
> +			cxl_p1_write(adapter, CXL_PSL9_TRACECFG,
> +				     0x8400000000000000ULL | traceid);
> +	}
> +}
> +
> +static void cxl_stop_trace_psl8(struct cxl *adapter)
> +{
> +	int slice;
> +
> +	/* Stop the trace */
> +	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x8000000000000017LL);
> +
> +	/* Stop the slice traces */
> +	spin_lock(&adapter->afu_list_lock);
> +	for (slice = 0; slice < adapter->slices; slice++) {
> +		if (adapter->afu[slice])
> +			cxl_p1n_write(adapter->afu[slice], CXL_PSL_SLICE_TRACE,
> +				      0x8000000000000000LL);
> +	}
> +	spin_unlock(&adapter->afu_list_lock);
> +}
> +
>   static const struct cxl_service_layer_ops psl9_ops = {
>   	.adapter_regs_init = init_implementation_adapter_regs_psl9,
>   	.invalidate_all = cxl_invalidate_all_psl9,
> 
