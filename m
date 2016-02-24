Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAB141A0776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:35:16 +1100 (AEDT)
In-Reply-To: <1455981114-18869-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc/mm/hash: Clear the invalid slot information correctly
Message-Id: <20160224143516.A07E9140BEA@ozlabs.org>
Date: Thu, 25 Feb 2016 01:35:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 15:11:54 UTC, "Aneesh Kumar K.V" wrote:
> We can get a hash pte fault with 4k base page size and find the pte
> already inserted with 64K base page size. In that case we need to clear
> the existing slot information from the old pte. Fix this correctly
> 
> With THP, we also clear the slot information with respect to all
> the 64K hash pte mapping that 16MB page. They are all invalid
> now. This make sure we don't find the slot valid when we fault with
> 4k base page size. Finding the slot valid should not result in any wrong
> behavior because we do check again in hash page table for the validity.
> But we can avoid that check completely.
> 
> Fixes: a43c0eb8364c022 ("powerpc/mm: Convert 4k hash insert to C")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9ab3ac233a8b4ffcc27c8475b8

cheers
