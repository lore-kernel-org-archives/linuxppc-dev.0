Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS6RY2KjszDqyx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 20:08:40 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id x64so6213728wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 03:08:40 -0700 (PDT)
Date: Wed, 9 Aug 2017 13:08:35 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 02/16] mm: Prepare for FAULT_FLAG_SPECULATIVE
Message-ID: <20170809100835.5kz3zf5sd3oqrrj4@node.shutemov.name>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-3-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502202949-8138-3-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2017 at 04:35:35PM +0200, Laurent Dufour wrote:
> @@ -2295,7 +2302,11 @@ static int wp_page_copy(struct vm_fault *vmf)
>  	/*
>  	 * Re-check the pte - we dropped the lock
>  	 */
> -	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
> +	if (!pte_map_lock(vmf)) {
> +		mem_cgroup_cancel_charge(new_page, memcg, false);
> +		ret = VM_FAULT_RETRY;
> +		goto oom_free_new;

With the change, label is misleading.

> +	}
>  	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
>  		if (old_page) {
>  			if (!PageAnon(old_page)) {

-- 
 Kirill A. Shutemov
