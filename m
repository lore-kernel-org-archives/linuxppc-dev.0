Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZsdN4qj2zDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 02:54:00 +1100 (AEDT)
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: [PATCH v4 4/5] printk/nmi: increase the size of NMI buffer and make
 it configurable
Date: Wed, 30 Mar 2016 17:53:29 +0200
Message-Id: <1459353210-20260-5-git-send-email-pmladek@suse.com>
In-Reply-To: <1459353210-20260-1-git-send-email-pmladek@suse.com>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Testing has shown that the backtrace sometimes does not fit into the 4kB
temporary buffer that is used in NMI context.  The warnings are gone when
I double the temporary buffer size.

This patch doubles the buffer size and makes it configurable.

Note that this problem existed even in the x86-specific implementation
that was added by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI
stack trace on all CPUs").  Nobody noticed it because it did not print any
warnings.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jiri Kosina <jkosina@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 init/Kconfig        | 22 ++++++++++++++++++++++
 kernel/printk/nmi.c |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index fd10deeefc22..1c9be9396a4a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -861,6 +861,28 @@ config LOG_CPU_MAX_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config NMI_LOG_BUF_SHIFT
+	int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
+	range 10 21
+	default 13
+	depends on PRINTK_NMI
+	help
+	  Select the size of a per-CPU buffer where NMI messages are temporary
+	  stored. They are copied to the main log buffer in a safe context
+	  to avoid a deadlock. The value defines the size as a power of 2.
+
+	  NMI messages are rare and limited. The largest one is when
+	  a backtrace is printed. It usually fits into 4KB. Select
+	  8KB if you want to be on the safe side.
+
+	  Examples:
+		     17 => 128 KB for each CPU
+		     16 =>  64 KB for each CPU
+		     15 =>  32 KB for each CPU
+		     14 =>  16 KB for each CPU
+		     13 =>   8 KB for each CPU
+		     12 =>   4 KB for each CPU
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 572f94922230..bf08557d7e3d 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -41,7 +41,8 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
 static int printk_nmi_irq_ready;
 atomic_t nmi_message_lost;
 
-#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
+#define NMI_LOG_BUF_LEN ((1 << CONFIG_NMI_LOG_BUF_SHIFT) -		\
+			 sizeof(atomic_t) - sizeof(struct irq_work))
 
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
-- 
1.8.5.6
