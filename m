Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4C262C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 20:50:39 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc: Bail out of KGDB when we've been triggered
Date: Wed, 22 Aug 2012 18:43:11 +0800
Message-ID: <1345632192-19810-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1345632192-19810-1-git-send-email-tiejun.chen@windriver.com>
References: <1345632192-19810-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to skip a breakpoint exception when it occurs after
a breakpoint has already been removed.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kgdb.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index bbabc5a..e84252b 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -101,6 +101,24 @@ static int computeSignal(unsigned int tt)
 	return SIGHUP;		/* default for things we don't know about */
 }
 
+/**
+ *
+ *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
+ *	@exception: Exception vector number
+ *	@regs: Current &struct pt_regs.
+ *
+ *	On some architectures we need to skip a breakpoint exception when
+ *	it occurs after a breakpoint has been removed.
+ *
+ */
+int kgdb_skipexception(int exception, struct pt_regs *regs)
+{
+	if (kgdb_isremovedbreak(regs->nip))
+		return 1;
+
+	return 0;
+}
+
 static int kgdb_call_nmi_hook(struct pt_regs *regs)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), regs);
-- 
1.5.6
