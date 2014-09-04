Return-Path: <joro@8bytes.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5C291A0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 20:23:11 +1000 (EST)
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63DCB140116
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 20:23:11 +1000 (EST)
Date: Thu, 4 Sep 2014 12:14:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH] iommu/fsl: Fix warning resulting from adding PCI device
 twice
Message-ID: <20140904101402.GM28786@8bytes.org>
References: <1409810622-742-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409810622-742-1-git-send-email-Varun.Sethi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, iommu@lists.linux-foundation.org,
 alex.williamson@redhat.com, Emilian.Medve@freescale.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 11:33:42AM +0530, Varun Sethi wrote:
> +	if (!iommu_group_get(dev))
> +		ret = iommu_group_add_device(group, dev);
>  
>  	iommu_group_put(group);
>  	return ret;

Doesn't this additional call to iommu_group_get take a reference to the
iommu_group that needs to be released?


	Joerg
