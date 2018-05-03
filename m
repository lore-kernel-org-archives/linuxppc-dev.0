Return-Path: <ruscur@russell.cc>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bxVG18SbzF2S2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 10:53:55 +1000 (AEST)
Message-ID: <1525308825.2062.1.camel@russell.cc>
Subject: Re: [PATCH kernel] powerpc/ioda: Use ibm,supported-tce-sizes for
 IOMMU page size mask
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 03 May 2018 10:53:45 +1000
In-Reply-To: <20180502061239.36398-1-aik@ozlabs.ru>
References: <20180502061239.36398-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 16:12 +1000, Alexey Kardashevskiy wrote:
> At the moment we assume that IODA2 and newer PHBs can always do
> 4K/64K/16M
> IOMMU pages, however this is not the case for POWER9 and now skiboot
> advertises the supported sizes via the device so we use that instead
> of hard coding the mask.
> 
> This falls back to the default mask if no "ibm,supported-tce-sizes"
> is provided. This removes 16MB from the defaults as it is not
> supported
> everywhere; the downside of this is that hugepages backed POWER8
> guests
> will fall back to 64K IOMMU pages until skiboot is updated.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Russell Currey <ruscur@russell.cc>
