Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 472E6DDF24
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:43:43 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MhcDC027947
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:43:38 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC DEV <linuxppc-dev@ozlabs.org>
Subject: [PATCH/DON'T MERGE] powerpc: Add device tree fixups for the EFIKA
Date: Tue,  2 Jan 2007 23:41:41 +0100
Message-Id: <11677777011884-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>
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
---
 arch/powerpc/kernel/prom_init.c |   76 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)


Hi everyone,

This patch allows the efika to boot out of the box, by patching the device
tree. At this time, the consensus seems to be this patch won't me pushed
upstream because the correct fix would be for bplan to fix the device tree
in the firmware.

The list of "patched" entries here is not the complete list of firmware
problems (for e.g., David Woodhouse spotted other problems regarding parition
access IIRC, and some compatible properties have a double \0\0 at the end
instead of a simple one. The firmware also fails to init the port config
for PSC2 to AC97 mode ...).

So please, bplan fix this. Come to #mklinux or contact us by mail, I'm
sure we'll be happy to help you spot the problems that need fixing.

If you're an EFIKA user, ask bplan to fix their firmware, maybe they'll end
up hearing us.


 Sylvain


diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 520ef42..5291d62 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2117,11 +2117,87 @@ #else
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
+	struct subst_entry efika_subst_table[] = {
+		{ "/",			"device_type",	prop_cstr("efika") },
+		{ "/builtin",		"compatible",	prop_cstr("soc") },
+		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc52xx-ata"), },
+		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc52xx-bestcomm") },
+		{ "/builtin/ethernet",	"compatible",	prop_cstr("mpc5200b-fec\0mpc52xx-fec") },
+		{ "/builtin/pic",	"compatible",	prop_cstr("mpc5200b-pic\0mpc52xx-pic") },
+		{ "/builtin/serial",	"compatible",	prop_cstr("mpc5200b-psc-uart\0mpc52xx-psc-uart") },
+		{ "/builtin/sound",	"compatible",	prop_cstr("mpc5200b-psc-ac97\0mpc52xx-psc-ac97") },
+		{ "/builtin/sound",	"interrupts",	prop_sound_irq, sizeof(prop_sound_irq) },
+		{ "/builtin/sram",	"compatible",	prop_cstr("mpc5200b-sram\0mpc52xx-sram") },
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
