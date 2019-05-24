Return-Path: <SRS0=LfN0=TY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC10C282E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:54:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4898520674
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pMW9EVUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4898520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 459jrc5WcCzDqWn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 May 2019 09:54:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="pMW9EVUT"; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459jlq3V7gzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2019 09:49:59 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id r22so3319677pfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2019 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hSeuL2/o1hJWW7dWBrMonSWjJ1/vxYoP4q+pVJLuGkg=;
 b=pMW9EVUTzAPhotIyQm3Eoarq3hCw8AqUtsXtetNF860gWUcv2atmr+rZJL8mD1CBmy
 qdE9hrxIv04kKXSoaxN2qQ0v8a7rpYSA69+sgvhEa/B71QX44UC2LNZwAGM9BX+SZOUR
 sjB08g4fUlMJZ523g47EtrFR75J8J1VblpgKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSeuL2/o1hJWW7dWBrMonSWjJ1/vxYoP4q+pVJLuGkg=;
 b=C6XEeMb2bPRoA1Km0+eyJQ9g+fexexn/kd5M8zExxNVvMEFcNs6fH+gl9HCIHP/5k5
 021V9h6dTiecvP8GtFbIB8ExfX5EbNnqzSEll8wNOItEqF8tvwSTNiBBaWttel9KJfuN
 yTC2Q0bbfF5+cksvM4SC5kINRmBkIrAbift+aRABbngMVSZQ+VYE8GEyRIxtFEhMOq7s
 FBSW9H/cTMsj9+ZfMmJghWfia8JO7qxdILxWaWqbFYJN4VPa+9thwqNV/mh7MoT3OPoC
 SHWXBsOIJ97k4kf4iU0Ee9ulOGvvh/vR+LPg2xA28m+iSQo8biVqcY7Gw7AgN/ONFF3S
 Xosg==
X-Gm-Message-State: APjAAAXJ1pFBgLM06O9/yzeoxZmzYl1LSdrXBszOZZmP5X9MNMmCamyK
 ydmSprYVFU6QAHF5SpyPf6v9nA==
X-Google-Smtp-Source: APXvYqznegeKjv5vrHpFtq8kqkQovBYm8YPhf3wMKa16Vs+QaEmFvNHAGBfVn1lCiVdh4Es2x2EXHw==
X-Received: by 2002:a62:570a:: with SMTP id
 l10mr117460057pfb.151.1558741797190; 
 Fri, 24 May 2019 16:49:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
 by smtp.gmail.com with ESMTPSA id q4sm3297595pgb.39.2019.05.24.16.49.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 24 May 2019 16:49:56 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] trace: Use regular rcu_dereference_raw API
Date: Fri, 24 May 2019 19:49:30 -0400
Message-Id: <20190524234933.5133-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190524234933.5133-1-joel@joelfernandes.org>
References: <20190524234933.5133-1-joel@joelfernandes.org>
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
Cc: rcu@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

rcu_dereference_raw already does not do any tracing. There is no need to
use the _notrace variant of it and this series removes that API, so let us
use the regular variant here.

While at it, also replace the only user of
hlist_for_each_entry_rcu_notrace (which indirectly uses the
rcu_dereference_raw_notrace API) with hlist_for_each_entry_rcu which
also does not do any tracing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/ftrace.c          | 4 ++--
 kernel/trace/ftrace_internal.h | 8 ++++----
 kernel/trace/trace.c           | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b920358dd8f7..f7d5f0ee69de 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -706,7 +706,7 @@ ftrace_find_profiled_func(struct ftrace_profile_stat *stat, unsigned long ip)
 	if (hlist_empty(hhd))
 		return NULL;
 
-	hlist_for_each_entry_rcu_notrace(rec, hhd, node) {
+	hlist_for_each_entry_rcu(rec, hhd, node) {
 		if (rec->ip == ip)
 			return rec;
 	}
@@ -1135,7 +1135,7 @@ __ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip)
 	key = ftrace_hash_key(hash, ip);
 	hhd = &hash->buckets[key];
 
-	hlist_for_each_entry_rcu_notrace(entry, hhd, hlist) {
+	hlist_for_each_entry_rcu(entry, hhd, hlist) {
 		if (entry->ip == ip)
 			return entry;
 	}
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 0515a2096f90..e3530a284f46 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -6,22 +6,22 @@
 
 /*
  * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_notrace() is that elements removed from this list
+ * can use rcu_dereference_raw() is that elements removed from this list
  * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
+ * mechanism.  The rcu_dereference_raw() calls are needed to handle
  * concurrent insertions into the ftrace_global_list.
  *
  * Silly Alpha and silly pointer-speculation compiler optimizations!
  */
 #define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_notrace(list);			\
+	op = rcu_dereference_raw(list);			\
 	do
 
 /*
  * Optimized for just a single item in the list (as that is the normal case).
  */
 #define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
+	while (likely(op = rcu_dereference_raw((op)->next)) &&	\
 	       unlikely((op) != &ftrace_list_end))
 
 extern struct ftrace_ops __rcu *ftrace_ops_list;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec439999f387..cb8d696d9cde 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2638,10 +2638,10 @@ static void ftrace_exports(struct ring_buffer_event *event)
 
 	preempt_disable_notrace();
 
-	export = rcu_dereference_raw_notrace(ftrace_exports_list);
+	export = rcu_dereference_raw(ftrace_exports_list);
 	while (export) {
 		trace_process_export(export, event);
-		export = rcu_dereference_raw_notrace(export->next);
+		export = rcu_dereference_raw(export->next);
 	}
 
 	preempt_enable_notrace();
-- 
2.22.0.rc1.257.g3120a18244-goog

