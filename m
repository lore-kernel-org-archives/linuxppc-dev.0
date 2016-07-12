Return-Path: <brgerst@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpgSb0YZ4zDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 21:57:34 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id w143so963430oiw.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 04:57:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dc84a1b979d800049bfd0629ed9380238cba2807.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
 <dc84a1b979d800049bfd0629ed9380238cba2807.1468270393.git.luto@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 12 Jul 2016 07:57:31 -0400
Message-ID: <CAMzpN2j2F9gQCRGmzVb0LjQT9mmU9m=HRG2Vbf-g79+i57dvdg@mail.gmail.com>
Subject: Re: [PATCH v5 18/32] signal: Consolidate {TS,
 TLF}_RESTORE_SIGMASK code
To: Andy Lutomirski <luto@kernel.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2016 at 4:53 PM, Andy Lutomirski <luto@kernel.org> wrote:
> In general, there's no need for the "restore sigmask" flag to live in
> ti->flags.  alpha, ia64, microblaze, powerpc, sh, sparc (64-bit only),
> tile, and x86 use essentially identical alternative implementations,
> placing the flag in ti->status.
>
> Replace those optimized implementations with an equally good common
> implementation that stores it in a bitfield in struct task_struct
> and drop the custom implementations.
>
> Additional architectures can opt in by removing their
> TIF_RESTORE_SIGMASK defines.

There is a small typo in the subject, should be "signal: Consolidate
{TS,TIF}_RESTORE_SIGMASK code"

--
Brian Gerst
