Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF92C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 22:00:27 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD4E20675
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 22:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yc9h61XNzDqHW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 08:00:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yc7v01FKzDq9G
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2019 07:58:49 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 451D33087932;
 Mon,  6 May 2019 21:58:47 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1868260BEC;
 Mon,  6 May 2019 21:58:46 +0000 (UTC)
Date: Mon, 6 May 2019 15:58:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
Message-ID: <20190506155845.70f3b01d@x1.home>
In-Reply-To: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 06 May 2019 21:58:47 +0000 (UTC)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 19 Apr 2019 17:37:17 +0200
Greg Kurz <groug@kaod.org> wrote:

> If vfio_pci_register_dev_region() fails then we should rollback
> previous changes, ie. unmap the ATSD registers.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!

Alex

>  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> index 32f695ffe128..50fe3c4f7feb 100644
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -472,6 +472,8 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  	return 0;
>  
>  free_exit:
> +	if (data->base)
> +		memunmap(data->base);
>  	kfree(data);
>  
>  	return ret;
> 

