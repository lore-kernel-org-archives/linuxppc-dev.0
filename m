Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 192011A03F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 14:00:33 +1100 (AEDT)
Date: Thu, 29 Oct 2015 14:00:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/7] Remove 4k subpage tracking with hash 64K config
Message-ID: <20151029030029.GA31681@fergus.ozlabs.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 01:42:26AM +0530, Aneesh Kumar K.V wrote:
> Hi,
> 
> This patch series is on top of the series posted at 
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135299.html
> "[PATCH V4 00/31] powerpc/mm: Update page table format for book3s 64". In this
> series we remove 4k subpage tracking with 64K config. Instead we do a hash
> table lookup to get the slot information of 4k hash ptes. This also allow us
> to remove real_pte_t. Side effect of the change is that a specific 4k slot
> lookup can result in multiple H_READ hcalls. But that should only impact
> when we are using 4K subpages which should be rare.
> 
> NOTE: I only tested this on systemsim. Wanted to get this out to get early
> feedback.

I tried this on a quad G5 and it seems to work just fine.  On a kernel
compile test there was very little difference in speed - I measured
about 0.4% slowdown but that may not be statistically significant.
This was with 64k pages configured and THP enabled.

Paul.
