Return-Path: <mfm@muteddisk.com>
Received: from qmta02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id DBAD8B70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 12:06:10 +1000 (EST)
From: matt mooney <mfm@muteddisk.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 2/3 RESEND] powerpc: remove cast from void*
Date: Mon, 27 Sep 2010 19:04:44 -0700
Message-Id: <f7d601da574581e9dfdc1314a969475c73491c00.1285638395.git.mfm@muteddisk.com>
In-Reply-To: <cover.1285638395.git.mfm@muteddisk.com>
References: <cover.1285638395.git.mfm@muteddisk.com>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
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
