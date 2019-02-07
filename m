Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25807C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:38:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F60E20663
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F60E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVWn5m8szDqDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:38:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSXy6bSVzDqQd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:09:22 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5B3180E7B;
 Thu,  7 Feb 2019 19:09:20 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4E8617BAC;
 Thu,  7 Feb 2019 19:09:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 07/22] locking/rwsem: Move rwsem internal function
 declarations to rwsem-xadd.h
Date: Thu,  7 Feb 2019 14:07:11 -0500
Message-Id: <1549566446-27967-8-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 19:09:21 +0000 (UTC)
X-Mailman-Approved-At: Fri, 08 Feb 2019 07:26:12 +1100
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We don't need to expose rwsem internal functions which are not supposed
to be called directly from other kernel code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h       | 7 -------
 kernel/locking/rwsem-xadd.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 6e56006..1e0457b 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -50,13 +50,6 @@ struct rw_semaphore {
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 2eaa762..64e7d62 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -153,6 +153,13 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
+
 /*
  * lock for reading
  */
-- 
1.8.3.1

