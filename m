Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 852992C0382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 15:57:47 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 11:20:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 158AD3940043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:27:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S5vZ3G31129636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:27:36 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S5vdAx010178
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 15:57:39 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 1/3] mm/cma: Move dma contiguous changes into a
 seperate config
In-Reply-To: <51CC2530.2060605@samsung.com>
References: <1372062327-7028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <51CC2530.2060605@samsung.com>
Date: Fri, 28 Jun 2013 11:27:38 +0530
Message-ID: <87li5u93ql.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Michal Nazarewicz <mina86@mina86.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hello,
>
> On 6/24/2013 10:25 AM, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> We want to use CMA for allocating hash page table and real mode area for
>> PPC64. Hence move DMA contiguous related changes into a seperate config
>> so that ppc64 can enable CMA without requiring DMA contiguous.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> It's nice to see that CMA is gaining another client in mainline Linux 
> kernel.
> I also like the idea of adding CONFIG_DMA_CMA for DMA-mapping related CMA
> use to let others to use alloc_contig_range() interface.
>
> However I noticed that You have almost copied the whole drivers/base.c for
> separate use with PPC64 KVM. Is this really necessary? I think it should be
> possible to isolate some common code, which plays with contiguous region
> management and use it for both alloc_contig_range() clients (dma-mapping and
> ppc64 kvm).
>

One of the reason for having book3s_hv_cma.c is that few specifics vary
between dma contiguous. We have different alignment needs. Also i will be
switching the allocation to 256K chunks, not page size, in the next
update. It is also not large code duplication. I will post V2 soon and
may be we can see if it is worth consolidating.

-aneesh
