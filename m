Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT6Xj4wrYzDqbW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 20:16:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: Breno Leitao <leitao@debian.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Laura Abbott <labbott@redhat.com>, gromero@br.ibm.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: kernel BUG at mm/usercopy.c:72!
In-Reply-To: <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
References: <20170515191949.GA13641@gmail.com>
 <878tlxoy62.fsf@concordia.ellerman.id.au>
 <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
Date: Thu, 18 May 2017 20:16:17 +1000
Message-ID: <8737c2lbbi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kees Cook <keescook@chromium.org> writes:
> On Tue, May 16, 2017 at 4:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Yeah it looks like powerpc also suffers from the same bug that arm64
>> used to, ie. virt_addr_valid() will return true for some vmalloc
>> addresses.
>>
>> virt_addr_valid() is used pretty widely, I'm not sure if we can just fix
>> it without other fallout. I'll dig a bit more tomorrow if no one beats
>> me to it.
>>
>> Kees, depending on how that turns out we may ask you to revert
>> 517e1fbeb65f ("mm/usercopy: Drop extra is_vmalloc_or_module() check").
>
> That's fine by me. Let me know what you think would be best.

Oh man, what a mess.

I think we can do a small fix for this in powerpc code for 4.12, will
post it soon for Breno to test - I still can't reproduce locally.

cheers
