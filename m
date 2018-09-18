Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9kD0ddTzF3J4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 03:59:47 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:47 +0200
Message-Id: <20180918175850.4437-6-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 6/9] signal/powerpc: Call force_sig_fault from
 _exception
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The callers of _exception don't need the pkey exception logic because
they are not processing a pkey exception.  So just call exception_common
directly and then call force_sig_fault to generate the appropriate siginfo
and deliver the appropriate signal.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f6c778b5144f..c38bec51dd84 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -380,7 +380,10 @@ void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long ad
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
-	_exception_pkey(signr, regs, code, addr, 0);
+	if (!exception_common(signr, regs, code, addr))
+		return;
+
+	force_sig_fault(signr, code, (void __user *)addr, current);
 }
 
 void system_reset_exception(struct pt_regs *regs)
-- 
2.17.1
