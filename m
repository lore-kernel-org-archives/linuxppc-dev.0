Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03118DDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:52 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 02/20] bootwrapper: Set timebase_period_ns from
	dt_fixup_cpu_clocks.
Message-ID: <20070820173945.GA30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This lets udelay() work properly on platforms which use dt_fixup_cpu_clocks.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |    2 ++
 arch/powerpc/boot/ops.h     |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index c995155..ae8b886 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -74,6 +74,8 @@ void dt_fixup_cpu_clocks(u32 cpu, u32 tb, u32 bus)
 		if (bus > 0)
 			setprop_val(devp, "bus-frequency", bus);
 	}
+
+	timebase_period_ns = 1000000000 / tb;
 }
 
 void dt_fixup_clock(const char *path, u32 freq)
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 8607706..aebd6ed 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -191,4 +191,6 @@ static inline void exit(void)
 	static char _bss_stack[size]; \
 	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
 
+extern unsigned long timebase_period_ns;
+
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
1.5.0.3
