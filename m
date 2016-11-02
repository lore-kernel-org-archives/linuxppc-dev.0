Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t85JL2T06zDt3N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:21:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/oops: Fix missing pr_cont()s in print_msr_bits()
 et. al.
Date: Wed,  2 Nov 2016 22:20:47 +1100
Message-Id: <1478085650-23618-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
References: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the KERN_CONT changes these are being horribly split across lines,
for example:

    MSR: 8000000000009033 <
    SF,EE
    ,ME,IR
    ,DR,RI
    ,LE>

So fix it by using pr_cont() where appropriate.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 621d9b23df72..38f85d7a1e06 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1282,7 +1282,7 @@ static void print_bits(unsigned long val, struct regbit *bits, const char *sep)
 
 	for (; bits->bit; ++bits)
 		if (val & bits->bit) {
-			printk("%s%s", s, bits->name);
+			pr_cont("%s%s", s, bits->name);
 			s = sep;
 		}
 }
@@ -1305,9 +1305,9 @@ static void print_tm_bits(unsigned long val)
  *   T: Transactional	(bit 34)
  */
 	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
-		printk(",TM[");
+		pr_cont(",TM[");
 		print_bits(val, msr_tm_bits, "");
-		printk("]");
+		pr_cont("]");
 	}
 }
 #else
@@ -1316,10 +1316,10 @@ static void print_tm_bits(unsigned long val) {}
 
 static void print_msr_bits(unsigned long val)
 {
-	printk("<");
+	pr_cont("<");
 	print_bits(val, msr_bits, ",");
 	print_tm_bits(val);
-	printk(">");
+	pr_cont(">");
 }
 
 #ifdef CONFIG_PPC64
-- 
2.7.4
