Return-Path: <timur@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 8869DB70A8
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 08:53:40 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can reference
	it
Date: Fri, 17 Sep 2010 17:53:27 -0500
Message-ID: <1284764008-19469-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
watchdog driver) can use it.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This export is necessary for the Book-E watchdog driver to be compiled as a
module.  Since ppc_proc_freq is already exported, I figured it's okay for
ppc_tb_freq to be exported as well.

 arch/powerpc/kernel/time.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8533b3b..49aa130 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -163,6 +163,7 @@ static long timezone_offset;
 unsigned long ppc_proc_freq;
 EXPORT_SYMBOL(ppc_proc_freq);
 unsigned long ppc_tb_freq;
+EXPORT_SYMBOL(ppc_tb_freq);
 
 static DEFINE_PER_CPU(u64, last_jiffy);
 
-- 
1.7.2.3
