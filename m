Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1E6DDDF73
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m766nwht000053
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:49:59 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIW000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:49:57 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 3/6] powerpc: update QE/CPM2 headers for USB support
Date: Wed,  6 Aug 2008 15:04:42 +0800
Message-Id: <1218006285-27138-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006285-27138-2-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/immap_cpm2.h |    9 +++------
 arch/powerpc/include/asm/immap_qe.h   |    9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/immap_cpm2.h b/arch/powerpc/include/asm/immap_cpm2.h
index 4080bab..d4f069b 100644
--- a/arch/powerpc/include/asm/immap_cpm2.h
+++ b/arch/powerpc/include/asm/immap_cpm2.h
@@ -554,14 +554,11 @@ typedef struct usb_ctlr {
 	u8	usb_usadr;
 	u8	usb_uscom;
 	u8	res1[1];
-	u16	usb_usep1;
-	u16	usb_usep2;
-	u16	usb_usep3;
-	u16	usb_usep4;
+	__be16  usb_usep[4];
 	u8	res2[4];
-	u16	usb_usber;
+	__be16  usb_usber;
 	u8	res3[2];
-	u16	usb_usbmr;
+	__be16  usb_usbmr;
 	u8	usb_usbs;
 	u8	res4[7];
 } usb_cpm2_t;
diff --git a/arch/powerpc/include/asm/immap_qe.h b/arch/powerpc/include/asm/immap_qe.h
index 3c2fced..08d616a 100644
--- a/arch/powerpc/include/asm/immap_qe.h
+++ b/arch/powerpc/include/asm/immap_qe.h
@@ -215,10 +215,7 @@ struct usb_ctlr {
 	u8	usb_usadr;
 	u8	usb_uscom;
 	u8	res1[1];
-	__be16	usb_usep1;
-	__be16	usb_usep2;
-	__be16	usb_usep3;
-	__be16	usb_usep4;
+	__be16  usb_usep[4];
 	u8	res2[4];
 	__be16	usb_usber;
 	u8	res3[2];
@@ -472,8 +469,8 @@ extern phys_addr_t get_qe_base(void);
 
 static inline unsigned long immrbar_virt_to_phys(void *address)
 {
-	if ( ((u32)address >= (u32)qe_immr) &&
-			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
+	if (((u32)address >= (u32)qe_immr) &&
+			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)))
 		return (unsigned long)(address - (u32)qe_immr +
 				(u32)get_qe_base());
 	return (unsigned long)virt_to_phys(address);
-- 
1.5.5.1.248.g4b17
