Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com
 [IPv6:2607:f8b0:4003:c01::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6F381A1B06
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 23:50:19 +1100 (AEDT)
Received: by obciw8 with SMTP id iw8so82620770obc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 04:50:16 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
Date: Fri, 11 Dec 2015 13:50:16 +0100
Message-ID: <CAMuHMdW0CQYgs2Cz3REf6FHM5dj9LGN6AnmDZnFfaw0084ekSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Cris <linux-cris-kernel@axis.com>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 11, 2015 at 1:41 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
>> On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
>> > --- a/init/Kconfig
>> > +++ b/init/Kconfig
>> > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
>> >                      13 =3D>   8 KB for each CPU
>> >                      12 =3D>   4 KB for each CPU
>> >
>> > +config NMI_LOG_BUF_SHIFT
>> > +       int "Temporary per-CPU NMI log buffer size (12 =3D> 4KB, 13 =
=3D> 8KB)"
>> > +       range 10 21
>> > +       default 13
>> > +       depends on PRINTK && HAVE_NMI
>>
>> Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.
>
> =C3=85h, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.
>
> The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
> to fix it the following way:
>
>
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>         int "Temporary per-CPU NMI log buffer size (12 =3D> 4KB, 13 =3D> =
8KB)"
>         range 10 21
>         default 13
> -       depends on PRINTK && HAVE_NMI
> +       depends on PRINTK_NMI
>         help
>           Select the size of a per-CPU buffer where NMI messages are temp=
orary
>           stored. They are copied to the main log buffer in a safe contex=
t

Makes sense, as kernel/printk/nmi.c is compiled if PRINTK_NMI is set.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
