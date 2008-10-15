Return-Path: <roel.kluin@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 76BE2DE8A9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 05:36:36 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1741224fga.39
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:36:34 -0700 (PDT)
Message-ID: <48F53B0F.5010301@gmail.com>
Date: Tue, 14 Oct 2008 20:36:31 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] unsigned speed cannot be negative
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

unsigned speed cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
N.B. It could be possible that a different fix is needed.

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index cb01ebc..7b7da8c 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -142,7 +142,7 @@ unsigned int udbg_probe_uart_speed(void __iomem *comport, unsigned int clock)
 	speed = (clock / prescaler) / (divisor * 16);
 
 	/* sanity check */
-	if (speed < 0 || speed > (clock / 16))
+	if (speed > (clock / 16))
 		speed = 9600;
 
 	return speed;
