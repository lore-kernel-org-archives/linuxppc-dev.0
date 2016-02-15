Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AD2B1A0316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:02:23 +1100 (AEDT)
Date: Mon, 15 Feb 2016 15:11:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 08/29] mm: Some arch may want to use HPAGE_PMD related
 values as variables
Message-ID: <20160215041153.GC3797@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454923241-6681-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 02:50:20PM +0530, Aneesh Kumar K.V wrote:
> With next generation power processor, we are having a new mmu model
> [1] that require us to maintain a different linux page table format.
> 
> Inorder to support both current and future ppc64 systems with a single
> kernel we need to make sure kernel can select between different page
> table format at runtime. With the new MMU (radix MMU) added, we will
> have two different pmd hugepage size 16MB for hash model and 2MB for
> Radix model. Hence make HPAGE_PMD related values as a variable.

But this patch doesn't actually turn any constant into a variable, as
far as I can see...

Most of what this patch does is to move two tests around:

* The #if HPAGE_PMD_ORDER >= MAX_ORDER test get moved from a generic
header into all archs except powerpc, and for powerpc it gets turned
into BUILD_BUG_ON.  However, BUILD_BUG_ON only works on things that
are known at compile time, last time I looked.  Doesn't it need to be
a BUG_ON to prepare for HPAGE_PMD_ORDER being a variable that isn't
known at compile time?

* The existing BUILD_BUG_ON(HPAGE_PMD_ORDER < 2) gets turned into #if
for all archs except powerpc, and for powerpc it stays as a
BUILD_BUG_ON but gets moved to arch code.  That doesn't really seem to
accomplish anything.  Once again, doesn't it need to become a BUG_ON?
If so, could we just make it BUG_ON in the generic code where the
BUILD_BUG_ON currently is?

Paul.
