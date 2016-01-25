Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00DC61A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 05:07:13 +1100 (AEDT)
Subject: Re: [PATCH v4 0/3] kallsyms base relative series
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org,
 hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de,
 linux-arch@vger.kernel.org
References: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A65EEA.8010908@roeck-us.net>
Date: Mon, 25 Jan 2016 09:44:10 -0800
MIME-Version: 1.0
In-Reply-To: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2016 06:19 AM, Ard Biesheuvel wrote:
> This v4 of my kallsyms base relative implementation is now a 3 piece series,
> since it caused some problems due to the way absolute symbols are handled
> by the absolute per cpu code. As it turns out, that code was probably wrong
> in the sense that it caused non-relocated symbol addresses to be emitted
> for values that are in fact relative to the address of the kernel text.
>
> Patch #1 fixes the scripts/kallsyms invocation to only pass the x86_64
> specific --absolute-percpu option if CONFIG_SMP is also set.
>
> Patch #2 reworks the absolute percpu code to only emit those percpu symbols
> as absolute, and not symbols that have been classified as 'A' (absolute) by
> the linker, since that does not mean quite the same thing.
>
> Patch #3 is the original kallsyms base relative patch, with some
> modifications:
> - folded the s/ULLONG_MAX/-1ULL? change made by Andrew
> - ensured that the kallsyms_relative_base value itself is relocated as
>    required.
> - dropped all of the acks and other tags, as they have become outdated with
>    the recent changes to this patch.
>

I tested the series on top of mmotm (after reverting the original patches).
Qemu tests for mips, sparc, and x86 (both smp and nosmp) now pass.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Ard Biesheuvel (3):
>    x86: kallsyms: disable absolute percpu symbols on !SMP
>    kallsyms: don't overload absolute symbol type for percpu symbols
>    kallsyms: add support for relative offsets in kallsyms address table
>
>   init/Kconfig            |  16 +++
>   kernel/kallsyms.c       |  38 ++++++--
>   scripts/kallsyms.c      | 102 +++++++++++++++++---
>   scripts/link-vmlinux.sh |   6 +-
>   scripts/namespace.pl    |   2 +
>   5 files changed, 142 insertions(+), 22 deletions(-)
>
