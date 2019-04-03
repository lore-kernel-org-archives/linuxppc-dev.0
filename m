Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B6C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:26:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764852075E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764852075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z7gd299LzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 01:26:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z7XQ5sQgzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 01:20:38 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x33EGDMf083197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2019 10:20:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rmxca8e14-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 10:20:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 3 Apr 2019 15:20:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Apr 2019 15:20:28 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x33EKRCV55967984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2019 14:20:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B74FAE055;
 Wed,  3 Apr 2019 14:20:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D731AAE063;
 Wed,  3 Apr 2019 14:20:26 +0000 (GMT)
Received: from [9.145.9.70] (unknown [9.145.9.70])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  3 Apr 2019 14:20:26 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] ocxl: Remove superfluous 'extern' from headers
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325053456.14599-1-alastair@au1.ibm.com>
 <20190325053456.14599-4-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 3 Apr 2019 16:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325053456.14599-4-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040314-4275-0000-0000-00000323D8D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040314-4276-0000-0000-00003832E043
Message-Id: <18c7f188-c77c-76de-3bbe-aea5b6d6f316@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030097
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/03/2019 à 06:34, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The 'extern' keyword adds no value here.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/ocxl_internal.h | 54 +++++++++++++++----------------
>   include/misc/ocxl.h               | 36 ++++++++++-----------
>   2 files changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index a32f2151029f..321b29e77f45 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -16,7 +16,6 @@
>   
>   extern struct pci_driver ocxl_pci_driver;
>   
> -
>   struct ocxl_fn {
>   	struct device dev;
>   	int bar_used[3];
> @@ -92,41 +91,40 @@ struct ocxl_process_element {
>   	__be32 software_state;
>   };
>   
> +struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu);
> +void ocxl_afu_put(struct ocxl_afu *afu);
>   
> -extern struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu);
> -extern void ocxl_afu_put(struct ocxl_afu *afu);
> -
> -extern int ocxl_create_cdev(struct ocxl_afu *afu);
> -extern void ocxl_destroy_cdev(struct ocxl_afu *afu);
> -extern int ocxl_register_afu(struct ocxl_afu *afu);
> -extern void ocxl_unregister_afu(struct ocxl_afu *afu);
> +int ocxl_create_cdev(struct ocxl_afu *afu);
> +void ocxl_destroy_cdev(struct ocxl_afu *afu);
> +int ocxl_register_afu(struct ocxl_afu *afu);
> +void ocxl_unregister_afu(struct ocxl_afu *afu);
>   
> -extern int ocxl_file_init(void);
> -extern void ocxl_file_exit(void);
> +int ocxl_file_init(void);
> +void ocxl_file_exit(void);
>   
> -extern int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size);
> -extern void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
> -extern int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
> -extern void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
> +int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size);
> +void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
> +int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
> +void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
>   
> -extern struct ocxl_context *ocxl_context_alloc(void);
> -extern int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
> +struct ocxl_context *ocxl_context_alloc(void);
> +int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   			struct address_space *mapping);
> -extern int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
> -extern int ocxl_context_mmap(struct ocxl_context *ctx,
> +int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
> +int ocxl_context_mmap(struct ocxl_context *ctx,
>   			struct vm_area_struct *vma);
> -extern int ocxl_context_detach(struct ocxl_context *ctx);
> -extern void ocxl_context_detach_all(struct ocxl_afu *afu);
> -extern void ocxl_context_free(struct ocxl_context *ctx);
> +int ocxl_context_detach(struct ocxl_context *ctx);
> +void ocxl_context_detach_all(struct ocxl_afu *afu);
> +void ocxl_context_free(struct ocxl_context *ctx);
>   
> -extern int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
> -extern void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
> +int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
> +void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
>   
> -extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset);
> -extern int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset);
> -extern void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
> -extern int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset,
> +int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset);
> +int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset);
> +void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
> +int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset,
>   			int eventfd);
> -extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset);
> +u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset);
>   
>   #endif /* _OCXL_INTERNAL_H_ */
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 9ff6ddc28e22..4544573cc93c 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -53,7 +53,7 @@ struct ocxl_fn_config {
>    * Read the configuration space of a function and fill in a
>    * ocxl_fn_config structure with all the function details
>    */
> -extern int ocxl_config_read_function(struct pci_dev *dev,
> +int ocxl_config_read_function(struct pci_dev *dev,
>   				struct ocxl_fn_config *fn);
>   
>   /*
> @@ -62,14 +62,14 @@ extern int ocxl_config_read_function(struct pci_dev *dev,
>    * AFU indexes can be sparse, so a driver should check all indexes up
>    * to the maximum found in the function description
>    */
> -extern int ocxl_config_check_afu_index(struct pci_dev *dev,
> +int ocxl_config_check_afu_index(struct pci_dev *dev,
>   				struct ocxl_fn_config *fn, int afu_idx);
>   
>   /*
>    * Read the configuration space of a function for the AFU specified by
>    * the index 'afu_idx'. Fills in a ocxl_afu_config structure
>    */
> -extern int ocxl_config_read_afu(struct pci_dev *dev,
> +int ocxl_config_read_afu(struct pci_dev *dev,
>   				struct ocxl_fn_config *fn,
>   				struct ocxl_afu_config *afu,
>   				u8 afu_idx);
> @@ -77,7 +77,7 @@ extern int ocxl_config_read_afu(struct pci_dev *dev,
>   /*
>    * Get the max PASID value that can be used by the function
>    */
> -extern int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> +int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
>   
>   /*
>    * Tell an AFU, by writing in the configuration space, the PASIDs that
> @@ -87,7 +87,7 @@ extern int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
>    * 'afu_control_offset' is the offset of the AFU control DVSEC which
>    * can be found in the function configuration
>    */
> -extern void ocxl_config_set_afu_pasid(struct pci_dev *dev,
> +void ocxl_config_set_afu_pasid(struct pci_dev *dev,
>   				int afu_control_offset,
>   				int pasid_base, u32 pasid_count_log);
>   
> @@ -98,7 +98,7 @@ extern void ocxl_config_set_afu_pasid(struct pci_dev *dev,
>    * 'supported' is the total number of actags desired by all the AFUs
>    *             of the function.
>    */
> -extern int ocxl_config_get_actag_info(struct pci_dev *dev,
> +int ocxl_config_get_actag_info(struct pci_dev *dev,
>   				u16 *base, u16 *enabled, u16 *supported);
>   
>   /*
> @@ -108,7 +108,7 @@ extern int ocxl_config_get_actag_info(struct pci_dev *dev,
>    * 'func_offset' is the offset of the Function DVSEC that can found in
>    * the function configuration
>    */
> -extern void ocxl_config_set_actag(struct pci_dev *dev, int func_offset,
> +void ocxl_config_set_actag(struct pci_dev *dev, int func_offset,
>   				u32 actag_base, u32 actag_count);
>   
>   /*
> @@ -118,7 +118,7 @@ extern void ocxl_config_set_actag(struct pci_dev *dev, int func_offset,
>    * 'afu_control_offset' is the offset of the AFU control DVSEC for the
>    * desired AFU. It can be found in the AFU configuration
>    */
> -extern void ocxl_config_set_afu_actag(struct pci_dev *dev,
> +void ocxl_config_set_afu_actag(struct pci_dev *dev,
>   				int afu_control_offset,
>   				int actag_base, int actag_count);
>   
> @@ -128,7 +128,7 @@ extern void ocxl_config_set_afu_actag(struct pci_dev *dev,
>    * 'afu_control_offset' is the offset of the AFU control DVSEC for the
>    * desired AFU. It can be found in the AFU configuration
>    */
> -extern void ocxl_config_set_afu_state(struct pci_dev *dev,
> +void ocxl_config_set_afu_state(struct pci_dev *dev,
>   				int afu_control_offset, int enable);
>   
>   /*
> @@ -139,7 +139,7 @@ extern void ocxl_config_set_afu_state(struct pci_dev *dev,
>    * between the host and device, and set the Transaction Layer on both
>    * accordingly.
>    */
> -extern int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
> +int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
>   
>   /*
>    * Request an AFU to terminate a PASID.
> @@ -152,7 +152,7 @@ extern int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
>    * 'afu_control_offset' is the offset of the AFU control DVSEC for the
>    * desired AFU. It can be found in the AFU configuration
>    */
> -extern int ocxl_config_terminate_pasid(struct pci_dev *dev,
> +int ocxl_config_terminate_pasid(struct pci_dev *dev,
>   				int afu_control_offset, int pasid);
>   
>   /*
> @@ -165,13 +165,13 @@ extern int ocxl_config_terminate_pasid(struct pci_dev *dev,
>    * Returns a 'link handle' that should be used for further calls for
>    * the link
>    */
> -extern int ocxl_link_setup(struct pci_dev *dev, int PE_mask,
> +int ocxl_link_setup(struct pci_dev *dev, int PE_mask,
>   			void **link_handle);
>   
>   /*
>    * Remove the association between the function and its link.
>    */
> -extern void ocxl_link_release(struct pci_dev *dev, void *link_handle);
> +void ocxl_link_release(struct pci_dev *dev, void *link_handle);
>   
>   /*
>    * Add a Process Element to the Shared Process Area for a link.
> @@ -183,7 +183,7 @@ extern void ocxl_link_release(struct pci_dev *dev, void *link_handle);
>    * 'xsl_err_data' is an argument passed to the above callback, if
>    * defined
>    */
> -extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
> +int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		u64 amr, struct mm_struct *mm,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data);
> @@ -195,12 +195,12 @@ extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>    * pasid: the PASID for the AFU context
>    * tid: the new thread id for the process element
>    */
> -extern int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> +int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
>   
>   /*
>    * Remove a Process Element from the Shared Process Area for a link
>    */
> -extern int ocxl_link_remove_pe(void *link_handle, int pasid);
> +int ocxl_link_remove_pe(void *link_handle, int pasid);
>   
>   /*
>    * Allocate an AFU interrupt associated to the link.
> @@ -212,12 +212,12 @@ extern int ocxl_link_remove_pe(void *link_handle, int pasid);
>    * interrupt. It is an MMIO address which needs to be remapped (one
>    * page).
>    */
> -extern int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
> +int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
>   			u64 *obj_handle);
>   
>   /*
>    * Free a previously allocated AFU interrupt
>    */
> -extern void ocxl_link_free_irq(void *link_handle, int hw_irq);
> +void ocxl_link_free_irq(void *link_handle, int hw_irq);
>   
>   #endif /* _MISC_OCXL_H_ */
> 

