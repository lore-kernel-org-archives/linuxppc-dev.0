Return-Path: <wad@chromium.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 878DCB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 13:11:05 +1000 (EST)
Received: by gxk1 with SMTP id 1so2362166gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 20:11:01 -0700 (PDT)
From: Will Drewry <wad@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] powerpc: select HAVE_SECCOMP_FILTER and provide
	seccomp_execve
Date: Tue, 31 May 2011 22:10:43 -0500
Message-Id: <1306897845-9393-11-git-send-email-wad@chromium.org>
In-Reply-To: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
Cc: Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	jmorris@namei.org, rostedt@goodmis.org, tglx@linutronix.de,
	Paul Mackerras <paulus@samba.org>, kees.cook@canonical.com,
	torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/powerpc/Kconfig               |    1 +
 arch/powerpc/include/asm/seccomp.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8f4d50b..0bd4574 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,7 @@ config PPC
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
+	select HAVE_SECCOMP_FILTER
 	select IRQ_PER_CPU
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
index 00c1d91..3cb9cc1 100644
--- a/arch/powerpc/include/asm/seccomp.h
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -7,10 +7,12 @@
 #define __NR_seccomp_write __NR_write
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
+#define __NR_seccomp_execve __NR_execve
 
 #define __NR_seccomp_read_32 __NR_read
 #define __NR_seccomp_write_32 __NR_write
 #define __NR_seccomp_exit_32 __NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
+#define __NR_seccomp_execve_32 __NR_execve
 
 #endif	/* _ASM_POWERPC_SECCOMP_H */
-- 
1.7.0.4
