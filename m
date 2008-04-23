Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D301FDDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:25:51 +1000 (EST)
Message-ID: <480FB766.1040405@tiscali.nl>
Date: Thu, 24 Apr 2008 00:25:42 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH 2/2 v2] mpic_u3msi: mpic_u3msi: failed allocation unnoticed
References: <480F6905.3070808@tiscali.nl> <480F8754.7000200@tiscali.nl>
	<df21920e067e73985f73047e2d8bcbda@kernel.crashing.org>
In-Reply-To: <df21920e067e73985f73047e2d8bcbda@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may
>> return -ENOMEM, but hwirq of type irq_hw_number_t which is unsigned.
> 
>>      list_for_each_entry(entry, &pdev->msi_list, list) {
>>          hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
>> -        if (hwirq < 0) {
>> +        if (hwirq == -ENOMEM) {

> 
> Please test for _all_ error values, instead.
>
> Segher

In this case -ENOMEM was _all_ error values, but I get your point.
---
bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may return
signed, but hwirq is unsigned. A failed allocation remains unnoticed.

diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 1d5a408..e790f39 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -115,14 +115,16 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	u64 addr;
+	int ret;
 
 	addr = find_ht_magic_addr(pdev);
 	msg.address_lo = addr & 0xFFFFFFFF;
 	msg.address_hi = addr >> 32;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
-		if (hwirq < 0) {
+		ret = mpic_msi_alloc_hwirqs(msi_mpic, 1);
+		hwirq = ret;
+		if (ret < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");
 			return hwirq;
 		}
