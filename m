Return-Path: <carlos@systemhalted.org>
Received: from mail-qk0-x22e.google.com (mail-qk0-x22e.google.com
 [IPv6:2607:f8b0:400d:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcNWd22HfzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 02:10:21 +1100 (AEDT)
Received: by mail-qk0-x22e.google.com with SMTP id y76so26877224qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 07:10:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE2sS1i-xezJu2hHfzOxpCMZHc2J+dsturtqFPMRWHa6mm6ccQ@mail.gmail.com>
References: <20170226010156.GA28831@altlinux.org>
 <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
 <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
 <20170302154845.GB3503@altlinux.org>
 <CAE2sS1i-xezJu2hHfzOxpCMZHc2J+dsturtqFPMRWHa6mm6ccQ@mail.gmail.com>
From: "Carlos O'Donell" <carlos@systemhalted.org>
Date: Mon, 6 Mar 2017 10:10:18 -0500
Message-ID: <CAE2sS1jTyENymA-fSAk4dt29rYgX50zYqubVYnGVGnFrH=-1nA@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-cris-kernel@axis.com,
 uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 linux-am33-list@redhat.com,
 linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 3, 2017 at 8:23 PM, Carlos O'Donell <carlos@systemhalted.org> wrote:
> On Thu, Mar 2, 2017 at 10:48 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> On Thu, Mar 02, 2017 at 10:22:18AM -0500, Carlos O'Donell wrote:
>>> On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>> >> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
>>> >> userspace compilation errors like this:
>>> >>
>>> >> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>>> >>   size_t ss_size;
>>> >>
>>> >> As no uapi header provides a definition of size_t, inclusion
>>> >> of <stddef.h> seems to be the most conservative fix available.
>> [...]
>>> > I'm not sure if this is the best fix. We generally should not include one
>>> > standard header from another standard header. Would it be possible
>>> > to use __kernel_size_t instead of size_t?
>>>
>>> In glibc we handle this with special use of __need_size_t with GCC's
>>> provided stddef.h.
>>>
>>> For example glibc's signal.h does this:
>>>
>>> # define __need_size_t
>>> # include <stddef.h>
>>
>> Just to make it clear, do you suggest this approach for asm/signal.h as well?

The best practice from the glibc community looks like this:

(a) Create a bits/types/*.h header for the type you need.

e.g.
./time/bits/types/struct_timeval.h
./time/bits/types/struct_itimerspec.h
./time/bits/types/time_t.h
./time/bits/types/struct_timespec.h
./time/bits/types/struct_tm.h
./time/bits/types/clockid_t.h
./time/bits/types/clock_t.h
./time/bits/types/timer_t.h

(b) If neccessary the bits/types/*.h header is a wrapper:
~~~
#define __need_size_t
#include <stddef.h>
~~~
to get access to the compiler provided type.

This way all of the code you need simplifies to includes for the types you need.

e.g.

time/sys/time.h:
...
#include <bits/types.h>
#include <bits/types/time_t.h>
#include <bits/types/struct_timeval.h>
...

This is what we've been doing in glibc starting last September as we
cleaned up all the convoluted conditional logic to get the types we
needed in the headers that needed them.

Cheers,
Carlos.
