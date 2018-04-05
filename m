Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H58J03g2zF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 00:39:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w35Eatev001243
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2018 10:39:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h5njdrmna-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 10:39:56 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 5 Apr 2018 15:39:53 +0100
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, "Michael S. Tsirkin" <mst@redhat.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 20:09:30 +0530
MIME-Version: 1.0
In-Reply-To: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> There are certian platforms which would like to use SWIOTLB based DMA API
> for bouncing purpose without actually requiring an IOMMU back end. But the
> virtio core does not allow such mechanism. Right now DMA MAP API is only
> selected for devices which have an IOMMU and then the QEMU/host back end
> will process all incoming SG buffer addresses as IOVA instead of simple
> GPA which is the case for simple bounce buffers after being processed with
> SWIOTLB API. To enable this usage, it introduces an architecture specific
> function which will just make virtio core front end select DMA operations
> structure.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

+ "Michael S. Tsirkin" <mst@redhat.com>
