Return-Path: <SRS0+c221ceb7dfe241bf38c8+1694+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9A1EDE23F
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 02:52:45 +1000 (EST)
Subject: [EFIKA] Really, don't pretend to be CHRP
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sun, 13 Apr 2008 17:52:38 +0100
Message-Id: <1208105558.3026.137.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fedora 9 works on Efika without the separate 'device-tree supplement',
thanks to the kernel's own fixups. With one exception -- because 'CHRP'
still appears on the 'machine:' line in /proc/cpuinfo, the installer
misdetects the platform and misconfigures yaboot, putting it into a PReP
boot partition instead of in the /boot filesystem where the Efika's
firmware could find it.

The kernel's fixups for Efika already correct one instance of 'chrp', in
the 'device_type' property. This fixes it in the 'CODEGEN,description'
property too, since that's what's exposed to userspace in /proc/cpuinfo.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5ab4c84..723422e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2240,6 +2240,14 @@ static void __init fixup_device_tree_efika(void)
 	if (rv != PROM_ERROR && (strcmp(prop, "chrp") == 0))
 		prom_setprop(node, "/", "device_type", "efika", sizeof("efika"));
 
+	/* CODEGEN,description is exposed in /proc/cpuinfo so
+	   fix that too */
+	rv = prom_getprop(node, "CODEGEN,description", prop, sizeof(prop));
+	if (rv != PROM_ERROR && (strstr(prop, "CHRP")))
+		prom_setprop(node, "/", "CODEGEN,description",
+			     "Efika 5200B PowerPC System",
+			     sizeof("Efika 5200B PowerPC System"));
+
 	/* Fixup bestcomm interrupts property */
 	node = call_prom("finddevice", 1, 1, ADDR("/builtin/bestcomm"));
 	if (PHANDLE_VALID(node)) {



-- 
dwmw2
