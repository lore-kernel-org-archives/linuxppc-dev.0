Return-Path: <dave.long@linaro.org>
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com
 [209.85.220.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFA911A0743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 14:39:39 +1000 (AEST)
Received: by qkfc129 with SMTP id c129so35912583qkf.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 21:39:37 -0700 (PDT)
From: David Long <dave.long@linaro.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>,
 Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v2 0/2] Consolidate redundant register/stack access code
Date: Mon, 27 Jul 2015 00:39:32 -0400
Message-Id: <1437971974-2434-1-git-send-email-dave.long@linaro.org>
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

Changes since v1:
    Move the REG_OFFSET_NAME and REG_OFFSET_END macros to architecture-
    independent include file. Change their name from REG_* to REGS_* for
    consistency.

Note: Help regression testing s390, hexagon, and sh would be appreciated.
      Powerpc builds but I have not verified the functionality.

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
1.8.1.2
