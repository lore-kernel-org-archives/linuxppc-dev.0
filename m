Return-Path: <chris@distroguy.com>
Received: from mx-out02.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQFGy5g1WzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:08:26 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out02.mykolab.com (Postfix) with ESMTPS id 3D48D60092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 08:01:31 +0200 (CEST)
Date: Thu, 9 Jun 2016 16:01:25 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160609060120.GA26093@distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calling ISA 3.0 instructions copy, copy_first, paste and paste_last
generates an alignment fault when copying or pasting unaligned
data (128 byte). We catch this and send SIGBUS to the userspace
process that caused it.

We do not emulate these because paste may contain additional metadata
when pasting to a co-processor and paste_last is the synchronisation
point for preceding copy/paste sequences.

Thanks to Michael Neuling <mikey@neuling.org> for his help.

Signed-off-by: Chris Smart <chris@distroguy.com>
---
 arch/powerpc/kernel/align.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 8e7cb8e2b21a..fcdf09476eec 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -875,6 +875,21 @@ int fix_alignment(struct pt_regs *regs)
 		return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
 	}
 #endif
+
+	/*
+	 * ISA 3.0 (such as P9) copy, copy_first, paste and paste_last alignment
+	 * check.
+	 *
+	 * Send a SIGBUS to the process that caused the fault.
+	 *
+	 * We do not emulate these because paste may contain additional metadata
+	 * when pasting to a co-processor. Furthermore, paste_last is the
+	 * synchronisation point for preceding copy/paste sequences.
+	 */
+	if ((instruction & 0xfc0006fe) == 0x7c00060c){
+		return -EIO;
+	}
+
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-- 
2.7.4
