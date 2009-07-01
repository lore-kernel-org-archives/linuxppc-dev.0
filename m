Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6932FB70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:00:00 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3EBE3DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 06:59:59 +1000 (EST)
Date: Thu, 2 Jul 2009 00:59:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
Message-ID: <20090701205957.GA9583@oksana.dev.rtsoft.ru>
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090701194819.GB20522@ovro.caltech.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes various badnesses like this for all interrupt
controllers:

------------[ cut here ]------------
Badness at c04db9dc [verbose debug info unavailable]
NIP: c04db9dc LR: c04db9ac CTR: 00000000
REGS: c053de30 TRAP: 0700   Not tainted  (2.6.31-rc1-00432-ge69b2b5-dirty)
MSR: 00021000 <ME,CE>  CR: 22020084  XER: 00000000
TASK = c0500480[0] 'swapper' THREAD: c053c000
GPR00: 00000001 c053dee0 c0500480 00000000 00000050 00000020 3fffffff 00000000
GPR08: 00000001 c0540000 e0080080 00000000 22000084 64183600 3ff8f800 00000000
GPR16: 841b0240 449a0303 00000000 00000000 00000000 00000000 00000000 c04f5bf4
GPR24: 00000000 00000000 00000000 00000050 00000020 00000000 3fffffff 00000050
NIP [c04db9dc] alloc_arch_preferred_bootmem+0x48/0x74
LR [c04db9ac] alloc_arch_preferred_bootmem+0x18/0x74
Call Trace:
[c053dee0] [c000a5a4] __of_address_to_resource+0x44/0xd0 (unreliable)
[c053def0] [c04dba58] ___alloc_bootmem_nopanic+0x50/0x108
[c053df20] [c04dbb28] ___alloc_bootmem+0x18/0x50
[c053df30] [c04d5de0] qe_ic_init+0x5c/0x1b0
[c053df70] [c04d77b0] mpc85xx_mds_pic_init+0xb8/0x10c
[c053dfb0] [c04cf374] init_IRQ+0x28/0x3c

p.s. commit 85355bb272db31a3f2dd99d547eef794805e1319 ("powerpc: Fix
mpic alloc warning") missed some alloc_bootmem() instances, this is
now fixed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Wed, Jul 01, 2009 at 12:48:19PM -0700, Ira Snyder wrote:
[...]
> > [    0.000000] [c0489e60] [c043db98] ___alloc_bootmem_nopanic+0x54/0x108
> > [    0.000000] [c0489ea0] [c043de9c] ___alloc_bootmem+0x18/0x50
> > [    0.000000] [c0489eb0] [c0432a74] mpic_alloc+0x44/0x6d0
> > [    0.000000] [c0489f00] [c04333d4] pmac_setup_one_mpic+0xf4/0x124
> > [    0.000000] [c0489f40] [c04334e8] pmac_pic_init+0xe4/0x55c
> > [    0.000000] [c0489f90] [c042a618] init_IRQ+0x24/0x34
> > [    0.000000] [c0489fa0] [c04278e0] start_kernel+0x254/0x3a0
> > [    0.000000] [c0489ff0] [000034f4] 0x34f4
> > [    0.000000] Instruction dump:
> > [    0.000000] 38600000 409e0018 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c050
> > [    0.000000] 3929f260 80090004 7c000034 5400d97e <0f000000> 2f800000 409e0018 38800000
> > [    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
> > [    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
> > [    0.000000] mpic: Initializing for 64 sources
> > [    0.000000] irq: irq 55 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 55
> > 
> 
> I've been seeing a similar warning on my 83xx system. Here's the
> relevant output:
> 
[...]
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] Badness at /home/iws/devel/linux-2.6/mm/bootmem.c:535
> [    0.000000] NIP: c02baa68 LR: c02baa4c CTR: 00000000
> [    0.000000] REGS: c0305e50 TRAP: 0700   Not tainted  (2.6.31-rc1-00275-g9ea6fce)
> [    0.000000] MSR: 00021032 <ME,CE,IR,DR>  CR: 22022024  XER: 00000000
> [    0.000000] TASK = c02d5428[0] 'swapper' THREAD: c0304000
> [    0.000000] GPR00: 00000001 c0305f00 c02d5428 00000000 00000008 00000020 3fffffff 00000000 
> [    0.000000] GPR08: c0305ec0 c0340000 e0000700 00000000 22042024 00000000 0fffd000 00000000 
> [    0.000000] GPR16: 0fff2d28 0fff6d48 00000000 00000000 00000000 00000000 c02ce22c c02ce210 
> [    0.000000] GPR24: 00000000 00000008 00000020 cfffff28 c0310000 00000000 3fffffff 00000008 
> [    0.000000] NIP [c02baa68] alloc_arch_preferred_bootmem+0x34/0x70
> [    0.000000] LR [c02baa4c] alloc_arch_preferred_bootmem+0x18/0x70
> [    0.000000] Call Trace:
> [    0.000000] [c0305f00] [cfffff28] 0xcfffff28 (unreliable)
> [    0.000000] [c0305f10] [c02bb2b4] ___alloc_bootmem_nopanic+0x54/0x104
> [    0.000000] [c0305f50] [c02bb4d0] ___alloc_bootmem+0x18/0x50
> [    0.000000] [c0305f60] [c02b84c4] ipic_init+0x40/0x180
[...]
> The warning is caused by the slab allocator being available much earlier
> in the boot process. The following (untested!) patch should fix it for
> my board. A similar patch to arch/powerpc/sysdev/mpic.c would fix the
> error as well.

qe_ic is in the same boat, just as every other PIC controller. Heh..
doing some 'grep alloc_bootmem', it seems that there are pretty
much offenders. Let's fix them?

 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |    2 +-
 arch/powerpc/sysdev/ipic.c                   |    4 +---
 arch/powerpc/sysdev/mpic.c                   |    9 ++++-----
 arch/powerpc/sysdev/qe_lib/qe_ic.c           |    4 +---
 arch/powerpc/sysdev/uic.c                    |    3 +--
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index ddf0bdc..7ee979f 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -147,7 +147,7 @@ int __init pq2ads_pci_init_irq(void)
 		goto out;
 	}
 
-	priv = alloc_bootmem(sizeof(struct pq2ads_pci_pic));
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		of_node_put(np);
 		ret = -ENOMEM;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index a86d3ce..69e2630 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -728,12 +728,10 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	if (ret)
 		return NULL;
 
-	ipic = alloc_bootmem(sizeof(struct ipic));
+	ipic = kzalloc(sizeof(*ipic), GFP_KERNEL);
 	if (ipic == NULL)
 		return NULL;
 
-	memset(ipic, 0, sizeof(struct ipic));
-
 	ipic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,
 				       &ipic_host_ops, 0);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d46de1f..3981ae4 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -508,9 +508,8 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Setting up HT PICs workarounds for U3/U4\n");
 
 	/* Allocate fixups array */
-	mpic->fixups = alloc_bootmem(128 * sizeof(struct mpic_irq_fixup));
+	mpic->fixups = kzalloc(128 * sizeof(*mpic->fixups), GFP_KERNEL);
 	BUG_ON(mpic->fixups == NULL);
-	memset(mpic->fixups, 0, 128 * sizeof(struct mpic_irq_fixup));
 
 	/* Init spinlock */
 	spin_lock_init(&mpic->fixup_lock);
@@ -1109,9 +1108,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			psize /= 4;
 			bits = intvec_top + 1;
 			mapsize = BITS_TO_LONGS(bits) * sizeof(unsigned long);
-			mpic->protected = alloc_bootmem(mapsize);
+			mpic->protected = kzalloc(mapsize, GFP_KERNEL);
 			BUG_ON(mpic->protected == NULL);
-			memset(mpic->protected, 0, mapsize);
 			for (i = 0; i < psize; i++) {
 				if (psrc[i] > intvec_top)
 					continue;
@@ -1353,7 +1351,8 @@ void __init mpic_init(struct mpic *mpic)
 
 #ifdef CONFIG_PM
 	/* allocate memory to save mpic state */
-	mpic->save_data = alloc_bootmem(mpic->num_sources * sizeof(struct mpic_irq_save));
+	mpic->save_data = kmalloc(mpic->num_sources * sizeof(*mpic->save_data),
+				  GFP_KERNEL);
 	BUG_ON(mpic->save_data == NULL);
 #endif
 }
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 63cdf98..074905c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -333,12 +333,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 	if (ret)
 		return;
 
-	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
+	qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);
 	if (qe_ic == NULL)
 		return;
 
-	memset(qe_ic, 0, sizeof(struct qe_ic));
-
 	qe_ic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
 	if (qe_ic->irqhost == NULL)
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index d35405c..466ce9a 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -258,11 +258,10 @@ static struct uic * __init uic_init_one(struct device_node *node)
 
 	BUG_ON(! of_device_is_compatible(node, "ibm,uic"));
 
-	uic = alloc_bootmem(sizeof(*uic));
+	uic = kzalloc(sizeof(*uic), GFP_KERNEL);
 	if (! uic)
 		return NULL; /* FIXME: panic? */
 
-	memset(uic, 0, sizeof(*uic));
 	spin_lock_init(&uic->lock);
 	indexp = of_get_property(node, "cell-index", &len);
 	if (!indexp || (len != sizeof(u32))) {
-- 
1.6.3.3
