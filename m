Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNJ2KCvzF205
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:04 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id t6so18519563wmt.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:04 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 13/19] powerpc/52xx: Add missing functions prototypes
Date: Thu, 22 Mar 2018 21:19:59 +0100
Message-Id: <20180322202007.23088-14-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function prototypes were declared within a `#ifdef CONFIG_PPC_LITE5200`
block which would prevent them from being visible when compiling
`mpc52xx_pm.c`. Move the prototypes outside of the `#ifdef` block to fix
the following warnings treated as errors with W=1:

  arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: no previous prototype for ‘mpc52xx_pm_prepare’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/52xx/mpc52xx_pm.c:113:5: error: no previous prototype for ‘mpc52xx_pm_enter’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/52xx/mpc52xx_pm.c:181:6: error: no previous prototype for ‘mpc52xx_pm_finish’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/mpc52xx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index e94cede14522..0f6b3cbb119f 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -350,14 +350,14 @@ extern struct mpc52xx_suspend mpc52xx_suspend;
 extern int __init mpc52xx_pm_init(void);
 extern int mpc52xx_set_wakeup_gpio(u8 pin, u8 level);
 
-#ifdef CONFIG_PPC_LITE5200
-extern int __init lite5200_pm_init(void);
-
 /* lite5200 calls mpc5200 suspend functions, so here they are */
 extern int mpc52xx_pm_prepare(void);
 extern int mpc52xx_pm_enter(suspend_state_t);
 extern void mpc52xx_pm_finish(void);
 extern char saved_sram[0x4000]; /* reuse buffer from mpc52xx suspend */
+
+#ifdef CONFIG_PPC_LITE5200
+extern int __init lite5200_pm_init(void);
 #endif
 #endif /* CONFIG_PM */
 
-- 
2.11.0
