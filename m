Return-Path: <Paul.Burton@mips.com>
Received: from 9pmail.ess.barracuda.com (9pmail.ess.barracuda.com
 [64.235.150.224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419K3B4Fs0zF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 06:15:49 +1000 (AEST)
From: Paul Burton <paul.burton@mips.com>
To: <linux-kbuild@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, <linux-mips@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Matthew Wilcox
 <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>, Douglas Anderson
 <dianders@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Matthias Kaehlcke <mka@chromium.org>, He Zhe
 <zhe.he@windriver.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Al Viro
 <viro@zeniv.linux.org.uk>, Stafford Horne <shorne@gmail.com>, Gideon Israel
 Dsouza <gidisrael@gmail.com>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
Date: Tue, 19 Jun 2018 13:14:55 -0700
Message-ID: <20180619201458.4559-1-paul.burton@mips.com>
In-Reply-To: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
References: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series introduces infrastructure allowing compiler diagnostics to
be disabled or their severity modified for specific pieces of code, with
suitable abstractions to prevent that code from becoming tied to a
specific compiler.

This infrastructure is then used to disable the -Wattribute-alias
warning around syscall definitions, which rely on type mismatches to
sanitize arguments.

Finally PowerPC-specific #pragma's are removed now that the generic code
is handling this.

The series takes Arnd's RFC patches & addresses the review comments they
received. The most notable effect of this series to to avoid warnings &
build failures caused by -Wattribute-alias when compiling the kernel
with GCC 8.

Applies cleanly atop v4.18-rc1.

Thanks,
    Paul

Arnd Bergmann (2):
  kbuild: add macro for controlling warnings to linux/compiler.h
  disable -Wattribute-alias warning for SYSCALL_DEFINEx()

Paul Burton (1):
  powerpc: Remove -Wattribute-alias pragmas

 arch/powerpc/kernel/pci_32.c    |  4 ----
 arch/powerpc/kernel/pci_64.c    |  4 ----
 arch/powerpc/kernel/rtas.c      |  4 ----
 arch/powerpc/kernel/signal_32.c |  8 --------
 arch/powerpc/kernel/signal_64.c |  4 ----
 arch/powerpc/kernel/syscalls.c  |  4 ----
 arch/powerpc/mm/subpage-prot.c  |  4 ----
 include/linux/compat.h          |  8 +++++++-
 include/linux/compiler-gcc.h    | 27 +++++++++++++++++++++++++++
 include/linux/compiler_types.h  | 18 ++++++++++++++++++
 include/linux/syscalls.h        |  4 ++++
 11 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.17.1
