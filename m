Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x6391ccWzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:18:45 +1000 (AEST)
In-Reply-To: <153500011126.9482.8367068862900987587.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2] poewrpc/mce: Fix SLB rebolting during MCE recovery path.
Message-Id: <41x6384j4Vz9sBZ@ozlabs.org>
Date: Fri, 24 Aug 2018 00:18:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 04:56:08 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> With the powrpc next commit e7e81847478 (poewrpc/mce: Fix SLB rebolting
> during MCE recovery path.), the SLB error recovery is broken. The new
> change now does not add index value to RB[52-63] that selects the SLB
> entry while rebolting, instead it assumes that the shadow save area
> already have index embeded correctly in esid field. While all valid bolted
> save areas do contain index value set correctly, there is a case where
> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
> esid entry. This patch fixes that.
> 
> Without this patch the SLB rebolt code overwirtes the 1st entry of kernel
> linear mapping and causes SLB recovery to fail.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f52b3a00c789569d7ed822b5a6b30

cheers
