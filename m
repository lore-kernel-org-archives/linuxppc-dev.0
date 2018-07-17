Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V1sv0yjYzF35Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 10:50:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: malat@debian.org
Subject: [PATCH] powerpc/xmon: Fix disassembly since printf changes
Date: Tue, 17 Jul 2018 10:50:38 +1000
Message-Id: <20180717005038.32352-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent change to add printf annotations to xmon inadvertently made
the disassembly output ugly, eg:

  c00000002001e058  7ee00026      mfcr    r23
  c00000002001e05c  fffffffffae101a0      std     r23,416(r1)
  c00000002001e060  fffffffff8230000      std     r1,0(r3)

The problem being that negative 32-bit values are being displayed in
full 64-bits.

The printf conversion was actually correct, we are passing unsigned
long so it should use "lx". But powerpc instructions are only 4 bytes
and the code only reads 4 bytes, so inst should really just be
unsigned int, and that also fixes the printing to look the way we
want:

  c00000002001e058  7ee00026      mfcr    r23
  c00000002001e05c  fae101a0      std     r23,416(r1)
  c00000002001e060  f8230000      std     r1,0(r3)

Fixes: e70d8f55268b ("powerpc/xmon: Add __printf annotation to xmon_printf()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..196978733e64 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2734,7 +2734,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 {
 	int nr, dotted;
 	unsigned long first_adr;
-	unsigned long inst, last_inst = 0;
+	unsigned int inst, last_inst = 0;
 	unsigned char val[4];
 
 	dotted = 0;
@@ -2758,7 +2758,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 		dotted = 0;
 		last_inst = inst;
 		if (praddr)
-			printf(REG"  %.8lx", adr, inst);
+			printf(REG"  %.8x", adr, inst);
 		printf("\t");
 		dump_func(inst, adr);
 		printf("\n");
-- 
2.14.1
