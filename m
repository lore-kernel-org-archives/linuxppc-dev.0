Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B84C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:08:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D649F20865
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jky/hHNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D649F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4339MD49vrzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:08:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jky/hHNg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jky/hHNg"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4339Bd0ZXZzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 13:01:28 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 80so5388214pge.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 18:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WfcTuNz8tH8zmqFOtMr0Y1OwtVc8wPSozagTFwXUBZw=;
 b=Jky/hHNgP5NdPaTLlOMCYBj9yQeGYmccPQ8kRUZRNGiCllFRCvS/iKH26Mc/9HlLnn
 to0xWiprPOAyqv/VJvRArjQ30W3VPCtyfad6SRtFOPFLKnYLC/ULnysvHAln4KxcgjND
 i+KNMlyF1xAiMG5EwR8WDUM9l1HkiGjQjynAzqT4aiV11Lpxed6WSR1ewyUhzznGaeaE
 CzLLDW3cbUwQhb5LJ3EHgdh0fxvVBmAjWdmf6BZ4++p4v8jbGkp6IKxr9YCLaDNIXqeN
 GUYVKlSqqKRlvb98IeilZ+DJp19ve6KMJgNBVtlUD+0CRKYErv/B5a5dQN1algylPFsR
 15TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WfcTuNz8tH8zmqFOtMr0Y1OwtVc8wPSozagTFwXUBZw=;
 b=o+nPAYx+/p25KXh36oU0xIzC1yqbvc8pOHDX3W124jRJXBerCBeTd7F6/pmGwoKtUr
 oiHER0BG9Tg0fpsh2n9PYXaBd7BDNsjbObcq4YlcSsNe8VDtQe0MajGbHZ2TC/znveAF
 hq7bcC6e4UBK7r+M1kimYnIgRjxt+hKL8+6U0McXufdxIoT/x/sdW/9pHq6FDc0zpB7g
 100lmHtlkTi+yQmjuQNPAuvfRTaKATt8gc9DSlZTqI1f9mFjK1NO4sudyHFhiCSgIlrj
 SNghPkdCyjOWJXCtiFBBF7MvoahWZ4iij96lLE4KHMMVl2O/nkF14p8DIdLGpYruPY1S
 HdXw==
X-Gm-Message-State: AA+aEWbuMvyLT4DktOlOgdL71Iv0analNBI6ZOgqoHxGE6i7U2newuhL
 dewXeDf/atM/+TJw+r+LwsqmILs8QJU=
X-Google-Smtp-Source: AFSGD/Um60gTLe1PvE01JVPEzjDFJAseHV9Md8tKRyTOae9RKML2jNl0WfBS/T2aHg1lEfafZP6S9Q==
X-Received: by 2002:a63:24c2:: with SMTP id
 k185mr22267456pgk.406.1543197686896; 
 Sun, 25 Nov 2018 18:01:26 -0800 (PST)
Received: from bobo.local0.net (203-221-165-244.tpgi.com.au. [203.221.165.244])
 by smtp.gmail.com with ESMTPSA id b5sm76675525pfc.150.2018.11.25.18.01.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Nov 2018 18:01:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/smp: Fix NMI IPI xmon timeout
Date: Mon, 26 Nov 2018 12:01:06 +1000
Message-Id: <20181126020107.17250-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126020107.17250-1-npiggin@gmail.com>
References: <20181126020107.17250-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The xmon debugger IPI handler waits in the callback function while
xmon is still active. This means they don't complete the IPI, and the
initiator always times out waiting for them.

Things manage to work after the timeout because there is some fallback
logic to keep NMI IPI state sane in case of the timeout, but this is a
bit ugly.

This patch changes NMI IPI back to half-asynchronous (i.e., wait for
everyone to call in, do not wait for IPI function to complete), but
the complexity is avoided by going one step further and allowing new
IPIs to be issued before the IPI functions to all complete.

If synchronization against that is required, it is left up to the
caller, but current callers don't require that. In fact with the
timeout handling, callers must be able to cope with this already.

Fixes: 5b73151fff63 ("powerpc: NMI IPI make NMI IPIs fully sychronous")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 93 ++++++++++++---------------------------
 1 file changed, 29 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 137196a4248b..6e521a3f67ca 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -358,13 +358,12 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
  * NMI IPIs may not be recoverable, so should not be used as ongoing part of
  * a running system. They can be used for crash, debug, halt/reboot, etc.
  *
- * NMI IPIs are globally single threaded. No more than one in progress at
- * any time.
- *
  * The IPI call waits with interrupts disabled until all targets enter the
- * NMI handler, then the call returns.
+ * NMI handler, then returns. Subsequent IPIs can be issued before targets
+ * have returned from their handlers, so there is no guarantee about
+ * concurrency or re-entrancy.
  *
- * No new NMI can be initiated until targets exit the handler.
+ * A new NMI can be issued before all targets exit the handler.
  *
  * The IPI call may time out without all targets entering the NMI handler.
  * In that case, there is some logic to recover (and ignore subsequent
@@ -375,7 +374,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 static atomic_t __nmi_ipi_lock = ATOMIC_INIT(0);
 static struct cpumask nmi_ipi_pending_mask;
-static int nmi_ipi_busy_count = 0;
+static bool nmi_ipi_busy = false;
 static void (*nmi_ipi_function)(struct pt_regs *) = NULL;
 
 static void nmi_ipi_lock_start(unsigned long *flags)
@@ -414,7 +413,7 @@ static void nmi_ipi_unlock_end(unsigned long *flags)
  */
 int smp_handle_nmi_ipi(struct pt_regs *regs)
 {
-	void (*fn)(struct pt_regs *);
+	void (*fn)(struct pt_regs *) = NULL;
 	unsigned long flags;
 	int me = raw_smp_processor_id();
 	int ret = 0;
@@ -425,29 +424,17 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
 	 * because the caller may have timed out.
 	 */
 	nmi_ipi_lock_start(&flags);
-	if (!nmi_ipi_busy_count)
-		goto out;
-	if (!cpumask_test_cpu(me, &nmi_ipi_pending_mask))
-		goto out;
-
-	fn = nmi_ipi_function;
-	if (!fn)
-		goto out;
-
-	cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
-	nmi_ipi_busy_count++;
-	nmi_ipi_unlock();
-
-	ret = 1;
-
-	fn(regs);
-
-	nmi_ipi_lock();
-	if (nmi_ipi_busy_count > 1) /* Can race with caller time-out */
-		nmi_ipi_busy_count--;
-out:
+	if (cpumask_test_cpu(me, &nmi_ipi_pending_mask)) {
+		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+		fn = READ_ONCE(nmi_ipi_function);
+		WARN_ON_ONCE(!fn);
+		ret = 1;
+	}
 	nmi_ipi_unlock_end(&flags);
 
+	if (fn)
+		fn(regs);
+
 	return ret;
 }
 
@@ -473,7 +460,7 @@ static void do_smp_send_nmi_ipi(int cpu, bool safe)
  * - cpu is the target CPU (must not be this CPU), or NMI_IPI_ALL_OTHERS.
  * - fn is the target callback function.
  * - delay_us > 0 is the delay before giving up waiting for targets to
- *   complete executing the handler, == 0 specifies indefinite delay.
+ *   begin executing the handler, == 0 specifies indefinite delay.
  */
 int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool safe)
 {
@@ -487,31 +474,33 @@ int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool
 	if (unlikely(!smp_ops))
 		return 0;
 
-	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
 	nmi_ipi_lock_start(&flags);
-	while (nmi_ipi_busy_count) {
+	while (nmi_ipi_busy) {
 		nmi_ipi_unlock_end(&flags);
-		spin_until_cond(nmi_ipi_busy_count == 0);
+		spin_until_cond(!nmi_ipi_busy);
 		nmi_ipi_lock_start(&flags);
 	}
-
+	nmi_ipi_busy = true;
 	nmi_ipi_function = fn;
 
+	WARN_ON_ONCE(!cpumask_empty(&nmi_ipi_pending_mask));
+
 	if (cpu < 0) {
 		/* ALL_OTHERS */
 		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
 		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
 	} else {
-		/* cpumask starts clear */
 		cpumask_set_cpu(cpu, &nmi_ipi_pending_mask);
 	}
-	nmi_ipi_busy_count++;
+
 	nmi_ipi_unlock();
 
+	/* Interrupts remain hard disabled */
+
 	do_smp_send_nmi_ipi(cpu, safe);
 
 	nmi_ipi_lock();
-	/* nmi_ipi_busy_count is held here, so unlock/lock is okay */
+	/* nmi_ipi_busy is set here, so unlock/lock is okay */
 	while (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		nmi_ipi_unlock();
 		udelay(1);
@@ -519,34 +508,19 @@ int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool
 		if (delay_us) {
 			delay_us--;
 			if (!delay_us)
-				goto timeout;
+				break;
 		}
 	}
 
-	while (nmi_ipi_busy_count > 1) {
-		nmi_ipi_unlock();
-		udelay(1);
-		nmi_ipi_lock();
-		if (delay_us) {
-			delay_us--;
-			if (!delay_us)
-				goto timeout;
-		}
-	}
-
-timeout:
 	if (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		/* Timeout waiting for CPUs to call smp_handle_nmi_ipi */
 		ret = 0;
 		cpumask_clear(&nmi_ipi_pending_mask);
 	}
-	if (nmi_ipi_busy_count > 1) {
-		/* Timeout waiting for CPUs to execute fn */
-		ret = 0;
-		nmi_ipi_busy_count = 1;
-	}
 
-	nmi_ipi_busy_count--;
+	nmi_ipi_function = NULL;
+	nmi_ipi_busy = false;
+
 	nmi_ipi_unlock_end(&flags);
 
 	return ret;
@@ -614,17 +588,8 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 static void nmi_stop_this_cpu(struct pt_regs *regs)
 {
 	/*
-	 * This is a special case because it never returns, so the NMI IPI
-	 * handling would never mark it as done, which makes any later
-	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
-	 *
 	 * IRQs are already hard disabled by the smp_handle_nmi_ipi.
 	 */
-	nmi_ipi_lock();
-	if (nmi_ipi_busy_count > 1)
-		nmi_ipi_busy_count--;
-	nmi_ipi_unlock();
-
 	spin_begin();
 	while (1)
 		spin_cpu_relax();
-- 
2.19.2

