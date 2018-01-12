Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJBbZ2lClzF0bY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 05:48:42 +1100 (AEDT)
Date: Fri, 12 Jan 2018 10:48:21 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 kemi.wang@intel.com, sergey.senozhatsky.work@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v6 16/24] mm: Protect mm_rb tree with a rwlock
Message-ID: <20180112184821.GB7590@bombadil.infradead.org>
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-17-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515777968-867-17-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2018 at 06:26:00PM +0100, Laurent Dufour wrote:
> -static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
> +static void __vma_rb_erase(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
> +	struct rb_root *root = &mm->mm_rb;
>  	/*
>  	 * Note rb_erase_augmented is a fairly large inline function,
>  	 * so make sure we instantiate it only once with our desired
>  	 * augmented rbtree callbacks.
>  	 */
> +#ifdef CONFIG_SPF
> +	write_lock(&mm->mm_rb_lock);
> +#endif
>  	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> +#ifdef CONFIG_SPF
> +	write_unlock(&mm->mm_rb_lock); /* wmb */
> +#endif

I can't say I love this.  Have you considered:

#ifdef CONFIG_SPF
#define vma_rb_write_lock(mm)	write_lock(&mm->mm_rb_lock)
#define vma_rb_write_unlock(mm)	write_unlock(&mm->mm_rb_lock)
#else
#define vma_rb_write_lock(mm)	do { } while (0)
#define vma_rb_write_unlock(mm)	do { } while (0)
#endif

Also, SPF is kind of uninformative.  CONFIG_MM_SPF might be better?
Or perhaps even CONFIG_SPECULATIVE_PAGE_FAULT, just to make it really
painful to do these one-liner ifdefs that make the code so hard to read.
