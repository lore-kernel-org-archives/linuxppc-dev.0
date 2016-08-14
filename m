Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCDDG0q7WzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 08:43:09 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 4A2BF202BE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 22:43:06 +0000 (UTC)
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com
 [209.85.213.173])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5340A2022A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 22:43:04 +0000 (UTC)
Received: by mail-yb0-f173.google.com with SMTP id a92so860585ybi.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 15:43:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471209670.12231.60.camel@kernel.crashing.org>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <87k2fmtxbv.fsf@concordia.ellerman.id.au> <20160812054934.GJ17275@pek-khao-d1>
 <CAL_Jsq+_K-uU7bFkSm-tq-Q0DPhQt4j=f84OzQSCJFEC29O-8A@mail.gmail.com>
 <1471209670.12231.60.camel@kernel.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Sun, 14 Aug 2016 17:42:43 -0500
Message-ID: <CAL_Jsq+JLvThaz3ZTy80yVW23waPjqfw_JC-EJF-QuCk21=eJQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kevin Hao <haokexin@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 14, 2016 at 4:21 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2016-08-12 at 14:30 -0500, Rob Herring wrote:
>>
>> > With the commit 44a7185c2ae6 ("of/platform: Add common method to
>> > populate default bus"), a default function is introduced to
>> > populate
>> > the default bus and this function is invoked at the
>> > arch_initcall_sync
>> > level. But a lot of ppc boards use machine_device_initcall() to
>> > populate the default bus. This means that the default populate
>> > function
>> > has higher priority and would override the arch specific population
>> > of
>> > the bus. The side effect is that some arch specific bus are not
>> > probed,
>> > then cause various malfunction due to the miss of some devices.
>> > Since
>> > it is very possible to introduce bugs if we simply change the
>> > initcall
>> > level for all these boards(about 30+). This just disable this
>> > default
>> > function for all the ppc boards.
>> >
>> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> > ---
>> >  drivers/of/platform.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>>
>> I've applied this one.
>
> Not fan of the hard #ifdef at all... it will make it hard to convert
> platforms one by one. Why not an arch_want_default_of_probe() or
> something like this which we can then plumb into ppc_md. ?

Yeah, I'm not either really. I didn't propose using IS_ENABLED here
either as it does add a needless initcall.

Do you have any idea which platforms are not broken and could be
switched over now. If not, I think we should just leave as is for 4.8
and make it per platform selectable for 4.9.

Rob
