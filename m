Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFbPc6y6DzDsqn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 21:14:43 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id m203so6695326wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 02:14:43 -0800 (PST)
Date: Fri, 11 Nov 2016 13:14:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] mm: THP page cache support for ppc64
Message-ID: <20161111101439.GB19382@node.shutemov.name>
References: <20161107083441.21901-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161107083441.21901-2-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161107083441.21901-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2016 at 02:04:41PM +0530, Aneesh Kumar K.V wrote:
> @@ -2953,6 +2966,13 @@ static int do_set_pmd(struct fault_env *fe, struct page *page)
>  	ret = VM_FAULT_FALLBACK;
>  	page = compound_head(page);
>  
> +	/*
> +	 * Archs like ppc64 need additonal space to store information
> +	 * related to pte entry. Use the preallocated table for that.
> +	 */
> +	if (arch_needs_pgtable_deposit() && !fe->prealloc_pte)
> +		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
> +

-ENOMEM handling?

I think we should do this way before this point. Maybe in do_fault() or
something.

-- 
 Kirill A. Shutemov
