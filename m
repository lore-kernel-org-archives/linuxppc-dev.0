Return-Path: <linuxppc-dev+bounces-19168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C4710F6FBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8sv1Zgbz2yqf;
	Thu, 02 Apr 2026 03:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059411;
	cv=none; b=oNQaXpMAGzgd4hhcflzCJHbJUAEWk4239Uh54CnddF1INliijjdsbsZdxVzcGZiW9D5pPf69NnaAnr3YIzT++rFBazLV7xqLqD6VyF7F/X7/fkdV4dmuEy1vi5f3hXbhmlPYNkWHqIhG6kzpADFyYOHlGkWnndTFlnUbRs0K/qyJzawFIqjn52+Fg2fxVK5o8XUyWnv82ZD8ZDBalRlcRkWs+1KVasdFJtBF/k+3dr2Q6+ivybVVmT+D+yRbbxlMCWQbfmtQ/vvfQ81wKnRGDK8Nrt98W1GSkqcRLvWY7HKD0rPKCM/XjYHJJWVTBK/YTcHDtyj3aptfeXryqPANNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059411; c=relaxed/relaxed;
	bh=AF7euZSjCNn7kY+370KnroUx3ldzxafkVsVdsP0v8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez0ZSEovdOe90liPjyvLk9SOjpE/n+MDBQfJA7xdXPhmnk8vgHtgcvrxITwL2eN2F+YWoiPh8fxRnVzWSLrnuF/5aBFRzVSoNLcbHhzJBPjSDnOyBnd0ZWpqr7OSOgM/K31+0BjjnEi2ayni1BL23F1jnf+7a6fbDqbybqfsnbAW+KPQ7gJqQqSm0uxrPsJkAQveHcvsAgzJXwJxgrslmJh4Wb1n7fXLoU+yKiNriKZYuoDNbQMiGVioId6xr0pqfnQqJtvaZBbxvIGQ8w+oYur8Q2zrZzzDg7yosV2Ohy8l/6kXBVQEj3Rpk9juvfOio6V2aqLBW+WNWZqabUDqMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6S35z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACXQm7CQc1pkhThCw--.927S2;
	Thu, 02 Apr 2026 00:03:14 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	robh@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/prom_init: reject oversized string properties before string use
Date: Thu,  2 Apr 2026 00:03:13 +0800
Message-ID: <20260401160313.88483-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
X-CM-TRANSID:qwCowACXQm7CQc1pkhThCw--.927S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW5KF1kWrW8Jr17Gw1rJFb_yoWxtw1fpF
	yrKayUCFy8ZF9I93yFqr1rZrZ8KF1ft3yxJ345Wr4q9F1DA34rXr47KrW5ZrykCFy8C3Wr
	ZFs8ZFs2ywnxAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0PhUUU
	UU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

prom_getprop() returns a byte count but does not append a trailing NUL.
prom_init.c still feeds several such properties directly into string
operations like prom_strcmp(), prom_strstr(), and %s-style printing.

Add a small helper that reads string properties with room for a
terminator and make it fail when the firmware property does not fit in
its destination buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/kernel/prom_init.c | 65 +++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f26e80cbc615..5518adbb3d25 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -663,6 +663,29 @@ static inline int __init prom_getprop(phandle node, const char *pname,
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
+static int __init prom_getprop_string(phandle node, const char *pname,
+				      char *value, size_t valuelen)
+{
+	int rc;
+
+	if (!valuelen)
+		return PROM_ERROR;
+
+	rc = prom_getprop(node, pname, value, valuelen);
+	if (rc == PROM_ERROR || rc <= 0) {
+		value[0] = '\0';
+		return rc;
+	}
+
+	if (rc >= valuelen) {
+		value[valuelen - 1] = '\0';
+		return PROM_ERROR;
+	}
+	value[rc] = '\0';
+
+	return rc;
+}
+
 static inline int __init prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
@@ -791,7 +814,8 @@ static void __init early_cmdline_parse(void)
 	p = prom_cmd_line;
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && (long)prom.chosen > 0)
-		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
+		l = prom_getprop_string(prom.chosen, "bootargs", p,
+					COMMAND_LINE_SIZE);
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || l <= 0 || p[0] == '\0')
 		prom_strlcat(prom_cmd_line, " " CONFIG_CMDLINE,
@@ -1231,7 +1255,7 @@ static int __init prom_count_smt_threads(void)
 	/* Pick up th first CPU node we can find */
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
-		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
 
 		if (prom_strcmp(type, "cpu"))
 			continue;
@@ -1677,14 +1701,14 @@ static void __init prom_init_mem(void)
 
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
-		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
 
 		if (type[0] == 0) {
 			/*
 			 * CHRP Longtrail machines have no device_type
 			 * on the memory node, so check the name instead...
 			 */
-			prom_getprop(node, "name", type, sizeof(type));
+			prom_getprop_string(node, "name", type, sizeof(type));
 		}
 		if (prom_strcmp(type, "memory"))
 			continue;
@@ -2005,10 +2029,10 @@ static void __init prom_initialize_tce_table(void)
 		compatible[0] = 0;
 		type[0] = 0;
 		model[0] = 0;
-		prom_getprop(node, "compatible",
-			     compatible, sizeof(compatible));
-		prom_getprop(node, "device_type", type, sizeof(type));
-		prom_getprop(node, "model", model, sizeof(model));
+		prom_getprop_string(node, "compatible", compatible,
+				    sizeof(compatible));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "model", model, sizeof(model));
 
 		if ((type[0] == 0) || (prom_strstr(type, "pci") == NULL))
 			continue;
@@ -2170,12 +2194,12 @@ static void __init prom_hold_cpus(void)
 		__be32 reg;
 
 		type[0] = 0;
-		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
 		if (prom_strcmp(type, "cpu") != 0)
 			continue;
 
 		/* Skip non-configured cpus. */
-		if (prom_getprop(node, "status", type, sizeof(type)) > 0)
+		if (prom_getprop_string(node, "status", type, sizeof(type)) > 0)
 			if (prom_strcmp(type, "okay") != 0)
 				continue;
 
@@ -2248,9 +2272,8 @@ static void __init prom_find_mmu(void)
 	oprom = call_prom("finddevice", 1, 1, ADDR("/openprom"));
 	if (!PHANDLE_VALID(oprom))
 		return;
-	if (prom_getprop(oprom, "model", version, sizeof(version)) <= 0)
+	if (prom_getprop_string(oprom, "model", version, sizeof(version)) <= 0)
 		return;
-	version[sizeof(version) - 1] = 0;
 	/* XXX might need to add other versions here */
 	if (prom_strcmp(version, "Open Firmware, 1.0.5") == 0)
 		of_workarounds = OF_WA_CLAIM;
@@ -2296,7 +2319,8 @@ static void __init prom_init_stdout(void)
 
 		/* If it's a display, note it */
 		memset(type, 0, sizeof(type));
-		prom_getprop(stdout_node, "device_type", type, sizeof(type));
+		prom_getprop_string(stdout_node, "device_type", type,
+				    sizeof(type));
 		if (prom_strcmp(type, "display") == 0)
 			prom_setprop(stdout_node, path, "linux,boot-display", NULL, 0);
 	}
@@ -2343,8 +2367,8 @@ static int __init prom_find_machine_type(void)
 	 *    non-IBM designs !
 	 *  - it has /rtas
 	 */
-	len = prom_getprop(prom.root, "device_type",
-			   compat, sizeof(compat)-1);
+	len = prom_getprop_string(prom.root, "device_type",
+				  compat, sizeof(compat));
 	if (len <= 0)
 		return PLATFORM_GENERIC;
 	if (prom_strcmp(compat, "chrp"))
@@ -2408,7 +2432,7 @@ static void __init prom_check_displays(void)
 	prom_debug("Looking for displays\n");
 	for (node = 0; prom_next_node(&node); ) {
 		memset(type, 0, sizeof(type));
-		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
 		if (prom_strcmp(type, "display") != 0)
 			continue;
 
@@ -2892,7 +2916,7 @@ static void __init fixup_device_tree_pmac(void)
 	// Some pmacs are missing #size-cells on escc or i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
-		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop_string(node, "device_type", type, sizeof(type));
 		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s") &&
 		    prom_strcmp(type, "media-bay"))
 			continue;
@@ -2988,7 +3012,7 @@ static void __init fixup_device_tree_efika(void)
 	if (!PHANDLE_VALID(node))
 		return;
 
-	rv = prom_getprop(node, "model", prop, sizeof(prop));
+	rv = prom_getprop_string(node, "model", prop, sizeof(prop));
 	if (rv == PROM_ERROR)
 		return;
 	if (prom_strcmp(prop, "EFIKA5K2"))
@@ -2998,13 +3022,14 @@ static void __init fixup_device_tree_efika(void)
 
 	/* Claiming to be 'chrp' is death */
 	node = call_prom("finddevice", 1, 1, ADDR("/"));
-	rv = prom_getprop(node, "device_type", prop, sizeof(prop));
+	rv = prom_getprop_string(node, "device_type", prop, sizeof(prop));
 	if (rv != PROM_ERROR && (prom_strcmp(prop, "chrp") == 0))
 		prom_setprop(node, "/", "device_type", "efika", sizeof("efika"));
 
 	/* CODEGEN,description is exposed in /proc/cpuinfo so
 	   fix that too */
-	rv = prom_getprop(node, "CODEGEN,description", prop, sizeof(prop));
+	rv = prom_getprop_string(node, "CODEGEN,description", prop,
+				 sizeof(prop));
 	if (rv != PROM_ERROR && (prom_strstr(prop, "CHRP")))
 		prom_setprop(node, "/", "CODEGEN,description",
 			     "Efika 5200B PowerPC System",
-- 
2.50.1 (Apple Git-155)


