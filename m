Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x243.google.com (mail-ig0-x243.google.com
 [IPv6:2607:f8b0:4001:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvsb81JNTzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 17:51:00 +1000 (AEST)
Received: by mail-ig0-x243.google.com with SMTP id qu10so5508296igc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 00:51:00 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
Date: Wed, 27 Apr 2016 09:50:58 +0200
Message-ID: <CAMuHMdWppdXFjoj-+YC137fgPYb4TE_Kp4fycitJdPaqMGn3VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] simplify rtc-generic driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>,
 alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 RTCLINUX <rtc-linux@googlegroups.com>,
 Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Tue, Apr 26, 2016 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is a resend of an earlier series, to clean up the rtc-generic
> driver by avoiding the dependency on the architecture specific
> include/asm/rtc.h header that after this series is only used
> for the deprecated "genrtc" driver. As I've shown in another
> series, only three architectures (m68k, powerpc, parisc)
> actually use the genrtc driver, and they all support rtc-generic
> as a replacement as well.
>
> The only missing piece appears to be the ioctl support for
> the m68k q40 machine that I'm adding in patch 2 here.

Apparently I had applied your previous version to my local tree, but I had
completely forgotten about it. So it has received quite some compile testing.

CONFIG_GEN_RTC is not enabled in any of the m68k defconfigs, so I think it's
been unused for a while.
CONFIG_RTC_DRV_GENERIC is modular, so I typically don't run-test it.
I just did that, and after fixing patch 1 to use IS_ENABLED() it worked fine
on ARAnyM.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I do not have a Q40, so I couldn't test that part.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
