Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS6XF52dHzDqyx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 20:12:45 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id r77so6217085wmd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 03:12:45 -0700 (PDT)
Date: Wed, 9 Aug 2017 13:12:41 +0300
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
Subject: Re: [PATCH 05/16] mm: Protect VMA modifications using VMA sequence
 count
Message-ID: <20170809101241.ek4fqinqaq5qfkq4@node.shutemov.name>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-6-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502202949-8138-6-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2017 at 04:35:38PM +0200, Laurent Dufour wrote:
> The VMA sequence count has been introduced to allow fast detection of
> VMA modification when running a page fault handler without holding
> the mmap_sem.
> 
> This patch provides protection agains the VMA modification done in :
> 	- madvise()
> 	- mremap()
> 	- mpol_rebind_policy()
> 	- vma_replace_policy()
> 	- change_prot_numa()
> 	- mlock(), munlock()
> 	- mprotect()
> 	- mmap_region()
> 	- collapse_huge_page()

I don't thinks it's anywhere near complete list of places where we touch
vm_flags. What is your plan for the rest?
-- 
 Kirill A. Shutemov
