Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C592CDDE3D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:22 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEEB8013413
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:15 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
Date: Mon, 12 Feb 2007 23:13:20 +0100
Message-Id: <11713184101239-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184091057-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We make the efika device tree compliant with the defined bindings
(at least compliant enough). This is mostly done by mangling
the device_type and compatible properties, but also adding
some missing bits.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/kernel/prom_init.c |   81 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 520ef42..4fb5938 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2117,11 +2117,92 @@ #else
 #define fixup_device_tree_pmac()
 #endif
 
+#ifdef CONFIG_PPC_EFIKA
+/* The current fw of the Efika has a device tree needs quite a few
+ * fixups to be compliant with the mpc52xx bindings. It's currently
+ * unknown if it will ever be compliant (come on bPlan ...) so we do fixups.
+ * NOTE that we (barely) tolerate it because the EFIKA was out before
+ * the bindings were finished, for any new boards -> RTFM ! */
+
+struct subst_entry {
+	char *path;
+	char *property;
+	void *value;
+	int value_len;
+};
+
+static void __init fixup_device_tree_efika(void)
+{
+	/* Substitution table */
+	#define prop_cstr(x) x, sizeof(x)
+	int prop_sound_irq[3] = { 2, 2, 0 };
+	int prop_bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
+	                             3,4,0, 3,5,0, 3,6,0, 3,7,0,
+	                             3,8,0, 3,9,0, 3,10,0, 3,11,0,
+	                             3,12,0, 3,13,0, 3,14,0, 3,15,0 };
+	struct subst_entry efika_subst_table[] = {
+		{ "/",			"device_type",	prop_cstr("efika") },
+		{ "/builtin",		"compatible",	prop_cstr("soc") },
+		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
+		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
+		{ "/builtin/bestcomm",	"interrupts",	prop_bcomm_irq, sizeof(prop_bcomm_irq) },
+		{ "/builtin/ethernet",	"compatible",	prop_cstr("mpc5200b-fec\0mpc5200-fec") },
+		{ "/builtin/pic",	"compatible",	prop_cstr("mpc5200b-pic\0mpc5200-pic") },
+		{ "/builtin/serial",	"compatible",	prop_cstr("mpc5200b-psc-uart\0mpc5200-psc-uart") },
+		{ "/builtin/sound",	"compatible",	prop_cstr("mpc5200b-psc-ac97\0mpc5200-psc-ac97") },
+		{ "/builtin/sound",	"interrupts",	prop_sound_irq, sizeof(prop_sound_irq) },
+		{ "/builtin/sram",	"compatible",	prop_cstr("mpc5200b-sram\0mpc5200-sram") },
+		{ "/builtin/sram",	"device_type",	prop_cstr("sram") },
+		{}
+	};
+	#undef prop_cstr
+
+	/* Vars */
+	u32 node;
+	char prop[64];
+	int rv, i;
+
+	/* Check if we're really running on a EFIKA */
+	node = call_prom("finddevice", 1, 1, ADDR("/"));
+	if (!PHANDLE_VALID(node))
+		return;
+
+	rv = prom_getprop(node, "model", prop, sizeof(prop));
+	if (rv == PROM_ERROR)
+		return;
+	if (strcmp(prop, "EFIKA5K2"))
+		return;
+
+	prom_printf("Applying EFIKA device tree fixups\n");
+
+	/* Process substitution table */
+	for (i=0; efika_subst_table[i].path; i++) {
+		struct subst_entry *se = &efika_subst_table[i];
+
+		node = call_prom("finddevice", 1, 1, ADDR(se->path));
+		if (!PHANDLE_VALID(node)) {
+			prom_printf("fixup_device_tree_efika: ",
+				"skipped entry %x - not found\n", i);
+			continue;
+		}
+
+		rv = prom_setprop(node, se->path, se->property,
+					se->value, se->value_len );
+		if (rv == PROM_ERROR)
+			prom_printf("fixup_device_tree_efika: ",
+				"skipped entry %x - setprop error\n", i);
+	}
+}
+#else
+#define fixup_device_tree_efika()
+#endif
+
 static void __init fixup_device_tree(void)
 {
 	fixup_device_tree_maple();
 	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
+	fixup_device_tree_efika();
 }
 
 static void __init prom_find_boot_cpu(void)
-- 
1.4.2
