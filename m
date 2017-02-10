Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKK105NG6zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 13:40:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add a prototype for mcount() so it can be versioned
Date: Fri, 10 Feb 2017 13:40:02 +1100
Message-Id: <1486694402-28066-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we get a warning that _mcount() can't be versioned:

  WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.

Add a prototype to asm-prototypes.h to fix it.

The prototype is not really correct, mcount() is not a normal function,
it has a special ABI. But for the purpose of versioning it doesn't
matter.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-prototypes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index ba47c70712f9..f6c5264287e5 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -120,4 +120,6 @@ extern s64 __ashrdi3(s64, int);
 extern int __cmpdi2(s64, s64);
 extern int __ucmpdi2(u64, u64);
 
+void _mcount(void);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
-- 
2.7.4
