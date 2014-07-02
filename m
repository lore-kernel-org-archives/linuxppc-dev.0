Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by lists.ozlabs.org (Postfix) with ESMTP id 96F671A0009
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:00:33 +1000 (EST)
Subject: [PATCH v5 1/2] kprobes/powerpc: Fix arch_deref_entry_point to
 support ABIv2
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@gmail.com>
Date: Wed, 02 Jul 2014 07:00:22 +0000
Message-ID: <20140702070022.14689.7254.stgit@kbuild-fedora.novalocal>
In-Reply-To: <1404276081.7254.1.camel@concordia>
References: <1404276081.7254.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Anoop Thomas Mathew <atm@profoundis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-tip-commits@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
 sparse@chrisli.org, rdunlap@infradead.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 Chris Wright <chrisw@sous-sol.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, dl9pf@gmx.de,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since PowerPC64 ABIv2 doesn't have function descriptor
any more, arch_deref_entry_point(), which returns function
entry point from function descriptor, should be updated.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anoop Thomas Mathew <atm@profoundis.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/kprobes.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 90fab64..72a1034 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -491,7 +491,12 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
+/*
+ * On PPC64 ABIv1 the function pointer actually points to the
+ * function's descriptor. The first entry in the descriptor is the
+ * address of the function text.
+ */
 unsigned long arch_deref_entry_point(void *entry)
 {
 	return ((func_descr_t *)entry)->entry;
