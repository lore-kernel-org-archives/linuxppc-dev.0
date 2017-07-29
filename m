Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x236.google.com (mail-qk0-x236.google.com
 [IPv6:2607:f8b0:400d:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKh2v4L15zDqyx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 08:58:31 +1000 (AEST)
Received: by mail-qk0-x236.google.com with SMTP id a77so36694465qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 15:58:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170729140901.5887-1-bsingharora@gmail.com>
References: <20170729140901.5887-1-bsingharora@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 30 Jul 2017 08:58:28 +1000
Message-ID: <CAKTCnznL9fxBq_xwm-z4yg_7muNKFJso26GMbEJCbSzN38N+fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc/radix/kasan: KASAN support for Radix
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: kasan-dev@googlegroups.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +
> +extern struct static_key_false powerpc_kasan_enabled_key;
> +#define check_return_arch_not_ready() \
> +       do {                                                            \
> +               if (!static_branch_likely(&powerpc_kasan_enabled_key))  \
> +                       return;                                         \
> +       } while (0)

This is supposed to call __mem*() before returning, I'll do a new RFC,
I must have missed it in my rebasing somewhere

Balbir
