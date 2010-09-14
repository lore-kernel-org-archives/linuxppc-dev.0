Return-Path: <mfm@muteddisk.com>
Received: from qmta11.emeryville.ca.mail.comcast.net
	(qmta11.emeryville.ca.mail.comcast.net [76.96.27.211])
	by ozlabs.org (Postfix) with ESMTP id BA317B70A8
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 15:40:46 +1000 (EST)
From: matt mooney <mfm@muteddisk.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc: remove cast from void*
Date: Mon, 13 Sep 2010 22:32:21 -0700
Message-Id: <1284442341-11787-1-git-send-email-mfm@muteddisk.com>
Cc: xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unnecessary cast from void* in assignment.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index e19ff02..f106662 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -55,7 +55,7 @@ static void hc_stop(struct seq_file *m, void *p)
 static int hc_show(struct seq_file *m, void *p)
 {
 	unsigned long h_num = (unsigned long)p;
-	struct hcall_stats *hs = (struct hcall_stats *)m->private;
+	struct hcall_stats *hs = m->private;
 
 	if (hs[h_num].num_calls) {
 		if (cpu_has_feature(CPU_FTR_PURR))
-- 
1.7.2.1
