Return-Path: <keescook@google.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy9SK3sc8zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 05:54:40 +1000 (AEST)
Received: by mail-io0-x236.google.com with SMTP id v36so6204334ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 12:54:40 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1505893239.30180.24.camel@abdul.in.ibm.com>
References: <1505198479.10243.23.camel@abdul>
 <1505893239.30180.24.camel@abdul.in.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 20 Sep 2017 12:54:37 -0700
Message-ID: <CAGXu5jKMGuc-i0vfZx3TYx4iq35PCF0T1y9zv9A=k7ieES2Qkg@mail.gmail.com>
Subject: Re: [linux-next][Oops] memory hot-unplug results fault instruction
 address at /include/linux/list.h:104
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 20, 2017 at 12:40 AM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> On Tue, 2017-09-12 at 12:11 +0530, abdul wrote:
>> Hi,
>>
>> Memory hot-unplug on PowerVM LPAR running next-20170911 results in
>> Faulting instruction address: 0xc0000000002b56c4
>>
>> which maps to the below code path:
>>
>> 0xc0000000002b56c4 is in __rmqueue (./include/linux/list.h:104).
>> 99     * This is only for internal list manipulation where we know
>> 100    * the prev/next entries already!
>> 101    */
>> 102   static inline void __list_del(struct list_head * prev, struct
>> list_head * next)
>> 103   {
>> 104           next->prev = prev;
>> 105           WRITE_ONCE(prev->next, next);
>> 106   }
>> 107
>> 108   /**
>>
>
> I see another kernel Oops when running transparent hugepages
> de-fragmentation test.
>
> And the faulty instruction address again pointing to same code line
> 0xc00000000026f9f4 is in compaction_alloc (./include/linux/list.h:104)
>
> steps to recreate:
> -----------------
> 1. Enable transparent hugepages ("always")
> 2. Turn off the defrag $ echo 0 > khugepaged/defrag
> 3. Write random to memory path
> 4. Set huge pages numbers
> 5. Turn on defrag $ echo 1 > khugepaged/defrag
>
>
> new trace:
> ----------
> Unable to handle kernel paging request for data at address
> 0x5deadbeef0000108

This looks like use-after-list-removal, that value appears to be LIST_POISON1.

Try enabling CONFIG_DEBUG_LIST to see if you get better details?

-Kees

-- 
Kees Cook
Pixel Security
