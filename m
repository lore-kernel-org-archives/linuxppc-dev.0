Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C54C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 13:13:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACE520823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSZI6FDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACE520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z8R05jKszF3GM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 00:13:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="sSZI6FDx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="sSZI6FDx"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z8KG6gFrzF3G0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 00:08:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OjEPoOrSvn/SVnSSCA7UFGSNFLgoXG8AkPeL/+L6YF0=; b=sSZI6FDxu+tf8PQCNWEkJ+Tz8
 oT3acWz0M2WVtCMCF5Fpo/a5j98FxzyitYJKXB0XckSeSbEwwHNUuAOBgo45a67zpPJIXS4gFSl2G
 yjqidKF0N1/i+2KxdsNEKvmTjTE8hZ57kV/Esy+Mo16uEadxL6Tp9injSfGZ7jLONWu6dYZdw4mlJ
 hzuv+KZnPqtZK9GOiIidk7wTerGDYgJXbMJF69XsA9jwJHba2o6AGXJq79x1IHh7CPQegUjIM8HpY
 P39BJbhj/xfe1wf8N03bAwk2nTGR8qVbuxjEjB8Ov3ZJj4az77bcMKWwkdVWse0pyrVL0TDgBn6RV
 +hpidC2HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOjHV-00081a-Lt; Mon, 19 Nov 2018 13:08:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6B28220298BFC; Mon, 19 Nov 2018 14:08:00 +0100 (CET)
Date: Mon, 19 Nov 2018 14:08:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 00/10] perf/core: Generalise event exclusion checking
Message-ID: <20181119130800.GE9761@hirez.programming.kicks-ass.net>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 16, 2018 at 10:24:03AM +0000, Andrew Murray wrote:
> Many PMU drivers do not have the capability to exclude counting events
> that occur in specific contexts such as idle, kernel, guest, etc. These
> drivers indicate this by returning an error in their event_init upon
> testing the events attribute flags.
> 
> However this approach requires that each time a new event modifier is
> added to perf, all the perf drivers need to be modified to indicate that
> they don't support the attribute. This results in additional boiler-plate
> code common to many drivers that needs to be maintained. An example of
> this is the addition of exclude_host and exclude_guest in 2011 yet many
> PMU drivers do not support this or indicate an error on events that make
> use of it.
> 
> This patch generalises the test for exclusion and updates PMU drivers to
> use it. This is a functional change as some PMU drivers will now correctly
> report that they don't support certain events whereas they previously did.

Right, I like that idea, and yes, there's a lot of fail around there :/

> A longer term approach may instead be for PMU's to advertise their
> capabilities on registration.

This I think is the better approach. We already have the
PERF_PMU_CAP_flags that can be used to advertise various PMU
capabilities.

Something along these lines I suppose; then every PMU that actually
checks the flags, needs to set the flag, otherwise it'll fail.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..de15723ea52a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -244,6 +244,7 @@ struct perf_event;
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
+#define PERF_PMU_CAP_EXCLUDE			0x80
 
 /**
  * struct pmu - generic performance monitoring unit
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab358c3..d76b724177b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9772,6 +9772,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
+	if (!ret) {
+		if ((pmu->capabilities & PERF_PMU_CAP_EXCLUDE) ||
+		    event_has_exclude_flags(event)) {
+			event->destroy(event);
+			ret = -EINVAL;
+		}
+	}
+
 	if (ret)
 		module_put(pmu->module);
 

