Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 48511B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 11:09:37 +1100 (EST)
Date: Wed, 6 Oct 2010 11:09:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: linux-next: build failure in Linus' tree
Message-Id: <20101006110935.e332fdf9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

Today's linux-next initial build (powerpc ppc64_defconfig) failed like
this:

cc1: warnings being treated as errors
arch/powerpc/kernel/module.c: In function 'module_finalize':
arch/powerpc/kernel/module.c:66: error: unused variable 'err'

Caused by commit 5336377d6225959624146629ce3fc88ee8ecda3d ("modules: Fix
module_bug_list list corruption race").

I added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 6 Oct 2010 11:06:44 +1100
Subject: [PATCH] powerpc: remove unused variable

Since powerpc uses -Werror on arch powerpc, the build was broken like
this:

cc1: warnings being treated as errors
arch/powerpc/kernel/module.c: In function 'module_finalize':
arch/powerpc/kernel/module.c:66: error: unused variable 'err'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/module.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 4ef93ae..49cee9d 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -63,7 +63,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		const Elf_Shdr *sechdrs, struct module *me)
 {
 	const Elf_Shdr *sect;
-	int err;
 
 	/* Apply feature fixups */
 	sect = find_section(hdr, sechdrs, "__ftr_fixup");
-- 
1.7.1


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
