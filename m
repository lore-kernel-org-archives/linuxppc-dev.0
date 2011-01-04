Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 5FD8BB70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 18:30:11 +1100 (EST)
Received: by fxm5 with SMTP id 5so13190239fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 23:30:08 -0800 (PST)
MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Mon, 3 Jan 2011 23:29:47 -0800
Message-ID: <AANLkTikTWejPTTS1Xt6mk86u=_HKSX==Y=d2iyqKFb8m@mail.gmail.com>
Subject: [PATCH] RapidIO: Fix hang on RapidIO doorbell queue full condition
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In fsl_rio_dbell_handler, the code currently simply acknowledges the QFI queue
full interrupt, but does nothing to resolve the queue full condition.  Instead,
it jumps to the end of the isr.  When a queue full condition occurs, the isr is
then re-entered immediately and continually, forever.

The fix is to just fall through and read out current doorbell entries.

Tested against 2.6.26-rc8 on a p2020

Signed-off-by: Thomas Taranowski <tom@baringforge.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 9725369..9f99bef 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -973,7 +973,6 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
        if (dsr & DOORBELL_DSR_QFI) {
                pr_info("RIO: doorbell queue full\n");
                out_be32(&priv->msg_regs->dsr, DOORBELL_DSR_QFI);
-               goto out;
        }

        /* XXX Need to check/dispatch until queue empty */
-- 
1.7.0.4


Thomas Taranowski
Certified netburner consultant
baringforge.com
