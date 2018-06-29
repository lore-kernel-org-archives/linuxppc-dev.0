Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HQlp6TQlzF1nL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 04:53:42 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id n2-v6so4363847pgq.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 11:53:42 -0700 (PDT)
Date: Fri, 29 Jun 2018 11:53:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Anatolij Gustschin <agust@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180629185339.GA37582@beast>
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
adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 31d3515672f3..b23da85fa73c 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
 	u32 intr_main_mask;
 	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
 	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
-	char saved_0x500[mpc52xx_ds_cached_size];
+	char saved_0x500[256];
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
