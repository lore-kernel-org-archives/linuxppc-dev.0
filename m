Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmpzV1QSHzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 00:30:45 +1000 (AEST)
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C817921E93
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:30:43 +0000 (UTC)
Received: by mail-qk0-f174.google.com with SMTP id z143so12132813qkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 07:30:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
 <1504390854.4974.108.camel@kernel.crashing.org>
 <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Sep 2017 09:30:22 -0500
Message-ID: <CAL_JsqJNoWAAi3Nj5KxAf5ov73nfPVaGeT1RTNgzZGpdxZ7s=w@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux-MIPS <linux-mips@linux-mips.org>, Michal Simek <monstr@monstr.eu>,
 Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 3, 2017 at 5:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Sun, 3 Sep 2017, Benjamin Herrenschmidt wrote:
>
>> On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
>> > Since, according to a recent devicetree ML posting by Rob Herring,
>> > the node "/chosen@0" is most likely for real Open Firmware and
>> > does not apply to DTSpec, remove all remaining tests and
>> > references for that node, of which there are very few left:
>>
>> Technically that would break Open Firmware systems where the node is
>> really called chosen@0
>>
>> Now I'm not sure such a thing actually exist however.
>>
>> My collection of DTs don't seem to have one, except in the ancient
>> html variants that were extracted by the pengionppc folks for the
>> original PowerMac 8600 but I wonder if that's a bug in the
>> extraction script since they also have @0 on /packages etc...
>
>   obviously, this isn't a priority issue, i was just working off a
> comment by rob herring that "chosen@0" is not defined by the current
> DTSpec 0.1, so it seemed appropriate to toss it. if there's a reason
> to hang onto it, that's fine with me.
>
>   however, given the diff stat of the change to remove every single
> reference to that node name in the current kernel source:
>
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
>
> it seems inconsistent that three architectures would be testing for
> that node, but none of the rest. consistency suggests that every
> architecture should take it into account, or none should.

I generally agree and have moved various things from arch to
drivers/of/ to ensure that. But for legacy things, we have to allow
for exceptions. I agree with Ben and think that microblaze (they
generally just copied PPC), MIPS, and the FDT code in drivers/of/ can
be changed.

Rob
