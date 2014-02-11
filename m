Return-Path: <raghavendra.kt.linux@gmail.com>
Received: from mail-qa0-x22a.google.com (mail-qa0-x22a.google.com
 [IPv6:2607:f8b0:400d:c00::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F008E2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 20:39:32 +1100 (EST)
Received: by mail-qa0-f42.google.com with SMTP id k4so11534440qaq.29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 01:39:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140207165801.GC2107@lst.de>
References: <20140207165801.GC2107@lst.de>
Date: Tue, 11 Feb 2014 15:09:23 +0530
Message-ID: <CAC4Lta0=DojhnvPta5Rj3z61UzoEXO4H78iApa4nhNqmZcU+3g@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Raghavendra KT <raghavendra.kt.linux@gmail.com>
To: Torsten Duwe <duwe@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Raghavendra KT <raghavendra.kt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 7, 2014 at 10:28 PM, Torsten Duwe <duwe@lst.de> wrote:
> Ticket locks for ppc, version 2. Changes since v1:
> * The atomically exchanged entity is always 32 bits.
> * asm inline string variations thus removed.
> * Carry the additional holder hint only #if defined(CONFIG_PPC_SPLPAR)
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> --
[...]
> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
> +       register struct __raw_tickets old, tmp,
> +               inc = { .tail = TICKET_LOCK_INC };
> +
>         CLEAR_IO_SYNC;
> -       while (1) {
> -               if (likely(__arch_spin_trylock(lock) == 0))
> -                       break;
> +       __asm__ __volatile__(
> +"1:    lwarx   %0,0,%4         # arch_spin_lock\n"
> +"      add     %1,%3,%0\n"
> +       PPC405_ERR77(0, "%4")
> +"      stwcx.  %1,0,%4\n"
> +"      bne-    1b"
> +       : "=&r" (old), "=&r" (tmp), "+m" (lock->tickets)
> +       : "r" (inc), "r" (&lock->tickets)
> +       : "cc");
> +
> +       if (likely(old.head == old.tail))
> +               goto out;
> +
> +       for (;;) {
> +               unsigned count = 100;

I am sure you wanted to tune the total loops to typical lock holding time ...
