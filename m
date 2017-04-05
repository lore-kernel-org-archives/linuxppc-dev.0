Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyr9l6Bb5zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 01:58:51 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 2369C2014A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 15:58:49 +0000 (UTC)
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76999201B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 15:58:45 +0000 (UTC)
Received: by mail-yw0-f179.google.com with SMTP id i203so8140483ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 08:58:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406003251.533e2845@roar.ozlabs.ibm.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 5 Apr 2017 10:58:23 -0500
Message-ID: <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Wed, Apr 5, 2017 at 9:32 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Wed, 5 Apr 2017 08:35:06 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
>
>> On Wed, Apr 5, 2017 at 7:37 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > Introduce primitives for FDT parsing. These will be used for powerpc
>> > cpufeatures node scanning, which has quite complex structure but should
>> > be processed early.
>>
>> Have you looked at unflattening the FDT earlier?
>
> Hi, thanks for taking a look. Did you mean to trim the cc list?

Ugg, no. I've added everyone back.

> It may be possible but I'd like to avoid it if we can. There might
> turn out to be some errata or feature that requires early setup. And
> the current cpu feature parsing code does it with flat dt.

Well, I'd like to avoid expanding usage of flat DT parsing in the
kernel. But you could just put this function into arch/powerpc and I'd
never see it, but I like that even less. Mainly, I just wanted to
raise the point.

Your argument works until you need that setup in assembly code, then
you are in the situation that you need to either handle the setup in
bootloader/firmware or have an simple way to determine that condition.

Rob

>
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  drivers/of/fdt.c       | 39 +++++++++++++++++++++++++++++++++++++++
>> >  include/linux/of_fdt.h |  6 ++++++
>> >  2 files changed, 45 insertions(+)
>> >
>> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> > index e5ce4b59e162..a45854fe5156 100644
>> > --- a/drivers/of/fdt.c
>> > +++ b/drivers/of/fdt.c
>> > @@ -754,6 +754,37 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
>> >  }
>> >
>> >  /**
>> > + * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
>> > + * @it: callback function
>> > + * @data: context data pointer
>> > + *
>> > + * This function is used to scan sub-nodes of a node.
>> > + */
>> > +int __init of_scan_flat_dt_subnodes(unsigned long node,
>> > +                                   int (*it)(unsigned long node,
>> > +                                             const char *uname,
>> > +                                             void *data),
>> > +                                   void *data)
>> > +{
>> > +       const void *blob = initial_boot_params;
>> > +       const char *pathp;
>> > +       int offset, rc = 0;
>> > +
>> > +       offset = node;
>> > +        for (offset = fdt_first_subnode(blob, offset);
>> > +             offset >= 0 && !rc;
>> > +             offset = fdt_next_subnode(blob, offset)) {
>>
>> fdt_for_each_subnode()
>
> Got it.
>
>>
>> > +
>> > +               pathp = fdt_get_name(blob, offset, NULL);
>> > +               if (*pathp == '/')
>> > +                       pathp = kbasename(pathp);
>>
>> Seems a bit odd that you parse the name in this function. Perhaps the
>> caller should do that, or if you want subnodes matching a certain
>> name, then do the matching here. But you didn't copy me on the rest of
>> the series, so I don't know how you are using this.
>
> Hmm, it was a while since writing that part. I guess I just copied
> of_scan_flat_dt interface.
>
> Caller is in this patch:
>
> https://patchwork.ozlabs.org/patch/747262/
>
> I'll include you in subsequent post if you prefer.
>
> Thanks,
> Nick
