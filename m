Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 053C91A017B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:25:53 +1000 (AEST)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v4.1-rc1
In-Reply-To: <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
 <871tj4uara.fsf@rustcorp.com.au>
 <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
Date: Tue, 28 Apr 2015 21:54:15 +0930
Message-ID: <87pp6osaog.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Mark Brown <broonie@kernel.org>, sparclinux <sparclinux@vger.kernel.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Can't see that one with a simple grep: can you post warning?
>
> /home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
> /home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
> passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
> type [enabled by default]
> /home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
> 'const struct cpumask *' but argument is of type 'struct nodemask_t *'

Um, I turned the cpu_isset() into cpumask_test_cpu(), but that just
showed this bug up.  The tile maintainers need to fix this one.

Thanks,
Rusty.
