Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 93CC8DDF8A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 08:31:16 +1100 (EST)
Date: Wed, 13 Feb 2008 23:30:52 +0200
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [2.6 patch] powerpc: vdso_do_func_patch{32,64}() must be __init
Message-ID: <20080213213052.GO3383@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following section mismatches:

<--  snip  -->

...
WARNING: vmlinux.o(.text+0xe49c): Section mismatch in reference from the function .vdso_do_func_patch64() to the function .init.text:.find_symbol64()
WARNING: vmlinux.o(.text+0xe4d0): Section mismatch in reference from the function .vdso_do_func_patch64() to the function .init.text:.find_symbol64()
WARNING: vmlinux.o(.text+0xe56c): Section mismatch in reference from the function .vdso_do_func_patch32() to the function .init.text:.find_symbol32()
WARNING: vmlinux.o(.text+0xe5a0): Section mismatch in reference from the function .vdso_do_func_patch32() to the function .init.text:.find_symbol32()
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch has been sent on:
- 30 Jan 2008

 arch/powerpc/kernel/vdso.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

1c52ed2049b82e8458d03e50633b01ac5e1dfa40 
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 3702df7..d3437c4 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -336,9 +336,9 @@ static unsigned long __init find_function32(struct lib32_elfinfo *lib,
 	return sym->st_value - VDSO32_LBASE;
 }
 
-static int vdso_do_func_patch32(struct lib32_elfinfo *v32,
-				struct lib64_elfinfo *v64,
-				const char *orig, const char *fix)
+static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
+				       struct lib64_elfinfo *v64,
+				       const char *orig, const char *fix)
 {
 	Elf32_Sym *sym32_gen, *sym32_fix;
 
@@ -433,9 +433,9 @@ static unsigned long __init find_function64(struct lib64_elfinfo *lib,
 #endif
 }
 
-static int vdso_do_func_patch64(struct lib32_elfinfo *v32,
-				struct lib64_elfinfo *v64,
-				const char *orig, const char *fix)
+static int __init vdso_do_func_patch64(struct lib32_elfinfo *v32,
+				       struct lib64_elfinfo *v64,
+				       const char *orig, const char *fix)
 {
 	Elf64_Sym *sym64_gen, *sym64_fix;
 
