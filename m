Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD8C282CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:39:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35890214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35890214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p9jT146ZzDqHm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 00:39:57 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p9bv57TVzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 00:35:07 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SDTOe0042239
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:35:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qa0f8e3gq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:35:02 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 28 Jan 2019 13:34:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 13:34:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SDYu9M45351038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 13:34:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D03611C054;
 Mon, 28 Jan 2019 13:34:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DECB211C050;
 Mon, 28 Jan 2019 13:34:55 +0000 (GMT)
Received: from [9.145.43.137] (unknown [9.145.43.137])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 13:34:55 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] cxl: Force a CAPP reset when unloading CXL module
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20190125051131.29351-1-vaibhav@linux.ibm.com>
 <20190125051131.29351-3-vaibhav@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 28 Jan 2019 14:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125051131.29351-3-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012813-0016-0000-0000-0000024BE184
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012813-0017-0000-0000-000032A5E87A
Message-Id: <536488a4-3ba1-6188-dfd1-f1edc5ffcf6a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280105
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/01/2019 à 06:11, Vaibhav Jain a écrit :
> This patch forces shutdown of CAPP when CXL module is unloaded. This
> is accomplished via a call to pnv_phb_to_cxl_mode() with mode ==
> OPAL_PHB_CAPI_MODE_PCIE.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h  |  1 +
>   drivers/misc/cxl/main.c |  3 +++
>   drivers/misc/cxl/pci.c  | 25 ++++++++++++++++++++++++-
>   3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index d1d927ccb589..e545c2b81faf 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -1136,4 +1136,5 @@ void cxl_context_mm_count_get(struct cxl_context *ctx);
>   /* Decrements the reference count to "struct mm_struct" */
>   void cxl_context_mm_count_put(struct cxl_context *ctx);
>   
> +void cxl_pci_shutdown_capp(void);
>   #endif
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index f35406be465a..f14ff0dcf231 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -372,6 +372,9 @@ static void exit_cxl(void)
>   	if (cxl_is_power8())
>   		unregister_cxl_calls(&cxl_calls);
>   	idr_destroy(&cxl_adapter_idr);
> +
> +	if (cpu_has_feature(CPU_FTR_HVMODE))
> +		cxl_pci_shutdown_capp();
>   }
>   
>   module_init(init_cxl);
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index c79ba1c699ad..01be2e2d1069 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -25,7 +25,7 @@
>   
>   #include "cxl.h"
>   #include <misc/cxl.h>
> -
> +#include <misc/cxllib.h>
>   
>   #define CXL_PCI_VSEC_ID	0x1280
>   #define CXL_VSEC_MIN_SIZE 0x80
> @@ -2065,6 +2065,29 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	}
>   }
>   
> +void cxl_pci_shutdown_capp(void)
> +{
> +	struct pci_dev *pdev;
> +	struct pci_bus *root_bus;
> +	int rc;
> +
> +	/* Iterate over all CAPP supported PHB's and force them to PCI mode */
> +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> +		for_each_pci_bridge(pdev, root_bus) {
> +
> +			if (!cxllib_slot_is_supported(pdev, 0))
> +				continue;
> +
> +			rc = pnv_phb_to_cxl_mode(pdev,
> +						 OPAL_PHB_CAPI_MODE_PCIE);
> +			if (rc)
> +				dev_err(&pdev->dev,
> +					"cxl: Error resetting CAPP. Err=%d\n",
> +					rc);
> +		}


That's the part I don't like. We're iterating over quite a few PCI 
devices, we basically don't know the ones we need to reset.
If we have a per-adapter property on /sys to activate the 
reset-on-unload, then we could move the call to 
pnv_phb_to_cxl_mode(OPAL_PHB_CAPI_MODE_PCIE) on the cxl_remove() 
callback, and only do it for the adapters we've been asked.

   Fred



> +	}
> +}
> +
>   static const struct pci_error_handlers cxl_err_handler = {
>   	.error_detected = cxl_pci_error_detected,
>   	.slot_reset = cxl_pci_slot_reset,
> 

