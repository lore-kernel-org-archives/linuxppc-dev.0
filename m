Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15063C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 07:07:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1D121850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 07:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1D121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44b9qV5K2VzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 18:07:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44b9nl288hzDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 18:05:46 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x356xM6g014877
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2019 03:05:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rp0vsu7eh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 03:05:42 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 5 Apr 2019 08:05:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Apr 2019 08:05:37 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3575aYq38273066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Apr 2019 07:05:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0B465204E;
 Fri,  5 Apr 2019 07:05:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5003E52052;
 Fri,  5 Apr 2019 07:05:35 +0000 (GMT)
Received: from [9.81.192.72] (unknown [9.81.192.72])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 934BEA0195;
 Fri,  5 Apr 2019 18:05:33 +1100 (AEDT)
Subject: Re: [PATCH v4 1/4] ocxl: Rename struct link to ocxl_link
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325053456.14599-1-alastair@au1.ibm.com>
 <20190325053456.14599-2-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 5 Apr 2019 18:05:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325053456.14599-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040507-4275-0000-0000-0000032486D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040507-4276-0000-0000-00003833955E
Message-Id: <327f4cc9-4c1b-a44c-3f61-d6363d73574d@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050052
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 25/3/19 4:34 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The term 'link' is ambiguous (especially when the struct is used for a
> list), so rename it for clarity.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/file.c |  5 ++---
>   drivers/misc/ocxl/link.c | 36 ++++++++++++++++++------------------
>   2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index e6a607488f8a..009e09b7ded5 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -151,10 +151,9 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>   		mutex_unlock(&ctx->status_mutex);
>   
>   		if (status == ATTACHED) {
> -			int rc;
> -			struct link *link = ctx->afu->fn->link;
> +			int rc = ocxl_link_update_pe(ctx->afu->fn->link,
> +				ctx->pasid, ctx->tidr);
>   
> -			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
>   			if (rc)
>   				return rc;
>   		}
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index d50b861d7e57..8d2690a1a9de 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -76,7 +76,7 @@ struct spa {
>    * limited number of opencapi slots on a system and lookup is only
>    * done when the device is probed
>    */
> -struct link {
> +struct ocxl_link {
>   	struct list_head list;
>   	struct kref ref;
>   	int domain;
> @@ -179,7 +179,7 @@ static void xsl_fault_handler_bh(struct work_struct *fault_work)
>   
>   static irqreturn_t xsl_fault_handler(int irq, void *data)
>   {
> -	struct link *link = (struct link *) data;
> +	struct ocxl_link *link = (struct ocxl_link *) data;
>   	struct spa *spa = link->spa;
>   	u64 dsisr, dar, pe_handle;
>   	struct pe_data *pe_data;
> @@ -256,7 +256,7 @@ static int map_irq_registers(struct pci_dev *dev, struct spa *spa)
>   				&spa->reg_tfc, &spa->reg_pe_handle);
>   }
>   
> -static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
> +static int setup_xsl_irq(struct pci_dev *dev, struct ocxl_link *link)
>   {
>   	struct spa *spa = link->spa;
>   	int rc;
> @@ -311,7 +311,7 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
>   	return rc;
>   }
>   
> -static void release_xsl_irq(struct link *link)
> +static void release_xsl_irq(struct ocxl_link *link)
>   {
>   	struct spa *spa = link->spa;
>   
> @@ -323,7 +323,7 @@ static void release_xsl_irq(struct link *link)
>   	unmap_irq_registers(spa);
>   }
>   
> -static int alloc_spa(struct pci_dev *dev, struct link *link)
> +static int alloc_spa(struct pci_dev *dev, struct ocxl_link *link)
>   {
>   	struct spa *spa;
>   
> @@ -350,7 +350,7 @@ static int alloc_spa(struct pci_dev *dev, struct link *link)
>   	return 0;
>   }
>   
> -static void free_spa(struct link *link)
> +static void free_spa(struct ocxl_link *link)
>   {
>   	struct spa *spa = link->spa;
>   
> @@ -364,12 +364,12 @@ static void free_spa(struct link *link)
>   	}
>   }
>   
> -static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
> +static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_link)
>   {
> -	struct link *link;
> +	struct ocxl_link *link;
>   	int rc;
>   
> -	link = kzalloc(sizeof(struct link), GFP_KERNEL);
> +	link = kzalloc(sizeof(struct ocxl_link), GFP_KERNEL);
>   	if (!link)
>   		return -ENOMEM;
>   
> @@ -405,7 +405,7 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
>   	return rc;
>   }
>   
> -static void free_link(struct link *link)
> +static void free_link(struct ocxl_link *link)
>   {
>   	release_xsl_irq(link);
>   	free_spa(link);
> @@ -415,7 +415,7 @@ static void free_link(struct link *link)
>   int ocxl_link_setup(struct pci_dev *dev, int PE_mask, void **link_handle)
>   {
>   	int rc = 0;
> -	struct link *link;
> +	struct ocxl_link *link;
>   
>   	mutex_lock(&links_list_lock);
>   	list_for_each_entry(link, &links_list, list) {
> @@ -442,7 +442,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_setup);
>   
>   static void release_xsl(struct kref *ref)
>   {
> -	struct link *link = container_of(ref, struct link, ref);
> +	struct ocxl_link *link = container_of(ref, struct ocxl_link, ref);
>   
>   	list_del(&link->list);
>   	/* call platform code before releasing data */
> @@ -452,7 +452,7 @@ static void release_xsl(struct kref *ref)
>   
>   void ocxl_link_release(struct pci_dev *dev, void *link_handle)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   
>   	mutex_lock(&links_list_lock);
>   	kref_put(&link->ref, release_xsl);
> @@ -488,7 +488,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   	struct spa *spa = link->spa;
>   	struct ocxl_process_element *pe;
>   	int pe_handle, rc = 0;
> @@ -558,7 +558,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
>   
>   int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   	struct spa *spa = link->spa;
>   	struct ocxl_process_element *pe;
>   	int pe_handle, rc;
> @@ -594,7 +594,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
>   
>   int ocxl_link_remove_pe(void *link_handle, int pasid)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   	struct spa *spa = link->spa;
>   	struct ocxl_process_element *pe;
>   	struct pe_data *pe_data;
> @@ -666,7 +666,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_remove_pe);
>   
>   int ocxl_link_irq_alloc(void *link_handle, int *hw_irq, u64 *trigger_addr)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   	int rc, irq;
>   	u64 addr;
>   
> @@ -687,7 +687,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_irq_alloc);
>   
>   void ocxl_link_free_irq(void *link_handle, int hw_irq)
>   {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>   
>   	pnv_ocxl_free_xive_irq(hw_irq);
>   	atomic_inc(&link->irq_available);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

