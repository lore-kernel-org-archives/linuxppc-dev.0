Return-Path: <dvlasenk@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8WPm1Bk8zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:57:00 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc: Do not make the entire heap executable
To: Kees Cook <keescook@chromium.org>
References: <20160809190822.28856-1-dvlasenk@redhat.com>
 <CAGXu5j+arjRNmGVPeevMBsO6Mdpmw8Lq0GPvJvXNPJeQ8uCWkA@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <3e1336d7-d0c1-beec-7526-af4eebc199fa@redhat.com>
Date: Wed, 10 Aug 2016 14:56:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+arjRNmGVPeevMBsO6Mdpmw8Lq0GPvJvXNPJeQ8uCWkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2016 12:43 AM, Kees Cook wrote:
>> -static int do_brk(unsigned long addr, unsigned long len)
>> +static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long flags)
>>  {
>>         struct mm_struct *mm = current->mm;
>>         struct vm_area_struct *vma, *prev;
>> -       unsigned long flags;
>>         struct rb_node **rb_link, *rb_parent;
>>         pgoff_t pgoff = addr >> PAGE_SHIFT;
>>         int error;
>> @@ -2666,7 +2665,7 @@ static int do_brk(unsigned long addr, unsigned long len)
>>         if (!len)
>>                 return 0;
>>
>> -       flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>> +       flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>
> For sanity's sake, should a mask be applied here? i.e. to be extra
> careful about what flags can get passed in?

Maybe... I am leaving it to mm experts.

> Otherwise, this looks okay to me:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
