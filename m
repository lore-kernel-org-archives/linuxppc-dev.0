Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E93D2DDE29
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:32:50 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 791038810
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 19:32:49 +0500 (SAMST)
Date: Tue, 25 Sep 2007 18:34:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] [POWERPC] QE pario: support for MPC85xx layout
Message-ID: <20070925143440.GD5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070925143126.GA30013@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

8 bytes padding required to match MPC85xx registers layout.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_io.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index e32b45b..d566e89 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -36,6 +36,9 @@ struct port_regs {
 	__be32	cpdir2;		/* Direction register */
 	__be32	cppar1;		/* Pin assignment register */
 	__be32	cppar2;		/* Pin assignment register */
+#ifdef CONFIG_MPC85xx
+	u8	pad[8];
+#endif
 };
 
 static struct port_regs *par_io = NULL;
-- 
1.5.0.6
