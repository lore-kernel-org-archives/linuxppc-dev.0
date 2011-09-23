Return-Path: <xenidis@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 630B4B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 01:38:28 +1000 (EST)
Received: by yxk8 with SMTP id 8so3163822yxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 08:38:25 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc: Fix xmon for systems without MSR[RI]
Date: Fri, 23 Sep 2011 10:40:46 -0500
Message-Id: <1316792446-10599-1-git-send-email-jimix@pobox.com>
In-Reply-To: <1312838739-20660-1-git-send-email-jimix@pobox.com>
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
Cc: scottwood@freescale.com, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <dwg@au1.ibm.com>

Based on patch by David Gibson <dwg@au1.ibm.com>

xmon has a longstanding bug on systems which are SMP-capable but lack
the MSR[RI] bit.  In these cases, xmon invoked by IPI on secondary
CPUs will not properly keep quiet, but will print stuff, thereby
garbling the primary xmon's output.  This patch fixes it, by ignoring
the RI bit if the processor does not support it.

There's already a version of this for 4xx upstream, which we'll need
to extend to other RI-lacking CPUs at some point.  For now this adds
Book3e processors to the mix.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>

---
Restricted it to Book3e
---
 arch/powerpc/xmon/xmon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 42541bb..13f82f8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -340,8 +340,8 @@ int cpus_are_in_xmon(void)
 
 static inline int unrecoverable_excp(struct pt_regs *regs)
 {
-#ifdef CONFIG_4xx
-	/* We have no MSR_RI bit on 4xx, so we simply return false */
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOK3E)
+	/* We have no MSR_RI bit on 4xx or Book3e, so we simply return false */
 	return 0;
 #else
 	return ((regs->msr & MSR_RI) == 0);
-- 
1.7.0.4
