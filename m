Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62042B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 03:39:29 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B2130DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 03:39:28 +1000 (EST)
Date: Wed, 1 Jul 2009 21:39:25 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Don't scan for TBI PHY addresses on
	MPC8569E-MDS boards
Message-ID: <20090701173925.GA22134@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes (e.g. when there are no UEMs attached to a board)
fsl_pq_mdio_find_free() fails to find a spare address for a TBI PHY,
this is because get_phy_id() returns bogus 0x0000ffff values
(0xffffffff is expected), and therefore mdio bus probing fails with
the following message:

  fsl-pq_mdio: probe of e0082120.mdio failed with error -16

And obviously ethernet doesn't work after this.

This patch solves the problem by adding tbi-phy node into mdio node,
so that we won't scan for spare addresses, we'll just use a fixed one.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 2577f37..baa4ac7 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -502,6 +502,10 @@
 				reg = <0x6>;
 				device_type = "ethernet-phy";
 			};
+			tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 		mdio@3520 {
 			#address-cells = <1>;
-- 
1.6.3.3
