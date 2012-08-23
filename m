Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB6942C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 12:17:35 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v2][PATCH 2/3] powerpc: Bail out of KGDB when we've been triggered
Date: Thu, 23 Aug 2012 10:10:19 +0800
Message-ID: <1345687820-5248-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1345687820-5248-1-git-send-email-tiejun.chen@windriver.com>
References: <1345687820-5248-1-git-send-email-tiejun.chen@windriver.com>
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
v2: simply kgdb_skipexception() return path. 

 arch/powerpc/kernel/kgdb.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index bbabc5a..05adb69 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -101,6 +101,21 @@ static int computeSignal(unsigned int tt)
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
+	return kgdb_isremovedbreak(regs->nip);
+}
+
 static int kgdb_call_nmi_hook(struct pt_regs *regs)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), regs);
-- 
1.5.6
