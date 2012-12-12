Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0D272C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 23:39:05 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so510899pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 04:39:03 -0800 (PST)
Message-ID: <50C87AE1.9000708@ozlabs.ru>
Date: Wed, 12 Dec 2012 23:38:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
References: <1354901926.3224.96.camel@bling.home>
 <1355315657-31153-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1355315657-31153-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,

I posted other pair of patches. While debugging and testing my stuff I 
implemented some rough hack to support IOMMU mappings without passing those 
hypercalls to the QEMU, this is why I moved pieces of code around - want to 
support both QEMU-VFIO and kernel optimized H_PUT_TCE handler.



On 12/12/12 23:34, Alexey Kardashevskiy wrote:
> This patch initializes IOMMU groups based on the IOMMU
> configuration discovered during the PCI scan on POWERNV
> (POWER non virtualized) platform. The IOMMU groups are
> to be used later by VFIO driver (PCI pass through).
>
> It also implements an API for mapping/unmapping pages for
> guest PCI drivers and providing DMA window properties.
> This API is going to be used later by QEMU-VFIO to handle
> h_put_tce hypercalls from the KVM guest.
>
> Although this driver has been tested only on the POWERNV
> platform, it should work on any platform which supports
> TCE tables.
>
> To enable VFIO on POWER, enable SPAPR_TCE_IOMMU config
> option and configure VFIO as required.
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---


-- 
Alexey
