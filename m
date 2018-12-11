Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B518C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3A02084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3A02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DL404F5kzDqXN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:12:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DL0K5x8lzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 11:09:21 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5C323082B0F;
 Tue, 11 Dec 2018 00:09:19 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFF185D717;
 Tue, 11 Dec 2018 00:09:18 +0000 (UTC)
Date: Mon, 10 Dec 2018 17:09:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 17/19] vfio_pci: Allow mapping extra regions
Message-ID: <20181210170918.119b254a@x1.home>
In-Reply-To: <20181123055304.25116-18-aik@ozlabs.ru>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-18-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 11 Dec 2018 00:09:20 +0000 (UTC)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 23 Nov 2018 16:53:02 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> So far we only allowed mapping of MMIO BARs to the userspace. However
> there there are GPUs with on-board coherent RAM accessible via side

s/there there/there/

Otherwise:

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> channels which we also want to map to the userspace. The first client
> for this is NVIDIA V100 GPU with NVLink2 direct links to a POWER9
> NPU-enabled CPU; such GPUs have 16GB RAM which is coherently mapped
> to the system address space, we are going to export these as an extra
> PCI region.
> 
> We already support extra PCI regions and this adds support for mapping
> them to the userspace.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes:
> v2:
> * reverted one of mistakenly removed error checks
> ---
>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>  drivers/vfio/pci/vfio_pci.c         | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index cde3b5d..86aab05 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -59,6 +59,9 @@ struct vfio_pci_regops {
>  		      size_t count, loff_t *ppos, bool iswrite);
>  	void	(*release)(struct vfio_pci_device *vdev,
>  			   struct vfio_pci_region *region);
> +	int	(*mmap)(struct vfio_pci_device *vdev,
> +			struct vfio_pci_region *region,
> +			struct vm_area_struct *vma);
>  };
>  
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index fef5002..4a6f7c0 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1130,6 +1130,15 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
> +	if (index >= VFIO_PCI_NUM_REGIONS) {
> +		int regnum = index - VFIO_PCI_NUM_REGIONS;
> +		struct vfio_pci_region *region = vdev->region + regnum;
> +
> +		if (region && region->ops && region->ops->mmap &&
> +		    (region->flags & VFIO_REGION_INFO_FLAG_MMAP))
> +			return region->ops->mmap(vdev, region, vma);
> +		return -EINVAL;
> +	}
>  	if (index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -EINVAL;
>  	if (!vdev->bar_mmap_supported[index])

