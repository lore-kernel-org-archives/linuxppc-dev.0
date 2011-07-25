Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C667EB70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 07:07:38 +1000 (EST)
Date: Mon, 25 Jul 2011 16:04:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: return the_cpu_ spec from identify_cpu
Message-ID: <20110725210436.GA3807@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit af9eef3c7b1ed004c378c89b87642f4937337d50 caused cpu_setup to see
the_cpu_spec, rather than the source struct.  However, on 32-bit, the
return value of identify_cpu was being used for feature fixups, and
identify_cpu was returning the source struct.  So if cpu_setup patches
the feature bits, the update won't affect the fixups.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/cputable.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9fb9332..fa44ff5 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2051,7 +2051,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 
 static struct cpu_spec the_cpu_spec;
 
-static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
+static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
+					       struct cpu_spec *s)
 {
 	struct cpu_spec *t = &the_cpu_spec;
 	struct cpu_spec old;
@@ -2114,6 +2115,8 @@ static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
 		t->cpu_setup(offset, t);
 	}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
+
+	return t;
 }
 
 struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
@@ -2124,10 +2127,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	s = PTRRELOC(s);
 
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
-		if ((pvr & s->pvr_mask) == s->pvr_value) {
-			setup_cpu_spec(offset, s);
-			return s;
-		}
+		if ((pvr & s->pvr_mask) == s->pvr_value)
+			return setup_cpu_spec(offset, s);
 	}
 
 	BUG();
-- 
1.7.4.1
