Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEF711A1816
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 21:17:59 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Wed, 20 Jan 2016 10:17:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 24D782190067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 10:17:42 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0KAHshr40763570
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 10:17:54 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0KAHrrR008025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 03:17:53 -0700
Date: Wed, 20 Jan 2016 11:17:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-s390@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390: enable text relative kallsyms for 64-bit targets
Message-ID: <20160120101751.GG3395@osiris>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160120094326.GD3395@osiris>
 <CAKv+Gu_nvdBqp50MZ+wHGn-nP3P3HBo_XeabqCCebEUBeVtUFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu_nvdBqp50MZ+wHGn-nP3P3HBo_XeabqCCebEUBeVtUFQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 20, 2016 at 11:04:24AM +0100, Ard Biesheuvel wrote:
> On 20 January 2016 at 10:43, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > On Wed, Jan 20, 2016 at 10:05:37AM +0100, Ard Biesheuvel wrote:
> >> This enables the newly introduced text-relative kallsyms support when
> >> building 64-bit targets. This cuts the size of the kallsyms address
> >> table in half, reducing the memory footprint of the kernel .rodata
> >> section by about 250 KB for a defconfig build.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> >> index dbeeb3a049f2..588160fd1db0 100644
> >> --- a/arch/s390/Kconfig
> >> +++ b/arch/s390/Kconfig
> >> @@ -149,6 +149,7 @@ config S390
> >>       select HAVE_REGS_AND_STACK_ACCESS_API
> >>       select HAVE_SYSCALL_TRACEPOINTS
> >>       select HAVE_VIRT_CPU_ACCOUNTING
> >> +     select KALLSYMS_TEXT_RELATIVE if 64BIT
> >
> > Please remove the "if 64BIT" since s390 is always 64BIT in the meantime.
> > Tested on s390 and everything seems still to work ;)
> >
> > Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> >
> 
> Thanks! Did you take a look at /proc/kallsyms, by any chance? It
> should look identical with and without these patches

Close to identical, since the generated code and offsets change a bit with
your new config option enabled and disabled. But only those parts that are
linked behind kernel/kallsyms.c.

However I did run a couple of ftrace, kprobes tests and enforced call
backtraces. Everything still works.

So it looks all good.
