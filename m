Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452951A02AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 08:21:00 +1000 (AEST)
Date: Tue, 19 May 2015 15:20:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 0/3] THP related cleanups
Message-Id: <20150519152057.c183197e9bac117d4a179f80@linux-foundation.org>
In-Reply-To: <1431704550-19937-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1431704550-19937-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 May 2015 21:12:27 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Changes from V4:
> * Folded patches in -mm
>   mm-thp-split-out-pmd-collpase-flush-into-a-separate-functions-fix.patch
>   mm-thp-split-out-pmd-collpase-flush-into-a-separate-functions-fix-2.patch
>   mm-clarify-that-the-function-operateds-on-hugepage-pte-fix.patch
> * Fix VM_BUG_ON on x86.
>  the default implementation of pmdp_collapse_flush used the hugepage variant
>  and hence can be called on pmd_t pointing to pgtable. This resulting in us
>  hitting VM_BUG_ON in pmdp_clear_flush. Update powerpc/mm: Use generic version of pmdp_clear_flush
>  to handle this.
> 
> 
> NOTE: Can we get this tested on s390 ?

fwiw, I build tested s390 allmodconfig in mm/ and arch/s390, no issues.
