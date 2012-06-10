Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2307FB6FFD
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2012 21:35:54 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339279889.24838.93.camel@pasglop>
 <m2k3zgf79j.fsf@igel.home> <1339281364.24838.94.camel@pasglop>
 <m2fwa4f5x5.fsf@igel.home> <1339283422.24838.96.camel@pasglop>
 <m2zk8br65n.fsf@linux-m68k.org> <1339312981.24838.98.camel@pasglop>
Date: Sun, 10 Jun 2012 13:35:45 +0200
In-Reply-To: <1339312981.24838.98.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Sun, 10 Jun 2012 17:23:01 +1000")
Message-ID: <m2zk8bz9f2.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Ah, excellent, so a small quirk in i2c_powermac is the way to go then,
> we can detect it by name and hack up something. Either that or even
> better, in prom_init, we could add the missing property to the
> device-tree.

How does that look like?  Though I'm not sure this is the right
approach.  Those models with the onyx chip that lack the pcm3052
compatible property apparently have no OF node at all to key off the
workaround.

Andreas.

diff --git i/arch/powerpc/kernel/prom_init.c w/arch/powerpc/kernel/prom_init.c
index 1b488e5..1b04159 100644
--- i/arch/powerpc/kernel/prom_init.c
+++ w/arch/powerpc/kernel/prom_init.c
@@ -2554,7 +2554,7 @@ static void __init fixup_device_tree_chrp(void)
 #endif
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
-static void __init fixup_device_tree_pmac(void)
+static void __init fixup_device_tree_pmac_u3_i2c(void)
 {
 	phandle u3, i2c, mpic;
 	u32 u3_rev;
@@ -2593,6 +2593,39 @@ static void __init fixup_device_tree_pmac(void)
 	prom_setprop(i2c, "/u3@0,f8000000/i2c@f8001000", "interrupt-parent",
 		     &parent, sizeof(parent));
 }
+
+static void __init fixup_device_tree_pmac_deq(void)
+{
+	phandle deq;
+	u32 i2c_address;
+
+	/*
+	 * On older G5s the tas3004 is described by a deq node missing a
+	 * compatible definition, instead of a codec node with a
+	 * tas3004,code compatible property. Fix that up here.
+	 */
+	deq = call_prom("finddevice", 1, 1, ADDR("/ht@0,f2000000/pci@1/mac-io@7/i2c@18000/deq@6a"));
+	if (!PHANDLE_VALID(deq))
+		return;
+	/* Check for proper i2c-address. */
+	if (prom_getprop(deq, "i2c-address", &i2c_address, sizeof(i2c_address)) == PROM_ERROR)
+		return;
+	i2c_address = (i2c_address >> 1) & 0x7f;
+	if (i2c_address != 0x34 && i2c_address != 0x35)
+		return;
+
+	prom_printf("fixing up missing compatible for deq node...\n");
+
+	prom_setprop (deq, "/ht@0,f2000000/pci@1/mac-io@7/i2c@18000/deq@6a",
+		      "compatible", &RELOC("tas3004\0codec\0"),
+		      sizeof("tas3004\0codec\0"));
+}
+
+static void __init fixup_device_tree_pmac(void)
+{
+	fixup_device_tree_pmac_u3_i2c();
+	fixup_device_tree_pmac_deq();
+}
 #else
 #define fixup_device_tree_pmac()
 #endif
-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
