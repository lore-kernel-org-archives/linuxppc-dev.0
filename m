Return-Path: <jfannin@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 7DBC3DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 02:37:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so964668anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jan 2008 07:37:22 -0800 (PST)
Date: Tue, 1 Jan 2008 10:36:07 -0500
From: Joseph Fannin <jfannin@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: export copy_page() on 32bit
Message-ID: <20080101153607.GA6391@nineveh.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Export copy_page() on 32bit powerpc; unionfs needs it.

Unionfs already builds as a module on 64bit powerpc, so the export is
placed within an existing CONFIG_PPC32 #ifdef.

Signed-off-by: Joseph Fannin <jfannin@gmail.com>
---

I ran into this in the -mm tree; it's not new to 2.6.24-rc6-mm1.

I haven't been able to find any evidence that copy_page() is exported
with 64bit; maybe this is because copy_page there is a wrapper around
the exported copy_4K_page() and gets optimized away, or maybe I just
don't know where to look.

If copy_page() is exported for 64bit somewhere, this might not be the
right thing?

diff -aurN -x .git linux-mm.orig/arch/powerpc/kernel/ppc_ksyms.c linux-mm.patched/arch/powerpc/kernel/ppc_ksyms.c
--- linux-mm.orig/arch/powerpc/kernel/ppc_ksyms.c	2008-01-01 04:03:33.000000000 -0500
+++ linux-mm.patched/arch/powerpc/kernel/ppc_ksyms.c	2008-01-01 04:15:33.000000000 -0500
@@ -59,6 +59,7 @@
 extern int sys_sigreturn(struct pt_regs *regs);
 
 EXPORT_SYMBOL(clear_pages);
+EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);


--
Joseph Fannin
jfannin@gmail.com
