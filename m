Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 712DADDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 23:46:58 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id D36D78817
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:46:56 +0500 (SAMST)
Date: Tue, 2 Oct 2007 17:48:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] [POWERPC] mpc8568mds.dts: fix PCIe I/O address space
	location and size
Message-ID: <20071002134807.GC19476@localhost.localdomain>
References: <20071002134535.GA17913@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071002134535.GA17913@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to u-boot/board/mpc8568mds/init.S:

LAW(Local Access Window) configuration:
2)   0xa000_0000   0xbfff_ffff     PCIe MEM                512MB
4)   0xe280_0000   0xe2ff_ffff     PCIe I/O                8M

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index a177dd0..39ec3c2 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -226,8 +226,8 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <1a 2>;
 			bus-range = <0 ff>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 08000000>;
+			ranges = <02000000 0 a0000000 a0000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
 			clock-frequency = <1fca055>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
-- 
1.5.0.6
