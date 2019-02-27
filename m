Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A5C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:46:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FF320C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FF320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448cRJ0ZH3zDqDb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:46:36 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 448cJ13lYGzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:40:16 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RDbgwP139657
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:40:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwuj48a2r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:40:08 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 27 Feb 2019 13:40:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 13:40:04 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1RDe3tP50331708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Feb 2019 13:40:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E972042045;
 Wed, 27 Feb 2019 13:40:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8167842041;
 Wed, 27 Feb 2019 13:40:02 +0000 (GMT)
Received: from [9.145.24.93] (unknown [9.145.24.93])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 13:40:02 +0000 (GMT)
Subject: Re: [PATCH 2/5] ocxl: Clean up printf formats
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 27 Feb 2019 14:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227045741.21412-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022713-0016-0000-0000-0000025B9235
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022713-0017-0000-0000-000032B5FA50
Message-Id: <577c579a-5bf8-45e6-c5f7-67aa00931e59@linux.ibm.com>
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
> Use %# instead of using a literal '0x'
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

I don't really care either way, but it looks ok.

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/config.c  |  6 +++---
>   drivers/misc/ocxl/context.c |  2 +-
>   drivers/misc/ocxl/trace.h   | 10 +++++-----
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 8f2c5d8bd2ee..0ee7856b033d 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -178,9 +178,9 @@ static int read_dvsec_vendor(struct pci_dev *dev)
>   	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_DLX_VERS, &dlx);
>   
>   	dev_dbg(&dev->dev, "Vendor specific DVSEC:\n");
> -	dev_dbg(&dev->dev, "  CFG version = 0x%x\n", cfg);
> -	dev_dbg(&dev->dev, "  TLX version = 0x%x\n", tlx);
> -	dev_dbg(&dev->dev, "  DLX version = 0x%x\n", dlx);
> +	dev_dbg(&dev->dev, "  CFG version = %#x\n", cfg);
> +	dev_dbg(&dev->dev, "  TLX version = %#x\n", tlx);
> +	dev_dbg(&dev->dev, "  DLX version = %#x\n", dlx);
>   	return 0;
>   }
>   
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index c10a940e3b38..3498a0199bde 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -134,7 +134,7 @@ static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
>   	vm_fault_t ret;
>   
>   	offset = vmf->pgoff << PAGE_SHIFT;
> -	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
> +	pr_debug("%s: pasid %d address %#lx offset %#llx\n", __func__,
>   		ctx->pasid, vmf->address, offset);
>   
>   	if (offset < ctx->afu->irq_base_offset)
> diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
> index bcb7ff330c1e..8d2f53812edd 100644
> --- a/drivers/misc/ocxl/trace.h
> +++ b/drivers/misc/ocxl/trace.h
> @@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(ocxl_context,
>   		__entry->tidr = tidr;
>   	),
>   
> -	TP_printk("linux pid=%d spa=0x%p pasid=0x%x pidr=0x%x tidr=0x%x",
> +	TP_printk("linux pid=%d spa=%p pasid=%#x pidr=%#x tidr=%#x",
>   		__entry->pid,
>   		__entry->spa,
>   		__entry->pasid,
> @@ -61,7 +61,7 @@ TRACE_EVENT(ocxl_terminate_pasid,
>   		__entry->rc = rc;
>   	),
>   
> -	TP_printk("pasid=0x%x rc=%d",
> +	TP_printk("pasid=%#x rc=%d",
>   		__entry->pasid,
>   		__entry->rc
>   	)
> @@ -87,7 +87,7 @@ DECLARE_EVENT_CLASS(ocxl_fault_handler,
>   		__entry->tfc = tfc;
>   	),
>   
> -	TP_printk("spa=%p pe=0x%llx dsisr=0x%llx dar=0x%llx tfc=0x%llx",
> +	TP_printk("spa=%p pe=%#llx dsisr=%#llx dar=%#llx tfc=%#llx",
>   		__entry->spa,
>   		__entry->pe,
>   		__entry->dsisr,
> @@ -127,7 +127,7 @@ TRACE_EVENT(ocxl_afu_irq_alloc,
>   		__entry->irq_offset = irq_offset;
>   	),
>   
> -	TP_printk("pasid=0x%x irq_id=%d virq=%u hw_irq=%d irq_offset=0x%llx",
> +	TP_printk("pasid=%#x irq_id=%d virq=%u hw_irq=%d irq_offset=0x%llx",
>   		__entry->pasid,
>   		__entry->irq_id,
>   		__entry->virq,
> @@ -150,7 +150,7 @@ TRACE_EVENT(ocxl_afu_irq_free,
>   		__entry->irq_id = irq_id;
>   	),
>   
> -	TP_printk("pasid=0x%x irq_id=%d",
> +	TP_printk("pasid=%#x irq_id=%d",
>   		__entry->pasid,
>   		__entry->irq_id
>   	)
> 

