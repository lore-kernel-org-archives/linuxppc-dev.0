Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com
 [IPv6:2607:f8b0:4001:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvz1Y634RzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 21:55:45 +1000 (AEST)
Received: by mail-ig0-x244.google.com with SMTP id g8so6408359igr.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 04:55:45 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4599222.az1Zyv5Lrl@wuerfel>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
 <3034953.EvqV1iv2Ef@caliban.sf-tec.de>
 <18012781.hPTzXnRcSP@wuerfel> <4599222.az1Zyv5Lrl@wuerfel>
Date: Wed, 27 Apr 2016 13:55:43 +0200
Message-ID: <CAMuHMdV0DwdMkJURBH05ntrJWz0eY_wT__vHG32sx-sjSp0m_w@mail.gmail.com>
Subject: Re: [PATCH 6/8] char/genrtc: parisc: use asm-generic/rtc.h
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tony Luck <tony.luck@intel.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
 David Howells <dhowells@redhat.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 alpha <linux-alpha@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 1:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 April 2016 13:21:16 Arnd Bergmann wrote:
>> On Wednesday 27 April 2016 00:07:47 Rolf Eike Beer wrote:
>> > Arnd Bergmann wrote:
>> > > The asm-generic/rtc.h header can now be included by
>> > > architectures that provide their own set_rtc_time/get_rtc_time
>> > > macros, letting us remove most of the common contents in
>> > > the powerpc implementation.
>> >
>> > parisc in this case.
>> >
>>
>> Fixed, thanks!
>
> Actually, after the comment about just removing the gen_rtc driver
> in the long run, I checked again and found that PARISC unconditionally
> selects RTC_CLASS, so this driver can't even be built here.
> We should just remove the header and drop PARISC from the list.
>
> If we also drop m68k, that just leaves powerpc.

I've just checked Debian's unofficial linux-image-4.5.0-1-m68k_4.5.1-1_m68k,
and it also enables RTC_CLASS and CONFIG_RTC_DRV_GENERIC, so gen_rtc
can be dropped on m68k for sure.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
