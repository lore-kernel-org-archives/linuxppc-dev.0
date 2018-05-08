Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsc3VKQzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:36 +1000 (AEST)
In-Reply-To: <152336766167.8374.13811759102783227353.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [v2,
 1/2] powerpc/fadump: exclude memory holes while reserving memory in
 second kernel
Message-Id: <40gMsc1MHWz9s0W@ozlabs.org>
Date: Wed,  9 May 2018 00:52:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 13:41:16 UTC, Hari Bathini wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The second kernel, during early boot after the crash, reserves rest of
> the memory above boot memory size to make sure it does not touch any of the
> dump memory area. It uses memblock_reserve() that reserves the specified
> memory region irrespective of memory holes present within that region.
> There are chances where previous kernel would have hot removed some of
> its memory leaving memory holes behind. In such cases fadump kernel reports
> incorrect number of reserved pages through arch_reserved_kernel_pages()
> hook causing kernel to hang or panic.
> 
> Fix this by excluding memory holes while reserving rest of the memory
> above boot memory size during second kernel boot after crash.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b71a693d3db3abd1ddf7d29be967a1

cheers
