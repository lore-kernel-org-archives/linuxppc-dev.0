Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTF83w1LzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:48 +1000 (AEST)
In-Reply-To: <16ab841927ec607e16c37cbeff0aede21a27b8c3.1501679953.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,
 1/5] powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned
 TLBs
Message-Id: <3xXTF82Lcmz9t4Z@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 13:51:01 UTC, Christophe Leroy wrote:
> __change_page_attr() uses flush_tlb_page().
> flush_tlb_page() uses tlbie instruction, which also invalidates
> pinned TLBs, which is not what we expect.
> 
> This patch modifies the implementation to use flush_tlb_kernel_range()
> instead. This will make use of tlbia which will preserve pinned TLBs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e611939fc8ec13387018df88083de7

cheers
