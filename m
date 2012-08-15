Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 039AB2C0162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 19:25:36 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>
Subject: [PATCH V7 2/3] powerpc/ge_imp3a: Add ISA node to PCI primary bus
Date: Wed, 15 Aug 2012 16:57:05 +0800
Message-ID: <1345021026-10886-3-git-send-email-B38951@freescale.com>
In-Reply-To: <1345021026-10886-1-git-send-email-B38951@freescale.com>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI primary bus will be determined by looking for ISA node in device tree.
Also for board ge_imp3a primary bus is the second PCI controller detected.
So we add ISA node to ge_imp3a's device tree to fit the new determination.

Adding ISA node to other boards' device tree is not necessary. The situation
that the first bus is primary have already been handled. Please refer to the
following patch:
powerpc/pci: Make sure ISA IO base is not zero

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/ge_imp3a.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/ge_imp3a.dts b/arch/powerpc/boot/dts/ge_imp3a.dts
index fefae41..aa2c4b5 100644
--- a/arch/powerpc/boot/dts/ge_imp3a.dts
+++ b/arch/powerpc/boot/dts/ge_imp3a.dts
@@ -248,6 +248,10 @@
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
 				  0x0 0x10000>;
+
+			isa@1e {
+				device_type = "isa";
+			};
 		};
 	};
 };
-- 
1.7.5.1
