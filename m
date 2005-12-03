Return-Path: <otavio@debian.org>
Received: from covilha.procergs.com.br (covilha.procergs.com.br
	[200.198.128.244]) by ozlabs.org (Postfix) with ESMTP id 8DDEB6884B
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 05:34:25 +1100 (EST)
In-Reply-To: 
Date: Sat, 3 Dec 2005 16:34:19 -0200
Message-Id: <11336348593561-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org,  akpm@osdl.org
From: Otavio Salvador <otavio@debian.org>
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH] arch/ppc/kernel/idle.c: don't declare cpu variable in
	non-SMP kernels
Reply-To: Otavio Salvador <otavio@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disable declaration of cpu variable in default_idle function when
building non-SMP kernels.

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

 arch/ppc/kernel/idle.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 06378a021f5873003a07f0388aa0cb6e81a32c19
156ff805b4408c6831c7840c1ed1fe3d148bc3c8
diff --git a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
index 821a75e..b23a979 100644
--- a/arch/ppc/kernel/idle.c
+++ b/arch/ppc/kernel/idle.c
@@ -37,7 +37,9 @@
 void default_idle(void)
 {
 	void (*powersave)(void);
+#ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
+#endif
 
 	powersave = ppc_md.power_save;
 
---
0.99.9k
