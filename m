Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydXtf5ms3zDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 20:31:38 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id r190so1232814oie.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 01:31:38 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.DEB.2.20.1711170954000.1709@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
 <alpine.DEB.2.20.1711160958430.2191@nanos>
 <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
 <alpine.DEB.2.20.1711170954000.1709@nanos>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Nov 2017 10:31:34 +0100
Message-ID: <CAK8P3a3fcVKTwoqN0CxYchzcFqUZPBeko=oYsA9eNxu4bQoYyw@mail.gmail.com>
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

On Fri, Nov 17, 2017 at 9:58 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> On Thu, Nov 16, 2017 at 10:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 15 Nov 2017, Deepa Dinamani wrote:
>> >> Would this work for everyone?
>> >
>> > Having extra config switches which are selectable by architectures and
>> > removed when everything is converted is definitely the right way to go.
>> >
>> > That allows you to gradually convert stuff w/o inflicting wreckage all over
>> > the place.
>>
>> The CONFIG_64BIT_TIME would do that nicely for the new stuff like
>> the conditional definition of __kernel_timespec, this one would get
>> removed after we convert all architectures.
>>
>> A second issue is how to control the compilation of the compat syscalls.
>> CONFIG_COMPAT_32BIT_TIME handles that and could be defined
>> in Kconfig as 'def_bool (!64BIT && CONFIG_64BIT_TIME) || COMPAT',
>> this is then just a more readable way of expressing exactly when the
>> functions should be built.
>>
>> For completeness, there may be a third category, depending on how
>> we handle things like sys_nanosleep(): Here, we want the native
>> sys_nanosleep on 64-bit architectures, and compat_sys_nanosleep()
>> to handle the 32-bit time_t variant on both 32-bit and 64-bit targets,
>> but our plan is to not have a native 32-bit sys_nanosleep on 32-bit
>> architectures any more, as new glibc should call clock_nanosleep()
>> with a new syscall number instead. Should we then enclose
>
> Isn't that going to break existing userspace?

No, syscall that existing 32-bit user space enters would be handled by
compat_sys_nanosleep() on both 32-bit and 64-bit kernels at that
point. The idea here is to make the code path more uniform between
32-bit and 64-bit kernels.

      Arnd
