Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KKCv73FWzF1LS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 06:51:07 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so18951640oib.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 13:51:07 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
 <87d0w6mfvi.fsf@concordia.ellerman.id.au>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <574d8619-1f1a-cad7-a33b-5c8296757fda@lwfinger.net>
Date: Mon, 2 Jul 2018 15:51:03 -0500
MIME-Version: 1.0
In-Reply-To: <87d0w6mfvi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2018 11:16 PM, Michael Ellerman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>>> page->page_type. The routine was called twice. The first had page_type of
>>> 0xfffffbff, which would have been expected for a . The second call had
>>> 0xffffffff, which led to the BUG.
>>
>> So it looks to me like the tear-down of the page tables first found a
>> page that is indeed a page table, and cleared the page table bit
>> (well, it set it - the bits are reversed).
> ...
>>
>> That said, can some ppc person who knows the 32-bit ppc code and maybe
>> knows what that "interrupt: 700" means talk about that oddity in the
>> trace, please?
> 
> I think everyone else answered your questions here, and it should be
> fixed now in your tree.
> 
> Larry let me know if you're still seeing a crash with 4.18-rc3.

The problem is fixed in 4.18-rc3. Thanks to all that helped.

Larry
