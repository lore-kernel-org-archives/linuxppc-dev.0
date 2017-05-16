Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wS7gf3CXLzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 06:03:58 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id h4so5103344oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 13:03:58 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170516114812.10660-3-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 May 2017 22:03:56 +0200
Message-ID: <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Gross <mark.gross@intel.com>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 16, 2017 at 1:48 PM, Christoph Hellwig <hch@lst.de> wrote:

>         unsigned long           expires;
> -       void                    (*function)(unsigned long);
> +       union {
> +               void            (*func)(struct timer_list *timer);
> +               void            (*function)(unsigned long);
> +       };
...
> +#define INIT_TIMER(_func, _expires, _flags)            \
> +{                                                      \
> +       .entry = { .next = TIMER_ENTRY_STATIC },        \
> +       .func = (_func),                                \
> +       .expires = (_expires),                          \
> +       .flags = TIMER_MODERN | (_flags),               \
> +       __TIMER_LOCKDEP_MAP_INITIALIZER(__FILE__ ":" __stringify(__LINE__)) \
> +}

If I remember correctly, this will fail with gcc-4.5 and earlier, which can't
use named initializers for anonymous unions. One of these two should
work, but they are both ugly:

a) don't use a named initializer for the union (a bit fragile)

 +#define INIT_TIMER(_func, _expires, _flags)            \
 +{                                                      \
 +       .entry = { .next = TIMER_ENTRY_STATIC },        \
 +       .expires = (_expires),                          \
 +       { .func = (_func) },                                \
 +       .flags = TIMER_MODERN | (_flags),               \
 +       __TIMER_LOCKDEP_MAP_INITIALIZER(__FILE__ ":" __stringify(__LINE__)) \
 +}

b) give the union a name (breaks any reference to timer_list->func in C code):

 +       union {
 +               void            (*func)(struct timer_list *timer);
 +               void            (*function)(unsigned long);
 +       } u;
...
 +#define INIT_TIMER(_func, _expires, _flags)            \
 +{                                                      \
 +       .entry = { .next = TIMER_ENTRY_STATIC },        \
 +       .u.func = (_func),                                \
 +       .expires = (_expires),                          \
 +       .flags = TIMER_MODERN | (_flags),               \
 +       __TIMER_LOCKDEP_MAP_INITIALIZER(__FILE__ ":" __stringify(__LINE__)) \
 +}

> +/**
> + * prepare_timer - initialize a timer before first use
> + * @timer:     timer structure to prepare
> + * @func:      callback to be called when the timer expires
> + * @flags      %TIMER_* flags that control timer behavior
> + *
> + * This function initializes a timer_list structure so that it can
> + * be used (by calling add_timer() or mod_timer()).
> + */
> +static inline void prepare_timer(struct timer_list *timer,
> +               void (*func)(struct timer_list *timer), u32 flags)
> +{
> +       __init_timer(timer, TIMER_MODERN | flags);
> +       timer->func = func;
> +}
> +
> +static inline void prepare_timer_on_stack(struct timer_list *timer,
> +               void (*func)(struct timer_list *timer), u32 flags)
> +{
> +       __init_timer_on_stack(timer, TIMER_MODERN | flags);
> +       timer->func = func;
> +}

I fear this breaks lockdep output, which turns the name of
the timer into a string that gets printed later. It should work
when these are macros, or a macro wrapping an inline function
like __init_timer is.

      Arnd
