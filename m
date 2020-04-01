Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57054C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 22:41:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E6A2078C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 22:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD2brSzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E6A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48t1Qj2FYGzDrCS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 09:41:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=alex.williamson@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QD2brSzy; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48t1NW6nQczDr0Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2020 09:39:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585780787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Alouy9q/FraZi33ad3ws+oSCClJMmuypJjzhB4Ja6OU=;
 b=QD2brSzy4v75kdQtq1SyxP+BvbYua9s2v8ZZYl6npktIj/PY5kEZwp+/Nn5ZvTpU4A3yii
 OG9rGYjfWQXEpx8o69jglUv3hVmTxuIMkCDJEunT0ItBT3MP+AHRvb9L6IZZvnnf7/bnsG
 Rtqa7JgfhJw6bPjBevoa1KDJEK3WMzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-4bsva1KDPWahEc7SzhBBeg-1; Wed, 01 Apr 2020 18:39:45 -0400
X-MC-Unique: 4bsva1KDPWahEc7SzhBBeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 824C2800D50;
 Wed,  1 Apr 2020 22:39:44 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0376196B93;
 Wed,  1 Apr 2020 22:39:43 +0000 (UTC)
Date: Wed, 1 Apr 2020 16:39:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio-pci/nvlink2: Allow fallback to
 ibm,mmio-atsd[0]
Message-ID: <20200401163943.0771ac78@w520.home>
In-Reply-To: <6183bf8ec2dd0433f213e081911ab8fd5cac2dcb.1585627961.git.sbobroff@linux.ibm.com>
References: <6183bf8ec2dd0433f213e081911ab8fd5cac2dcb.1585627961.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 31 Mar 2020 15:12:46 +1100
Sam Bobroff <sbobroff@linux.ibm.com> wrote:

> Older versions of skiboot only provide a single value in the device
> tree property "ibm,mmio-atsd", even when multiple Address Translation
> Shoot Down (ATSD) registers are present. This prevents NVLink2 devices
> (other than the first) from being used with vfio-pci because vfio-pci
> expects to be able to assign a dedicated ATSD register to each NVLink2
> device.
> 
> However, ATSD registers can be shared among devices. This change
> allows vfio-pci to fall back to sharing the register at index 0 if
> necessary.
> 
> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> Patch set v2:
> Patch 1/1: vfio-pci/nvlink2: Allow fallback to ibm,mmio-atsd[0]
> - Removed unnecessary warning.
> - Added Fixes tag.
> 
> Patch set v1:
> Patch 1/1: vfio-pci/nvlink2: Allow fallback to ibm,mmio-atsd[0]
> 
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to vfio next branch for v5.7 with Alexey's review.  Thanks,

Alex

> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> index f2983f0f84be..ae2af590e501 100644
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -420,8 +420,14 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  
>  	if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", nvlink_index,
>  			&mmio_atsd)) {
> -		dev_warn(&vdev->pdev->dev, "No available ATSD found\n");
> -		mmio_atsd = 0;
> +		if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", 0,
> +				&mmio_atsd)) {
> +			dev_warn(&vdev->pdev->dev, "No available ATSD found\n");
> +			mmio_atsd = 0;
> +		} else {
> +			dev_warn(&vdev->pdev->dev,
> +				 "Using fallback ibm,mmio-atsd[0] for ATSD.\n");
> +		}
>  	}
>  
>  	if (of_property_read_u64(npu_node, "ibm,device-tgt-addr", &tgt)) {

