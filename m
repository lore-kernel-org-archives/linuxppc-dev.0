Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A77C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 13:24:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BCD61492
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 13:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BCD61492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRLlt5qmJzDrdC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 00:24:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=dietmar.eggemann@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DRLSk5J9zzDrWk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2021 00:10:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D4231B;
 Thu, 28 Jan 2021 05:10:51 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F16853F719;
 Thu, 28 Jan 2021 05:10:48 -0800 (PST)
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/3] sched: Task priority related cleanups
Date: Thu, 28 Jan 2021 14:10:37 +0100
Message-Id: <20210128131040.296856-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
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

(1) Removing MAX_USER_RT_PRIO was already discussed here in April 2020:

    https://lkml.kernel.org/r/20200423094403.6f1d2b8d@gandalf.local.home

(2) USER_PRIO() and related macros are not used anymore except in one
    case for powerpc where MAX_USER_PRIO can be replaced by NICE_WIDTH.
    Set_load_weight(), task_prio(), cpu_weight_nice_write_s64(),
    __update_max_tr() don't use USER_PRIO() but priority - MAX_RT_PRIO.

(3) The function header of task_prio() needs an update. It looks
    ancient since it mentions a prio space [-16 ... 15] for mormal
    tasks. I can't figure out why this range is mentioned here? Maybe
    the influence of the 'sleep-bonus interactivity' feature which was
    removed by commit f3479f10c5d6 ("sched: remove the sleep-bonus
    interactivity code")? 

Dietmar Eggemann (3):
  sched: Remove MAX_USER_RT_PRIO
  sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
  sched/core: Update task_prio() function header

 arch/powerpc/platforms/cell/spufs/sched.c |  2 +-
 include/linux/sched/prio.h                | 18 +-----------------
 kernel/sched/core.c                       | 15 +++++++++------
 kernel/sched/sched.h                      |  2 +-
 4 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.25.1

