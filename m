Return-Path: <SRS0=bXCp=74=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05348C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 13:58:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E08207DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qo5IGkkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E08207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ltGN4qRgzDqVC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 23:58:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+982856cf37d7c265414a+6140+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=Qo5IGkkz; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49lrzy18sBzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 23:01:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=T94kCvjMg3POOYY9QZ5B+bKnsinmf9rCUNlS0Naq4B0=; b=Qo5IGkkztcUZUo+cF8SPeORX9i
 w8KjM/VC9s4RMbj4LN1fKVtGCejc53i0Zu2X7+dZHUKqbl+/UWNGou0bWdNaQSGZGFBALkNZyyX7G
 7WPcNWmdxBXgCdcQmbNo4w+COAtvJ909XyC6k/F9jHQD/7PTa4oq2W1vPCOQ0q/U7pcIct/SwXOFK
 ttpKACNil9TDb9+ef+c4u10g1xvHGoDSCuYvcugulrM6h5bvWrzi4gpMUu3jqFiIt+7jLRAhrE1wo
 AYbI592N/mkwbu7osPGGfCrVJQGOe+sP14GCKFKsGMmY+XEQIT5qRRum69TNwcvDRsf4IHCkpK76+
 SpOrojPQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkojK-00081b-G3; Mon, 15 Jun 2020 13:00:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/6] kernel: add a kernel_wait helper
Date: Mon, 15 Jun 2020 15:00:32 +0200
Message-Id: <20200615130032.931285-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
References: <20200615130032.931285-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a helper that waits for a pid and stores the status in the passed
in kernel pointer.  Use it to fix the usage of kernel_wait4 in
call_usermodehelper_exec_sync that only happens to work due to the
implicit set_fs(KERNEL_DS) for kernel threads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/exit.c              | 16 ++++++++++++++++
 kernel/umh.c               | 29 ++++-------------------------
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 38359071236ad7..a80007df396e95 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -102,6 +102,7 @@ struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
+int kernel_wait(pid_t pid, int *stat);
 
 extern void free_task(struct task_struct *tsk);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f2810338..fd598846df0b17 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
 	return ret;
 }
 
+int kernel_wait(pid_t pid, int *stat)
+{
+	struct wait_opts wo = {
+		.wo_type	= PIDTYPE_PID,
+		.wo_pid		= find_get_pid(pid),
+		.wo_flags	= WEXITED,
+	};
+	int ret;
+
+	ret = do_wait(&wo);
+	if (ret > 0 && wo.wo_stat)
+		*stat = wo.wo_stat;
+	put_pid(wo.wo_pid);
+	return ret;
+}
+
 SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
 		int, options, struct rusage __user *, ru)
 {
diff --git a/kernel/umh.c b/kernel/umh.c
index 1284823dbad338..6fd948e478bec4 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -126,37 +126,16 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 {
 	pid_t pid;
 
-	/* If SIGCLD is ignored kernel_wait4 won't populate the status. */
+	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
 	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
-	if (pid < 0) {
+	if (pid < 0)
 		sub_info->retval = pid;
-	} else {
-		int ret = -ECHILD;
-		/*
-		 * Normally it is bogus to call wait4() from in-kernel because
-		 * wait4() wants to write the exit code to a userspace address.
-		 * But call_usermodehelper_exec_sync() always runs as kernel
-		 * thread (workqueue) and put_user() to a kernel address works
-		 * OK for kernel threads, due to their having an mm_segment_t
-		 * which spans the entire address space.
-		 *
-		 * Thus the __user pointer cast is valid here.
-		 */
-		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
-
-		/*
-		 * If ret is 0, either call_usermodehelper_exec_async failed and
-		 * the real error code is already in sub_info->retval or
-		 * sub_info->retval is 0 anyway, so don't mess with it then.
-		 */
-		if (ret)
-			sub_info->retval = ret;
-	}
+	else
+		kernel_wait(pid, &sub_info->retval);
 
 	/* Restore default kernel sig handler */
 	kernel_sigaction(SIGCHLD, SIG_IGN);
-
 	umh_complete(sub_info);
 }
 
-- 
2.26.2

