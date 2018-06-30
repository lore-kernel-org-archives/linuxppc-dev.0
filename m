Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HzRK2FW7zF20w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jul 2018 02:25:19 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id c2-v6so11156079oic.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 09:25:19 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To: christophe leroy <christophe.leroy@c-s.fr>,
 Matthew Wilcox <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <1a73e92a-f77d-ba1e-ebf8-b469db3c465e@c-s.fr>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b721b0c9-a802-2296-fc82-5c11c2698327@lwfinger.net>
Date: Sat, 30 Jun 2018 11:25:15 -0500
MIME-Version: 1.0
In-Reply-To: <1a73e92a-f77d-ba1e-ebf8-b469db3c465e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2018 04:31 AM, christophe leroy wrote:
> 
> 
> Le 29/06/2018 à 22:42, Larry Finger a écrit :
>> My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a kernel 
>> BUG at include/linux/page-flags.h:700! The problem was bisected to commit 
>> 1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is not possible to 
>> capture the bug with anything other than a camera. The first few lines of the 
>> traceback are as follows:
>>
>> free_pgd_range+0x19c/0x30c (unreliable)
>> free_pgtables_0xa0/0xb0
>> exit_pmap+0xf4/0x16c
>> mmput+0x64/0xf0
>> do_exit+0x33c/0x89c
>> oops_end+0x13c/0x144
>> _exception_pkey+0x58/0x128
>> ret_from_except_full+0x0/0x4
>> --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>>      LR = free_pgd_range+0x19c/0x30c
>> free_pgtables+0xa/0xb
>> exit_mnap+0xf4/0x16c
>> mmput+0x64/0xf0
>> flush_old_exec+0x490/0x550
>>
>> I have more information regarding this BUG. Line 700 of page-flags.h is the 
>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded 
>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), 
>> page) in routine __ClearPageTable(), which is called from pgtable_page_dtor() 
>> in include/linux/mm.h. I also added a printk call to PageTable() that logs 
>> page->page_type. The routine was called twice. The first had page_type of 
>> 0xfffffbff, which would have been expected for a . The second call had 
>> 0xffffffff, which led to the BUG.
>>
> 
> Oh, seems to be the one I noticed and told Aneesh about 
> (https://patchwork.ozlabs.org/patch/922771/)
> 
> Aneesh provided the patch https://patchwork.ozlabs.org/patch/934111/ for it, 
> does it help ?

Yes, those changes fix the problem.

Larry
