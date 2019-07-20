Return-Path: <SRS0=Rj2I=VR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A876C7618F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 01:35:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2414020873
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 01:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45r9R945RlzDqyh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 11:35:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45r9KP205QzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2019 11:30:01 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 024A8AE807F6;
 Fri, 19 Jul 2019 21:29:22 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 1/2] powerpc/pseries: Call RTAS directly
Date: Sat, 20 Jul 2019 11:29:18 +1000
Message-Id: <20190720012919.14417-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190720012919.14417-1-aik@ozlabs.ru>
References: <20190720012919.14417-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pseries guests call RTAS via a RTAS entry point which is a firmware
image under powernv and simple HCALL wrapper under QEMU. For the latter,
we can skip the binary image and do HCALL directly, eliminating the need
in the RTAS blob entirely.

This checks the DT whether the new method is supported and use it if it is.
This removes few checks as QEMU might decide not to keen RTAS around at
all (might be the case for secure VMs).

Note that kexec still checks for the linux,rtas-xxx properties which has
to be fixed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/rtas.h |  1 +
 arch/powerpc/kernel/rtas.c      | 47 +++++++++++++++------------------
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3c1887351c71..60cd528806c1 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -59,6 +59,7 @@ struct rtas_t {
 	arch_spinlock_t lock;
 	struct rtas_args args;
 	struct device_node *dev;	/* virtual address pointer */
+	bool hcall;
 };
 
 struct rtas_suspend_me_data {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5faf0a64c92b..0651291ab5ff 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -49,6 +49,14 @@ struct rtas_t rtas = {
 };
 EXPORT_SYMBOL(rtas);
 
+static void __enter_rtas(unsigned long pa)
+{
+	if (rtas.hcall)
+		plpar_hcall_norets(H_RTAS, pa);
+	else
+		enter_rtas(pa);
+}
+
 DEFINE_SPINLOCK(rtas_data_buf_lock);
 EXPORT_SYMBOL(rtas_data_buf_lock);
 
@@ -95,9 +103,6 @@ static void call_rtas_display_status(unsigned char c)
 {
 	unsigned long s;
 
-	if (!rtas.base)
-		return;
-
 	s = lock_rtas();
 	rtas_call_unlocked(&rtas.args, 10, 1, 1, NULL, c);
 	unlock_rtas(s);
@@ -145,9 +150,6 @@ static void udbg_rtascon_putc(char c)
 {
 	int tries;
 
-	if (!rtas.base)
-		return;
-
 	/* Add CRs before LFs */
 	if (c == '\n')
 		udbg_rtascon_putc('\r');
@@ -164,9 +166,6 @@ static int udbg_rtascon_getc_poll(void)
 {
 	int c;
 
-	if (!rtas.base)
-		return -1;
-
 	if (rtas_call(rtas_getchar_token, 0, 2, &c))
 		return -1;
 
@@ -205,9 +204,6 @@ void rtas_progress(char *s, unsigned short hex)
 	static int current_line;
 	static int pending_newline = 0;  /* did last write end with unprinted newline? */
 
-	if (!rtas.base)
-		return;
-
 	if (display_width == 0) {
 		display_width = 0x10;
 		if ((root = of_find_node_by_path("/rtas"))) {
@@ -382,7 +378,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 	save_args = rtas.args;
 	rtas.args = err_args;
 
-	enter_rtas(__pa(&rtas.args));
+	__enter_rtas(__pa(&rtas.args));
 
 	err_args = rtas.args;
 	rtas.args = save_args;
@@ -428,7 +424,7 @@ va_rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret,
 	for (i = 0; i < nret; ++i)
 		args->rets[i] = 0;
 
-	enter_rtas(__pa(args));
+	__enter_rtas(__pa(args));
 }
 
 void rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret, ...)
@@ -449,7 +445,7 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	char *buff_copy = NULL;
 	int ret;
 
-	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
+	if (token == RTAS_UNKNOWN_SERVICE)
 		return -1;
 
 	s = lock_rtas();
@@ -1064,9 +1060,6 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!rtas.entry)
-		return -EINVAL;
-
 	if (copy_from_user(&args, uargs, 3 * sizeof(u32)) != 0)
 		return -EFAULT;
 
@@ -1115,7 +1108,7 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	flags = lock_rtas();
 
 	rtas.args = args;
-	enter_rtas(__pa(&rtas.args));
+	__enter_rtas(__pa(&rtas.args));
 	args = rtas.args;
 
 	/* A -1 return code indicates that the last command couldn't
@@ -1149,8 +1142,8 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 void __init rtas_initialize(void)
 {
 	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
-	u32 base, size, entry;
-	int no_base, no_size, no_entry;
+	u32 base = 0, size = 0, entry = 0, do_h_rtas = 0;
+	int no_base, no_size, no_entry, ret;
 
 	/* Get RTAS dev node and fill up our "rtas" structure with infos
 	 * about it.
@@ -1161,17 +1154,15 @@ void __init rtas_initialize(void)
 
 	no_base = of_property_read_u32(rtas.dev, "linux,rtas-base", &base);
 	no_size = of_property_read_u32(rtas.dev, "rtas-size", &size);
-	if (no_base || no_size) {
-		of_node_put(rtas.dev);
-		rtas.dev = NULL;
-		return;
-	}
 
 	rtas.base = base;
 	rtas.size = size;
 	no_entry = of_property_read_u32(rtas.dev, "linux,rtas-entry", &entry);
 	rtas.entry = no_entry ? rtas.base : entry;
 
+	ret = of_property_read_u32(of_chosen, "qemu,h_rtas", &do_h_rtas);
+	rtas.hcall = !ret && do_h_rtas;
+
 	/* If RTAS was found, allocate the RMO buffer for it and look for
 	 * the stop-self token if any
 	 */
@@ -1208,6 +1199,10 @@ int __init early_init_dt_scan_rtas(unsigned long node,
 		rtas.base = *basep;
 		rtas.entry = *entryp;
 		rtas.size = *sizep;
+	} else {
+		rtas.base = 0;
+		rtas.entry = 0;
+		rtas.size = 0;
 	}
 
 #ifdef CONFIG_UDBG_RTAS_CONSOLE
-- 
2.17.1

