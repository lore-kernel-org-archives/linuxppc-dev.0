Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWzyZ1ZYdzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 19:30:43 +1100 (AEDT)
Received: by mail-wm0-x22c.google.com with SMTP id b9so8962984wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Nov 2017 00:30:43 -0800 (PST)
Date: Wed, 8 Nov 2017 11:30:38 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Florian Weimer <fweimer@redhat.com>, linux-arch@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171108083038.djj3qdhhnrazkk7b@node.shutemov.name>
References: <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
 <20171107222228.0c8a50ff@roar.ozlabs.ibm.com>
 <20171107122825.posamr2dmzlzvs2p@node.shutemov.name>
 <20171108002448.6799462e@roar.ozlabs.ibm.com>
 <2ce0a91c-985c-aad8-abfa-e91bc088bb3e@linux.vnet.ibm.com>
 <87y3nh2wt5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3nh2wt5.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 08, 2017 at 03:56:06PM +1100, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> >> 
> >> If it is decided to keep these kind of heuristics, can we get just a
> >> small but reasonably precise description of each change to the
> >> interface and ways for using the new functionality, such that would be
> >> suitable for the man page? I couldn't fix powerpc because nothing
> >> matches and even Aneesh and you differ on some details (MAP_FIXED
> >> behaviour).
> >
> >
> > I would consider MAP_FIXED as my mistake. We never discussed this 
> > explicitly and I kind of assumed it to behave the same way. ie, we 
> > search in lower address space (128TB) if the hint addr is below 128TB.
> >
> > IIUC we agree on the below.
> >
> > 1) MAP_FIXED allow the addr to be used, even if hint addr is below 128TB 
> > but hint_addr + len is > 128TB.
> 
> So:
>   mmap(0x7ffffffff000, 0x2000, ..., MAP_FIXED ...) = 0x7ffffffff000
> 
> > 2) For everything else we search in < 128TB space if hint addr is below 
> > 128TB
> 
>   mmap((x < 128T), 0x1000, ...) = (y < 128T)
>   ...
>   mmap(0x7ffffffff000, 0x1000, ...) = 0x7ffffffff000
>   mmap(0x800000000000, 0x1000, ...) = 0x800000000000
>   ...
>   mmap((x >= 128T), 0x1000, ...) = (y >= 128T)
> 
> > 3) We don't switch to large address space if hint_addr + len > 128TB. 
> > The decision to switch to large address space is primarily based on hint 
> > addr
> 
> But does the mmap succeed in that case or not?
> 
> ie:  mmap(0x7ffffffff000, 0x2000, ...) = ?

It does, but resulting address doesn't match the hint. It's somewhere
below 47-bit border.

-- 
 Kirill A. Shutemov
