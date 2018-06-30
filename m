Return-Path: <larry.finger@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Hd3m190wzF1xl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 12:38:11 +1000 (AEST)
Received: by mail-ot0-x243.google.com with SMTP id w22-v6so11929319otk.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 19:38:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From: Denise Finger <Larry.Finger@lwfinger.net>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jerome Glisse
 <jglisse@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Message-ID: <e9712f15-21fd-79a1-0292-8ca88d710c92@lwfinger.net>
Date: Fri, 29 Jun 2018 21:38:07 -0500
MIME-Version: 1.0
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2018 04:01 PM, Linus Torvalds wrote:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>> page->page_type. The routine was called twice. The first had page_type of
>> 0xfffffbff, which would have been expected for a . The second call had
>> 0xffffffff, which led to the BUG.
> 
> So it looks to me like the tear-down of the page tables first found a
> page that is indeed a page table, and cleared the page table bit
> (well, it set it - the bits are reversed).
> 
> Then it took an exception (that "interrupt: 700") and that causes
> do_exit() again, and it tries to free the same page table - and now
> it's no longer marked as a page table, because it already went through
> the __ClearPageTable() dance once.
> 
> So on the second path through, it catches that "the bit already said
> it wasn't a page table" and does the BUG.
> 
> But the real question is what the problem was the *first* time around.
> I assume that has scrolled off the screen? This part:
> 
>    _exception_pkey+0x58/0x128
>    ret_from_except_full+0x0/0x4
>    --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>         LR = free_pgd_range+0x19c/0x30c
>    free_pgtables+0xa/0xb
>    exit_mnap+0xf4/0x16c
>    mmput+0x64/0xf0
> 
> Does reverting that commit 1d40a5ea01d5 make everything work for you?
> Because if so, judging by the deafening silence on this so far, I
> think that's what we should do.
> 
> That said, can some ppc person who knows the 32-bit ppc code and maybe
> knows what that "interrupt: 700" means talk about that oddity in the
> trace, please?

The deafening silence may be due to my having an old Microsoft address for 
Matthew Wilcox in my first posting. He should now have received the BUG report, 
and he may have some suggestions. Yes, reverting commit 1d40a5ea01d5 does permit 
the box to boot.

Kirill's patch also works, which seems like a better solution. If any other 
architecture bugs on boot, at least we will know where to look. :)

@Kirill: You may add a Reported-by: and Tested-by: Larry Finger 
<Larry.Finger@lwfinger.net> to the patch.

Thanks for the help,

Larry
