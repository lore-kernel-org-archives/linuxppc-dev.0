Return-Path: <SRS0=Dwgl=2B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E76C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 01:47:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E533A205ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 01:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="bP3iB9YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E533A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XfvW5BbgzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 12:47:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="bP3iB9YZ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Xfpy3kMQzDqdD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2019 12:43:51 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id bd4so723104plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 17:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YtLJPvCfWgLv2jZaFNpCvWvr5sYMnowjH90dF56Fu9I=;
 b=bP3iB9YZdpDgq9XG1+PF3dN3RRMc2M0l+7WH543NQ1pVU9EK1CBDHKJqSUQaztA8QI
 CwOcfxTasim5eY92pycbdCEfaYiN8eLYhORScv4f7tswTLXTDko8NFJKYdXLN9ZuQ2By
 GzIOzYTIPBBC0Ou3FtbGD5YBjZgjGLhW4JG40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YtLJPvCfWgLv2jZaFNpCvWvr5sYMnowjH90dF56Fu9I=;
 b=s10yAk7tmtDePqbmMlaxCQq/obCM2g2RGsVm4E2r2G4wCqDERT3kmTTiHRob7aDSM+
 cOBD57N95w0LgsURtmS66P4gfV9MKMpKbyCA6bRB/mO8zXqLtTDUuMEi1V8IVnrwMFZ7
 yyS2cshc7UOGW14pQpT+DfDpqx21HvgtlkHgb9e0B5JZKlmaIuJU/anGU9sFgvuRpyGH
 y10apvDEXOURZM1FBOAa+PkvF8Nz7/WF/9/JOAtwDJsjg+nl5MYCj0uycw2fJuob20TQ
 FCpeWtZiO7/tLh3/0VO9pRY9gvu3xalaN0LhaKU95m1ZbVsJhPXSTu6ATrr0K0iJBzqz
 9stg==
X-Gm-Message-State: APjAAAU+qYZHJ1aE8N2v9njeZV+opFPTbAac2NrllU9FzWK2qLZ9cJKa
 5M+AlqPiql/XJSYZlBK0ssEQuncDv4g=
X-Google-Smtp-Source: APXvYqy6W4HPjPnQyWFFTg6XWMAqjTRV+iZjz+EBjcb3rjK2reQbXPhLmkFc86QmVhlUCZmc8pT69A==
X-Received: by 2002:a17:902:fe09:: with SMTP id
 g9mr536738plj.162.1576028627948; 
 Tue, 10 Dec 2019 17:43:47 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-899f-c50f-5647-b1f9.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:899f:c50f:5647:b1f9])
 by smtp.gmail.com with ESMTPSA id g19sm306429pfh.134.2019.12.10.17.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 17:43:47 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fault: kernel can extend a user process's stack
Date: Wed, 11 Dec 2019 12:43:37 +1100
Message-Id: <20191211014337.28128-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
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
Cc: Tom Lane <tgl@sss.pgh.pa.us>, Daniel Black <daniel@linux.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If a process page-faults trying to write beyond the end of its
stack, we attempt to grow the stack.

However, if the kernel attempts to write beyond the end of a
process's stack, it takes a bad fault. This can occur when the
kernel is trying to set up a signal frame.

Permit the kernel to grow a process's stack. The same general
limits as to how and when the stack can be grown apply: the kernel
code still passes through expand_stack(), so anything that goes
beyond e.g. the rlimit should still be blocked.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205183
Reported-by: Tom Lane <tgl@sss.pgh.pa.us>
Cc: Daniel Black <daniel@linux.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b5047f9b5dec..00183731ea22 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -287,7 +287,17 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 			if (!res)
 				return !store_updates_sp(inst);
 			*must_retry = true;
+		} else if ((flags & FAULT_FLAG_WRITE) &&
+			   !(flags & FAULT_FLAG_USER)) {
+			/*
+			 * the kernel can also attempt to write beyond the end
+			 * of a process's stack - for example setting up a
+			 * signal frame. We assume this is valid, subject to
+			 * the checks in expand_stack() later.
+			 */
+			return false;
 		}
+
 		return true;
 	}
 	return false;
-- 
2.20.1

