Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzPjq4wfkzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:10:07 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id EB48F2014A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 14:10:04 +0000 (UTC)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8FAE2021A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 14:10:02 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id i203so20662240ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 07:10:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406103829.67d462e1@roar.ozlabs.ibm.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
 <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
 <1491425881.4166.90.camel@kernel.crashing.org>
 <20170406103829.67d462e1@roar.ozlabs.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 6 Apr 2017 09:09:41 -0500
Message-ID: <CAL_JsqKuomE41grhAvjFxkFbS4A3-M_TK8gP8FU=HdDpQ3TTkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 5, 2017 at 7:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 06 Apr 2017 06:58:01 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Wed, 2017-04-05 at 10:58 -0500, Rob Herring wrote:
>> > Well, I'd like to avoid expanding usage of flat DT parsing in the
>> > kernel. But you could just put this function into arch/powerpc and I'd
>> > never see it, but I like that even less. Mainly, I just wanted to
>> > raise the point.
>> >
>> > Your argument works until you need that setup in assembly code, then
>> > you are in the situation that you need to either handle the setup in
>> > bootloader/firmware or have an simple way to determine that condition.
>>
>> The main issue is that changing that is a very very invasive change in
>> an extremely fragile and rather nasty area of code shared by 32 and 64-
>> bit for which we don't even have easy access to all the machines to
>> test with anymore :)
>>
>> It's probably not impossible, but it would delay the new cpu feature
>> stuff that Nick is making by a lot, probably monthes, making it nearly
>> impossible to get back into distros etc...
>>
>> So while it might be something to consider, I would definitely keep
>> that as a separate unit of work to do later.
>
> Yeah, it's no longer a "drop in" replacement for existing features
> testing if we do this, which makes it hard to backport too (we will
> need this for compatibility with future firmware, so it will have to
> go into distro kernels.)
>
> Given that it's quite a small addition to of/fdt code, hopefully
> that gives you a reasonable justification to accept it.
>
> If you prefer not to, that's okay, but I think we would have to carry
> it in arch/powerpc at least for a time, because of the schedule we're
> working to for POWER9 enablement. As a longer term item I agree with you
> and Ben, it would be worth considering unflattening earlier.

As I mentioned, keeping it in arch/powerpc I like even less. So this is fine.

Rob
