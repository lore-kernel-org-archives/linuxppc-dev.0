Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 45E16B7BF4
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Oct 2009 23:35:45 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
References: <20090714065350.659537380@samba.org>
	<20090714065425.301516312@samba.org>
	<m2ocophale.fsf__34527.2158309401$1254511503$gmane$org@igel.home>
	<m28wfsef79.fsf@igel.home> <m2ocoo1qfi.fsf@igel.home>
	<1254606807.7122.23.camel@pasglop>
Date: Sun, 04 Oct 2009 14:35:41 +0200
In-Reply-To: <1254606807.7122.23.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Sun, 04 Oct 2009 08:53:27 +1100")
Message-ID: <m2skdze3qa.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Maybe a better fix is to force alignment in the kernel by requesting
> size + 64k - 4k and aligning it.

Sure you are right.

Andreas.

>From b9441a3d2148d439e2730def3222a7b70dccc432 Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 4 Oct 2009 14:29:04 +0200
Subject: [PATCH] powerpc: align vDSO base address

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/vdso.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 94e2df3..137dc22 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -50,6 +50,9 @@
 /* Max supported size for symbol names */
 #define MAX_SYMNAME	64
 
+/* The alignment of the vDSO */
+#define VDSO_ALIGNMENT	(1 << 16)
+
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
 static unsigned int vdso32_pages;
@@ -231,15 +234,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * pick a base address for the vDSO in process space. We try to put it
 	 * at vdso_base which is the "natural" base for it, but we might fail
 	 * and end up putting it elsewhere.
+	 * Add enough to the size so that the result can be aligned.
 	 */
 	down_write(&mm->mmap_sem);
 	vdso_base = get_unmapped_area(NULL, vdso_base,
-				      vdso_pages << PAGE_SHIFT, 0, 0);
+				      (vdso_pages << PAGE_SHIFT) +
+				      ((VDSO_ALIGNMENT - 1) & PAGE_MASK),
+				      0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
 		rc = vdso_base;
 		goto fail_mmapsem;
 	}
 
+	/* Add required alignment. */
+	vdso_base = ALIGN(vdso_base, VDSO_ALIGNMENT);
+
 	/*
 	 * Put vDSO base into mm struct. We need to do this before calling
 	 * install_special_mapping or the perf counter mmap tracking code
-- 
1.6.4.4


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
