Return-Path: <robh+dt@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2AC1A065B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 07:31:37 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by ozlabs.org (Postfix) with ESMTP id 00EC41402DE
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Dec 2015 07:31:35 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 95ECF203F4
 for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2015 20:31:33 +0000 (UTC)
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7552E203E3
 for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2015 20:31:32 +0000 (UTC)
Received: by ykdv3 with SMTP id v3so174770676ykd.0
 for <linuxppc-dev@ozlabs.org>; Sun, 06 Dec 2015 12:31:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5CD6EBAA-D0D6-434A-B9EA-B144C05711BC@ellerman.id.au>
References: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au>
 <vnkwk2oum9b8.fsf@codeaurora.org>
 <5CD6EBAA-D0D6-434A-B9EA-B144C05711BC@ellerman.id.au>
From: Rob Herring <robh+dt@kernel.org>
Date: Sun, 6 Dec 2015 14:31:12 -0600
Message-ID: <CAL_Jsq+PBXGwJC36Hio5KRU7rPSb-FRDZv-rAozg-sL8iCgWHA@mail.gmail.com>
Subject: Re: [PATCH] of: Fix comparison of reserved memory regions
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Mitchel Humpherys <mitchelh@codeaurora.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 5, 2015 at 5:43 AM, Michael Ellerman <michael@ellerman.id.au> wrote:
>
>
> On 5 December 2015 04:07:39 GMT+11:00, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
>>On Wed, Nov 18 2015 at 09:46:38 PM, Michael Ellerman
>><mpe@ellerman.id.au> wrote:
>>> In order to check for overlapping reserved memory regions, we first
>>need
>>> to sort the array of memory regions. This is implemented using
>>sort(),
>>> and a custom comparison function __rmem_cmp().
>>>
>>> Unfortunatley __rmem_cmp() doesn't work in all cases. Because the two
>>> base values are phys_addr_t, they may be u64 on some platforms, in
>>which
>>> case subtracting one from the other and then (implicitly) casting to
>>int
>>> does not give us the -ve/0/+ve value we need.
>>>
>>> This leads to incorrect reports about overlaps, eg:
>>>
>>>   ibm,slw-image@1ffe600000 (0x0000001ffe600000--0x0000001ffe700000)
>>overlaps with
>>>   ibm,firmware-allocs-memory@1000000000
>>(0x0000001000000000--0x0000001000dc0200)
>>>
>>> Fix it by just doing the standard double if and return 0 logic.
>>>
>>> Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory
>>regions")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>  drivers/of/of_reserved_mem.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>>Woops, thanks.
>>
>>Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>
>
> Thanks for testing.
>
> Rob, can we get this merged for 4.4 please?

Yes. I meant to last week, but was waiting on getting another issue
sorted out. I should get it to Linus in the next couple of days.

Rob
