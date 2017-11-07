Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWVLZ5lqbzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 00:16:21 +1100 (AEDT)
Received: by mail-wm0-x22b.google.com with SMTP id s66so3609286wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Nov 2017 05:16:21 -0800 (PST)
Date: Tue, 7 Nov 2017 16:16:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Florian Weimer <fweimer@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171107131616.342goolaujjsnjge@node.shutemov.name>
References: <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
 <c5586546-1e7e-0f0f-a8b3-680fadb38dcf@redhat.com>
 <20171107114422.bgnm5k6w2zqjoazc@node.shutemov.name>
 <7fc1641b-361c-2ee2-c510-f7c64d173bf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7fc1641b-361c-2ee2-c510-f7c64d173bf8@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2017 at 02:05:42PM +0100, Florian Weimer wrote:
> On 11/07/2017 12:44 PM, Kirill A. Shutemov wrote:
> > On Tue, Nov 07, 2017 at 12:26:12PM +0100, Florian Weimer wrote:
> > > On 11/07/2017 12:15 PM, Kirill A. Shutemov wrote:
> > > 
> > > > > First of all, using addr and MAP_FIXED to develop our heuristic can
> > > > > never really give unchanged ABI. It's an in-band signal. brk() is a
> > > > > good example that steadily keeps incrementing address, so depending
> > > > > on malloc usage and address space randomization, you will get a brk()
> > > > > that ends exactly at 128T, then the next one will be >
> > > > > DEFAULT_MAP_WINDOW, and it will switch you to 56 bit address space.
> > > > 
> > > > No, it won't. You will hit stack first.
> > > 
> > > That's not actually true on POWER in some cases.  See the process maps I
> > > posted here:
> > > 
> > >    <https://marc.info/?l=linuxppc-embedded&m=150988538106263&w=2>
> > 
> > Hm? I see that in all three cases the [stack] is the last mapping.
> > Do I miss something?
> 
> Hah, I had not noticed.  Occasionally, the order of heap and stack is
> reversed.  This happens in approximately 15% of the runs.

Heh. I guess ASLR on Power is too fancy :)

That's strange layout. It doesn't give that much (relatively speaking)
virtual address space for both stack and heap to grow.

-- 
 Kirill A. Shutemov
