Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E659CDDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:38:59 +1100 (EST)
Date: Tue, 15 Jan 2008 09:36:17 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] bootwrapper: convert cuboot-8{3,5}xx to
	dt_fixup_mac_address_by_alias
Message-ID: <Pine.LNX.4.64.0801150935230.29314@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---

in my git tree.

 arch/powerpc/boot/cuboot-83xx.c |    3 ++-
 arch/powerpc/boot/cuboot-85xx.c |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
index acd860e..61af1c1 100644
--- a/arch/powerpc/boot/cuboot-83xx.c
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -24,7 +24,8 @@ static void platform_fixups(void)
 	void *soc;

 	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
-	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
 	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);

 	/* Unfortunately, the specific model number is encoded in the
diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
index 943779e..6776a1a 100644
--- a/arch/powerpc/boot/cuboot-85xx.c
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -24,8 +24,9 @@ static void platform_fixups(void)
 	void *soc;

 	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
-	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr,
-	                       bd.bi_enet2addr);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet2", bd.bi_enet2addr);
 	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 8, bd.bi_busfreq);

 	/* Unfortunately, the specific model number is encoded in the
-- 
1.5.3.7
