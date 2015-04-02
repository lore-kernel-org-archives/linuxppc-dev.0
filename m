Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 734341A084B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:01:57 +1100 (AEDT)
Message-ID: <1428012097.20500.279.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 03 Apr 2015 09:01:37 +1100
In-Reply-To: <1428011820.20500.277.camel@kernel.crashing.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402214343.GA15680@oracle.com>
 <1428011820.20500.277.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 08:57 +1100, Benjamin Herrenschmidt wrote:

> No, the last argument to iommu_area_alloc() which is passed from the
> callers when doing consistent allocs. Basically, the DMA api mandates
> that consistent allocs are naturally aligned (to their own size), we
> implement that on powerpc by passing that alignment argument down.

Talking of this ... I notice this is not documented in DMA-API.txt...
however many drivers make that assumption, and the DMA pool allocator
in mm/dmapool.c as well.

Maybe somebody should update DMA-API.txt...

Cheers,
Ben.
