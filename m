Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4432fNdzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:24:51 +1000 (AEST)
Date: Thu, 18 May 2017 10:24:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
 Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
Message-ID: <20170518082448.GB3812@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> b) give the union a name (breaks any reference to timer_list->func in C code):
> 
>  +       union {
>  +               void            (*func)(struct timer_list *timer);
>  +               void            (*function)(unsigned long);
>  +       } u;

I'll look into that, as it seems a lot safer, and places outside
the timer code shouldn't really touch it (although I bet they do,
so more fixes for this series..)

> I fear this breaks lockdep output, which turns the name of
> the timer into a string that gets printed later. It should work
> when these are macros, or a macro wrapping an inline function
> like __init_timer is.

Ok, I'll fix it up.  Although this macro mess isn't really readable
at all.
