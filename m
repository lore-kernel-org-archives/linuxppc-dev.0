Return-Path: <linuxppc-dev+bounces-29657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0FCCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 15:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j72Zt1t9wz2xST;
	Mon, 19 Oct 2026 02:26:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792337190;
	cv=none; b=Hi73J2mASRpfd6ysEdEp58/SaULNoTcifK7PYPwAgmNXjbcDRNMcgtT5PXx4DbfIAkb880Uw14qhxmAlfkKQj8TsZuwps+sUSlPsLuZoYNBixtP4RoqjMrTWA3/dr5BdDlD+lrxiT72fKKYBBlTrgA1t+uqjpdJ3wfEVtkBCp5/UpEDYpdqxfihOrrAMy7pMqANpU1RuwG6XF2lLAE1ukjHzIxVR+RYyNNTx0L6wtiPzGi/eWRNSUNhqNT6I/yY0zg0l9hJHx4CklChctg8pXHwSYlQ9pXOutoDYuutNxu/DzUhN4ruJ8mRimANQrrsoaEQlq3UuBdvwsP3DmIIHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792337190; c=relaxed/relaxed;
	bh=whoUjQfO/MaEvOa7tAljG49R0UiUJE6SLq9r+UfLh/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuUpQ1obCofTxrRYbMzseQM1BuqRPqbVLIR/ZCJzpUrF+4psuburqY8ZpG3P8RQ5mdEaLwKw6K665Rl3Dbr6oJKN45SFxMnqyVH/Sg3TSL+1ONhaxKVU9Zy/wTDuYeG+12T9gKBofNROzXHSYzP2sqK7o3WoJdJt3EKV+eMtXsyVa2q/hXwhX/v/b/Szkaxt9Hdk1TL3aSxYVvrdHZRtfyLmPCbsL7MyL0adzywxozrwAJBbegvIocfHzfEKMl5hUR6BacXsvums5Ff2pafB4K6/edvnwtnH/djYb/4w3eVOZ0dLQE7wf/Ap+wJidJ583VQnp1jm1bsRY2nAASM4nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lO1TLL37; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lO1TLL37;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j72Zr4X4Fz2xPW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:26:27 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFEM5k1294246;
	Sun, 18 Oct 2026 15:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=whoUjQfO/MaEvOa7tAljG49R0UiUJE6SLq9r+UfLh
	/8=; b=lO1TLL37qXwVVO1hlWhXGeFtxzsXC4HM+WAl1uv8Mw8FFvOChfVseJipf
	gz+ermWKrVVHBv/4TQVdLe1TqHkKnEP0+MxsOralVOSmigYF5q9XBEYareeGLuSD
	3Zy493gK+9g3WJf4CUyfbd7jBtZA3zfbGlBYAe14mhBQW3NXpYt3Vyu2qOZ/mzCw
	wSMwZTIpfLYmKm8y0IjsGLLXsQLq7vIO1pRfIJkw9ZQ8B+x8LuZPgiBHDr29xw0q
	MBQbFwfCIvMU3QB9ridyC4C6tSSqwU/RqJQkl5QDif7bLrkykHGWKOfoaZTIOA36
	ScqaGQMryRDXqz7yUZGr1bL2r0SOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7ea6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 15:26:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK8oc2779299;
	Sun, 18 Oct 2026 15:26:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcp1y9nan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 15:26:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IFQJJX47055280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 15:26:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 279EC20043;
	Sun, 18 Oct 2026 15:26:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFDBD20040;
	Sun, 18 Oct 2026 15:26:16 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.124.217.98])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 15:26:16 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: kees@kernel.org, maddy@linux.ibm.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] gcc-plugins: Add a plugin to ease debugging of memory ordering bugs
Date: Sun, 18 Oct 2026 20:56:06 +0530
Message-ID: <20261018152608.1323494-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2MCBTYWx0ZWRfX6/cXMyoNLVZM
 7wRZ7fEKKbsbhgQhxyUi31OrpDYq9BZ+3KriVyWy6SzX5vDZzTye90lxRb3xbICJ2FbEztQHjTh
 Kjg0+HsCT3Z2TwFmKsrqi5QtRn7Z5oA=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad4e520 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=SMgOnqTPEg9jcWRg:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=XxtmG6sFAAAA:8
 a=VnNF1IyMAAAA:8 a=Z-CbJQqKeFpCzIUWG4sA:9 a=CYKbh7h7szYBv2aNwBbU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2MCBTYWx0ZWRfX+6PydY49q/Cf
 uZFJIDw0KZjvP4YoDfhZeNAiT7XyywZbkNSF9k92Xq5Xyrdnoy7+wXH7wsSJ6KtBobjNAnLTreT
 IcZ+/To8ToEtzvUvPbfVA6ZbZ2Wv19XwBG+t8uoOelDvro2yD9U3829yncdUlo2i3Bl1BTJi3WZ
 bpPaSOlpnNLcFQ3j3V89Lk8W7JEhnFlN6VRx0N1d7FKft51cXi2V3ALfg9oh58Ff7DskmF7noZf
 dKhFNWnmMPKerT25zKsMNelGoyr69mH8tZ2oyOesr3dgdyKmQlnRNc3G64ei5Qu7KuUNDBitRFo
 LQGgoyiqddZgKaT0XOceUf1xOFJksfJER40fQjmf0OCCDyeg2UPo/KcBGHJx4m3V2fpa9sG4qP9
 Le0L7DXiMypHPabWcySqvPmRzbZoO9zQOnUuUztMlO0/B1yL5yQwaM6H+CuxfNrjXIwF89RUvP3
 5Ezvn5jcKx56Zl6Mu1w==
X-Proofpoint-GUID: n7YQTyMxVFC0rcuCiZ0P3DPaZT7iAWIb
X-Proofpoint-ORIG-GUID: 6VrlyuLNsFKf0D5A5dGykHD2sSqE8Ncn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180060

On CPUs that support out of order execution, barriers are used to make
sure that if a cpu updates a variable, all other cpus see the correct
value. However, sometimes developers forget to put the barriers in the
right place and this ends up causing bugs.

Introduce a new plugin that can insert barriers after every load/store
to memory to make it easy to verify if a given bug is due to a missing
barrier.

Testing:
To test this plugin on IBM Power systems, I reverted the commit
bb9b52bd51dc ("KVM: PPC: Book3S HV: Add missing barriers to XIVE code and document them").

I was able to see lockups in the KVM guest with the commit reverted. I
then used the barriers plugin to insert barriers, and noticed that the
lockups were no longer observed in the KVM guest.

Assisted-by: LLM IBM-Bob
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 scripts/Makefile.gcc-plugins          |   2 +
 scripts/gcc-plugins/Kconfig           |   6 ++
 scripts/gcc-plugins/barriers_plugin.c | 134 ++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 scripts/gcc-plugins/barriers_plugin.c

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0e1423b09c2..cefc1cdad8df 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,8 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
+gcc-plugin-$(CONFIG_GCC_PLUGIN_BARRIERS)	+= barriers_plugin.so
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 6b34ba19358d..d73e00fbb732 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -36,4 +36,10 @@ config GCC_PLUGIN_LATENT_ENTROPY
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
+config GCC_PLUGIN_BARRIERS
+	bool "Insert barriers after every load/store"
+	help
+	  By saying Y here barriers will be inserted after every load/store
+	  instruction.
+
 endif
diff --git a/scripts/gcc-plugins/barriers_plugin.c b/scripts/gcc-plugins/barriers_plugin.c
new file mode 100644
index 000000000000..54ee8b12e77b
--- /dev/null
+++ b/scripts/gcc-plugins/barriers_plugin.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "gcc-common.h"
+
+#if defined(__powerpc__)
+# define BARRIER_ASM "sync"
+#else
+# define BARRIER_ASM ""  /* compiler barrier only: asm volatile("" ::: "memory") */
+#endif
+
+__visible int plugin_is_GPL_compatible;
+
+static struct plugin_info barriers_plugin_info = {
+	.version = PLUGIN_VERSION,
+	.help = "Insert barriers after every load/store instruction\n"
+};
+
+/*
+ * Return true if this GIMPLE statement performs a non-stack memory access.
+ */
+static bool is_mem_based(tree expr)
+{
+	switch (TREE_CODE(expr)) {
+	case MEM_REF:
+	case INDIRECT_REF:
+	case TARGET_MEM_REF:
+		return true;
+	case COMPONENT_REF:
+		return is_mem_based(TREE_OPERAND(expr, 0));
+	default:
+		return false;
+	}
+}
+
+static bool gimple_has_mem_access(gimple stmt)
+{
+	if (gimple_code(stmt) == GIMPLE_CALL)
+		return true;
+
+	if (gimple_code(stmt) != GIMPLE_ASSIGN)
+		return false;
+
+	if (is_mem_based(gimple_assign_lhs(stmt)))
+		return true;
+
+	if (is_mem_based(gimple_assign_rhs1(stmt)))
+		return true;
+
+	return false;
+}
+
+/*
+ * Build a GIMPLE statement for "asm volatile(<barrier_instn> ::: "memory");".
+ */
+static gasm *build_mb_asm(void)
+{
+	vec <tree, va_gc> *clobbers = NULL;
+	gasm *stmt;
+	tree clob = build_tree_list(NULL_TREE, build_const_char_string(7, "memory"));
+
+	vec_safe_push(clobbers, clob);
+	stmt = gimple_build_asm_vec(BARRIER_ASM, NULL, NULL, clobbers, NULL);
+	gimple_asm_set_volatile(stmt, true);
+	return stmt;
+}
+
+static unsigned int insert_barriers_execute(void)
+{
+	basic_block bb;
+	unsigned int i;
+	gimple_stmt_iterator *gsi_p;
+	gimple stmt;
+	gasm *barrier;
+
+	FOR_EACH_BB_FN(bb, cfun) {
+		/*
+		 * Collect the iterator positions of all memory-accessing
+		 * statements first, then insert. Inserting while iterating
+		 * would visit the newly-added asm statements on the next step.
+		 */
+		auto_vec <gimple_stmt_iterator> to_instrument;
+
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi)) {
+			stmt = gsi_stmt(gsi);
+			if (!is_gimple_debug(stmt) && gimple_has_mem_access(stmt))
+				to_instrument.safe_push(gsi);
+		}
+
+		FOR_EACH_VEC_ELT(to_instrument, i, gsi_p) {
+			barrier = build_mb_asm();
+			gsi_insert_after(gsi_p, barrier, GSI_CONTINUE_LINKING);
+			update_stmt(barrier);
+		}
+	}
+	return 0;
+}
+
+#define PASS_NAME insert_barriers
+#define NO_GATE
+#define PROPERTIES_REQUIRED  PROP_gimple_any
+
+#include "gcc-generate-gimple-pass.h"
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	const char * const plugin_name = plugin_info->base_name;
+	const int argc = plugin_info->argc;
+	const struct plugin_argument * const argv = plugin_info->argv;
+	int i = 0;
+
+	/*
+	 * Run before "ssa", the entry to the main GIMPLE optimization pipeline.
+	 * At this point no memory-access reordering has occurred yet, so the
+	 * inserted barrier statements are seen by
+	 * all subsequent passes and act as both compiler and hardware barriers,
+	 * exactly like the kernel's smp_mb() macro.
+	 */
+	PASS_INFO(insert_barriers, "ssa", 1, PASS_POS_INSERT_BEFORE);
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	/* Give the information about the plugin */
+	register_callback(plugin_name, PLUGIN_INFO, NULL,
+						&barriers_plugin_info);
+
+	register_callback(plugin_name, PLUGIN_PASS_MANAGER_SETUP, NULL,
+					&insert_barriers_pass_info);
+
+	return 0;
+}
\ No newline at end of file
-- 
2.55.0


