Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E91C433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 13:16:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CB064DD8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 13:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CB064DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRLZm5rWdzDrbd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 00:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=dietmar.eggemann@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DRLSj6VNlzDrWZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2021 00:11:01 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A95712FC;
 Thu, 28 Jan 2021 05:10:59 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 264D63F719;
 Thu, 28 Jan 2021 05:10:56 -0800 (PST)
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] sched/core: Update task_prio() function header
Date: Thu, 28 Jan 2021 14:10:40 +0100
Message-Id: <20210128131040.296856-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128131040.296856-1-dietmar.eggemann@arm.com>
References: <20210128131040.296856-1-dietmar.eggemann@arm.com>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Hillf Danton <hdanton@sina.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The description of the RT offset and the values for 'normal' tasks needs
update. Moreover there are DL tasks now.
task_prio() has to stay like it is to guarantee compatibility with the
/proc/<pid>/stat priority field:

  # cat /proc/<pid>/stat | awk '{ print $18; }'

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625ec1e12064..be3a956c2d23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5602,8 +5602,12 @@ SYSCALL_DEFINE1(nice, int, increment)
  * @p: the task in question.
  *
  * Return: The priority value as seen by users in /proc.
- * RT tasks are offset by -200. Normal tasks are centered
- * around 0, value goes from -16 to +15.
+ *
+ * sched policy         return value   kernel prio    user prio/nice
+ *
+ * normal, batch, idle     [0 ... 39]  [100 ... 139]          0/[-20 ... 19]
+ * fifo, rr             [-2 ... -100]     [98 ... 0]  [1 ... 99]
+ * deadline                     -101             -1           0
  */
 int task_prio(const struct task_struct *p)
 {
-- 
2.25.1

