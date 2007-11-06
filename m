Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 15999DDF35
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:05:09 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 2E51A1439B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:00 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09143-08 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:05:58 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 99E9E14399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:05:58 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 01/13] [POWERPC] Add 'model: ...' line to common
	show_cpuinfo()
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:04:55 +0100
Message-ID: <20071106200455.10913.40738.stgit@hekate.izotz.org>
In-Reply-To: <20071106200446.10913.29338.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
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

Print out 'model' property of '/' node as a machine name
in generic show_cpuinfo() routine.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Olof Johansson <olof@lixom.net>
---

 arch/powerpc/kernel/setup-common.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2de00f8..cb291f1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -165,6 +165,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned short min;
 
 	if (cpu_id == NR_CPUS) {
+		struct device_node *root;
+		const char *model = NULL;
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
 		unsigned long bogosum = 0;
 		int i;
@@ -176,6 +178,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
 		if (ppc_md.name)
 			seq_printf(m, "platform\t: %s\n", ppc_md.name);
+		root = of_find_node_by_path("/");
+		if (root)
+			model = of_get_property(root, "model", NULL);
+		of_node_put(root);
+		if (model)
+			seq_printf(m, "model\t\t: %s\n", model);
+
 		if (ppc_md.show_cpuinfo != NULL)
 			ppc_md.show_cpuinfo(m);
 
