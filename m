Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKhCp4JdHzDr03
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 09:06:14 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id q66so23948778qki.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 16:06:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKTCnznL9fxBq_xwm-z4yg_7muNKFJso26GMbEJCbSzN38N+fg@mail.gmail.com>
References: <20170729140901.5887-1-bsingharora@gmail.com>
 <CAKTCnznL9fxBq_xwm-z4yg_7muNKFJso26GMbEJCbSzN38N+fg@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 30 Jul 2017 09:06:10 +1000
Message-ID: <CAKTCnzneP4Hn6Ko69TBPv4scaQYMQoNdg8eQ5dRx4TWS6a=o=Q@mail.gmail.com>
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

On Sun, Jul 30, 2017 at 8:58 AM, Balbir Singh <bsingharora@gmail.com> wrote:
>> +
>> +extern struct static_key_false powerpc_kasan_enabled_key;
>> +#define check_return_arch_not_ready() \
>> +       do {                                                            \
>> +               if (!static_branch_likely(&powerpc_kasan_enabled_key))  \
>> +                       return;                                         \
>> +       } while (0)
>
> This is supposed to call __mem*() before returning, I'll do a new RFC,
> I must have missed it in my rebasing somewhere

Sorry for the noise, I am sleep deprived, I was trying to state that this
does not work for hash (with disable_radix on the command-line)

Balbir Singh.
