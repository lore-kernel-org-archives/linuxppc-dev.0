Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 663C8B7131
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:07 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J72Ho005845
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:03 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/11] powerpc: Fix compile error with paca code on ppc64e
Date: Fri,  8 Oct 2010 14:06:47 -0500
Message-Id: <1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/paca.c: In function 'allocate_lppacas':
arch/powerpc/kernel/paca.c:111:1: error: parameter name omitted
arch/powerpc/kernel/paca.c:111:1: error: parameter name omitted

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/paca.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 1e068a4..cefc0df 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -108,7 +108,7 @@ static void free_lppacas(void)
 
 #else
 
-static inline void allocate_lppacas(int, unsigned long) { }
+static inline void allocate_lppacas(int nr_cpus, unsigned long limit) { }
 static inline void free_lppacas(void) { }
 
 #endif /* CONFIG_PPC_BOOK3S */
-- 
1.7.2.3
