Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydZYF4jtbzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 21:46:41 +1100 (AEDT)
Received: by mail-ot0-x244.google.com with SMTP id b49so1665420otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 02:46:41 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.DEB.2.20.1711171138510.7700@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
 <alpine.DEB.2.20.1711160958430.2191@nanos>
 <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
 <alpine.DEB.2.20.1711170954000.1709@nanos>
 <CAK8P3a3fcVKTwoqN0CxYchzcFqUZPBeko=oYsA9eNxu4bQoYyw@mail.gmail.com>
 <alpine.DEB.2.20.1711171049180.1709@nanos>
 <CAK8P3a10N42rBO8XBrZWYOCwVB8jayjgZu2oa8FSpHTzszQacQ@mail.gmail.com>
 <alpine.DEB.2.20.1711171138510.7700@nanos>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Nov 2017 11:46:37 +0100
Message-ID: <CAK8P3a1J0C5A+SzVWDz52ZkawG1HZYj2cR6oc=DL=QrXgYaiHg@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
 John Stultz <john.stultz@linaro.org>,
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

On Fri, Nov 17, 2017 at 11:40 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> On Fri, Nov 17, 2017 at 10:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> >> On Fri, Nov 17, 2017 at 9:58 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> No, syscall that existing 32-bit user space enters would be handled by
>> >> compat_sys_nanosleep() on both 32-bit and 64-bit kernels at that
>> >> point. The idea here is to make the code path more uniform between
>> >> 32-bit and 64-bit kernels.
>> >
>> > So on a 32bit system compat_sys_nanosleep() would be the legacy
>> > sys_nanosleep() with the existing syscall number, but you don't want to
>> > introduce a new sys_nanosleep64() for 32bit. That makes a lot of sense.
>> >
>> > So back to your original question whether to use #if (MAGIC logic) or a
>> > separate config symbol. Please use the latter, these magic logic constructs
>> > are harder to read and prone to get wrong at some point. Having the
>> > decision logic in one place is always the right thing to do.
>>
>> How about this:
>>
>> config LEGACY_TIME_SYSCALLS
>>       def_bool 64BIT || !64BIT_TIME
>>       help
>>         This controls the compilation of the following system calls:
>> time, stime,
>>         gettimeofday, settimeofday, adjtimex, nanosleep, alarm, getitimer,
>>         setitimer, select, utime, utimes, futimesat, and
>> {old,new}{l,f,}stat{,64}.
>>         These all pass 32-bit time_t arguments on 32-bit architectures and
>>         are replaced by other interfaces (e.g. posix timers and clocks, statx).
>>         C libraries implementing 64-bit time_t in 32-bit architectures have to
>>         implement the handles by wrapping around the newer interfaces.
>
> s/handles/handling/ ????

I meant "handlers".

>>         New architectures should not explicitly disable this.
>
> New architectures should never enable this, right?

Right, I got an extra "not". I guess if Deepa incorporates the new option,
she can also improve my English ;-)

         Arnd
