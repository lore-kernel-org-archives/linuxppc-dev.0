Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmkmZ3JkQzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 21:21:02 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v85BKKP0089393
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 07:20:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2csqt5u9kv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 07:20:59 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 5 Sep 2017 12:20:57 +0100
Subject: Re: [PATCH V2] cxl: Add support for POWER9 DD2
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1504538995-13792-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 13:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <1504538995-13792-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0cde622f-107c-92f2-42c6-b41e0e0133be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/09/2017 à 17:29, Christophe Lombard a écrit :
> The PSL initialization sequence has been updated to DD2.
> This patch adapts to the changes, retaining compatibility with DD1.
> The patch includes some changes to DD1 fix-ups as well.
> 
> Tests performed on some of the old/new hardware.
> 
> The function is_page_fault(), for POWER9, lists the Translation Checkout
> Responses where the page fault will be handled by copro_handle_mm_fault().
> This list is too restrictive and not necessary.
> 
> This patches removes this restriction and all page faults, whatever the
> reason, will be handled. In this case, the interruption is always
> acknowledged.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> ---

I'm ok with those changes.
We should add to the commit message that we'll have more changes coming, 
at least to add the phb reset when switching to capi mode (if we still 
can't get rid of it). The other item is capp recovery, which is still 
being worked on, but any change required there would hopefully be 
limited to skiboot.

With the above:
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


> Changelog[v2]
>   - Rebase to latest upstream.
>   - Update the function is_page_fault()
> ---
>   drivers/misc/cxl/cxl.h   |  2 ++
>   drivers/misc/cxl/fault.c | 15 ++-------------
>   drivers/misc/cxl/pci.c   | 46 +++++++++++++++++++++++-----------------------
>   3 files changed, 27 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index b1afecc..0167df8 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -100,6 +100,8 @@ static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
>   static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
>   /* PSL registers - CAIA 2 */
>   static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
> +static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
> +static const cxl_p1_reg_t CXL_XSL9_DEF      = {0x0140};
>   static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
>   static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
>   static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 6eed7d0..0cf7f4a 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -204,22 +204,11 @@ static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
> 
>   static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
>   {
> -	u64 crs; /* Translation Checkout Response Status */
> -
>   	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
>   		return true;
> 
> -	if (cxl_is_power9()) {
> -		crs = (dsisr & CXL_PSL9_DSISR_An_CO_MASK);
> -		if ((crs == CXL_PSL9_DSISR_An_PF_SLR) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_RGC) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_RGP) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_HRH) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_STEG) ||
> -		    (crs == CXL_PSL9_DSISR_An_URTCH)) {
> -			return true;
> -		}
> -	}
> +	if (cxl_is_power9())
> +		return true;
> 
>   	return false;
>   }
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index d18b3d9..3edc991 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -401,7 +401,8 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
>   	*capp_unit_id = get_capp_unit_id(np, *phb_index);
>   	of_node_put(np);
>   	if (!*capp_unit_id) {
> -		pr_err("cxl: invalid capp unit id\n");
> +		pr_err("cxl: invalid capp unit id (phb_index: %d)\n",
> +		       *phb_index);
>   		return -ENODEV;
>   	}
> 
> @@ -475,37 +476,36 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
>   	psl_fircntl |= 0x1ULL; /* ce_thresh */
>   	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
> 
> -	/* vccredits=0x1  pcklat=0x4 */
> -	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0000000000001810ULL);
> -
> -	/*
> -	 * For debugging with trace arrays.
> -	 * Configure RX trace 0 segmented mode.
> -	 * Configure CT trace 0 segmented mode.
> -	 * Configure LA0 trace 0 segmented mode.
> -	 * Configure LA1 trace 0 segmented mode.
> +	/* Setup the PSL to transmit packets on the PCIe before the
> +	 * CAPP is enabled
>   	 */
> -	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000000ULL);
> -	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000003ULL);
> -	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000005ULL);
> -	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000006ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
> 
>   	/*
>   	 * A response to an ASB_Notify request is returned by the
>   	 * system as an MMIO write to the address defined in
> -	 * the PSL_TNR_ADDR register
> +	 * the PSL_TNR_ADDR register.
> +	 * keep the Reset Value: 0x00020000E0000000
>   	 */
> -	/* PSL_TNR_ADDR */
> 
> -	/* NORST */
> -	cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
> +	/* Enable XSL rty limit */
> +	cxl_p1_write(adapter, CXL_XSL9_DEF, 0x51F8000000000005ULL);
> +
> +	/* Change XSL_INV dummy read threshold */
> +	cxl_p1_write(adapter, CXL_XSL9_INV, 0x0000040007FFC200ULL);
> 
> -	/* allocate the apc machines */
> -	cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
> +	if (phb_index == 3) {
> +		/* disable machines 31-47 and 20-27 for DMA */
> +		cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000FF3FFFF0000ULL);
> +	}
> +
> +	/* Snoop machines */
> +	cxl_p1_write(adapter, CXL_PSL9_APCDEDALLOC, 0x800F000200000000ULL);
> 
> -	/* Disable vc dd1 fix */
> -	if (cxl_is_power9_dd1())
> -		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
> +	if (cxl_is_power9_dd1()) {
> +		/* Disabling deadlock counter CAR */
> +		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
> +	}
> 
>   	return 0;
>   }
> 
