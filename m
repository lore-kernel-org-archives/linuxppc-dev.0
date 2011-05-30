Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5010B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 21:56:17 +1000 (EST)
Received: by wyg36 with SMTP id 36so2912126wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 04:56:09 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpic: support compiling with DEBUG enabled
Date: Mon, 30 May 2011 15:56:09 +0400
Message-Id: <1306756569-12912-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support compilation of mpic.c with DEBUG defined, as now we have irq_desc and
not irq number.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3a8de5b..3f995dc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -848,7 +848,7 @@ static void mpic_unmask_tm(struct irq_data *d)
 	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = virq_to_hw(d->irq) - mpic->timer_vecs[0];
 
-	DBG("%s: enable_tm: %d (tm %d)\n", mpic->name, irq, src);
+	DBG("%s: enable_tm: %d (tm %d)\n", mpic->name, d->irq, src);
 	mpic_tm_write(src, mpic_tm_read(src) & ~MPIC_VECPRI_MASK);
 	mpic_tm_read(src);
 }
-- 
1.7.4.4
