Return-Path: <SRS0=VSEi=4O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3FC4BA0D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:25:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBBF2084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD6sjSAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBBF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48S2lj3lqZzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 15:25:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lD6sjSAX; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48S2NL2jVVzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 15:08:34 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z12so636362pgl.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 20:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=f3EId3jMgeXmLg/m1MUXwlRZoUMxmv84+0RbLeDKFr8=;
 b=lD6sjSAXWeGd7DP9H/U/DYA5HQdTIxwDX3g+CjJ5WsMN4ch4IET/lIp2NiCoTrkiup
 P42XnW/1lAAcvmXtGH2SCMzJBMlvnr9GIvHHnAdkw0cVFjBlJoF531+ADoPKTC38HAgJ
 KhrrervAVSGI4SG1U1UEhTC9JdgsCD+8p563Slb8KSsb3h2D3xA1/R+Ah0vNfE7o5x5z
 YSs6BfcArMAqSwwnsZSWDXDzJTULvCLCc/Vq/dxNvoVm+oKfnOPSMnEJqBy8E/YgV9BI
 wb8HKrrkFQh+dHv+s+cOSJpNlnDkfR4STqZ16gy51I0rU7X0lBT0gMSm3V90IRBFDyEQ
 XtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=f3EId3jMgeXmLg/m1MUXwlRZoUMxmv84+0RbLeDKFr8=;
 b=C8A5Q6M+dr6rJiK46YbfaDkQwa4Te+3ohcemZnlA7A/38AuaKZ/VdY3gWVaaOZom+H
 WdivnEr4mx3Y09ITqo3PE4morLw6vt+IvwHlcHw0og5SEOD47TQ7JWiAf9Y4RPI/kWaS
 6AatmKpTvKXCD9py5ja7pNNHk+JPVT+Nla6neLZjh3nAoKhrlK9HZhoF6shKCHS9322G
 uhdc9mqowDo1djVaztQyerGZSwG+qWo3vgl/t50hQQNaMAny4DyJFW8VvpbUeJivb4QW
 U/kpfVn0di6UpGeCnq4QQMiAvFpbyz/z3Y9r5DD5BBle7YbHFKVvSeUvW4uMJOEbJcZg
 MrBw==
X-Gm-Message-State: APjAAAV2OqEJbUN5XbNXsob1NZw02omynXBJ2KR5pHtmcTiS7/DeotgA
 pfj8OKckiFV/1cHfrmsBN5pMtES7fPM=
X-Google-Smtp-Source: APXvYqxh9QJu9K+nO2zxPk/vncEwx/o+0+pGbPMMBxlkPtQH7dwpUHhOUYMCJD9yUpVc9kPOoPOILQ==
X-Received: by 2002:a63:4103:: with SMTP id o3mr1630527pga.199.1582690111716; 
 Tue, 25 Feb 2020 20:08:31 -0800 (PST)
Received: from tee480.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d4sm604681pjg.19.2020.02.25.20.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 20:08:31 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 07/14] powerpc/traps: Check for prefixed instructions in
 facility_unavailable_exception()
Date: Wed, 26 Feb 2020 15:07:09 +1100
Message-Id: <20200226040716.32395-8-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226040716.32395-1-jniethe5@gmail.com>
References: <20200226040716.32395-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If prefixed instructions are made unavailable by the [H]FSCR, attempting
to use them will cause a facility unavailable exception. Add "PREFIX" to
the facility_strings[].

Currently there are no prefixed instructions that are actually emulated
by emulate_instruction() within facility_unavailable_exception().
However, when caused by a prefixed instructions the SRR1 PREFIXED bit is
set. Prepare for dealing with emulated prefixed instructions by checking
for this bit.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d80b82fc1ae3..cd8b3043c268 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1739,6 +1739,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		[FSCR_TAR_LG] = "TAR",
 		[FSCR_MSGP_LG] = "MSGP",
 		[FSCR_SCV_LG] = "SCV",
+		[FSCR_PREFIX_LG] = "PREFIX",
 	};
 	char *facility = "unknown";
 	u64 value;
-- 
2.17.1

