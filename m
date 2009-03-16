Return-Path: <a.beregalov@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by ozlabs.org (Postfix) with ESMTP id 90217DDEEA
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 03:18:05 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id j2so2490366tid.13
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:18:03 -0700 (PDT)
Date: Mon, 16 Mar 2009 19:17:51 +0300
From: Alexander Beregalov <a.beregalov@gmail.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org
Subject: [PATCH next] powerpc/5200: fix building GPT driver without sysfs
Message-ID: <20090316161751.GA3622@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_create_attribs':
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:373: error: parameter name omitted
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:373: warning: 'return' with a value, in function returning void

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index cb038dc..ef81cce 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -370,7 +370,7 @@ static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt)
 }

 #else /* defined(CONFIG_SYSFS) */
-static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
+static inline void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt) {}
 #endif /* defined(CONFIG_SYSFS) */

 /* ---------------------------------------------------------------------
