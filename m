Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk0CH6qHkzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:14:35 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 16:14:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 51C0A3578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:14:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3B6ELhL4522402
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:14:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3B6Dvb8010354
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:13:57 +1000
Message-ID: <570B4093.1010600@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 11:43:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V2] powerpc/mm: Add validation for platform reserved memory
 ranges
References: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/07/2016 03:25 PM, Anshuman Khandual wrote:
> For partition running on PHYP, there can be a adjunct partition
> which shares the virtual address range with the operating system.
> Virtual address ranges which can be used by the adjunct partition
> are communicated with virtual device node of the device tree with
> a property known as "ibm,reserved-virtual-addresses". This patch
> introduces a new function named 'validate_reserved_va_range' which
> is called  during initialization to validate that these reserved
> virtual address ranges do not overlap with the address ranges used
> by the kernel for all supported memory contexts. This helps prevent
> the possibility of getting return codes similar to H_RESOURCE for
> H_PROTECT hcalls for conflicting HPTE entries.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> - Tested on both POWER8 LE and BE platforms
> 
> Changes in V2:
> - Added braces to the definition of LINUX_VA_BITS
> - Adjusted tabs as spaces for the definition of PARTIAL_LINUX_VA_MASK

mpe, any updates on this ?
