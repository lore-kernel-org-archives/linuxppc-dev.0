Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15516C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:23:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3747720850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3747720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439j9F5J8HzDqRK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:22:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 439hPf0wsrzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 03:48:37 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13E415AB;
 Thu,  6 Dec 2018 08:48:36 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6055B3F5AF;
 Thu,  6 Dec 2018 08:48:32 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 12/12] perf/core: remove unused perf_flags
Date: Thu,  6 Dec 2018 16:47:29 +0000
Message-Id: <1544114849-47266-13-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that perf_flags is not used we remove it.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/uapi/linux/perf_event.h       | 2 --
 tools/include/uapi/linux/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f35eb72..ba89bd3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f35eb72..ba89bd3 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
-- 
2.7.4

