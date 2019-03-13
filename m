Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3AC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:03:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E072171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E072171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K9TH3ZDdzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:02:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=188.165.38.119; helo=11.mo6.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 12599 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Mar 2019 23:00:35 AEDT
Received: from 11.mo6.mail-out.ovh.net (11.mo6.mail-out.ovh.net
 [188.165.38.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K9QW64VpzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 23:00:29 +1100 (AEDT)
Received: from player158.ha.ovh.net (unknown [10.109.159.35])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 44A5B1B806B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:24:37 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 8BF873845CCD;
 Wed, 13 Mar 2019 08:24:29 +0000 (UTC)
Date: Wed, 13 Mar 2019 09:24:28 +0100
From: Greg Kurz <groug@kaod.org>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH 2/5] ocxl: Clean up printf formats
Message-ID: <20190313092428.747cc671@bahia.lan>
In-Reply-To: <20190313040702.14276-3-alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190313040702.14276-1-alastair@au1.ibm.com>
 <20190313040702.14276-3-alastair@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13710364644560574795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 13 Mar 2019 15:06:58 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use %# instead of using a literal '0x'
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  drivers/misc/ocxl/config.c  |  6 +++---
>  drivers/misc/ocxl/context.c |  2 +-
>  drivers/misc/ocxl/trace.h   | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 8f2c5d8bd2ee..0ee7856b033d 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -178,9 +178,9 @@ static int read_dvsec_vendor(struct pci_dev *dev)
>  	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_DLX_VERS, &dlx);
>  
>  	dev_dbg(&dev->dev, "Vendor specific DVSEC:\n");
> -	dev_dbg(&dev->dev, "  CFG version = 0x%x\n", cfg);
> -	dev_dbg(&dev->dev, "  TLX version = 0x%x\n", tlx);
> -	dev_dbg(&dev->dev, "  DLX version = 0x%x\n", dlx);
> +	dev_dbg(&dev->dev, "  CFG version = %#x\n", cfg);
> +	dev_dbg(&dev->dev, "  TLX version = %#x\n", tlx);
> +	dev_dbg(&dev->dev, "  DLX version = %#x\n", dlx);
>  	return 0;
>  }
>  
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index c10a940e3b38..3498a0199bde 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -134,7 +134,7 @@ static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
>  	vm_fault_t ret;
>  
>  	offset = vmf->pgoff << PAGE_SHIFT;
> -	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
> +	pr_debug("%s: pasid %d address %#lx offset %#llx\n", __func__,
>  		ctx->pasid, vmf->address, offset);
>  
>  	if (offset < ctx->afu->irq_base_offset)
> diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
> index bcb7ff330c1e..68bf2f173a1a 100644
> --- a/drivers/misc/ocxl/trace.h
> +++ b/drivers/misc/ocxl/trace.h
> @@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(ocxl_context,
>  		__entry->tidr = tidr;
>  	),
>  
> -	TP_printk("linux pid=%d spa=0x%p pasid=0x%x pidr=0x%x tidr=0x%x",
> +	TP_printk("linux pid=%d spa=%p pasid=%#x pidr=%#x tidr=%#x",
>  		__entry->pid,
>  		__entry->spa,
>  		__entry->pasid,
> @@ -61,7 +61,7 @@ TRACE_EVENT(ocxl_terminate_pasid,
>  		__entry->rc = rc;
>  	),
>  
> -	TP_printk("pasid=0x%x rc=%d",
> +	TP_printk("pasid=%#x rc=%d",
>  		__entry->pasid,
>  		__entry->rc
>  	)
> @@ -87,7 +87,7 @@ DECLARE_EVENT_CLASS(ocxl_fault_handler,
>  		__entry->tfc = tfc;
>  	),
>  
> -	TP_printk("spa=%p pe=0x%llx dsisr=0x%llx dar=0x%llx tfc=0x%llx",
> +	TP_printk("spa=%p pe=%#llx dsisr=%#llx dar=%#llx tfc=%#llx",
>  		__entry->spa,
>  		__entry->pe,
>  		__entry->dsisr,
> @@ -127,7 +127,7 @@ TRACE_EVENT(ocxl_afu_irq_alloc,
>  		__entry->irq_offset = irq_offset;
>  	),
>  
> -	TP_printk("pasid=0x%x irq_id=%d virq=%u hw_irq=%d irq_offset=0x%llx",
> +	TP_printk("pasid=%#x irq_id=%d virq=%u hw_irq=%d irq_offset=%#llx",
>  		__entry->pasid,
>  		__entry->irq_id,
>  		__entry->virq,
> @@ -150,7 +150,7 @@ TRACE_EVENT(ocxl_afu_irq_free,
>  		__entry->irq_id = irq_id;
>  	),
>  
> -	TP_printk("pasid=0x%x irq_id=%d",
> +	TP_printk("pasid=%#x irq_id=%d",
>  		__entry->pasid,
>  		__entry->irq_id
>  	)

