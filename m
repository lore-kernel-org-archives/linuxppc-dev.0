Return-Path: <dave.long@linaro.org>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6151A1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 16:39:03 +1100 (AEDT)
Received: by mail-qg0-x22b.google.com with SMTP id b67so46831079qgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 21:39:03 -0800 (PST)
From: David Long <dave.long@linaro.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
 "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>,
 Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v3 0/2] Consolidate redundant register/stack access code
Date: Tue,  9 Feb 2016 00:38:55 -0500
Message-Id: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "David A. Long" <dave.long@linaro.org>

Move duplicate and functionally equivalent code for accessing registers
and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
common kernel files.

I'm sending this out again (with updated distribution list) because v2
just never got pulled in, even though I don't think there were any
outstanding issues.

Changes since v1:
	Move the REG_OFFSET_NAME and REG_OFFSET_END macros to architecture-
	independent include file.

Changes since v2:
	No material changes, just merge up to v4.5-rc2.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

 arch/arm/include/asm/ptrace.h          |   6 --
 arch/arm/kernel/ptrace.c               |  74 +---------------
 arch/hexagon/include/uapi/asm/ptrace.h |   3 -
 arch/powerpc/include/asm/ptrace.h      |  38 --------
 arch/powerpc/kernel/ptrace.c           |  65 +++-----------
 arch/s390/include/asm/ptrace.h         |   3 -
 arch/s390/kernel/ptrace.c              |  69 +++++----------
 arch/sh/include/asm/ptrace.h           |  48 +---------
 arch/sh/kernel/Makefile                |   2 +-
 arch/sh/kernel/ptrace.c                |  33 -------
 arch/sh/kernel/ptrace_32.c             |  50 +++++------
 arch/sh/kernel/ptrace_64.c             | 154 ++++++++++++++++-----------------
 arch/x86/include/asm/ptrace.h          |  37 --------
 arch/x86/kernel/ptrace.c               |  93 ++++++--------------
 include/linux/ptrace.h                 |  54 ++++++++++++
 kernel/ptrace.c                        |  38 ++++++++
 16 files changed, 258 insertions(+), 509 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

-- 
2.5.0
