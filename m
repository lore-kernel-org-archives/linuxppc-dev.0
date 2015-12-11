Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A09F1A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 22:10:05 +1100 (AEDT)
Received: by obc18 with SMTP id 18so80281498obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 03:10:02 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1449667265-17525-5-git-send-email-pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
Date: Fri, 11 Dec 2015 12:10:02 +0100
Message-ID: <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
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

On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
>                      13 =>   8 KB for each CPU
>                      12 =>   4 KB for each CPU
>
> +config NMI_LOG_BUF_SHIFT
> +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> +       range 10 21
> +       default 13
> +       depends on PRINTK && HAVE_NMI

Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.

> +       help
> +         Select the size of a per-CPU buffer where NMI messages are temporary
> +         stored. They are copied to the main log buffer in a safe context
> +         to avoid a deadlock. The value defines the size as a power of 2.
> +
> +         NMI messages are rare and limited. The largest one is when
> +         a backtrace is printed. It usually fits into 4KB. Select
> +         8KB if you want to be on the safe side.
> +
> +         Examples:
> +                    17 => 128 KB for each CPU
> +                    16 =>  64 KB for each CPU
> +                    15 =>  32 KB for each CPU
> +                    14 =>  16 KB for each CPU
> +                    13 =>   8 KB for each CPU
> +                    12 =>   4 KB for each CPU
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 5465230b75ec..78c07d441b4e 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -41,7 +41,8 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
>  static int printk_nmi_irq_ready;
>  atomic_t nmi_message_lost;
>
> -#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> +#define NMI_LOG_BUF_LEN ((1 << CONFIG_NMI_LOG_BUF_SHIFT) -             \
> +                        sizeof(atomic_t) - sizeof(struct irq_work))

kernel/printk/nmi.c:50:24: error: 'CONFIG_NMI_LOG_BUF_SHIFT'
undeclared here (not in a function)

E.g. efm32_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/12565754/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
