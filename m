Return-Path: <srs0=uhf0=6v=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBMR26D5DzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 11:05:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xBMR25STYz8vCM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 11:05:34 +1000 (AEST)
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xBMR226mNz9s82
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2017 11:05:34 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id h15so784415qte.2
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2017 18:05:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500015083-23511-2-git-send-email-mpe@ellerman.id.au>
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
 <1500015083-23511-2-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 18 Jul 2017 11:05:31 +1000
Message-ID: <CAKTCnzn-r5xdi2JCegf3qaSO6c5WU=K0cO8qNCQQMG1iQN3YbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/mm/hash: Refactor hash__mark_rodata_ro()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 14, 2017 at 4:51 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Move the core logic into a helper, so we can use it for changing other
> permissions.
>
> We also change the logic to align start down, and end up. This means
> calling the function with a range will expand that range to be at
> least 1 mmu_linear_psize page in size. We need that so we can use it
> on __init_begin ...  __init_end which is not a full page in size.
>
> This should always work for _stext/__init_begin, because we align
> __init_begin to _stext + 16M in the linker script.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
