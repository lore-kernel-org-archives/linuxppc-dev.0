Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSVBL440kzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 10:58:33 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id x64so1265574wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 17:58:32 -0700 (PDT)
Date: Thu, 10 Aug 2017 03:58:28 +0300
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
Message-ID: <20170810005828.qmw3p7d676hjwkss@node.shutemov.name>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-6-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170809101241.ek4fqinqaq5qfkq4@node.shutemov.name>
 <f935091a-d8f9-1951-8397-f5c464a2b922@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f935091a-d8f9-1951-8397-f5c464a2b922@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 09, 2017 at 12:43:33PM +0200, Laurent Dufour wrote:
> On 09/08/2017 12:12, Kirill A. Shutemov wrote:
> > On Tue, Aug 08, 2017 at 04:35:38PM +0200, Laurent Dufour wrote:
> >> The VMA sequence count has been introduced to allow fast detection of
> >> VMA modification when running a page fault handler without holding
> >> the mmap_sem.
> >>
> >> This patch provides protection agains the VMA modification done in :
> >> 	- madvise()
> >> 	- mremap()
> >> 	- mpol_rebind_policy()
> >> 	- vma_replace_policy()
> >> 	- change_prot_numa()
> >> 	- mlock(), munlock()
> >> 	- mprotect()
> >> 	- mmap_region()
> >> 	- collapse_huge_page()
> > 
> > I don't thinks it's anywhere near complete list of places where we touch
> > vm_flags. What is your plan for the rest?
> 
> The goal is only to protect places where change to the VMA is impacting the
> page fault handling. If you think I missed one, please advise.

That's very fragile approach. We rely here too much on specific compiler behaviour.

Any write access to vm_flags can, in theory, be translated to several
write accesses. For instance with setting vm_flags to 0 in the middle,
which would result in sigfault on page fault to the vma.

Nothing (apart from common sense) prevents compiler from generating this
kind of pattern.

-- 
 Kirill A. Shutemov
