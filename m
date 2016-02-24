Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAF5B1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 05/12] powerpc/ftrace: ftrace_graph_caller() needs to
 save/restore toc
Date: Thu, 25 Feb 2016 01:28:28 +1100
Message-Id: <1456324115-21144-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

Squash.

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2a7313cfbc7d..9e77a2c8f218 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1237,6 +1237,11 @@ _GLOBAL(ftrace_graph_caller)
 	std	r5, 64(r1)
 	std	r4, 56(r1)
 	std	r3, 48(r1)
+
+	/* Save callee's TOC in the ABI compliant location */
+	std	r2, 24(r1)
+	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
+
 	mfctr	r4		/* ftrace_caller has moved local addr here */
 	std	r4, 40(r1)
 	mflr	r3		/* ftrace_caller has restored LR from stack */
@@ -1262,6 +1267,9 @@ _GLOBAL(ftrace_graph_caller)
 	ld	r4, 56(r1)
 	ld	r3, 48(r1)
 
+	/* Restore callee's TOC */
+	ld	r2, 24(r1)
+
 	addi	r1, r1, 112
 	mflr	r0
 	std	r0, LRSAVE(r1)
-- 
2.5.0
