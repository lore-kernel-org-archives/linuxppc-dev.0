Return-Path: <tytso@mit.edu>
Received: from thunker.thunk.org (www.church-of-our-saviour.org [69.25.196.31])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86D72DDF40
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 07:24:41 +1100 (EST)
Date: Wed, 12 Mar 2008 16:24:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-ID: <20080312202431.GG15804@mit.edu>
References: <E1JZGwo-0000vf-2v@closure.thunk.org>
	<20080312034110.GT6887@bakeyournoodle.com>
	<20080312144239.GY15804@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080312144239.GY15804@mit.edu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Once again, this time with feeling....

						- Ted

>From c91cfaabc17f8a53807a2f31f067a732e34a1550 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 12 Mar 2008 11:50:39 -0400
Subject: [PATCH] [PATCH] powerpc: Export empty_zero_page

The empty_zero_page symbol is exported by most other architectures
(s390, ia64, x86, um), and an upcoming ext4 patch needs it because
ZERO_PAGE() references empty_zero_page, and we need it to zero out an
unitialized extents in ext4 files.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 arch/powerpc/kernel/ppc_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index aa9ff35..885a723 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -58,6 +58,7 @@ extern void program_check_exception(struct pt_regs *regs);
 extern void single_step_exception(struct pt_regs *regs);
 extern int sys_sigreturn(struct pt_regs *regs);
 
+EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
-- 
1.5.4.1.144.gdfee-dirty
