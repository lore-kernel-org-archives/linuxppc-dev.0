Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE2C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 14:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64A92077D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1dm04uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64A92077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48v2Nk3wz4zDqpB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2020 01:28:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P1dm04uq; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48v12834QxzDrdH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2020 00:27:28 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id k191so3487360pgc.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2020 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eHABQ0e8hhMeohhlg0yik4/JbKqE36gMrfpYoFlgvHo=;
 b=P1dm04uq+B7BQJtGkym4pg1Sz4uiZaDvmyNq7ZSFNiC4TDdjV6CppeUJV8zn/hUH1e
 I3NB0o8TCVISsB8vfHcqzbUzI83oS6D6LWWsXJjfZGwSNKxigldXnAEnKce6s6N2xVWy
 Js4BHOOmuSzvTdymevKal9+X5yYMgLEwTiemQEcqxl6raF9aQqxIp7ey/xIf9o59Cww7
 ddNiSlyL43IXaCNs+QvWtm9sP0Qv72HlzVD3Z9/eyXh4dmv2hf1J6alGDrus4NjkvI2v
 6omY+WvJAYva/wp/MNgyCGN8f6+QLvR0dgF602mUS9unXhy7IK2lJOISEaym819aOh7K
 M25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eHABQ0e8hhMeohhlg0yik4/JbKqE36gMrfpYoFlgvHo=;
 b=UeTo5p9Hu/ZgoObpK27tzxOQ/Ku/BkYWryisXnaQbt70bty6UHTDA88d8iE0z+R/rm
 fLb9OfDt9607JGJ5m6FjZfwcWw0VfEvMUzB13LqvzH074b8tornq6Jlhh2gwUirETXTY
 iH7mwJ5XayAO0UzzJrNHivFUJf3zZCPs3iz79u2z4Tlp18JZszXJlbKdSPHBNSKiF6tD
 xpMD0E5lFbcRf7EJpmgMvRR8MC7ZZtivjNRpEp4F6ROBt4xdCSUyd+gyRxqo9jvSGac/
 cqthe/536Zp2zuslXRcsAdx27iaBbNliakZVxDlHTs2bnURaEWBv6eZAkkd8DvCB9to4
 xGWg==
X-Gm-Message-State: AGi0PuYDUgz1Ecami+SEWyiR+oxKPC0ZzV6/TUpq+66ywcKXeFRMnHDD
 oSKlMP8a8rWCkOkpCYtcjHDHIQOe
X-Google-Smtp-Source: APiQypL3pO0+wxrid6OOT81qoK+ePDKqy0gN7ezANTK6jb5hyvRCOjZ/38uqICY4RAItUtc4gJkcAQ==
X-Received: by 2002:a65:5b49:: with SMTP id y9mr8122525pgr.153.1585920444812; 
 Fri, 03 Apr 2020 06:27:24 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id o65sm5941422pfg.187.2020.04.03.06.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 06:27:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/14] powerpc/64s: system reset do not trace
Date: Fri,  3 Apr 2020 23:26:21 +1000
Message-Id: <20200403132622.130394-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200403132622.130394-1-npiggin@gmail.com>
References: <20200403132622.130394-1-npiggin@gmail.com>
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Similarly to the previous patch, do not trace system reset. This code
is used when there is a crash or hang, and tracing disturbs the system
more and has been known to crash in the crash handling path.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1845fd7e161a..ed7b7a6e2dc0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -443,6 +443,9 @@ void system_reset_exception(struct pt_regs *regs)
 	unsigned long hsrr0, hsrr1;
 	bool nested = in_nmi();
 	bool saved_hsrrs = false;
+	u8 ftrace_enabled = local_paca->ftrace_enabled;
+
+	local_paca->ftrace_enabled = 0;
 
 	/*
 	 * Avoid crashes in case of nested NMI exceptions. Recoverability
@@ -524,6 +527,8 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_exit();
 
+	local_paca->ftrace_enabled = ftrace_enabled;
+
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
 
-- 
2.23.0

