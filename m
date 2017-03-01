Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYLKL1rX7zDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 03:20:54 +1100 (AEDT)
Received: by mail-ot0-x243.google.com with SMTP id w44so4676638otw.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 08:20:54 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170226010156.GA28831@altlinux.org>
References: <20170226010156.GA28831@altlinux.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 1 Mar 2017 17:20:50 +0100
Message-ID: <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org,
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

On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
> userspace compilation errors like this:
>
> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>   size_t ss_size;
>
> As no uapi header provides a definition of size_t, inclusion
> of <stddef.h> seems to be the most conservative fix available.
>
> On the kernel side size_t is typedef'ed to __kernel_size_t, so
> an alternative fix would be to change the type of sigaltstack.ss_size
> from size_t to __kernel_size_t for all architectures except those where
> sizeof(size_t) < sizeof(__kernel_size_t), namely, x32 and mips n32.
>
> On x32 and mips n32, however, #include <stddef.h> seems to be the most
> straightforward way to obtain the definition for sigaltstack.ss_size's
> type.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

I'm not sure if this is the best fix. We generally should not include one
standard header from another standard header. Would it be possible
to use __kernel_size_t instead of size_t?

     Arnd
