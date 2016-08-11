Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s97qw5tgHzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 23:18:19 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 6F578202EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:18:16 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5DBB82024D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:18:13 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id z8so1979856ywa.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 06:18:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Aug 2016 08:17:52 -0500
Message-ID: <CAL_JsqKSQ2pUNEm+1_skkOM=gYihYBztcJusnZ=PCOvo+TkV6A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 6:09 AM, Kevin Hao <haokexin@gmail.com> wrote:
> With the commit 44a7185c2ae6 ("of/platform: Add common method to
> populate default bus"), a default function is introduced to populate
> the default bus and this function is invoked at the arch_initcall_sync
> level. This will override the arch specific population of default bus
> which run at a lower level than arch_initcall_sync. Since not all
> powerpc specific buses are added to the of_default_bus_match_table[],
> this causes some powerpc specific bus are not probed. Fix this by
> using a more preceding initcall.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> Of course we can adjust the powerpc arch codes to use the
> of_platform_default_populate_init(), but it has high risk to break
> other boards given the complicated powerpc specific buses. So I would
> like just to fix the broken boards in the current release, and cook
> a patch to change to of_platform_default_populate_init() for linux-next.

The patch that broke things was sitting in -next for some time and no
one reported anything. Are all these boards broken?

I'm fine to just disable the default call for PPC instead if there's
some chance this does not fix some boards. There could be some other
initcall ordering dependencies.

>
> Only boot test on a mpc8315erdb board.

Curious, what would it take to remove the of_platform_bus_probe and
use the default here? We can add additional bus compatibles to match.
The difference between of_platform_bus_probe and
of_platform_bus_populate is the former will match root nodes with no
compatible string. Most platforms should not need that behavior and it
would be nice to know which ones.

Rob
