Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C0C83002
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:09:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BB0206E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDzV8AF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49B4ns56pQzDqWM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 12:09:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HDzV8AF0; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B4Zq6fDvzDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 11:59:31 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id d184so9931942pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fk1NTwRlGGlt8EmeicvxJx+77flJk3sTn7ril2NvHK8=;
 b=HDzV8AF0JVKltWHOk6J8NeqliyWy5iSqfro6cJxw3m36u1GhNUuh1sCeS7YXSCUEw6
 k/6MY5bWhB6lxZ4gzt8P2jyGzhgjFvuw+oQEJmHS+AnGvsC3cpKUhw1vjLqBXUX/3iiE
 xLxuRRy8ihq80GhvWLJfpgzkj340uYohzFhmQZh7FAJfCFsvRx6xB91vYolUAabFPkU1
 8D47dd6aHPbaZYi1DBFep7Zl2ZR9hVZP96LznQ6SWi+TUVPqhADytGxl4cepcod13TZm
 2Ratm6pIqxeypqICIPzRyvEq9EKcXtJkJ3Tnk7NRqvXpiAECZsDm2TIZkxPNNwmciexG
 004A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fk1NTwRlGGlt8EmeicvxJx+77flJk3sTn7ril2NvHK8=;
 b=rOd3i8G18FBKdkKFzyseMVElXj4T+vlrf6lFekWuMvZLcPRiwZtFTIhrpzmMiO1Ccc
 4Nxvyuo1TPTD//hwnCgoX9Cff487US1wkDc87JPw0/Py2LaKe/YpOZw6321ynV6xc5/k
 eLvUV10tgUYUfAO/9o+k5wdp6xBipudJmdVO8+rh2lSbgzOSIWiKDdHNccijbaiEtrg+
 BdTjjq/YZ5/hPG5lQmOwNf8HzR61e3HUBEg2fXRsJy1uUyyUitgCpTcbIgZPy8lR44FL
 rEuwfN52t6ORdHS+VkM+vm+LDMNwFAA9viMcPtf7tLt5UPo5E+tn9zNImbR2kKDUVVzE
 ehcw==
X-Gm-Message-State: AGi0PuauLLGJAHfbMQvn7BJGy94Kk/ba1PJ4RA0E3NNWKPDT8PnE0EHO
 ugoprRu84E+UclMbhkFmyNLJ7jrG2y8=
X-Google-Smtp-Source: APiQypKky9Sbiou00mMGTEked5IqZv1cG33ghj7SGsINqaly2/+CpjfZyN0WJrkCJ/VFAPzQVkxw8w==
X-Received: by 2002:a62:15d8:: with SMTP id 207mr26216708pfv.140.1588039168783; 
 Mon, 27 Apr 2020 18:59:28 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id o68sm13666642pfb.206.2020.04.27.18.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 18:59:28 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 04/28] powerpc/xmon: Use bitwise calculations
 in_breakpoint_table()
Date: Tue, 28 Apr 2020 11:57:50 +1000
Message-Id: <20200428015814.15380-5-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428015814.15380-1-jniethe5@gmail.com>
References: <20200428015814.15380-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A modulo operation is used for calculating the current offset from a
breakpoint within the breakpoint table. As instruction lengths are
always a power of 2, this can be replaced with a bitwise 'and'. The
current check for word alignment can be replaced with checking that the
lower 2 bits are not set.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v6: New to series
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f7ce3ea8694c..e922cde99db2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -856,8 +856,8 @@ static struct bpt *in_breakpoint_table(unsigned long nip, unsigned long *offp)
 	off = nip - (unsigned long) bpt_table;
 	if (off >= sizeof(bpt_table))
 		return NULL;
-	*offp = off % BPT_SIZE;
-	if (*offp != 0 && *offp != 4)
+	*offp = off & (BPT_SIZE - 1);
+	if (off & 3)
 		return NULL;
 	return bpts + (off / BPT_SIZE);
 }
-- 
2.17.1

