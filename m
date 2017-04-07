Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzqj22j4lzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 16:40:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
In-Reply-To: <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
 <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
Date: Fri, 07 Apr 2017 16:40:54 +1000
Message-ID: <87tw60hg95.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh+dt@kernel.org> writes:

> On Wed, Apr 5, 2017 at 9:32 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Wed, 5 Apr 2017 08:35:06 -0500
>> Rob Herring <robh+dt@kernel.org> wrote:
>>
>>> On Wed, Apr 5, 2017 at 7:37 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>> > Introduce primitives for FDT parsing. These will be used for powerpc
>>> > cpufeatures node scanning, which has quite complex structure but should
>>> > be processed early.
>>>
>>> Have you looked at unflattening the FDT earlier?
>>
>> Hi, thanks for taking a look. Did you mean to trim the cc list?
>
> Ugg, no. I've added everyone back.
>
>> It may be possible but I'd like to avoid it if we can. There might
>> turn out to be some errata or feature that requires early setup. And
>> the current cpu feature parsing code does it with flat dt.
>
> Well, I'd like to avoid expanding usage of flat DT parsing in the
> kernel. But you could just put this function into arch/powerpc and I'd
> never see it, but I like that even less. Mainly, I just wanted to
> raise the point.
>
> Your argument works until you need that setup in assembly code, then
> you are in the situation that you need to either handle the setup in
> bootloader/firmware or have an simple way to determine that condition.

Where Nick does this FDT parsing is literally the first C code that runs
in the kernel. The MMU is off, we don't even know how much memory we
have, or where it is.

So it's basically impossible to do the unflattening earlier. What we
could do is move the CPU feature setup *later*.

As Ben & Nick said that would be a pretty intrusive change, and
definitely not something we want to do now.

What we could probably do is split some of the flat tree parsing, so
that we discover memory, even just some of it, then unflatten, and then
do more setup using the unflattened tree.

But that will require a lot of delicate work. So we'd definitely like to
do that separately from this series.

cheers
