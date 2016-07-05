Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdR47GDzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:43 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdN3n5tz9sRZ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:40 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/41] powerpc: Make PTRRELOC() 32-bit only
Date: Tue,  5 Jul 2016 15:03:40 +1000
Message-Id: <1467695057-12431-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PTRRELOC is only used by 32-bit code since on 32-bit systems, early_init
can be run with relocation off and running at an offset. Define it to
identity on 64-bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/setup.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e9d384c..fa0687e 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -19,7 +19,11 @@ extern unsigned long reloc_offset(void);
 extern unsigned long add_reloc_offset(unsigned long);
 extern void reloc_got2(unsigned long);
 
+#ifdef CONFIG_PPC32
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
+#else
+#define PTRRELOC(x)	(x)
+#endif
 
 void check_for_initrd(void);
 void initmem_init(void);
-- 
2.7.4
