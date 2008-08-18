Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id AEC1EDDED7
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 14:00:17 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Message-Id: <0a5bcb5674b6e7681261568f121c90b744ebc840.1219032000.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] Fix memory leak in arch/powerpc/sysdev/qe_lib/uuc_fast.c
	ucc_fast_init()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Aug 2008 14:00:14 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, danielm77@spray.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In kernel bugzilla 11364 Daniel Marjamäki notes that if the an the ioremap
fails we'll return -ENOMEM without kfree()ing uccf.

Add a kfree on the error path.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 1aecb07..3455abc 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -208,6 +208,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	uccf->uf_regs = ioremap(uf_info->regs, sizeof(struct ucc_fast));
 	if (uccf->uf_regs == NULL) {
 		printk(KERN_ERR "%s: Cannot map UCC registers\n", __func__);
+		kfree(uccf);
 		return -ENOMEM;
 	}
 
-- 
1.5.6.3
