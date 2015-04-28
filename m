Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA54F1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:45:35 +1000 (AEST)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v4.1-rc1
In-Reply-To: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
Date: Tue, 28 Apr 2015 14:09:37 +0930
Message-ID: <871tj4uara.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
> On Mon, Apr 27, 2015 at 11:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v4.1-rc1[1] compared to v4.0[2].
>>
>> Summarized:
>>   - build errors: +34/-11
>>   - build warnings: +135/-163
>>
>> As I haven't mastered kup yet, there's no verbose summary at
>> http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v4.1-rc1.summary.gz
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/8779/ (254 out of 257 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/head/8710/ (254 out of 257 configs)
>>
>>
>> *** ERRORS ***
>>
>> 34 regressions:
>
> The quiet days are over...
>
>>   + /home/kisskb/slave/src/arch/mips/cavium-octeon/smp.c: error: passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 242:2
>>   + /home/kisskb/slave/src/arch/mips/kernel/process.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 52:2
>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 149:2, 211:2
>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 221:2
>
> mips/bigsur_defconfig
> mips/malta_defconfig
> mips/cavium_octeon_defconfig
> mips/ip27_defconfig

Already fixed in other thread...

> and related warnings due to lack of -Werror on
> ia64-defconfig

That fix is fairly obvious, I'll post separately.

> tilegx_defconfig

Can't see that one with a simple grep: can you post warning?

> m32r/m32700ut.smp_defconfig

Will post fix for this too.

> cpumask also gives fishy warnings:
>
>     lib/cpumask.c:167:25: warning: the address of 'cpu_all_bits' will
> always evaluate as 'true' [-Waddress]
>
> on sparc (e.g. sparc64/sparc64-allmodconfig) and powerpc (e.g.
> powerpc/ppc64_defconfig), which seem to have been reported 6 months
> ago...

Hmm, this is cpumask_of_node?  That's... Oh my, that requires
a separate post.

> Can we throw some bitcoins at the cpumasks? ;-)

I think I should be throwing bitcoins at you, instead!

Thanks,
Rusty.
