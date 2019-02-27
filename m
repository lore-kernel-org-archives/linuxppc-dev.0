Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E246C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56E720C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56E720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448cPC0LZBzDqKT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448cHC66FJzDqDb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:39:35 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RDbkwf083766
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:39:33 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwtpdk2t3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:39:32 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 27 Feb 2019 13:39:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 13:39:27 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1RDdQbS26280036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Feb 2019 13:39:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ED4842045;
 Wed, 27 Feb 2019 13:39:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB44B42049;
 Wed, 27 Feb 2019 13:39:25 +0000 (GMT)
Received: from [9.145.24.93] (unknown [9.145.24.93])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 13:39:25 +0000 (GMT)
Subject: Re: [PATCH 5/5] ocxl: Remove some unused exported symbols
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-6-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 27 Feb 2019 14:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227045741.21412-6-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022713-4275-0000-0000-00000314A23A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022713-4276-0000-0000-00003822E585
Message-Id: <c43b3a4b-13db-1f50-0083-8c8b2701838f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270091
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



Le 27/02/2019 à 05:57, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove some unused exported symbols.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

If you have a respin of the series, that patch also adds a comment 
around ocxl_context_attach(), which is for later.
But in any case:
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/config.c        |  2 --
>   drivers/misc/ocxl/ocxl_internal.h | 26 +++++++++++++++++++++++++-
>   include/misc/ocxl.h               | 23 -----------------------
>   3 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 026ac2ac4f9c..c90c2e4875bf 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -299,7 +299,6 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>   	}
>   	return 1;
>   }
> -EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
>   
>   static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
>   			struct ocxl_afu_config *afu)
> @@ -535,7 +534,6 @@ int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count)
>   {
>   	return pnv_ocxl_get_pasid_count(dev, count);
>   }
> -EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
>   
>   void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
>   			u32 pasid_count_log)
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 321b29e77f45..cd5a1e3cc950 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -107,10 +107,34 @@ void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
>   int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
>   void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
>   
> +/*
> + * Get the max PASID value that can be used by the function
> + */
> +int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> +
> +int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
> +
> +/*
> + * Check if an AFU index is valid for the given function.
> + *
> + * AFU indexes can be sparse, so a driver should check all indexes up
> + * to the maximum found in the function description
> + */
> +int ocxl_config_check_afu_index(struct pci_dev *dev,
> +				struct ocxl_fn_config *fn, int afu_idx);
> +
> +/**
> + * Update values within a Process Element
> + *
> + * link_handle: the link handle associated with the process element
> + * pasid: the PASID for the AFU context
> + * tid: the new thread id for the process element
> + */
> +int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> +
>   struct ocxl_context *ocxl_context_alloc(void);
>   int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   			struct address_space *mapping);
> -int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
>   int ocxl_context_mmap(struct ocxl_context *ctx,
>   			struct vm_area_struct *vma);
>   int ocxl_context_detach(struct ocxl_context *ctx);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 4544573cc93c..9530d3be1b30 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -56,15 +56,6 @@ struct ocxl_fn_config {
>   int ocxl_config_read_function(struct pci_dev *dev,
>   				struct ocxl_fn_config *fn);
>   
> -/*
> - * Check if an AFU index is valid for the given function.
> - *
> - * AFU indexes can be sparse, so a driver should check all indexes up
> - * to the maximum found in the function description
> - */
> -int ocxl_config_check_afu_index(struct pci_dev *dev,
> -				struct ocxl_fn_config *fn, int afu_idx);
> -
>   /*
>    * Read the configuration space of a function for the AFU specified by
>    * the index 'afu_idx'. Fills in a ocxl_afu_config structure
> @@ -74,11 +65,6 @@ int ocxl_config_read_afu(struct pci_dev *dev,
>   				struct ocxl_afu_config *afu,
>   				u8 afu_idx);
>   
> -/*
> - * Get the max PASID value that can be used by the function
> - */
> -int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> -
>   /*
>    * Tell an AFU, by writing in the configuration space, the PASIDs that
>    * it can use. Range starts at 'pasid_base' and its size is a multiple
> @@ -188,15 +174,6 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data);
>   
> -/**
> - * Update values within a Process Element
> - *
> - * link_handle: the link handle associated with the process element
> - * pasid: the PASID for the AFU context
> - * tid: the new thread id for the process element
> - */
> -int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> -
>   /*
>    * Remove a Process Element from the Shared Process Area for a link
>    */
> 

