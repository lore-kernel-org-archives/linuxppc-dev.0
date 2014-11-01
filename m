Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id B49011A006B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 06:21:17 +1100 (AEDT)
Date: Sat, 01 Nov 2014 15:21:12 -0400 (EDT)
Message-Id: <20141101.152112.741323581543029110.davem@davemloft.net>
To: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V4 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aarcange@redhat.com, linux-arch@vger.kernel.org, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Oct 2014 13:49:44 +0530

> Update generic gup implementation with powerpc specific details.
> On powerpc at pmd level we can have hugepte, normal pmd pointer
> or a pointer to the hugepage directory.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V3:
> * Drop arm and arm64 changes
> * Add hugepte assumption to the function 

Wait, what are you doing here?

You can't assume that a pmd is something you can just go:

	__pte(pmd_val(x))

with.  Not at all.

You have to use the correct pmd_*() accessors at all times on
this object.

Platforms can encode PMDs however they like.  In fact, on sparc64,
we used to have 32-bit PMDs with a special encoding for huge
PMDs that looked nothing at all like a 64-bit PTE.

Please code this in a portable manner to support the powerpc
facilities, don't add assumptions that are not necessarily
universally true.
