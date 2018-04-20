Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SJPj4FmBzF1ql
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 00:38:33 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id j26-v6so9744228qtl.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 07:38:33 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de>
 <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 16:38:29 +0200
Message-ID: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To: Jeffrey Walton <noloader@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Albert ARIBAUD <albert.aribaud@3adev.fr>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
 Daniel Schepler <dschepler@gmail.com>, "H . J . Lu" <hjl.tools@gmail.com>,
 Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "# 3.4.x" <stable@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>  #include <asm-generic/msgbuf.h>
>> +#else
>
> I understand there's some progress having Clang compile the kernel.
> Clang treats __ILP32__ and friends differently than GCC. I believe
> ILP32 shows up just about everywhere there are 32-bit ints, longs and
> pointers. You might find it on Aarch64 or you might find it on MIPS64
> when using Clang.
>
> I think that means this may be a little suspicious:
>
>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>
> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
> devs insisted they were within their purview. Also see
> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>
> Sorry about the top-post. I just wanted to pick out that one piece.

It seems I made a typo and it needs to be __ILP32__ rather than
__ilp32__ (corrected that locally, will resend once we have resolved
this).

Aside from that, the #if check seems to be correct to me: this
is an x86-specific header, so it won't ever be seen on other
architectures. On x86-32, __x86_64__ isn't set, so we don't care
about whether __ilp32__ is set or not, and on x86-64 (lp64),
__ilp32__ is never set, so we still get the asm-generic header.

      Arnd
