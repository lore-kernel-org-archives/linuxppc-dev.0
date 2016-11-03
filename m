Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8XLZ0TfCzDvNn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 15:39:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/module: Add support for R_PPC64_REL32 relocations
Date: Thu,  3 Nov 2016 15:39:17 +1100
Message-Id: <1478147957-4766-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We haven't seen these before, but the soon to be merged relative
exception tables support causes them to be generated.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/module_64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 183368e008cf..bb1807184bad 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -652,6 +652,11 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			*location = value - (unsigned long)location;
 			break;
 
+		case R_PPC64_REL32:
+			/* 32 bits relative (used by relative exception tables) */
+			*(u32 *)location = value - (unsigned long)location;
+			break;
+
 		case R_PPC64_TOCSAVE:
 			/*
 			 * Marker reloc indicates we don't have to save r2.
-- 
2.7.4
