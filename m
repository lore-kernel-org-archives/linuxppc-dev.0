Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C735C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 15:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B046120672
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoEeQ0ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B046120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Bv084YNKzDsTS
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 02:49:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoEeQ0ql";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoEeQ0ql"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BtxP4F08zDrdR
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 02:46:49 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id q26so7144435wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Dec 2018 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L7GQhOnYZ/9ITTatnN1cAFhc2f132GWO/j4E7PzXJkc=;
 b=MoEeQ0qlk8lK2HFY5wZuBTYmTkRj2V1GDxW8Qk7FWgacrci8nWtEJYzosetPdMMRWx
 /NjfFWyv+Ue/R7Z11KXN7RxXNZRUsk9ELrWUJRHx+bzh1pgjPDA72LXm9Zwvv/m3VrLi
 KO869Z7ZBi27Ezo71rrQ6df3++3ciUwHv9+jdFcv2xlrCyYqNodA1a3Yx9UfwGwfoGu2
 2VhayLS8pS7gLLvX1sA/Qdw+XcPDfkMeNVzbNlyGLzhk52MaowKEGZE+uBFwjLYx9wNq
 +K/DNpY4UTyNR6PrgVupIMk5kMa/ilY3zLx3fuXQNazKR51dzfuczTKmflOVy5s/T+hO
 0zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=L7GQhOnYZ/9ITTatnN1cAFhc2f132GWO/j4E7PzXJkc=;
 b=J2wG542qHcXoMsldppI0gROo8MJBa+T8lOLiZ/cYZ1rRQMQsS+xMTUCCfCUK9IgEuo
 DIKRQ/XgEx/TKtaAyNgNIPvRGLMF8Tx1nsddD+a+1Oc8Wn2vGDyMqIgY+gCJA+gE92wm
 4lZxToZr8/s7EdOji8vZyILFsJr5iSo7m0SKqBGoKS1LtoZekglDJLxHBrbMh1jSK5ml
 sO64I+HGQaFdzsV6Ov7Auvn1CPYGO5RQEnTgdkw+GLa3HfuneHn4OROBADf1JmXAsyEc
 XBRK3Ob1sjqnrNmVvTqBbEREOALja75zQfoq3UVeAwUmO7jwyJtyYXw7A2guH8mup7vF
 3dEQ==
X-Gm-Message-State: AA+aEWavtHC7rYCez285apxZvFCi+pbqzl/MMzhtWbdEesMo1wn9kzB4
 TJrbcnBN5fFFmQcHkzqSLPM=
X-Google-Smtp-Source: AFSGD/Xyiblms4cYzEQCqEbXOREVh2DV4op56OzEiW80YkOLqrBCipD5tsMeepqmJ///o5qy1h76fA==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr5337638wmg.71.1544284004126; 
 Sat, 08 Dec 2018 07:46:44 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id l37sm15771092wre.69.2018.12.08.07.46.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 07:46:43 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 19C4D11422CD; Sat,  8 Dec 2018 16:46:37 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
Date: Sat,  8 Dec 2018 16:46:23 +0100
Message-Id: <20181208154624.6504-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mathieu Malaterre <malat@debian.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

`pt_regs_check` is a dummy function, its purpose is to break the build
if struct pt_regs and struct user_pt_regs don't match.

This function has no functionnal purpose, and will get eliminated at
link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION

This commit adds a prototype to fix warning at W=1:

  arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index a398999d0770..341c0060b4c8 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 	user_enter();
 }
 
+void __init pt_regs_check(void);
+/* dummy function, its purpose is to break the build if struct pt_regs and
+ * struct user_pt_regs don't match.
+ */
 void __init pt_regs_check(void)
 {
 	BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
-- 
2.19.2

