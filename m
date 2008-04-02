Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC804DE0C2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 03:55:17 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org,
	grant.likely@secretlab.ca
Subject: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart 16550.
Date: Wed,  2 Apr 2008 09:52:14 -0700
In-Reply-To: <12071551351007-git-send-email-john.linn@xilinx.com>
References: <12071551351007-git-send-email-john.linn@xilinx.com>
Message-Id: <20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Xilinx 16550 uart core is not a standard 16550 because it uses
word-based addressing rather than byte-based adressing. With
additional properties it is compatible with the open firmware
'ns16550' compatible binding.

This code updates the ns16550 driver to use the reg-offset property
so that the Xilinx UART 16550 can be used with it. The reg-shift
was already being handled.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/boot/ns16550.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..da9d2c2 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 {
 	int n;
 	unsigned long reg_phys;
+	u32 reg_offset;
 
 	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
 	if (n != sizeof(reg_base)) {
@@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 		reg_base = (void *)reg_phys;
 	}
 
+	n = getprop(devp, "reg-offset", &reg_offset, sizeof(reg_offset));
+	if (n == sizeof(reg_offset))
+		reg_base += reg_offset;
+
 	n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
 	if (n != sizeof(reg_shift))
 		reg_shift = 0;
-- 
1.5.2.1
