Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HPQW1Q6gzF1wk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 12:53:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w362nF4m121062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2018 22:53:19 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h5wnfwqfq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 22:53:18 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 6 Apr 2018 03:53:17 +0100
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 08:23:10 +0530
MIME-Version: 1.0
In-Reply-To: <1522963113.21446.211.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2018 02:48 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
>>> In this specific case, because that would make qemu expect an iommu,
>>> and there isn't one.
>>
>>
>> I think that you can set iommu_platform in qemu without an iommu.
> 
> No I mean the platform has one but it's not desirable for it to be used
> due to the performance hit.

Also the only requirement is to bounce the I/O buffers through SWIOTLB
implemented as DMA API which the virtio core understands. There is no
need for an IOMMU to be involved for the device representation in this
case IMHO.
