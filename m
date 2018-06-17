Return-Path: <shorne@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417bmL3bs2zF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 11:11:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so6534193pfl.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 18:11:58 -0700 (PDT)
Date: Sun, 17 Jun 2018 10:11:53 +0900
From: Stafford Horne <shorne@gmail.com>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-kbuild@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
 Ingo Molnar <mingo@kernel.org>, Matthew Wilcox <matthew@wil.cx>,
 Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, He Zhe <zhe.he@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Gideon Israel Dsouza <gidisrael@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
Message-ID: <20180617011153.GA24595@lianli.shorne-pla.net>
References: <20180616005323.7938-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 15, 2018 at 05:53:19PM -0700, Paul Burton wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
> 
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
> 
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
> 
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
> 
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> 
> Thanks,
>     Paul
> 
> Arnd Bergmann (2):
>   kbuild: add macro for controlling warnings to linux/compiler.h
>   disable -Wattribute-alias warning for SYSCALL_DEFINEx()
> 
> Paul Burton (1):
>   Revert "powerpc: fix build failure by disabling attribute-alias
>     warning in pci_32"
> 
>  arch/powerpc/kernel/pci_32.c   |  4 ---
>  include/linux/compat.h         |  8 ++++-
>  include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>  include/linux/compiler_types.h | 18 ++++++++++
>  include/linux/syscalls.h       |  4 +++
>  5 files changed, 95 insertions(+), 5 deletions(-)

Hello Paul,

I tested the series out with the new OpenRISC 9.0.0 port and the
-Wattribute-alias warnings are gone.  Thank you.

Using toolchain binaries from:
  https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180613

For the series:

Tested-by: Stafford Horne <shorne@gmail.com>

-Stafford
