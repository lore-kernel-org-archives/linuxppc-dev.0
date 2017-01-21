Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v5L3k12FfzDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 01:45:53 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc/sstep: Return directly after a failed address_ok() in
 emulate_step()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <bc39d538-80f2-e810-0d58-39522605e067@users.sourceforge.net>
Date: Sat, 21 Jan 2017 15:45:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 15:30:15 +0100

* Return directly after a call of the function "address_ok" failed
  in a case block.

  This issue was detected by using the Coccinelle software.

* Delete two error code assignments which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/lib/sstep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9c78a9c102c3..c33519c25b47 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1803,9 +1803,8 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
-		err = -EFAULT;
 		if (!address_ok(regs, op.ea, size))
-			goto ldst_done;
+			return 0;
 		err = 0;
 		switch (size) {
 		case 4:
@@ -1828,9 +1827,8 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
-		err = -EFAULT;
 		if (!address_ok(regs, op.ea, size))
-			goto ldst_done;
+			return 0;
 		err = 0;
 		switch (size) {
 		case 4:
-- 
2.11.0
