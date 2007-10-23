Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 41385DDF6B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:13:33 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id D55A814311
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:33 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08109-02 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:13:32 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id BA7F8142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:32 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to common
	show_cpuinfo()
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:13:09 +0200
Message-ID: <20071023231309.29359.20887.stgit@hekate.izotz.org>
In-Reply-To: <20071023231302.29359.27417.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Print out '/model' property as a machine name in generic
show_cpuinfo() routine.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/kernel/setup-common.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2de00f8..1aa0733 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -165,6 +165,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned short min;
 
 	if (cpu_id == NR_CPUS) {
+		struct device_node *root;
+		const char *model = "";
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
 		unsigned long bogosum = 0;
 		int i;
@@ -176,6 +178,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
 		if (ppc_md.name)
 			seq_printf(m, "platform\t: %s\n", ppc_md.name);
+		root = of_find_node_by_path("/");
+		if (root)
+			model = of_get_property(root, "model", NULL);
+		of_node_put(root);
+		seq_printf(m, "machine\t\t: %s\n", model);
+
 		if (ppc_md.show_cpuinfo != NULL)
 			ppc_md.show_cpuinfo(m);
 
