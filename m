Return-Path: <gang.chen.5i5j@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BF2C1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 12:02:44 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id eu11so2695254pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 19:02:40 -0700 (PDT)
Message-ID: <53ED6B40.8000409@gmail.com>
Date: Fri, 15 Aug 2014 10:06:56 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
References: <53ECE9DD.80004@gmail.com>	<CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com>
 <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
In-Reply-To: <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Linux/MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-s390@vger.kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux@lists.openrisc.net,
 Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Jean Delvare <jdelvare@suse.de>,
 egtvedt@samfundet.no, Jonas Bonn <jonas@southpole.se>,
 Liqin Chen <liqin.linux@gmail.com>, jesper.nilsson@axis.com,
 linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, "David S. Miller" <davem@davemloft.net>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 takata@linux-m32r.org, x86@kernel.org, jejb@parisc-linux.org,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Lennox Wu <lennox.wu@gmail.com>, Mark Salter <msalter@redhat.com>,
 Matt Turner <mattst88@gmail.com>, hskinnemoen@gmail.com, fenghua.yu@intel.com,
 James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>,
 realmz6@gmail.com, linux-kbuild <linux-kbuild@vger.kernel.org>,
 heiko.carstens@de.ibm.com, jdike@addtoit.com, linux-alpha@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, Chris Metcalf <cmetcalf@tilera.com>,
 starvik@axis.com, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 user-mode-linux-user@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, tony.luck@intel.com,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, "vgupta@synopsys.com" <vgupta@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org,
 user-mode-linux-devel@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, yasutake.koichi@jp.panasonic.com,
 linuxppc-dev@lists.ozlabs.org, deller@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/15/14 9:52, Max Filippov wrote:
> On Fri, Aug 15, 2014 at 5:47 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Hi Chen,
>>
>> On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
>>> Normal architectures:
>>>
>>>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>>>
>>>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>>>                   score, unicore32, x86
>>>
>>>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>>>
>>> Special architectures:
>>>
>>>  - Deside by compiler: microblaze, tile, xtensa.
>>>
>>>  - Deside by building host: um
>>>
>>>  - Next, need improve Kbuild to probe endian to deside whether need mark
>>>    __BUILDING_TIME_BIG_ENDIAN__ before real config.

Please check this comments, thanks.

>>
>> [...]
>>
>>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>>> index 3a617af..a3e8f7e 100644
>>> --- a/arch/xtensa/Kconfig
>>> +++ b/arch/xtensa/Kconfig
>>> @@ -22,6 +22,8 @@ config XTENSA
>>>         select HAVE_IRQ_TIME_ACCOUNTING
>>>         select HAVE_PERF_EVENTS
>>>         select COMMON_CLK
>>> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
>>> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>>         help
>>>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>>>           primarily for embedded systems.  These processors are both
>>
>> I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
>> nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't
> 
> Correction: it always selects CPU_LITTLE_ENDIAN, regardless of the
> compiler endianness.
> 

Yeah, at present, it always select CPU_LITTLE_ENDIAN, next, Kbuild need
be improved for it, just the comments said.

If this patch can be pass checking, I shall improve the Kbuild for it,
also will modify some individual drivers to use CPU_*_ENDIAN.

I guess, we need Cc to kbuild for getting more ideas, suggestions, or
completions.



THanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
