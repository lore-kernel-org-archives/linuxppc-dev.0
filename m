Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D70F568734
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:07:34 +1100 (EST)
Date: Thu, 17 Nov 2005 17:05:02 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <Pine.LNX.4.44.0511171704240.15752-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dave@cray.com, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc: Fix MPC83xx device table
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The SVRs for MPC8343/E where incorrect and really the SVRs
for MPC8347/E.

Signed-off-by: David Updegraff <dave@cray.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 6eba85c696e0a0fef59435bd641110a759b308ab
tree 0f2393d85f4f225793508a321460c74579c9d834
parent 5b45c04aa9d209ba1a71ff8061fda9ae3979ddd6
author Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:06:02 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:06:02 -0600

 arch/ppc/syslib/mpc83xx_sys.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
index a152398..82cf3ab 100644
--- a/arch/ppc/syslib/mpc83xx_sys.c
+++ b/arch/ppc/syslib/mpc83xx_sys.c
@@ -69,9 +69,33 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		},
 	},
 	{
-		.ppc_sys_name	= "8343E",
+		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80540000,
+		.num_devices	= 9,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+		},
+	},
+	{
+		.ppc_sys_name	= "8347",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80550000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+		},
+	},
+	{
+		.ppc_sys_name	= "8343E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80560000,
 		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
@@ -83,7 +107,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 	{
 		.ppc_sys_name	= "8343",
 		.mask 		= 0xFFFF0000,
-		.value 		= 0x80550000,
+		.value 		= 0x80570000,
 		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{
