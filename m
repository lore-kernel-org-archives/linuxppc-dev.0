Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVbhj3Hs8zDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 18:12:21 +1000 (AEST)
Received: by mail-yw0-x232.google.com with SMTP id z186so36282359ywd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 01:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465216025.2658.7.camel@ellerman.id.au>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
Date: Thu, 16 Jun 2016 11:12:15 +0300
Message-ID: <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/6/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2016-06-06 at 10:52 +0300, Denis Kirjanov wrote:
>
>> Update: now with the proper mailing address.
>>
>> Hi,
>>
>> Posting if anyone knows how to quickly fix it :)
>
> Sorry but no.
>
>> Enabling  CONFIG_PPC_EARLY_DEBUG on my quad G5 causes kernel to die
>> with the  unrecoverable exception 4100.
>
> That means you took a SLB miss when MSR_RI was off.
>
> What's at c000000000ace328 ?
>
>> I haven't bisected this yet. Photo attached.
>
> A bisect would be awesome.

Ok, the issue was introduced by the commit
caca285e5ab4a7a19fede51688106ceed6fc45dd (powerpc/mm/radix: Use
STD_MMU_64 to properly isolate hash related code) and 970mp dies on
the following condition:
+BEGIN_MMU_FTR_SECTION
        bl      slb_allocate_realmode
-
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)

In my config I've enabled radix MMU lookup but in my understanding
only recent IBM  machines support this feature and we have to call SLB
entry through slb_allocate_realmode on HPTE machine?

Thanks!


>
> cheers
>
>
