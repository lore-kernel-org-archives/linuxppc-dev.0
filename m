Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GcZZ1hvYzF1pK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:12:38 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id u189so386755wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:12:37 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/19] powerpc/52xx: Add missing functions prototypes
Date: Wed,  4 Apr 2018 22:12:30 +0200
Message-Id: <20180404201230.27756-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-14-malat@debian.org>
References: <20180322202007.23088-14-malat@debian.org>
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

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/include/asm/mpc52xx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index e94cede14522..ce1e0aabaa64 100644
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
+int __init lite5200_pm_init(void);
 #endif
 #endif /* CONFIG_PM */
 
-- 
2.11.0
