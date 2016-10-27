Return-Path: <dsafonov@virtuozzo.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0116.outbound.protection.outlook.com [104.47.1.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4YN336hYzDvNy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 04:12:03 +1100 (AEDT)
From: Dmitry Safonov <dsafonov@virtuozzo.com>
To: <linux-kernel@vger.kernel.org>
CC: Dmitry Safonov <dsafonov@virtuozzo.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Andy Lutomirski <luto@amacapital.net>, Oleg
 Nesterov <oleg@redhat.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mm@kvack.org>
Subject: [PATCHv3 2/8] powerpc/vdso: remove unused params in
 vdso_do_func_patch{32, 64}
Date: Thu, 27 Oct 2016 20:09:42 +0300
Message-ID: <20161027170948.8279-3-dsafonov@virtuozzo.com>
In-Reply-To: <20161027170948.8279-1-dsafonov@virtuozzo.com>
References: <20161027170948.8279-1-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Impact: cleanup

vdso_do_func_patch{32,64} only use {v32,v64} parameter accordingly.
Remove not needed parameters.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/powerpc/kernel/vdso.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4ffb82a2d9e9..278b9aa25a1c 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -309,7 +309,6 @@ static unsigned long __init find_function32(struct lib32_elfinfo *lib,
 }
 
 static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
-				       struct lib64_elfinfo *v64,
 				       const char *orig, const char *fix)
 {
 	Elf32_Sym *sym32_gen, *sym32_fix;
@@ -344,7 +343,6 @@ static unsigned long __init find_function32(struct lib32_elfinfo *lib,
 }
 
 static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
-				       struct lib64_elfinfo *v64,
 				       const char *orig, const char *fix)
 {
 	return 0;
@@ -419,8 +417,7 @@ static unsigned long __init find_function64(struct lib64_elfinfo *lib,
 #endif
 }
 
-static int __init vdso_do_func_patch64(struct lib32_elfinfo *v32,
-				       struct lib64_elfinfo *v64,
+static int __init vdso_do_func_patch64(struct lib64_elfinfo *v64,
 				       const char *orig, const char *fix)
 {
 	Elf64_Sym *sym64_gen, *sym64_fix;
@@ -619,11 +616,9 @@ static __init int vdso_fixup_alt_funcs(struct lib32_elfinfo *v32,
 		 * It would be easy to do, but doesn't seem to be necessary,
 		 * patching the OPD symbol is enough.
 		 */
-		vdso_do_func_patch32(v32, v64, patch->gen_name,
-				     patch->fix_name);
+		vdso_do_func_patch32(v32, patch->gen_name, patch->fix_name);
 #ifdef CONFIG_PPC64
-		vdso_do_func_patch64(v32, v64, patch->gen_name,
-				     patch->fix_name);
+		vdso_do_func_patch64(v64, patch->gen_name, patch->fix_name);
 #endif /* CONFIG_PPC64 */
 	}
 
-- 
2.10.1
