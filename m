Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9B50DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 22:34:52 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Run sbc310 USB fixup code only on the
	appropriate platform.
To: linuxppc-dev@ozlabs.org
Date: Fri, 13 Mar 2009 11:35:08 +0000
Message-ID: <20090313113258.6583.64155.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch to limit NEC fixup to SBC310, following similar patch to SBC610 by Tony Breeds: 368a12117dd8abf6eaefa37c21ac313b517128b9

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

Hi Kumar, 

The sbc310 patches have been added to your next tree. This patch is
needed to stop the same problem occuring as occured with the sbc610.

 arch/powerpc/platforms/86xx/gef_sbc310.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 0f20172..ba3ce43 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -153,6 +153,10 @@ static void __init gef_sbc310_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
+	/* Do not do the fixup on other platforms! */
+	if (!machine_is(gef_sbc310))
+		return;
+
 	printk(KERN_INFO "Running NEC uPD720101 Fixup\n");
 
 	/* Ensure only ports 1 & 2 are enabled */
