Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5cF94NX0zDrWC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:26:05 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id 64so34955190wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 05:26:05 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: 
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xmon: Do not compute/store the major opcode
Date: Tue, 26 Dec 2017 14:25:47 +0100
Message-Id: <20171226132548.22177-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation
changes)") usage of variable `op` has been removed. Completely remove opcode
computation since not used anymore.

Fix fatal warning:

arch/powerpc/xmon/ppc-dis.c: In function ‘lookup_powerpc’:
arch/powerpc/xmon/ppc-dis.c:96:17: error: variable ‘op’ set but not used [-Werror=unused-but-set-variable]
   unsigned long op;
                 ^~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/ppc-dis.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 31db8c072acd..9deea5ee13f6 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -93,10 +93,6 @@ lookup_powerpc (unsigned long insn, ppc_cpu_t dialect)
 {
   const struct powerpc_opcode *opcode;
   const struct powerpc_opcode *opcode_end;
-  unsigned long op;
-
-  /* Get the major opcode of the instruction.  */
-  op = PPC_OP (insn);
 
   opcode_end = powerpc_opcodes + powerpc_num_opcodes;
   /* Find the first match in the opcode table for this major opcode.  */
-- 
2.11.0
