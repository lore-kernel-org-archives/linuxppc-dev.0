Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420kd22jHWzF31M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 21:57:10 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id e2-v6so2223177pgv.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 04:57:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Alan Modra <amodra@gmail.com>
Subject: [RFC PATCH] powerpc/64/module: REL32 relocation range check
Date: Wed, 29 Aug 2018 21:56:56 +1000
Message-Id: <20180829115656.9878-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent module relocation overflow crash demonstrated that we
have no range checking on REL32 relative relocations. This patch
implements a basic check, the same kernel that previously oopsed
and rebooted now continues with some of these errors when loading
the module:

    module_64: x_tables: REL32 527703503449812 out of range!

Question is whether other relocations (ADDR32, REL16, TOC16, etc.)
should also have overflow checks.
---
 arch/powerpc/kernel/module_64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a2636c250b7b..2a2fb656d23b 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -678,7 +678,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 		case R_PPC64_REL32:
 			/* 32 bits relative (used by relative exception tables) */
-			*(u32 *)location = value - (unsigned long)location;
+			/* Convert value to relative */
+			value -= (unsigned long)location;
+			if (value + 0x80000000 > 0xffffffff) {
+				pr_err("%s: REL32 %li out of range!\n",
+				       me->name, (long int)value);
+				return -ENOEXEC;
+			}
+			*(u32 *)location = value;
 			break;
 
 		case R_PPC64_TOCSAVE:
-- 
2.18.0
