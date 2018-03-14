Return-Path: <arndbergmann@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401cFW4ZXJzF0qm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:12:47 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id z7-v6so3967272iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 09:12:47 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 17:12:44 +0100
Message-ID: <CAK8P3a3hbD=-P1wBwXEOnMdewGsUpZPERBHv6wo+3qqDkZD1qg@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
 David Miller <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 devel@driverdev.osuosl.org,
 gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 oprofile-list@lists.sf.net, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>,
 Steven Rostedt <rostedt@goodmis.org>, Robert Richter <rric@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, sebott@linux.vnet.ibm.com,
 sparclinux <sparclinux@vger.kernel.org>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>,
 "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 5:03 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html [1]
>
> Thomas, Arnd, this seems ready to be merged now.
> Can you help get this merged?
>
> Big picture is as per the lwn article:
> https://lwn.net/Articles/643234/ [2]
>
> The series is directed at converting posix clock syscalls:
> clock_gettime, clock_settime, clock_getres and clock_nanosleep
> to use a new data structure __kernel_timespec at syscall boundaries.
> __kernel_timespec maintains 64 bit time_t across all execution modes.
>
> vdso will be handled as part of each architecture when they enable
> support for 64 bit time_t.
>
> The compat syscalls are repurposed to provide backward compatibility
> by using them as native syscalls as well for 32 bit architectures.
> They will continue to use timespec at syscall boundaries.
>
> CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
> or timespec at syscall boundaries.
>
> The series does the following:
> 1. Enable compat syscalls on 32 bit architectures.
> 2. Add a new __kernel_timespec type to be used as the data structure
>    for all the new syscalls.
> 3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
>    [1] and [2] to switch to new definition of __kernel_timespec. It is
>    the same as struct timespec otherwise.
> 4. Add new CONFIG_32BIT_TIME to conditionally compile compat syscalls.

I've applied all 10 patches to my y2038 git branch [1], which is part
of linux-next,
to give it a little wider testing. If everything goes well, I'd send a
pull request to
Thomas next week so he can integrate it into tip from there, or (if he prefers)
send it directly to Linus in the merge window.

Thanks a lot for your persistence and your work on this!

      Arnd

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git#y2038
