Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40K3l443ZKzDr4s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 05:43:28 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id s18so6589589wrg.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 12:43:28 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: Make some functions static
Date: Sun,  8 Apr 2018 21:43:18 +0200
Message-Id: <20180408194318.8062-1-malat@debian.org>
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

In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
prototypes for

- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

were added but at the same time in commit d15a261d876d ("powerpc/32: Make
some functions static") those same functions were made static. Fix
conflicting changes by removing the prototypes and leave the function as
static. Fix the following warnings, treated as errors with W=1:

  arch/powerpc/kernel/setup_32.c:127:19: error: static declaration of ‘ppc_setup_l2cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:140:19: error: static declaration of ‘ppc_setup_l3cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:186:19: error: static declaration of ‘ppc_init’ follows non-static declaration

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/setup_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9827b6b3aaaa..9e79be13b937 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -124,7 +124,7 @@ notrace void __init machine_init(u64 dt_ptr)
 }
 
 /* Checks "l2cr=xxxx" command-line option */
-static int __init ppc_setup_l2cr(char *str)
+int __init ppc_setup_l2cr(char *str)
 {
 	if (cpu_has_feature(CPU_FTR_L2CR)) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
@@ -137,7 +137,7 @@ static int __init ppc_setup_l2cr(char *str)
 __setup("l2cr=", ppc_setup_l2cr);
 
 /* Checks "l3cr=xxxx" command-line option */
-static int __init ppc_setup_l3cr(char *str)
+int __init ppc_setup_l3cr(char *str)
 {
 	if (cpu_has_feature(CPU_FTR_L3CR)) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
@@ -183,7 +183,7 @@ EXPORT_SYMBOL(nvram_sync);
 
 #endif /* CONFIG_NVRAM */
 
-static int __init ppc_init(void)
+int __init ppc_init(void)
 {
 	/* clear the progress line */
 	if (ppc_md.progress)
-- 
2.11.0
