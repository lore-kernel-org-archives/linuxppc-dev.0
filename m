Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19120B6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 01:08:07 +1000 (EST)
Received: by fxe23 with SMTP id 23so1317740fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 08:08:03 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4 1/2] ppc: enable scom access functions on Maple
Date: Wed, 29 Jun 2011 19:07:55 +0400
Message-Id: <1309360076-22579-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1309360076-22579-1-git-send-email-dbaryshkov@gmail.com>
References: <1309360076-22579-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable functions used to access SCOM if PPC_MAPLE is defined: they are
used by cpufreq driver to control hardware.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/kernel/misc_64.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index e89df59..616921e 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -339,7 +339,7 @@ _GLOBAL(real_205_writeb)
 #endif /* CONFIG_PPC_PASEMI */
 
 
-#ifdef CONFIG_CPU_FREQ_PMAC64
+#if defined(CONFIG_CPU_FREQ_PMAC64) || defined(CONFIG_CPU_FREQ_MAPLE)
 /*
  * SCOM access functions for 970 (FX only for now)
  *
@@ -408,7 +408,7 @@ _GLOBAL(scom970_write)
 	/* restore interrupts */
 	mtmsrd	r5,1
 	blr
-#endif /* CONFIG_CPU_FREQ_PMAC64 */
+#endif /* CONFIG_CPU_FREQ_PMAC64 || CONFIG_CPU_FREQ_MAPLE */
 
 
 /*
-- 
1.7.5.4
