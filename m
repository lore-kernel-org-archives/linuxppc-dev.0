Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96234B70ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 17:36:09 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p0L6a4Z0016123
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 00:36:05 -0600
Subject: [PATCH] powerpc: Pass the right cpu_spec to ->setup_cpu() on 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 17:36:03 +1100
Message-ID: <1295591763.2148.282.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calling setup_cpu() on 64-bit, we pass a pointer to the
cputable entry we have found. This used to be fine when cur_cpu_spec
was a pointer to that entry, but nowadays, we copy the entry into
a separate variable, and we do so before we call the setup_cpu()
callback. That means that any attempt by that callback at patching
the CPU table entry (to adjust CPU features for example) will patch
the wrong table.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cputable.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 843abf7..fb83d36 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2105,8 +2105,8 @@ static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
 	 * pointer on ppc64 and booke as we are running at 0 in real mode
 	 * on ppc64 and reloc_offset is always 0 on booke.
 	 */
-	if (s->cpu_setup) {
-		s->cpu_setup(offset, s);
+	if (t->cpu_setup) {
+		t->cpu_setup(offset, t);
 	}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
 }
