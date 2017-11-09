Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXqYs1BMGzDr62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 04:15:43 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id z80so4654008pff.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:15:43 -0800 (PST)
Date: Fri, 10 Nov 2017 04:15:26 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Florian Weimer
 <fweimer@redhat.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-mm
 <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171110041526.6137bc9a@roar.ozlabs.ibm.com>
In-Reply-To: <20171107140158.iz4b2lchhrt6eobe@node.shutemov.name>
References: <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
 <20171107222228.0c8a50ff@roar.ozlabs.ibm.com>
 <20171107122825.posamr2dmzlzvs2p@node.shutemov.name>
 <20171108002448.6799462e@roar.ozlabs.ibm.com>
 <2ce0a91c-985c-aad8-abfa-e91bc088bb3e@linux.vnet.ibm.com>
 <20171107140158.iz4b2lchhrt6eobe@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 7 Nov 2017 17:01:58 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Tue, Nov 07, 2017 at 07:15:58PM +0530, Aneesh Kumar K.V wrote:
> >   
> > > 
> > > If it is decided to keep these kind of heuristics, can we get just a
> > > small but reasonably precise description of each change to the
> > > interface and ways for using the new functionality, such that would be
> > > suitable for the man page? I couldn't fix powerpc because nothing
> > > matches and even Aneesh and you differ on some details (MAP_FIXED
> > > behaviour).  
> > 
> > 
> > I would consider MAP_FIXED as my mistake. We never discussed this explicitly
> > and I kind of assumed it to behave the same way. ie, we search in lower
> > address space (128TB) if the hint addr is below 128TB.
> > 
> > IIUC we agree on the below.
> > 
> > 1) MAP_FIXED allow the addr to be used, even if hint addr is below 128TB but
> > hint_addr + len is > 128TB.
> > 
> > 2) For everything else we search in < 128TB space if hint addr is below
> > 128TB
> > 
> > 3) We don't switch to large address space if hint_addr + len > 128TB. The
> > decision to switch to large address space is primarily based on hint addr
> > 
> > Is there any other rule we need to outline? Or is any of the above not
> > correct?  
> 
> That's correct.
> 

Thanks guys, I'll send out some powerpc patches to match -- it deviates in
its MAP_FIXED handling (treats it the same as !MAP_FIXED).

So these semantics are what we're going with? Anything that does mmap() is
guaranteed of getting a 47-bit pointer and it can use the top 17 bits for
itself? Is intended to be cross-platform or just x86 and power specific?

Also, this may follow from deduction from 1-3, but for explicit
specification in man page:

4) To get an unspecified allocation with the largest possible address range,
we pass in -1 for mmap hint.

Are we allowing 8 bits bits of unused address in this case, or must the
app not assume anything about number of bits used?

Thanks,
Nick
