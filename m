Return-Path: <npalix@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5EBD8DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 21:25:12 +1100 (EST)
From: Nicolas Palix <npalix@diku.dk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/powermac: Add missing of_node_put
Date: Wed, 3 Dec 2008 11:25:03 +0100
References: <200812021445.18670.npalix@diku.dk>
	<20081203101901.4f317425.sfr@canb.auug.org.au>
	<20081203102508.ce955781.sfr@canb.auug.org.au>
In-Reply-To: <20081203102508.ce955781.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812031125.03478.npalix@diku.dk>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Julia Lawall <julia@diku.dk>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

I fix the patch. I also change the "vias == 0" in "vias == NULL".
Is "!vias" better ?

On Wednesday 03 December 2008 00:25:08 Stephen Rothwell wrote:
> Hi Nicolas,
> 
> On Wed, 3 Dec 2008 10:19:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I think this particular patch is also required against Linus' kernel (not
> > just linux-next).
> 
> In fact, I think all these patches can apply to Linus' current tree.
> 
Signed-off-by: Nicolas Palix <npalix@diku.dk>
Signed-off-by: Julia Lawall <julia@diku.dk>
---
 arch/powerpc/platforms/powermac/pci.c  |    2 +
 arch/powerpc/platforms/powermac/time.c |   11 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index bcf50d7..800fcce 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -661,6 +661,7 @@ static void __init init_second_ohare(void)
 			pci_find_hose_for_OF_device(np);
 		if (!hose) {
 			printk(KERN_ERR "Can't find PCI hose for OHare2 !\n");
+			of_node_put(np);
 			return;
 		}
 		early_read_config_word(hose, bus, devfn, PCI_COMMAND, &cmd);
@@ -669,6 +670,7 @@ static void __init init_second_ohare(void)
 		early_write_config_word(hose, bus, devfn, PCI_COMMAND, cmd);
 	}
 	has_second_ohare = 1;
+	of_node_put(np);
 }
 
 /*
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 59eb840..1810e42 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -265,12 +265,15 @@ int __init via_calibrate_decr(void)
 	struct resource rsrc;
 
 	vias = of_find_node_by_name(NULL, "via-cuda");
-	if (vias == 0)
+	if (vias == NULL)
 		vias = of_find_node_by_name(NULL, "via-pmu");
-	if (vias == 0)
+	if (vias == NULL)
 		vias = of_find_node_by_name(NULL, "via");
-	if (vias == 0 || of_address_to_resource(vias, 0, &rsrc))
+	if (vias == NULL || of_address_to_resource(vias, 0, &rsrc)) {
+	        of_node_put(vias);
 		return 0;
+	}
+	of_node_put(vias);
 	via = ioremap(rsrc.start, rsrc.end - rsrc.start + 1);
 	if (via == NULL) {
 		printk(KERN_ERR "Failed to map VIA for timer calibration !\n");
@@ -297,7 +300,7 @@ int __init via_calibrate_decr(void)
 	ppc_tb_freq = (dstart - dend) * 100 / 6;
 
 	iounmap(via);
-	
+
 	return 1;
 }
 #endif
-- 
Nicolas Palix
