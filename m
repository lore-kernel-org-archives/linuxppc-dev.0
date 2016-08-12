Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9w2t2T5szDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 05:30:29 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 811F720123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 19:30:27 +0000 (UTC)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com
 [209.85.213.179])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 98B4E2034F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 19:30:25 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id w8so10576292ybe.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 12:30:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160812054934.GJ17275@pek-khao-d1>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <87k2fmtxbv.fsf@concordia.ellerman.id.au> <20160812054934.GJ17275@pek-khao-d1>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Aug 2016 14:30:04 -0500
Message-ID: <CAL_Jsq+_K-uU7bFkSm-tq-Q0DPhQt4j=f84OzQSCJFEC29O-8A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
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

On Fri, Aug 12, 2016 at 12:49 AM, Kevin Hao <haokexin@gmail.com> wrote:
> On Fri, Aug 12, 2016 at 02:39:32PM +1000, Michael Ellerman wrote:
>> Kevin Hao <haokexin@gmail.com> writes:

[...]

>> Every one of those initcall changes could be introducing a bug, by
>> changing the order vs other init calls.
>>
>> Can we just go back to the old behaviour on ppc?
>
> Sure. How about this one?
>
> From 4362b4cdd8a6198df4cc46c628473f0d44e03fa8 Mon Sep 17 00:00:00 2001
> From: Kevin Hao <haokexin@gmail.com>
> Date: Fri, 12 Aug 2016 13:30:03 +0800
> Subject: [PATCH v2] of/platform: disable the
>  of_platform_default_populate_init() for all the ppc boards
>
> With the commit 44a7185c2ae6 ("of/platform: Add common method to
> populate default bus"), a default function is introduced to populate
> the default bus and this function is invoked at the arch_initcall_sync
> level. But a lot of ppc boards use machine_device_initcall() to
> populate the default bus. This means that the default populate function
> has higher priority and would override the arch specific population of
> the bus. The side effect is that some arch specific bus are not probed,
> then cause various malfunction due to the miss of some devices. Since
> it is very possible to introduce bugs if we simply change the initcall
> level for all these boards(about 30+). This just disable this default
> function for all the ppc boards.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/of/platform.c | 2 ++
>  1 file changed, 2 insertions(+)

I've applied this one.

Rob
