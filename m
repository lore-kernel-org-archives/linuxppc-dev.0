Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KBgt1PHrzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 01:56:26 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j3-v6so7703860pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 08:56:26 -0700 (PDT)
Date: Mon, 2 Jul 2018 08:56:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180702155621.GA16047@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a stack size large enough for the saved routine and
adds a sanity check making sure the routine doesn't overflow into the
0x600 exception handler.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use "0x600-0x500" for size calculation to illustrate handler sizes
---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 31d3515672f3..b1d208ded981 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
 	u32 intr_main_mask;
 	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
 	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
-	char saved_0x500[mpc52xx_ds_cached_size];
+	char saved_0x500[0x600-0x500];
+
+	if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
+		return -ENOMEM;
 
 	/* disable all interrupts in PIC */
 	intr_main_mask = in_be32(&intr->main_mask);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
