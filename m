Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418MSD6zsyzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 17:00:42 +1000 (AEST)
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
To: Paul Burton <paul.burton@mips.com>, linux-kbuild@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-mips@linux-mips.org,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Matthew Wilcox <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, He Zhe <zhe.he@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Gideon Israel Dsouza <gidisrael@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180616005323.7938-1-paul.burton@mips.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f9b53b28-7961-d970-3c6c-570ec595d29f@c-s.fr>
Date: Mon, 18 Jun 2018 09:00:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/06/2018 à 02:53, Paul Burton a écrit :
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
>      Paul
> 
> Arnd Bergmann (2):
>    kbuild: add macro for controlling warnings to linux/compiler.h
>    disable -Wattribute-alias warning for SYSCALL_DEFINEx()
> 
> Paul Burton (1):
>    Revert "powerpc: fix build failure by disabling attribute-alias
>      warning in pci_32"
> 
>   arch/powerpc/kernel/pci_32.c   |  4 ---
>   include/linux/compat.h         |  8 ++++-
>   include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>   include/linux/compiler_types.h | 18 ++++++++++
>   include/linux/syscalls.h       |  4 +++
>   5 files changed, 95 insertions(+), 5 deletions(-)
> 

Works well, thanks.

You can then also revert 	2479bfc9bc600dcce7f932d52dcfa8d677c41f93
("powerpc: Fix build by disabling attribute-alias warning for 
SYSCALL_DEFINEx")

Christophe
