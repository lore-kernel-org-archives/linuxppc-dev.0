Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A78CB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 00:32:45 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix compile fail in hugetlb cmdline parsing
Date: Mon,  7 May 2012 10:32:22 -0400
Message-Id: <1336401142-18733-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Baron <jbaron@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9fb48c744ba6a4bf58b666f4e6fdac3008ea1bd4

    "params: add 3rd arg to option handler callback signature"

added an extra arg to the function, but didn't catch all the use
cases needing it, causing this compile fail in mpc85xx_defconfig:

 arch/powerpc/mm/hugetlbpage.c:316:4: error: passing argument 7 of
 'parse_args' from incompatible pointer type [-Werror]

 include/linux/moduleparam.h:317:12: note: expected
	 'int (*)(char *, char *, const char *)' but argument is of type
	 'int (*)(char *, char *)'

This function has no need to printk out the "doing" value, so
just add the arg as an "unused".

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Becky Bruce <beckyb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index fb05b12..1a6de0a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -271,7 +271,8 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 
 unsigned long gpage_npages[MMU_PAGE_COUNT];
 
-static int __init do_gpage_early_setup(char *param, char *val)
+static int __init do_gpage_early_setup(char *param, char *val,
+				       const char *unused)
 {
 	static phys_addr_t size;
 	unsigned long npages;
-- 
1.7.9.1
