Return-Path: <deepa.kernel@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycg9f4ktkzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:11:34 +1100 (AEDT)
Received: by mail-io0-x230.google.com with SMTP id g73so3318922ioj.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 15:11:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Wed, 15 Nov 2017 15:11:31 -0800
Message-ID: <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
To: Arnd Bergmann <arnd@arndb.de>
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
 Michael Ellerman <mpe@ellerman.id.au>, oberpar@linux.vnet.ibm.com,
 oprofile-list@lists.sf.net,
 Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>,
 Ralf Baechle <ralf@linux-mips.org>, Steven Rostedt <rostedt@goodmis.org>,
 Robert Richter <rric@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
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

> I had on concern about x32, maybe we should check
> for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
> bits.

Thanks, I think you are right. I had the check conditional on
CONFIG_64BIT_TIME and then removed as I forgot why I added it. :)

> Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
> it help to just leave out that part for now and unconditionally
> define '__kernel_timespec' as 'timespec' until we are ready to
> convert the architectures?

Another approach would be to use separate configs:

1. To indicate 64 bit time_t syscall support. This will be dependent
on architectures as CONFIG_64BIT_TIME.
We can delete this once all architectures have provided support for this.

2. Another config (maybe COMPAT_32BIT_TIME?) to be introduced later,
which will compile out all syscalls/ features that use 32 bit time_t.
This can help build a y2038 safe kernel later.

Would this work for everyone?

-Deepa
