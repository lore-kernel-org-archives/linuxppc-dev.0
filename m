Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:41:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B382173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEWQxwVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B382173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447njw2QGCzDq83
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:41:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rEWQxwVP"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447ngl22FDzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:39:27 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id 10so9650530eds.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 21:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f0MWNfIl7BaIjVKIXDFU2rkRENWt9ONmC8+s19bQ8C0=;
 b=rEWQxwVPUiKduCDMy9WEb26SBN2oYU8ZwoGEfI6TwU/2z/gql80SKGFUFbdAZ38INY
 gS25mIn9yLZ8+Q98vonmSYMIels6+xGCsB5iyRYGNlrJL1OHtZ3Jjc/WGIdLlDw/7Qb9
 tAhaIcyR5pdfHBeCFBz6yIpEknl1P5djHoXI/oGzRQDZOEeX65sgebSrzhlHO9/FN/7l
 lCgnoG25r5GYWEi9BnToMZw8CGDL9XI7zbcg/tVEaIQHt++gqAHh9MaooyKuTu3IjO1A
 9TXZx+t6SidvPis5coOXF0z9HLSyGy7VGDWusIpGw7MlXRmrP7l5aNBsG28guZSXehSB
 3j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f0MWNfIl7BaIjVKIXDFU2rkRENWt9ONmC8+s19bQ8C0=;
 b=jzNYEGxaO1LxaoHdlMhHp9raglLVrMl+smVsEZT5Rh0I7INEynuk+9o4fUvYN093kH
 IcIAtuqaeMxSKD6TLAXKpFzCwOfZ+xDieG6HfP5cK0ZgCQ+Ylggq5DZeitd/oBT10cZB
 0sUz8rWQ6FZrG/MuLEDlok/vPMabIMxdBZ+6jJEwfxUQQU1RWiSJcDm+VYRKM7fmJNc0
 n13hLfaUJerSPk00ryK/XwXvQDWagMTLdcga9P/Nta7+50ZVNq7OPRWfurkTePvX4BDm
 jXz63de2eDaj3rBXR5aLhOM77vB+LdNv8MA+I5cVgbJrTbx0PNtOPBS5oN/mQ6mJhMSV
 +dhQ==
X-Gm-Message-State: AHQUAuaUK0o6ktipI1vVcJKbr2WkwUi9pEJAR1xq2+jy3yW255zq+ZJm
 h6ZD7aG8T52ff3OcPq9M/gg=
X-Google-Smtp-Source: AHgI3IZeSmeUfqTDQ29rsudSd0aVmdsgFKqoIYp+QIlPysI9QVDM3bM7x9Q9JKvSpvGOfi0w9gXfOw==
X-Received: by 2002:a17:906:9398:: with SMTP id
 l24mr15644008ejx.128.1551159563625; 
 Mon, 25 Feb 2019 21:39:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id l53sm3224194eda.66.2019.02.25.21.39.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 21:39:22 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/xmon: Fix opcode being uninitialized in
 print_insn_powerpc
Date: Mon, 25 Feb 2019 22:38:55 -0700
Message-Id: <20190226053855.7020-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building with -Wsometimes-uninitialized, Clang warns:

arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
  if (cpu_has_feature(CPU_FTRS_POWER9))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
  if (opcode == NULL)
      ^~~~~~
arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
condition is always true
  if (cpu_has_feature(CPU_FTRS_POWER9))
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
'opcode' to silence this warning
  const struct powerpc_opcode *opcode;
                                     ^
                                      = NULL
1 warning generated.

This warning seems to make no sense on the surface because opcode is set
to NULL right below this statement. However, there is a comma instead of
semicolon to end the dialect assignment, meaning that the opcode
assignment only happens in the if statement. Properly terminate that
line so that Clang no longer warns.

Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
Link: https://github.com/ClangBuiltLinux/linux/issues/390
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/xmon/ppc-dis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 9deea5ee13f6..27f1e6415036 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -158,7 +158,7 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
     dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
 		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
 		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
+		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
-- 
2.21.0

