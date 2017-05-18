Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x22f.google.com (mail-qt0-x22f.google.com
 [IPv6:2607:f8b0:400d:c0d::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT7Tb5DSvzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 20:58:43 +1000 (AEST)
Received: by mail-qt0-x22f.google.com with SMTP id f55so30679068qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 03:58:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8737c2lbbi.fsf@concordia.ellerman.id.au>
References: <20170515191949.GA13641@gmail.com>
 <878tlxoy62.fsf@concordia.ellerman.id.au>
 <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
 <8737c2lbbi.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 18 May 2017 20:58:40 +1000
Message-ID: <CAKTCnz=Hp21KGBRj3OUGwuMQe1z9MRrR2+iYDGKQ7+khOAz=Ag@mail.gmail.com>
Subject: Re: kernel BUG at mm/usercopy.c:72!
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Breno Leitao <leitao@debian.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Laura Abbott <labbott@redhat.com>, gromero@br.ibm.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 18, 2017 at 8:16 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>> On Tue, May 16, 2017 at 4:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Yeah it looks like powerpc also suffers from the same bug that arm64
>>> used to, ie. virt_addr_valid() will return true for some vmalloc
>>> addresses.
>>>
>>> virt_addr_valid() is used pretty widely, I'm not sure if we can just fix
>>> it without other fallout. I'll dig a bit more tomorrow if no one beats
>>> me to it.
>>>
>>> Kees, depending on how that turns out we may ask you to revert
>>> 517e1fbeb65f ("mm/usercopy: Drop extra is_vmalloc_or_module() check").
>>
>> That's fine by me. Let me know what you think would be best.
>
> Oh man, what a mess.
>
> I think we can do a small fix for this in powerpc code for 4.12, will
> post it soon for Breno to test - I still can't reproduce locally.

To reproduce locally you'd need an alias'd 0xd000..<addr> mapped to a
0xc000..<addr> (due to the assumptions in __pa()) and with
virt_to_page(addr) have PageSlab(page) set, I guess. I guess with very
few modules, a whole lot of 0xd000... space is unused, but if we had a
bunch of modules and ended up with an 0xd000<addr> range aliased as
PageSlab you would probably run into it more easily.

Balbir Singh
