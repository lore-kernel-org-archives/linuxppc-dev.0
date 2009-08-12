Return-Path: <Paul.Gortmaker@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 215D6B7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 01:08:47 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 70D6EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 01:08:45 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id n7CDYrsi025222
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 06:34:53 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] Fix incorrect PCI interrupt map in SBC834x DTS
Date: Wed, 12 Aug 2009 09:34:30 -0400
Message-Id: <764194b0524e1baccb737668f5aeb198989ac2d1.1250036189.git.paul.gortmaker@windriver.com>
In-Reply-To: <22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
	<22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
In-Reply-To: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
References: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liang Li <liang.li@windriver.com>

Allows interrupts to occur on the sbc834x. Currently PCI devices
get assigned an incorrect IRQ and so the interrupt count never
increases. This was tested with the 82546GB based dual port E1000
PCI-X NIC which uses two distinct IRQ lines on the one card.

root@localhost:/root> cat /proc/interrupts | grep eth
17:         78   IPIC   Level     eth1
48:      27121   IPIC   Level     eth0

Signed-off-by: Liang Li <liang.li@windriver.com>
Signed-off-by: Yang Shi <yang.shi@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index b83036a..0dc90f9 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -310,10 +310,10 @@
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 23 0x8>;
+				 0x8800 0x0 0x0 0x1 &ipic 48 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 17 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 18 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 19 0x8>;
 
 		interrupt-parent = <&ipic>;
 		interrupts = <0x42 0x8>;
-- 
1.6.3.3
