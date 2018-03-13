Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400rTg3RcmzDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 21:20:36 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DAEmET112386
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 06:20:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gpc4128bq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 06:20:33 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 10:20:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w2DAKTCr22020254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:20:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13E7C4C046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:13:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC1AE4C059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:13:45 +0000 (GMT)
Received: from [9.164.168.190] (unknown [9.164.168.190])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:13:45 +0000 (GMT)
Subject: Re: [PATCH] cxl: Perform NULL check for 'cxl_afu *' at various places
 in cxl
To: linuxppc-dev@lists.ozlabs.org
References: <20180308100547.2994-1-vaibhav@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 11:20:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180308100547.2994-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c97946a0-2488-5892-66ae-5ad8e5a0007f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/03/2018 à 11:05, Vaibhav Jain a écrit :
> It is possible for a CXL card to have a valid PSL but no valid
> AFUs. When this happens we have a valid instance of 'struct cxl'
> representing the adapter but with its member 'struct cxl_afu *cxl[]'
> as empty. Unfortunately at many placed within cxl code (especially
> during an EEH) the elements of this array are passed on to various
> other cxl functions. Which may result in kernel oops/panic when this
> 'struct cxl_afu *' is dereferenced.
> 
> So this patch puts a NULL check at the beginning of various cxl
> functions that accept 'struct cxl_afu *' as a formal argument and are
> called from with a loop of the form:
> 
>         for (i = 0; i < adapter->slices; i++) {
>         	   	afu = adapter->afu[i];
> 		/* call some function with 'afu' */
> 	}


So we are calling functions with an invalid afu argument. We can verify 
in the callees the value of the afu pointer, like you're doing here, but 
why not tackle it at source and avoid calling the function in the first 
place? It would have the nice side effect of reminding developers that 
the AFU array can be empty.
We already have a few checks in place in the "for (i = 0; i < 
adapter->slices; i++)" loops, but it was overlooked when eeh support was 
added. I think we should fix that.

   Fred




> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/api.c     |  2 +-
>   drivers/misc/cxl/context.c |  3 +++
>   drivers/misc/cxl/guest.c   |  4 ++++
>   drivers/misc/cxl/main.c    |  3 +++
>   drivers/misc/cxl/native.c  |  4 ++++
>   drivers/misc/cxl/pci.c     | 13 ++++++++++++-
>   6 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 753b1a698fc4..3466ef8b9e86 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -128,7 +128,7 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
>   	int rc;
> 
>   	afu = cxl_pci_to_afu(dev);
> -	if (IS_ERR(afu))
> +	if (IS_ERR_OR_NULL(afu))
>   		return ERR_CAST(afu);
> 
>   	ctx = cxl_context_alloc();
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 7ff315ad3692..3957e6e7d187 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -303,6 +303,9 @@ void cxl_context_detach_all(struct cxl_afu *afu)
>   	struct cxl_context *ctx;
>   	int tmp;
> 
> +	if (afu == NULL)
> +		return;
> +
>   	mutex_lock(&afu->contexts_lock);
>   	idr_for_each_entry(&afu->contexts_idr, ctx, tmp) {
>   		/*
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index f58b4b6c79f2..8165f6f26704 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -760,6 +760,8 @@ static int activate_afu_directed(struct cxl_afu *afu)
> 
>   static int guest_afu_activate_mode(struct cxl_afu *afu, int mode)
>   {
> +	if (afu == NULL)
> +		return -EINVAL;
>   	if (!mode)
>   		return 0;
>   	if (!(mode & afu->modes_supported))
> @@ -791,6 +793,8 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
> 
>   static int guest_afu_deactivate_mode(struct cxl_afu *afu, int mode)
>   {
> +	if (afu == NULL)
> +		return -EINVAL;
>   	if (!mode)
>   		return 0;
>   	if (!(mode & afu->modes_supported))
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index c1ba0d42cbc8..296a71ca6f2e 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -271,6 +271,9 @@ struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
> 
>   int cxl_afu_select_best_mode(struct cxl_afu *afu)
>   {
> +	if (afu == NULL)
> +		return -EINVAL;
> +
>   	if (afu->modes_supported & CXL_MODE_DIRECTED)
>   		return cxl_ops->afu_activate_mode(afu, CXL_MODE_DIRECTED);
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 1b3d7c65ea3f..d46415b19b71 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -971,6 +971,8 @@ static int deactivate_dedicated_process(struct cxl_afu *afu)
> 
>   static int native_afu_deactivate_mode(struct cxl_afu *afu, int mode)
>   {
> +	if (afu == NULL)
> +		return -EINVAL;
>   	if (mode == CXL_MODE_DIRECTED)
>   		return deactivate_afu_directed(afu);
>   	if (mode == CXL_MODE_DEDICATED)
> @@ -980,6 +982,8 @@ static int native_afu_deactivate_mode(struct cxl_afu *afu, int mode)
> 
>   static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
>   {
> +	if (!afu)
> +		return -EINVAL;
>   	if (!mode)
>   		return 0;
>   	if (!(mode & afu->modes_supported))
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 758842f65a1b..8c87d9fdcf5a 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1295,6 +1295,9 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
>   {
>   	int rc;
> 
> +	if (afu == NULL)
> +		return -EINVAL;
> +
>   	if ((rc = pci_map_slice_regs(afu, adapter, dev)))
>   		return rc;
> 
> @@ -1341,6 +1344,10 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
> 
>   static void pci_deconfigure_afu(struct cxl_afu *afu)
>   {
> +
> +	if (afu == NULL)
> +		return;
> +
>   	/*
>   	 * It's okay to deconfigure when AFU is already locked, otherwise wait
>   	 * until there are no readers
> @@ -2078,6 +2085,10 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
>   	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
>   	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
> 
> +	/* Force a hotplug if an uninitiaized AFU is encountered */
> +	if (afu == NULL)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
>   	/* There should only be one entry, but go through the list
>   	 * anyway
>   	 */
> @@ -2330,7 +2341,7 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
> 
> -		if (afu->phb == NULL)
> +		if (afu == NULL || afu->phb == NULL)
>   			continue;
> 
>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> 
