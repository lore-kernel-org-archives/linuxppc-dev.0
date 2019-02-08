Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587A1C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:18:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814B2218D9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0luxU4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814B2218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgP86CWzzDqMg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:18:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T0luxU4Y"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9n0753zDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:28 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so920374pgk.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cZLwnkxygz8f1u53wW3gs/ZKt8SL1XY6mjhgJDlWmwU=;
 b=T0luxU4Y4cHYoKnAemqvIES5GBlPRdA7XhhgHxJ9xNhe0XVbEU2JMQ9VuM9AaSPHQ3
 qkCBUIhWJ6xW3ATpRsxZzCdrTiHg1WyW0Ssre3OKxPq8gwLljKS+6x/tWLkorkl9OEaQ
 c81fpyeWkknAHQaqXQ6w2qMsESYPmqrW7KZO815qCUIV3HzKAC6+76qnmouHO7xZzF2w
 A6LatT3UHiDBH3JyYygMFxIZbn9CH3lTmHkIb1GhAlGlnMv9/ltYAIiFDEJwhAvFvz7H
 gQkpdUVNUChxWZH0WK7wBPLscwVIqf5kG7uhDAtQpoI9xrlOVu+w9bSDrEpmkTS+zLhB
 W3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cZLwnkxygz8f1u53wW3gs/ZKt8SL1XY6mjhgJDlWmwU=;
 b=ZLXbw4yIveEvjGPJULfM7iEmF5XXN2609PanKA2706n/RdQWY17I5+gDgQ8cEGq6+q
 DeL4qkQ4eaMXkMvanhjuGv7Eip4QYaJKT92+E61K5sQACaIy6ekNDBe5Eb3oXdBK7hlw
 +SxOPirJgW3rEi7JUpd/oVQwxOZ/jaHx+paam4fQgpjccbMNJLUkmf4nXSv9a0W/0HAZ
 X/0smkXB66vb5pLgLgj/0SqBRzuYkmtom5lucC1QK01u/aAaZ1r811wtg4dHJzWnWMhN
 JWiF4XbxI4gSv6cKsw+tIb+/RIGgBJmbG1pY7e3QwPHG1B3lPBxjMXxmyyJNtMlV4CoW
 lb7A==
X-Gm-Message-State: AHQUAuaAooF+FL2IPAI8rqLl6qPmLvflOZbxtpjlRUQclmxhoSx4hkg6
 eCck79UT8TvsDbgM/obV0J9HdVma
X-Google-Smtp-Source: AHgI3IZWVO02/mviJzz2nWlEVxijyr6aO6Sk8iIjJO8cndZjcvy2vXazomY/7iPdCZhvMkPNrKpG6g==
X-Received: by 2002:a63:df50:: with SMTP id h16mr2416862pgj.421.1549595307097; 
 Thu, 07 Feb 2019 19:08:27 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:26 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/7] powerpc/eeh: Allow disabling recovery
Date: Fri,  8 Feb 2019 14:08:01 +1100
Message-Id: <20190208030802.10805-6-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently when we detect an error we automatically invoke the EEH recovery
handler. This can be annoying when debugging EEH problems, or when working
on EEH itself so this patch adds a debugfs knob that will prevent a
recovery event from being queued up when an issue is detected.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h  |  1 +
 arch/powerpc/kernel/eeh.c       | 11 +++++++++++
 arch/powerpc/kernel/eeh_event.c |  9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fc21b6e78e91..6f6721561302 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -220,6 +220,7 @@ struct eeh_ops {
 
 extern int eeh_subsystem_flags;
 extern uint32_t eeh_max_freezes;
+extern bool eeh_debugfs_no_recover;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index d1f0bdf41fac..92809b137e39 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -111,6 +111,13 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
  */
 uint32_t eeh_max_freezes = 5;
 
+/*
+ * Controls whether a recovery event should be scheduled when an
+ * isolated device is discovered. This is only really useful for
+ * debugging problems with the EEH core.
+ */
+bool eeh_debugfs_no_recover;
+
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
 
@@ -1810,7 +1817,11 @@ static int __init eeh_init_proc(void)
 					   &eeh_enable_dbgfs_ops);
 		debugfs_create_u32("eeh_max_freezes", 0600,
 				powerpc_debugfs_root, &eeh_max_freezes);
+		debugfs_create_bool("eeh_disable_recovery", 0600,
+				powerpc_debugfs_root,
+				&eeh_debugfs_no_recover);
 		eeh_cache_debugfs_init();
+#endif
 	}
 
 	return 0;
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 227e57f980df..19837798bb1d 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -126,6 +126,15 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	unsigned long flags;
 	struct eeh_event *event;
 
+	/*
+	 * If we've manually supressed recovery events via debugfs
+	 * then just drop it on the floor.
+	 */
+	if (eeh_debugfs_no_recover) {
+		pr_err("EEH: Event dropped due to no_recover setting\n");
+		return 0;
+	}
+
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
 		pr_err("EEH: out of memory, event not handled\n");
-- 
2.20.1

