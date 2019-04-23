Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50998C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:57:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12FD208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0V8y2S9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12FD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbPN66kXzDqSp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:57:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0V8y2S9"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTcm52dhzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:37:12 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id z16so3262337pgv.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
 b=H0V8y2S9LY/h1oclaqAqBDBVPpIsCwmSZ1eaAydDS9yJAo8ZH7vpapqzuh7pb3kycC
 LArRs6FRsK5zM5OugFN4WIEkkaMZmONSSeVWzGpHYHe2W7/vdKNn1CNtr2dyssuL8VmN
 rZLwb8JL3KYiBZUJA4vrgRC34fv8nK+Qf55zTjPT1Q45QBwZvNLjiI64ekZScAhxVzn+
 lkP7DU/LdaCXzfG6tqMBGsYfzNVih6mlAowHOk1zf6F2AZKkPl7F2z6v5MwAwxyKOy8Y
 LSYlIHdI7CW0UByUVOZ7ED9kBF6mm/1QNMJy3+5SBYrFHE6DSEgMhIaF6jJbu+wYWLbs
 Q0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
 b=JiMkVIC9xxg+1XZYZ6fzJZalEmbWsElV3x7S+vkbDpmpGPih/7UekTdgjS6ODtbNYB
 ooF96UFwYOKhEaW83BapMP2qMEWxz9sPhun/qDfxxeRb3UMYsdhjFlnqn+S/TWJfDqU6
 JN7ktS8N1WMcSTBpjIQeDRUlWIoCwsWqYq6g27Jt5tCNcLXYezSCeSs1iTJd3oL77/8U
 xFoyWLOVc3Qad/d2ptu+qkqlHId7ngPEQ1XYOZTvObSZ+Xfp+3W8FzfWzcsDUt6AjyJK
 s/Ly+rMGPYa5v8poERfBmot/lMst4i5t+/0KpRn8naC+6ccwKthEct0g9zxqhZpJwzhi
 ZQ8g==
X-Gm-Message-State: APjAAAUl7yDMCWztxfATqV9FYCP03In2xfDUM56fpK75m3Jy+v2SGQQm
 SuUgHZeke3Ytit4XjBo7y38=
X-Google-Smtp-Source: APXvYqxrACQ5i2jIhn4LUrHm3mZQzFOFJ01PPmOWO3KVjgS+E+E3Jf2lRhZP1U+++JzF2DGkbf5Uig==
X-Received: by 2002:a63:5953:: with SMTP id j19mr25403845pgm.260.1556037430791; 
 Tue, 23 Apr 2019 09:37:10 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:37:10 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 41/63] Documentation: x86: convert kernel-stacks to reST
Date: Wed, 24 Apr 2019 00:29:10 +0800
Message-Id: <20190423162932.21428-42-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:32 +1000
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                   |  1 +
 .../x86/{kernel-stacks => kernel-stacks.rst}  | 20 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c0bfd0bd6000..489f4f4179c4 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -11,3 +11,4 @@ Linux x86 Support
    boot
    topology
    exception-tables
+   kernel-stacks
diff --git a/Documentation/x86/kernel-stacks b/Documentation/x86/kernel-stacks.rst
similarity index 92%
rename from Documentation/x86/kernel-stacks
rename to Documentation/x86/kernel-stacks.rst
index 9a0aa4d3a866..3e6bf5940db0 100644
--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Kernel Stacks
+=============
+
 Kernel stacks on x86-64 bit
----------------------------
+===========================
 
 Most of the text from Keith Owens, hacked by AK
 
@@ -57,7 +63,7 @@ IST events with the same code to be nested.  However in most cases, the
 stack size allocated to an IST assumes no nesting for the same code.
 If that assumption is ever broken then the stacks will become corrupt.
 
-The currently assigned IST stacks are :-
+The currently assigned IST stacks are :
 
 * DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
 
@@ -98,7 +104,7 @@ For more details see the Intel IA32 or AMD AMD64 architecture manuals.
 
 
 Printing backtraces on x86
---------------------------
+==========================
 
 The question about the '?' preceding function names in an x86 stacktrace
 keeps popping up, here's an indepth explanation. It helps if the reader
@@ -108,7 +114,7 @@ arch/x86/kernel/dumpstack.c.
 Adapted from Ingo's mail, Message-ID: <20150521101614.GA10889@gmail.com>:
 
 We always scan the full kernel stack for return addresses stored on
-the kernel stack(s) [*], from stack top to stack bottom, and print out
+the kernel stack(s) [1]_, from stack top to stack bottom, and print out
 anything that 'looks like' a kernel text address.
 
 If it fits into the frame pointer chain, we print it without a question
@@ -136,6 +142,6 @@ that look like kernel text addresses, so if debug information is wrong,
 we still print out the real call chain as well - just with more question
 marks than ideal.
 
-[*] For things like IRQ and IST stacks, we also scan those stacks, in
-    the right order, and try to cross from one stack into another
-    reconstructing the call chain. This works most of the time.
+.. [1] For things like IRQ and IST stacks, we also scan those stacks, in
+       the right order, and try to cross from one stack into another
+       reconstructing the call chain. This works most of the time.
-- 
2.20.1

