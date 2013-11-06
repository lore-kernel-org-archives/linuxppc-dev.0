Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D7372C00CC
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Nov 2013 23:51:13 +1100 (EST)
Received: by mail-pb0-f42.google.com with SMTP id jt11so8973754pbb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Nov 2013 04:51:10 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20131106123946.GJ10651@twins.programming.kicks-ass.net>
References: <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
 <20131106123946.GJ10651@twins.programming.kicks-ass.net>
Date: Wed, 6 Nov 2013 13:51:10 +0100
Message-ID: <CAMuHMdXZjQJvT7R4ODbDNBgAVwPUBPjB6UoR66_sNuFx7opUDw@mail.gmail.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, Tony Luck <tony.luck@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>, Russell King <linux@arm.linux.org.uk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 6, 2013 at 1:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>  Documentation/memory-barriers.txt     |  157 +++++++++++++++++-----------------
>  arch/alpha/include/asm/barrier.h      |   15 +++
>  arch/arc/include/asm/barrier.h        |   15 +++
>  arch/arm/include/asm/barrier.h        |   15 +++
>  arch/arm64/include/asm/barrier.h      |   50 ++++++++++
>  arch/avr32/include/asm/barrier.h      |   14 +++
>  arch/blackfin/include/asm/barrier.h   |   15 +++
>  arch/cris/include/asm/barrier.h       |   15 +++
>  arch/frv/include/asm/barrier.h        |   15 +++
>  arch/h8300/include/asm/barrier.h      |   15 +++
>  arch/hexagon/include/asm/barrier.h    |   15 +++
>  arch/ia64/include/asm/barrier.h       |   49 ++++++++++
>  arch/m32r/include/asm/barrier.h       |   15 +++
>  arch/m68k/include/asm/barrier.h       |   15 +++
>  arch/metag/include/asm/barrier.h      |   15 +++
>  arch/microblaze/include/asm/barrier.h |   15 +++
>  arch/mips/include/asm/barrier.h       |   15 +++
>  arch/mn10300/include/asm/barrier.h    |   15 +++
>  arch/parisc/include/asm/barrier.h     |   15 +++
>  arch/powerpc/include/asm/barrier.h    |   21 ++++
>  arch/s390/include/asm/barrier.h       |   15 +++
>  arch/score/include/asm/barrier.h      |   15 +++
>  arch/sh/include/asm/barrier.h         |   15 +++
>  arch/sparc/include/asm/barrier_32.h   |   15 +++
>  arch/sparc/include/asm/barrier_64.h   |   15 +++
>  arch/tile/include/asm/barrier.h       |   15 +++
>  arch/unicore32/include/asm/barrier.h  |   15 +++
>  arch/x86/include/asm/barrier.h        |   15 +++
>  arch/xtensa/include/asm/barrier.h     |   15 +++
>  include/linux/compiler.h              |    9 +
>  30 files changed, 581 insertions(+), 79 deletions(-)

This is screaming for a default implementation in asm-generic.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
