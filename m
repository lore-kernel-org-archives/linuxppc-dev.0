Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y76C82nBVzDr5H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 19:59:15 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id f3so7747266oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 01:59:15 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-11-git-send-email-keescook@chromium.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Oct 2017 10:59:12 +0200
Message-ID: <CAK8P3a2uio4L3BMedHGg0wVy2asJ_CD8xqxevSnqdNDKOy6Vqw@mail.gmail.com>
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from
 DEFINE_TIMER
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Harish Patil <harish.patil@cavium.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 John Stultz <john.stultz@linaro.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, Kalle Valo <kvalo@qca.qualcomm.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <len.brown@intel.com>,
 Manish Chopra <manish.chopra@cavium.com>, Mark Gross <mark.gross@intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>,
 Networking <netdev@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>,
 Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Ralf Baechle <ralf@linux-mips.org>,
 Sebastian Reichel <sre@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Tejun Heo <tj@kernel.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
 linux1394-devel@lists.sourceforge.net,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 linux-pm@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-watchdog@vger.kernel.org,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 5, 2017 at 1:27 AM, Kees Cook <keescook@chromium.org> wrote:
> Drop the arguments from the macro and adjust all callers with the
> following script:
>
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts

I was slightly worried about this large-scale rework, since it might conflict
with new users of DEFINE_TIMER(), causing bisection problems.

However, a little research showed that we have only added two users
in the past five years, so this is not a real concern.

for arch/arm, drivers/char and overall:

Acked-by: Arnd Bergmann <arnd@arndb.de>
