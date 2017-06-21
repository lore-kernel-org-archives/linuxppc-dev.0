Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtD590yKbzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:08 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LIccwV056312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:06 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7w133e9r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:06 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:39:04 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LId0lY7799164
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:00 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LIcxcd017808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:00 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/6] powerpc64/elfv1: Validate function pointer address in
 the function descriptor
Date: Thu, 22 Jun 2017 00:08:37 +0530
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <701603cefa05559fec722e6cb809ae6afd0648e6.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we assume that the function pointer we receive in
ppc_function_entry() points to a function descriptor. However, this is
not always the case. In particular, assembly symbols without the right
annotation do not have an associated function descriptor. Some of these
symbols are added to the kprobe blacklist using _ASM_NOKPROBE_SYMBOL().
When such addresses are subsequently processed through
arch_deref_entry_point() in populate_kprobe_blacklist(), we see the
below errors during bootup:
    [    0.663963] Failed to find blacklist at 7d9b02a648029b6c
    [    0.663970] Failed to find blacklist at a14d03d0394a0001
    [    0.663972] Failed to find blacklist at 7d5302a6f94d0388
    [    0.663973] Failed to find blacklist at 48027d11e8610178
    [    0.663974] Failed to find blacklist at f8010070f8410080
    [    0.663976] Failed to find blacklist at 386100704801f89d
    [    0.663977] Failed to find blacklist at 7d5302a6f94d00b0

Fix this by checking if the address in the function descriptor is
actually a valid kernel address. In the case of assembly symbols, this
will almost always fail as this ends up being powerpc instructions. In
that case, return pointer to the address we received, rather than the
dereferenced value.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index abef812de7f8..ec54050be585 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -83,8 +83,16 @@ static inline unsigned long ppc_function_entry(void *func)
 	 * On PPC64 ABIv1 the function pointer actually points to the
 	 * function's descriptor. The first entry in the descriptor is the
 	 * address of the function text.
+	 *
+	 * However, we may have received a pointer to an assembly symbol
+	 * that may not be a function descriptor. Validate that the entry
+	 * points to a valid kernel address and if not, return the pointer
+	 * we received as is.
 	 */
-	return ((func_descr_t *)func)->entry;
+	if (kernel_text_address(((func_descr_t *)func)->entry))
+		return ((func_descr_t *)func)->entry;
+	else
+		return (unsigned long)func;
 #else
 	return (unsigned long)func;
 #endif
-- 
2.13.1
