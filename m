Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05F31A0617
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 10:52:39 +1100 (AEDT)
Date: Fri, 19 Feb 2016 10:15:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 01/30] mm: Make vm_get_page_prot arch specific.
Message-ID: <20160218231546.GC2765@fergus.ozlabs.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 10:20:25PM +0530, Aneesh Kumar K.V wrote:
> With next generation power processor, we are having a new mmu model
> [1] that require us to maintain a different linux page table format.
> 
> Inorder to support both current and future ppc64 systems with a single
> kernel we need to make sure kernel can select between different page
> table format at runtime. With the new MMU (radix MMU) added, we will
> have to dynamically switch between different protection map. Hence
> override vm_get_page_prot instead of using arch_vm_get_page_prot. We
> also drop arch_vm_get_page_prot since only powerpc used it.

This seems like unnecessary churn to me.  Let's just make hash use the
same values as radix for things like _PAGE_RW, _PAGE_EXEC etc., and
then we don't need any of this.

Paul.
